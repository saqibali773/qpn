//
//  PostSearchVC.m
//  QPN
//
//  Created by Muhammad Usman on 16/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "PostSearchVC.h"
#import "GTConstants.h"
#import "SearchFilterCell.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "Industry.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "OtherProfileVC.h"

#import "ProfileOptionsCell.h"
#import "TitleSubTitleCell.h"

#import "JobsRecommendedCell.h"
#import "SearchUserCell.h"

#import "WYDropDownListPopUP.h"
#import "WYPopoverController.h"
#import "RecommendedJobDetailVC.h"
#import "FeedSearch.h"
#import "AppliedJobDetailVC.h"

#import "RateCell.h"

typedef enum : NSUInteger {
    Top_Cat = 0,
    Student_Cat = 2,
    Partner_Cat = 1,
    Professional_Cat = 3,
    Job_Cat = 4,
    Partner_Cat_Filter = 7,
    Professional_Cat_Filter = 8,
    Job_Cat_Filter = 9,
    
}SearchCatagories;

typedef enum : NSUInteger {
    Industry_filter = 0,
    jobtype_filter = 1,
    regintype_filter = 2,
    joblocation_filter = 3,
    rate_filter = 4,
}SearchFilters;


@interface PostSearchVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,WYPopoverControllerDelegate,GTDropDownList,RateCellDelegate>
{
    WYPopoverController *dropDownPopOverController;
    int selectedOptions;
    int indexForText;
}


@property (nonatomic) SearchCatagories search_catagory;
@property (nonatomic) SearchFilters search_filter;
@property (strong, nonatomic) NSString* filterTableHeadertitle;

@property (strong, nonatomic) NSString* selectedIndustry;
@property (strong, nonatomic) NSString* selectedContract;
@property (strong, nonatomic) NSString* selectedRegin;
@property (strong, nonatomic) NSString* selectedLocation;
@property (strong, nonatomic) NSString* selectedStars;

@property (strong, nonatomic) NSString* addedFilterUrl;


@end


