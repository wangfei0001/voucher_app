//
//  CategoryViewLayout.m
//  voucher
//
//  Created by fei wang on 13-9-25.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "CategoryViewLayout.h"

@implementation CategoryViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    [self setItemSize:CGSizeMake(80, 72)];
//    [self setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}

@end
