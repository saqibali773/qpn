//
//  AchievementVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "AchievementVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "TitleSubTitleCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "Achievement.h"
#import "AddAchievementVC.h"


@interface AchievementVC ()

@property (nonatomic,strong)NSMutableArray *achievements;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AchievementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.achievements = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [AUTH_MAN getAchievemnts:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            [self.achievements removeAllObjects];
            for (NSDictionary* dic in response)
            {
                Achievement * achiev = [[Achievement alloc] initWithDictionary:dic];
                [self.achievements addObject:achiev];
            };
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
    return self.achievements.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
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
    Achievement *achiv = [self.achievements objectAtIndex:indexPath.row];
    cell.title.text = achiv.title;
    cell.subTitle.text = [NSString stringWithFormat:@"%@",achiv.start_date];
    cell.subsubTitle.text = [NSString stringWithFormat:@"%@",achiv.descp];
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
    
    AddAchievementVC * vc;
    vc = [[AddAchievementVC alloc] initWithNibName:@"AddAchievementVC" bundle:[NSBundle mainBundle]];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)onMenuClick:(id)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:YES];    
}




@end