@implementation PostSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.filterCollectionView registerNib:[UINib nibWithNibName:@"SearchFilterCell" bundle:nil] forCellWithReuseIdentifier:@"SearchFilterCell"];
    
    self.searchBar.text = _serchText;
    self.selectedIndex = 0;
    
    self.indusrties = [NSMutableArray array];
    self.jobTypeArray = [NSMutableArray array];
    self.regionTypeArray = [NSMutableArray array];
    self.jobLocationArray = [NSMutableArray array];
    
    
    
    [self getIndustries];
    [self otherFilterList];
    
    self.filterTableView.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
    self.searchBtn.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    
    
    _search_catagory = Top_Cat;

    [self searchString];
    
    self.filterTableViewContainer.hidden = YES;
  /*
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.filterTableViewContainer addGestureRecognizer:singleFingerTap];
   */
   
    self.filterTableHeadertitle = @"";
    self.selectedIndustry = @"";
    self.selectedContract = @"";
    self.selectedRegin = @"";
    self.selectedLocation = @"";
    self.selectedStars = @"";
    
    self.addedFilterUrl = @"";
    
    self.searchBtn.layer.cornerRadius = 8.0;
    self.searchBtn.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchString
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.searchBtn.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view endEditing:YES];
    
    self.sString = [NSString stringWithFormat:@"?q=%@&search_type=%lu",self.searchBar.text,(unsigned long)_search_catagory];
    if(self.addedFilterUrl != nil && self.addedFilterUrl.length != 0){
        self.sString = [NSString stringWithFormat:@"%@%@",self.sString,self.addedFilterUrl];
    }
    NSLog(@"%@",self.sString);
    self.sString = [self.sString stringByAddingPercentEscapesUsingEncoding:
                    NSUTF8StringEncoding];
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting ...."];
     [AUTH_MAN searchFeed:self.sString parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
         
         [SHARED_MANAGER hideWorkingSpinner:self.view];
         self.addedFilterUrl = @"";
         if(response && [response isKindOfClass:[NSArray class]]) {
             
             self.feedSearchObj = [[FeedSearch alloc] initWithDictionary:response];
             
             [self.searchResultTableView reloadData];
                          
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

- (IBAction)filterBtnPressed:(UIButton *)sender {
    
    [SHARED_MANAGER.wyDropDownArray removeAllObjects];
    if (self.selectedIndex == 1)
    {
        [SHARED_MANAGER.wyDropDownArray addObject:@"Industry"];
    }
    else if (self.selectedIndex == 2)
    {
        [SHARED_MANAGER.wyDropDownArray addObject:@"Industry"];
        [SHARED_MANAGER.wyDropDownArray addObject:@"Stars"];
    }
    else if (self.selectedIndex == 4)
    {
        [SHARED_MANAGER.wyDropDownArray addObject:@"Industry"];
        [SHARED_MANAGER.wyDropDownArray addObject:@"Job Type"];
        [SHARED_MANAGER.wyDropDownArray addObject:@"Region"];
        [SHARED_MANAGER.wyDropDownArray addObject:@"Job Location"];
    }
 
    if (self.selectedIndex == 1 || self.selectedIndex == 2 || self.selectedIndex == 4) {
        
        [self addDropDownList:@"Select"];
    }
    else if(self.selectedIndex == 0)
    {
        [self addDropDownList:@"Select Catagory Before Filter"];
    }
    else
    {
        [self addDropDownList:@"No Filters for Students"];
    }
   
}
- (void) getIndustries
{
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading..."];
    [AUTH_MAN getIndustries:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            NSMutableArray *industries = [NSMutableArray array];
            for (id dic in response) {
                Industry *industry = [[Industry alloc] initWithDictionary:dic[@"industry"]];
                [industries addObject:industry];
            }
            self.indusrties = industries;
//            [self.tableView reloadData];
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
- (void) otherFilterList
{
    [self.jobTypeArray addObject: @"Any"];
    [self.jobTypeArray addObject: @"Part Time"];
    [self.jobTypeArray addObject: @"Full Time"];
    
    [self.regionTypeArray addObject: @"Any"];
    [self.regionTypeArray addObject: @"qn"];
    [self.regionTypeArray addObject: @"qn_wn"];
    [self.regionTypeArray addObject: @"gn"];

    [self.jobLocationArray addObject: @"Any"];
    [self.jobLocationArray addObject: @"Remote"];
    [self.jobLocationArray addObject: @"On Site"];
    
}
- (IBAction)backBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark collection View
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchFilterCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchFilterCell" forIndexPath:indexPath];
    cell.bottomBar.hidden = YES;
    
    
    switch (indexPath.row) {
            
        case 0:
            cell.FilterTitle.text = @"Top";
            break;
        case 1:
            cell.FilterTitle.text = @"Partner";
            break;
        case 2:
            cell.FilterTitle.text = @"Professional";
            break;
        case 3:
            cell.FilterTitle.text = @"Student";
            break;
        case 4:
            cell.FilterTitle.text = @"Jobs";
            break;
            
        default:
            break;
    }
    
    if (self.selectedIndex == indexPath.row) {
         cell.bottomBar.hidden = NO;
    }
    
    
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    SearchFilterCell *cell =(SearchFilterCell*) [collectionView cellForItemAtIndexPath:indexPath];
//    cell.bottomBar.hidden = NO;
    
    self.selectedIndex = (int)indexPath.row;
    [self.filterCollectionView reloadData];
    
   // self.filterTableViewContainer.transform = CGAffineTransformMakeTranslation(0.0,+self.filterTableViewContainer.frame.size.height);
    
    switch (indexPath.row) {
        case 0:
            self.search_catagory = Top_Cat;
            break;
        case 1:
            self.search_catagory = Partner_Cat;
            break;
        case 2:
            self.search_catagory = Professional_Cat;
            break;
        case 3:
            self.search_catagory = Student_Cat;
            break;
        case 4:
            self.search_catagory = Job_Cat;
            break;
            
        default:
            break;
    }
    [self searchString];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.searchBtn.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    SearchFilterCell *cell =(SearchFilterCell*) [collectionView cellForItemAtIndexPath:indexPath];
//    cell.bottomBar.hidden = YES;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((ScreenWidth - 45)/3.5, 45);
}

#pragma mark DropDown
-(void) addDropDownList:(NSString*) title
{
    
    WYDropDownListPopUP *dropdownV = [[WYDropDownListPopUP alloc] initWithNibName:@"WYDropDownListPopUP" bundle:[NSBundle mainBundle]];
    dropdownV.selectedOptions = selectedOptions;
    float height = 0.0;
    height = (SHARED_MANAGER.wyDropDownArray.count)*40 + 40;
    
    dropdownV.tableHeaderText = title;//@"Select";
    
    dropdownV.preferredContentSize = CGSizeMake(self.view.frame.size.width*0.7, height
                                                             );
    dropdownV.modalInPopover = NO;
    
    UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:dropdownV];
    
    dropDownPopOverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
    dropDownPopOverController.delegate = self;
    dropdownV.DropDowndelegate = self;
    dropDownPopOverController.passthroughViews = @[];
    dropDownPopOverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    dropDownPopOverController.wantsDefaultContentAppearance = NO;
    
    
    
    [dropDownPopOverController presentPopoverFromRect:self.filterBtn.bounds
                                               inView:self.filterBtn
                             permittedArrowDirections:WYPopoverArrowDirectionAny
                                             animated:YES
                                              options:WYPopoverAnimationOptionFadeWithScale];
}
-(void) selectedOptionFromList:(int)index
{
    [dropDownPopOverController dismissPopoverAnimated:NO];
     //    self.filterTableViewContainer.transform = CGAffineTransformMakeTranslation(0.0,-self.filterTableViewContainer.frame.size.height);
     
    [UIView animateWithDuration:0.5 animations:^{
             self.filterTableView.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
    }];
    //CGAffineTransformMakeTranslation(0.0,0.0);
    
    if (self.search_catagory == Partner_Cat || self.search_catagory == Partner_Cat_Filter) {
        self.search_catagory = Partner_Cat_Filter;
        self.search_filter = Industry_filter;
        self.filterTableHeadertitle = @"Industry";
    }
    else if(self.search_catagory == Professional_Cat ||  self.search_catagory == Professional_Cat_Filter)
    {
        self.search_catagory = Professional_Cat_Filter;
        switch (index) {
            case 0:
                self.search_filter = Industry_filter;
                self.filterTableHeadertitle = @"Industry";
                break;
            case 1:
                self.search_filter = rate_filter;
                self.filterTableHeadertitle = @"Star";
                break;
                
            default:
                break;
        }
    }
    else if(self.search_catagory == Job_Cat ||  self.search_catagory == Job_Cat_Filter)
    {
        self.search_catagory = Job_Cat_Filter;
        switch (index) {
            case 0:
                self.search_filter = Industry_filter;
                self.filterTableHeadertitle = @"Industry";
                break;
            case 1:
                self.search_filter = jobtype_filter;
                self.filterTableHeadertitle = @"Job Type";
                break;
            case 2:
                self.search_filter = regintype_filter;
                self.filterTableHeadertitle = @"Regin";
                break;
            case 3:
                self.search_filter = joblocation_filter;
                self.filterTableHeadertitle = @"Location";
                break;
            case 4:
                self.search_filter = rate_filter;
                self.filterTableHeadertitle = @"Star";
                break;
                
            default:
                break;
        }

    }
    self.filterTableViewContainer.hidden = NO;
    
    [self.filterTableView reloadData];
    
}
#pragma search delegates
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchString];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

#pragma -mark tableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchResultTableView) {
        
        return 2;
    }
    else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.searchResultTableView) {
        
        return 0.0;
    }
    else
    {
        return 55.0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  
    NSString * resuseID = @"profileOptionCell";
    ProfileOptionsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileOptionsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    view.backgroundColor = [UIColor whiteColor];
    cell.contentView.frame = CGRectMake(0, 0, ScreenWidth, 55);
    
    cell.title.text = self.filterTableHeadertitle;
    
    cell.addBtn.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [view addSubview:cell.contentView];
    return view;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchResultTableView) {
        
        switch (section) {
            case 0:
                return self.feedSearchObj.usersArray.count;
                break;
            case 1:
                return self.feedSearchObj.jobsArray.count;
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (self.search_filter) {
            case Industry_filter:
                return self.indusrties.count;
                break;
            case jobtype_filter:
                return self.jobTypeArray.count;
                break;
            case regintype_filter:
                return self.regionTypeArray.count;
                break;
            case joblocation_filter:
                return self.jobLocationArray.count;
                break;
            case rate_filter:
                return 1;
                break;
                
            default:
                break;
        }

    }
    return 0 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchResultTableView) {
        
        return 100.0;
    }
    else
    {
        return  51.0;
    }
    
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchResultTableView) {
        
        switch (indexPath.section) {
            case 0:
            {
                QPNUser *userObj = [self.feedSearchObj.usersArray objectAtIndex:indexPath.row];//self.recommendedJobs[indexPath.row];
                NSString * resuseID = @"SearchUserCell";
                SearchUserCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchUserCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
               // [cell configureCell:user];
                cell.userObj = userObj;
                [cell populateData];
                
                return cell;
            }
                break;
            case 1:
            {
                Job *job = [self.feedSearchObj.jobsArray objectAtIndex:indexPath.row];//self.recommendedJobs[indexPath.row];
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
    else
    {
        if (self.search_filter != rate_filter) {
            NSString * resuseID = @"TitleSubTitleCell";
            TitleSubTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            switch (self.search_filter) {
                case Industry_filter:
                {
                    Industry *industry = [self.indusrties objectAtIndex:indexPath.row];
                    cell.title.text = industry.industryName;
                }
                    break;
                case jobtype_filter:
                {
                    cell.title.text = [self.jobTypeArray objectAtIndex:indexPath.row];
                }
                    break;
                case regintype_filter:
                {
                    cell.title.text = [self.regionTypeArray objectAtIndex:indexPath.row];
                }
                    break;
                case joblocation_filter:
                {
                    cell.title.text = [self.jobLocationArray objectAtIndex:indexPath.row];
                }
                    break;
                    
                default:
                    break;
            }
            
            cell.subTitle.text = @"";
            cell.subsubTitle.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            NSString * resuseID = @"RateCell";
            RateCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RateCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.rateDelegate = self;
            [cell setRatting:0];
            
            return cell;
        }
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.searchResultTableView) {
        
        switch (indexPath.section) {
            case 0:
            {
                QPNUser *userObj = [self.feedSearchObj.usersArray objectAtIndex:indexPath.row];
                OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
                vc.userId = [userObj.userId stringValue];
                [self.navigationController pushViewController:vc animated:YES];
            
            }
            break;
            case 1:
            {
                Job *job = [self.feedSearchObj.jobsArray objectAtIndex:indexPath.row];//self.recommendedJobs[indexPath.row];
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
        }
    }
    else
    {
        switch (self.search_filter) {
            case Industry_filter:
            {
                Industry *industry = [self.indusrties objectAtIndex:indexPath.row];
               self.selectedIndustry = industry.industryName;
            }
                break;
            case jobtype_filter:
            {
                self.selectedContract = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            }
                break;
            case regintype_filter:
            {
                self.selectedRegin = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            }
                break;
            case joblocation_filter:
            {
                self.selectedLocation = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            }
                break;
                
            default:
                break;
        }
        
        self.addedFilterUrl = [NSString stringWithFormat:@"&industry=%@&contract_type=%@&rigion=%@&location=%@",self.selectedIndustry,self.selectedContract,self.selectedRegin,self.selectedLocation];
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.filterTableView.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
            
        } completion:^(BOOL finished) {
            
            self.filterTableViewContainer.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                
                self.searchBtn.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
            }];
        }];
        
        
    }
}

// tab Gestur
- (IBAction)doneClick:(id)sender {
    [self handleSingleTap:nil];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5 animations:^{
        
         self.filterTableView.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
        
    } completion:^(BOOL finished) {
        
        self.filterTableViewContainer.hidden = YES;
    }];
}

- (IBAction)searchBtnPress:(UIButton *)sender {
    
    [self searchString];
}

-(void) onRateBtnClicked:(id) sender starTag:(int) tag
{
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.filterTableView.transform = CGAffineTransformMakeTranslation(0.0,+ScreenHeight);
        
    } completion:^(BOOL finished) {
        
        self.filterTableViewContainer.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            
            self.searchBtn.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

@end
