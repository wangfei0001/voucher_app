//
//  Merchant.h
//  voucher
//
//  Created by fei wang on 13-9-14.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Address.h"

@interface Merchant : NSObject



@property (strong, nonatomic) NSString *company;

@property (strong, nonatomic) NSString *logo;

@property (assign, nonatomic) int id_merchant;


@property (retain, nonatomic) NSMutableArray *addresses;

- (id)initWithData: (id)data;


@end
