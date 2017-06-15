//
//  GTFeedback.h
//  QRApp
//  Created by Usama Shakeel on 01/11/2014.
//  Copyright (c) 2014 Usama Shakeel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
IB_DESIGNABLE
IBInspectable
@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
