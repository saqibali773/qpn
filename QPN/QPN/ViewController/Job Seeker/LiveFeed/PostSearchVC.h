//
//  PostSearchVC.h
//  QPN
//
//  Created by Muhammad Usman on 16/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedSearch.h"

@interface PostSearchVC : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) NSString * serchText;

@property (nonatomic) int selectedIndex;

@property (weak, nonatomic) IBOutlet UIView *filterTableViewContainer;
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@property (nonatomic,strong)NSMutableArray *indusrties;
@property (nonatomic,strong)NSMutableArray *jobTypeArray;
@property (nonatomic,strong)NSMutableArray *regionTypeArray;
@property (nonatomic,strong)NSMutableArray *jobLocationArray;



@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;

@property (strong, nonatomic) NSString * sString;

@property (weak, nonatomic) IBOutlet UIButton *filterBtn;

@property (strong , nonatomic) FeedSearch * feedSearchObj;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;



@end
