//
//  GTFeedback.m
//  QRApp
//  Created by Usama Shakeel on 01/11/2014.
//  Copyright (c) 2014 Usama Shakeel. All rights reserved.
//

#import "RoundedImageView.h"
#import <UIKit/UIKit.h>
@interface RoundedImageView ()

@end

@implementation RoundedImageView


- (void)dealloc
{
 
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = self.roundedCorner;
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
         self.layer.cornerRadius = self.roundedCorner;
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{[super drawRect:rect];
}

@end

