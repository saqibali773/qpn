//
//  IndustryVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "SkillVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "ProfileOptionsCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "Skill.h"
#import "AddSkillVC.h"


@interface SkillVC ()

@property (nonatomic,strong)NSMutableArray *skills;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SkillVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.skills = [NSMutableArray array];
                   // Do any additional setup after loading the view, typically from a nib
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    
}
- (void)viewWillAppear:(BOOL)animated
{

    [AUTH_MAN getSkills:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            [self.skills removeAllObjects];
            for (NSDictionary * dic in response) {
                Skill * skil = [[Skill alloc] initWithDictionary:dic];
                [self.skills addObject:skil];
                
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
    return self.skills.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * resuseID = @"profileOptionCell";
    ProfileOptionsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileOptionsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Skill *skill = [self.skills objectAtIndex:indexPath.row];
    cell.title.text = skill.title;
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
    AddSkillVC * vc;
    vc = [[AddSkillVC alloc] initWithNibName:@"AddSkillVC" bundle:[NSBundle mainBundle]];
    
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
