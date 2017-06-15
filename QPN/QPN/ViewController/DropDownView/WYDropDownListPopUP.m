//
//  WYDropDownListPopUP.m
//
//  Created by Nicolas CHENG on 02/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYDropDownListPopUP.h"
#import "GTConstants.h"
#import "WYDropDownCell.h"
#import "QPNSharedData.h"

@interface WYDropDownListPopUP ()
{
    
}
- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end

@implementation WYDropDownListPopUP

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WYSettingsTableViewCell"];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"view WILL appear");
}

- (void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"view DID appear");
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"view WILL disappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    //NSLog(@"view DID disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return SHARED_MANAGER.wyDropDownArray.count;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 30.0)];
        headerView.contentMode = UIViewContentModeScaleToFill;
        
        UIView* BaseLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30, screenRect.size.width, 1.0)];
//        BaseLine.backgroundColor = GREAY_BROWN;
        [headerView addSubview: BaseLine];
        headerView.contentMode = UIViewContentModeScaleToFill;
        
        // Add the label
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 3.5, ScreenWidth*0.7, 30.0)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.text = self.tableHeaderText;//@"Sharing Type";
        headerLabel.font = [UIFont systemFontOfSize:18];//APP_FONT(17);
        headerLabel.textColor = [UIColor colorWithRed:129.0/255.0 green:5.0/255.0 blue:65.0/255.0 alpha:1.0];
        

        headerLabel.textAlignment = UITextAlignmentCenter;
        [headerView addSubview: headerLabel];
        
        // Return the headerView
        return headerView;
    }
    else return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * resuseID = @"DropDownCell";
    WYDropDownCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WYDropDownCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.checkMark.hidden = YES;
  /*
    if(self.selectedOptions == indexPath.row){
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
        
    }else{
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
*/
    
    if ([[SHARED_MANAGER wyDropDownArray] objectAtIndex:indexPath.row])
    {
        cell.cellLable.text = [[SHARED_MANAGER wyDropDownArray] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [aTableView deselectRowAtIndexPath:indexPath animated:NO];
    
   // WYDropDownCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownCell"];
    
   //     cell = [self.tableView cellForRowAtIndexPath:indexPath];
 //       cell.accessoryType  = UITableViewCellAccessoryNone;
    if(self.DropDowndelegate&&[self.DropDowndelegate respondsToSelector:@selector(selectedOptionFromList:)]){
    
        [self.DropDowndelegate selectedOptionFromList:(int)indexPath.row];
    }
    
}

#pragma mark - Private

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *data  = [SHARED_MANAGER wyDropDownArray][indexPath.row];
    cell.textLabel.text = data[@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:data[@"image"]];
    
    if(self.selectedOptions == indexPath.row){
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;

    }else{
         cell.accessoryType  = UITableViewCellAccessoryNone;
    }
  
}

@end
