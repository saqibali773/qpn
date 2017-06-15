//
//  IndustryVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "ExperinceVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "TitleSubTitleCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "Experince.h"
#import "AddExperinceVC.h"


@interface ExperinceVC ()

@property (nonatomic,strong)NSMutableArray *experinces;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ExperinceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.experinces = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib
    }
- (void)viewWillAppear:(BOOL)animated
{
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    [AUTH_MAN getExperiences:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            [self.experinces removeAllObjects];
            for (NSDictionary* dic in response)
            {
                Experince * exp = [[Experince alloc] initWithDictionary:dic];
                [self.experinces addObject:exp];
            }
    
            [self.tableView reloadData];
        }else{
            if(error) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:errorDic[@"errors"]];
            }
        }
        
    }];

}
#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.experinces.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * resuseID = @"TitleSubTitleCell";
    TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleSubTitleCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    Experince *experince = [self.experinces objectAtIndex:indexPath.row];
    cell.title.text = experince.company_name;
    cell.subTitle.text = [NSString stringWithFormat:@"%@, %@",experince.job_title, experince.start_date];
    cell.subsubTitle.text = [NSString stringWithFormat:@"%@",experince.descp];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Action Methods
- (IBAction)onAddClick:(id)sender {
    AddExperinceVC * vc;
    vc = [[AddExperinceVC alloc] initWithNibName:@"AddExperinceVC" bundle:[NSBundle mainBundle]];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onMenuClick:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}




@end
