//
//  IndustryVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "IndustryVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "ProfileOptionsCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "GTAuthorizationManager.h"
#import "GTSharedData.h"
#import "Industry.h"


@interface IndustryVC ()

@property (nonatomic,strong)NSArray *indusrties;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation IndustryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    [AUTH_MAN getIndustries:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            NSMutableArray *industries = [NSMutableArray alloc];
            for (id dic in response) {
                Industry *industry = [[Industry alloc] initWithDictionary:dic];
                [industries addObject:industry];
            }
            self.indusrties = industries;
            [self.tableView reloadData];
        }else{
            if(error) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [self.view makeToast:errorDic[@"errors"]];
            }
        }
        
    }];
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.indusrties.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"profileOptionCell";
    ProfileOptionsCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileOptionsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Industry *industry = [self.indusrties objectAtIndex:indexPath.row];
    cell.title.text = industry.industryName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Industry *industry = [self.indusrties objectAtIndex:indexPath.row];
    if(_delegate && [_delegate respondsToSelector:@selector(selectedIndustry:)]) {
        [_delegate selectedIndustry:industry];
        [self dismissViewControllerAnimated:YES completion:nil];
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




@end
