//
//  SideDrawerVC.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideDrawerVC : UIViewController
@property (nonatomic,strong) NSMutableArray * sideList;
@property (strong, nonatomic) IBOutlet UITableView *sideMenuTableView;
@property(nonatomic)int selectedCell;

@property (weak, nonatomic) IBOutlet UIImageView *profileDp;
@property (weak, nonatomic) IBOutlet UILabel *userNAme;

@end
