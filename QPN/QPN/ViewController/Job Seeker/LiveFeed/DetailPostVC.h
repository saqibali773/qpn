//
//  DetailPostVC.h
//  QPN
//
//  Created by Muhammad Usman on 14/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPNPost.h"
#import "QPNSharedData.h"
#import "QPNPostComment.h"

@interface DetailPostVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QPNPost * post;

@property (nonatomic,strong) NSMutableArray* commentsArray;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;


@end
