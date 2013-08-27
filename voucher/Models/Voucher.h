//
//  Voucher.h
//  voucher
//
//  Created by fei wang on 13-8-27.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Voucher : NSObject

@property (assign, nonatomic) int id;

@property (strong, nonatomic) NSString *name;

@property (assign, nonatomic) BOOL reusable;

@property (assign, nonatomic) BOOL featured;

@property (assign, nonatomic) int reuseTotal;

@property (assign, nonatomic) int reuseLeft;

@property (strong, nonatomic) NSString *termCondition;

@property (strong, nonatomic) NSString *endTime;

- (id)initWithData: (id)data;

- (void)loadData: (id)data;

@end
