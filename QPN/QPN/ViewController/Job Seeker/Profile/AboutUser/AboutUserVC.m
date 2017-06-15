//
//  AboutUserVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "AboutUserVC.h"
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


@interface AboutUserVC ()<UISearchBarDelegate,ProfileOptionsCellDelegate>
@end

@implementation AboutUserVC
@synthesize  educationArray,experianceArray,achievementArray,skillArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.userAlldataApiCount = 0;
    
    self.educationArray = [NSMutableArray array];
    self.experianceArray = [NSMutableArray array];
    self.achievementArray = [NSMutableArray array];
    self.skillArray = [NSMutableArray array];
    
    if (SHARED_MANAGER.qpnUser)
    {
        self.navTitle.text = SHARED_MANAGER.qpnUser.first_name;
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
        [AUTH_MAN getEducations:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
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
        [AUTH_MAN getExperiences:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
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
        [AUTH_MAN getAchievemnts:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
           
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
        [AUTH_MAN getSkills:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            
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
    
    [cell.addBtn addTarget:self action:@selector(onAddBtnPressed:) forControlEvents:UIControlEventTouchDown];
    cell.addBtn.hidden = NO;
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
    cell.userAddDataDelegate = self;
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
            cell.title.text = @"Info";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                UserBriefInfoVC * vc = [[UserBriefInfoVC alloc] initWithNibName:@"UserBriefInfoVC" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1:
        {
            Education *education = [self.educationArray objectAtIndex:indexPath.row];

            AddEducationVC * vc;
            vc = [[AddEducationVC alloc] initWithNibName:@"AddEducationVC" bundle:[NSBundle mainBundle]];
            vc.isEditMode = true;
            vc.eduObj = education;
            SHARED_MANAGER.userDataCat =  UserEducation;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            Experince *experince = [self.experianceArray objectAtIndex:indexPath.row];
            AddExperinceVC * vc;
            vc = [[AddExperinceVC alloc] initWithNibName:@"AddExperinceVC" bundle:[NSBundle mainBundle]];
            vc.isEditingMode = YES;
            vc.expObj = experince;
            SHARED_MANAGER.userDataCat =  UserExperiance;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            Achievement *achiv = [self.achievementArray objectAtIndex:indexPath.row];
            AddAchievementVC * vc;
            vc = [[AddAchievementVC alloc] initWithNibName:@"AddAchievementVC" bundle:[NSBundle mainBundle]];
            vc.isEditingMode = YES;
            vc.achObj = achiv;
            SHARED_MANAGER.userDataCat =  UserAchievement;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            Skill *skill = [self.skillArray objectAtIndex:indexPath.row];
            AddSkillVC * vc;
            vc = [[AddSkillVC alloc] initWithNibName:@"AddSkillVC" bundle:[NSBundle mainBundle]];
            vc.isEditingMode = YES;
            vc.skillObj = skill;
            SHARED_MANAGER.userDataCat =  UserSkill;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
        }
            break;
            
        default:
            break;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform the real delete action here. Note: you may need to check editing style
    //   if you do not perform delete only.
    
    switch (indexPath.section)
    {
        case 1:{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:[NSString stringWithFormat:@"Are you sure you want to delete your Education?"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                Education *edu = [self.educationArray objectAtIndex:indexPath.row];
                [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
                [AUTH_MAN deleteEducation:edu.educationId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    [self.educationArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }];

            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 2:{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:[NSString stringWithFormat:@"Are you sure you want to delete your Experince?"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                Experince *exp = [self.experianceArray objectAtIndex:indexPath.row];
                [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
                [AUTH_MAN deleteExperince:exp.experinceId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    [self.experianceArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }];
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 3:{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:[NSString stringWithFormat:@"Are you sure you want to delete your Achievement?"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                Achievement *achi = [self.achievementArray objectAtIndex:indexPath.row];
                [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
                [AUTH_MAN deleteAchievemnts:achi.achievementId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    [self.achievementArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }];
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 4:{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:[NSString stringWithFormat:@"Are you sure you want to delete your Skill?"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                Skill *skill = [self.skillArray objectAtIndex:indexPath.row];
                [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
                [AUTH_MAN deleteSkills:skill.skillId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    [self.skillArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }];
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuClick:(id)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:YES];    
}

#pragma -mark cell delegate
- (void) onAddBtnPressed:(id) sender
{
    int index = (int)((UIButton*)sender).tag;
    
    if (index == 1)
    {
        AddEducationVC * vc;
        vc = [[AddEducationVC alloc] initWithNibName:@"AddEducationVC" bundle:[NSBundle mainBundle]];
        
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (index == 2)
    {
        AddExperinceVC * vc;
        vc = [[AddExperinceVC alloc] initWithNibName:@"AddExperinceVC" bundle:[NSBundle mainBundle]];
        
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 3)
    {
        AddAchievementVC * vc;
        vc = [[AddAchievementVC alloc] initWithNibName:@"AddAchievementVC" bundle:[NSBundle mainBundle]];
        
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 4)
    {
        AddSkillVC * vc;
        vc = [[AddSkillVC alloc] initWithNibName:@"AddSkillVC" bundle:[NSBundle mainBundle]];
        
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
