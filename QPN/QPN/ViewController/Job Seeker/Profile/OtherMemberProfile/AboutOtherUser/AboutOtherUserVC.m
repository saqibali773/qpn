//
//  AboutOtherUserVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "AboutOtherUserVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "ProfileOptionsCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "AchievementVC.h"
#import "EducationVC.h"
#import "ExperinceVC.h"
#import "SkillVC.h"
#import "QPNSharedData.h"
#import "SignInVC.h"

#import "Education.h"
#import "AddEducationVC.h"
#import "Experince.h"
#import "AddExperinceVC.h"
#import "Achievement.h"
#import "AddAchievementVC.h"
#import "Skill.h"
#import "AddSkillVC.h"

#import "UserBriefInfoVC.h"

#import "TitleSubTitleCell.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager+UserInfo.h"


@interface AboutOtherUserVC ()
@end

@implementation AboutOtherUserVC
@synthesize  educationArray,experianceArray,achievementArray,skillArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.userAlldataApiCount = 0;
    
    self.educationArray = [NSMutableArray array];
    self.experianceArray = [NSMutableArray array];
    self.achievementArray = [NSMutableArray array];
    self.skillArray = [NSMutableArray array];
    
    if (self.otherUser)
    {
        self.navTitle.text = self.otherUser.first_name;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self allApi: SHARED_MANAGER.userDataCat];
}

-(void) allApi:(UserDataCatagory) catagory
{
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    if (catagory == UserAllData ||catagory ==  UserEducation) {
        self.userAlldataApiCount++;
        [AUTH_MAN getOtherEducations:[self.otherUser.userId stringValue] parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
            if(response) {
                [self.educationArray removeAllObjects];
                for (NSDictionary* dic in response) {
                    Education * edu = [[Education alloc] initWithDictionary:dic[@"education"]];
                    [self.educationArray addObject:edu];
                }
                [self reloadAll];
            }else{
                [self reloadAll];
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:errorDic[@"errors"]];
                }
            }
        }];
    }
    if (catagory == UserAllData ||catagory ==  UserExperiance) {
    self.userAlldataApiCount++;
        [AUTH_MAN getOtherExperiences:[self.otherUser.userId stringValue] parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
            if(response) {
                [self.experianceArray removeAllObjects];
                for (NSDictionary* dic in response)
                {
                    Experince * exp = [[Experince alloc] initWithDictionary:dic[@"experience"]];
                    [self.experianceArray addObject:exp];
                }
                    [self reloadAll];
            }else{
                [self reloadAll];
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:errorDic[@"errors"]];
                }
            }
            
        }];
    }
    if (catagory == UserAllData ||catagory ==  UserAchievement) {
        self.userAlldataApiCount++;
        [AUTH_MAN getOtherAchievemnts:[self.otherUser.userId stringValue] parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
           
            if(response) {
                [self.achievementArray removeAllObjects];
                for (NSDictionary* dic in response)
                {
                    Achievement * achiev = [[Achievement alloc] initWithDictionary:dic[@"achievement"]];
                    [self.achievementArray addObject:achiev];
                };
                [self reloadAll];
            }else{
                [self reloadAll];
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:errorDic[@"errors"]];
                }
            }
            
        }];
    }
    if (catagory == UserAllData ||catagory ==  UserSkill) {
        self.userAlldataApiCount++;
        [AUTH_MAN getOtherSkills:[self.otherUser.userId stringValue] parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
            if(response) {
                [self.skillArray removeAllObjects];
                for (NSDictionary * dic in response) {
                    Skill * skil = [[Skill alloc] initWithDictionary:dic[@"skill"]];
                    [self.skillArray addObject:skil];
                    
                }
                [self reloadAll];
            }else{
                [self reloadAll];
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:errorDic[@"errors"]];
                }
            }
            
        }];
    }

}
-(void) reloadAll
{
    self.userAlldataApiCount--;
    if (self.userAlldataApiCount == 0)
    {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        [self.tableView reloadData];
    }
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return self.educationArray.count;
            break;
        case 2:
            return self.experianceArray.count;
            break;
        case 3:
            return self.achievementArray.count;
            break;
        case 4:
            return self.skillArray.count;
            break;
 
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section)
    {
        case 0:
            return 51.0;
            break;
        case 1:
            return 72.0;
            break;
        case 2:
            return 90.0;
            break;
        case 3:
            return 90.0;
            break;
        case 4:
            return 51.0;
            break;

        default:
            break;
    }
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0)
    {
        return 55.0;
    }
    return 0.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString * resuseID = @"profileOptionCell";
    ProfileOptionsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileOptionsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 55)];
    cell.contentView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 55);
    cell.addBtn.tag = section;
    switch (section)
    {
        case 1:
            cell.title.text = @"Education";
            break;
        case 2:
            cell.title.text = @"Experience";
            break;
        case 3:
            cell.title.text = @"Achievement";
            break;
        case 4:
            cell.title.text = @"Skill";
            break;
        default:
            break;
    }
    cell.index = section;
    cell.addBtn.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [view addSubview:cell.contentView];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section)
    {
        case 0:
        {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.title.text = @"User About";
            cell.subTitle.hidden = YES;
            cell.subsubTitle.hidden = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleSubTitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            Education *education = [self.educationArray objectAtIndex:indexPath.row];
            cell.title.text = education.institute;
            cell.subTitle.text = [NSString stringWithFormat:@"%@, %@ to %@",education.degree_title,education.start_date,education.end_date];
            cell.subsubTitle.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            
            break;
        case 2:
        {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleSubTitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            Experince *experince = [self.experianceArray objectAtIndex:indexPath.row];
            cell.title.text = experince.company_name;
            cell.subTitle.text = [NSString stringWithFormat:@"%@, %@",experince.job_title, experince.start_date];
            cell.subsubTitle.text = [NSString stringWithFormat:@"%@",experince.descp];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 3:
        {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleSubTitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            Achievement *achiv = [self.achievementArray objectAtIndex:indexPath.row];
            cell.title.text = achiv.title;
            cell.subTitle.text = [NSString stringWithFormat:@"%@",achiv.start_date];
            cell.subsubTitle.text = [NSString stringWithFormat:@"%@",achiv.descp];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 4:
        {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            Skill *skill = [self.skillArray objectAtIndex:indexPath.row];
            cell.title.text = skill.title;
            cell.subTitle.text = @"";
            cell.subsubTitle.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
   
        default:
            break;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuClick:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



@end
