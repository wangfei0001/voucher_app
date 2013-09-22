//
//  SearchBar.m
//  voucher
//
//  Created by fei wang on 13-9-18.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass: [UITextField class]] ) {
            
            ((UITextField *)subview).clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
    [self setShowsCancelButton:NO animated:NO];
}

@end
