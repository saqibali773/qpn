//
//  EducationVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "EducationVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "TitleSubTitleCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "Education.h"
#import "AddEducationVC.h"


@interface EducationVC ()

@property (nonatomic,strong)NSMutableArray *educations;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation EducationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.educations = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"loading..."];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [AUTH_MAN getEducations:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            [self.educations removeAllObjects];
            for (NSDictionary* dic in response) {
                Education * edu = [[Education alloc] initWithDictionary:dic];
                [self.educations addObject:edu];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.educations.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"TitleSubTitleCell";
    TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleSubTitleCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Education *education = [self.educations objectAtIndex:indexPath.row];
    cell.title.text = education.institute;
    cell.subTitle.text = [NSString stringWithFormat:@"%@, %@ to %@",education.degree_title,education.start_date,education.end_date];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Action Methods
- (IBAction)onAddClick:(id)sender {
    
    AddEducationVC * vc;
    vc = [[AddEducationVC alloc] initWithNibName:@"AddEducationVC" bundle:[NSBundle mainBundle]];

    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)onMenuClick:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];    
}




@end
