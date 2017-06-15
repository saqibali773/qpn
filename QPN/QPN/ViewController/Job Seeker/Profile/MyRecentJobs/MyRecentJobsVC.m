//
//  MyRecentJobsVC.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//
#import <AVFoundation/AVFoundation.h>
#import "MyRecentJobsVC.h"
#import "MyRecentJobsCell.h"
#import "QPNAuthorizationManager+Jobs.h"
#import "QPNAuthorizationManager.h"
#import "AppliedJobDetailVC.h"
#import "JobsRecommendedCell.h"
#import "RecommendedJobDetailVC.h"
#import "Job.h"
typedef enum : NSUInteger {
    JobTypeApplied,
    JobTypeWish,
    JobTypeRecommened
} JobType;

#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]
@interface MyRecentJobsVC ()<UITextViewDelegate> {
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic,strong) NSArray *appliedJobs;
@property (nonatomic,strong) NSArray *wishJobs;
@property (nonatomic,strong) NSArray *recommendedJobs;
@property (nonatomic,readwrite) JobType selectedJobs;

@end


@implementation MyRecentJobsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAppliedJobs) name:@"AppliedJobs" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWishJobs) name:@"wishJobs" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRecommendedJobs) name:@"recommendedJobs" object:nil];

    self.selectedJobs = JobTypeApplied;
    [self getAppliedJobs];
    [self getWishJobs];
    [self getRecommendedJobs];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
}


#pragma mark Custom Methods
- (IBAction)controlSegmentClicked:(id)sender {
    UISegmentedControl *control = (UISegmentedControl*)sender;
    
    self.selectedJobs = control.selectedSegmentIndex;
    
    int count = 0;
    
    switch (self.selectedJobs) {
            case JobTypeApplied: {
                count = (int)self.appliedJobs.count;
            }
            break;
            case JobTypeWish: {
                count = (int)self.wishJobs.count;
            }
            break;
            case JobTypeRecommened: {
                 count = (int)self.recommendedJobs.count;
            }
            break;
            
        default:
            break;
    }
    
    
    if(count == 0) {
        self.tableView.hidden = YES;
    } else {
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}

- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark Private Jobs

- (void)getAppliedJobs {
    
    [AUTH_MAN getAppliedJobs:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        
        if(!error && [response isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempJobs = [NSMutableArray array];
            for (NSDictionary *job in response) {
                Job *iJob = [[Job alloc] initWithDictionary:job];
                [tempJobs addObject:iJob];
            }
            self.appliedJobs = tempJobs;
        } else {
        
        }
        if(self.appliedJobs.count == 0 && self.selectedJobs == JobTypeWish) {
            self.tableView.hidden = YES;
        } else {
            self.tableView.hidden = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

- (void)getWishJobs {
    [AUTH_MAN getWishJobs:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        
        if(!error && [response isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempJobs = [NSMutableArray array];
            for (NSDictionary *job in response) {
                Job *iJob = [[Job alloc] initWithDictionary:job];
                [tempJobs addObject:iJob];
            }
            self.wishJobs = tempJobs;
        } else {
            
        }
        if(self.wishJobs.count == 0 && self.selectedJobs == JobTypeWish) {
            self.tableView.hidden = YES;
        } else {
            self.tableView.hidden = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}
- (void)getRecommendedJobs {
    
    [AUTH_MAN getRecommendedJobs: nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        if(!error && [response isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempJobs = [NSMutableArray array];
            for (NSDictionary *job in response) {
                Job *iJob = [[Job alloc] initWithDictionary:job];
                [tempJobs addObject:iJob];
            }
            self.recommendedJobs = tempJobs;
        } else {
            
        }
        if(self.recommendedJobs.count == 0 && self.selectedJobs == JobTypeWish) {
            self.tableView.hidden = YES;
        } else {
            self.tableView.hidden = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

#pragma -mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    switch (self.selectedJobs) {
            case JobTypeApplied: {
               return self.appliedJobs.count;
            }
            break;
            case JobTypeWish: {
                return self.wishJobs.count;
            }
            break;
            case JobTypeRecommened: {
                return self.recommendedJobs.count;
            }
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (self.selectedJobs) {
            case JobTypeApplied: {
                return 50.0;
            }
            break;
            case JobTypeWish: {
                return 50.0;
            }
            break;
            case JobTypeRecommened: {
                return 100.0;
            }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.selectedJobs) {
            case JobTypeApplied: {
                Job *job = self.appliedJobs[indexPath.row];
                NSString * resuseID = @"MyRecentJobsCell";
                MyRecentJobsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyRecentJobsCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                [cell configureCell:job];
                cell.flag.hidden = YES;
                return cell;
            }
            break;
            case JobTypeWish: {
                Job *job = self.wishJobs[indexPath.row];
                NSString * resuseID = @"MyRecentJobsCell";
                MyRecentJobsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyRecentJobsCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                [cell configureCell:job];
                cell.flag.hidden = NO;
                return cell;
            }
            break;
            case JobTypeRecommened: {
                Job *job = self.recommendedJobs[indexPath.row];
                NSString * resuseID = @"JobsRecommendedCell";
                JobsRecommendedCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JobsRecommendedCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                [cell configureCell:job];
                
                return cell;
            }
            break;
            
        default:
            break;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.selectedJobs) {
            case JobTypeApplied: {
                Job *job = self.appliedJobs[indexPath.row];
                AppliedJobDetailVC *vc = [[AppliedJobDetailVC alloc] initWithNibName:@"AppliedJobDetailVC" bundle:[NSBundle mainBundle]];
                vc.currentJob = job;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            case JobTypeWish: {
            
                Job *job = self.wishJobs[indexPath.row];
                if(job.is_applied) {
                    AppliedJobDetailVC *vc = [[AppliedJobDetailVC alloc] initWithNibName:@"AppliedJobDetailVC" bundle:[NSBundle mainBundle]];
                    vc.currentJob = job;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    RecommendedJobDetailVC *vc = [[RecommendedJobDetailVC alloc] initWithNibName:@"RecommendedJobDetailVC" bundle:[NSBundle mainBundle]];
                    vc.currentJob = job;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            break;
            case JobTypeRecommened: {
                Job *job = self.recommendedJobs[indexPath.row];
                RecommendedJobDetailVC *vc = [[RecommendedJobDetailVC alloc] initWithNibName:@"RecommendedJobDetailVC" bundle:[NSBundle mainBundle]];
                vc.currentJob = job;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        default:
            break;
    }
}


@end


