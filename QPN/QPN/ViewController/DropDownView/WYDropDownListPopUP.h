//
//  WYDropDownListPopUP.h
//
//  Created by Nicolas CHENG on 02/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GTDropDownList <NSObject>

-(void) selectedOptionFromList:(int)index;

@end

@interface WYDropDownListPopUP : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
}
@property (nonatomic,assign) id <GTDropDownList> DropDowndelegate;
@property (nonatomic)int selectedOptions;
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic,strong) NSString* tableHeaderText;


@end
