//
//  SharePostVC.m
//  QPN
//
//  Created by Muhammad Usman on 08/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SharePostVC.h"
#import "contactCell.h"

@interface SharePostVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SharePostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TableView Delegates
#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"contactCell";
    contactCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"contactCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    contactCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkBtn.selected = true;
    
}

@end
