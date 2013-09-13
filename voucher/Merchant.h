//
//  Merchant.h
//  voucher
//
//  Created by fei wang on 13-9-14.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Merchant : NSObject


@property (assign, nonatomic) float lat;

@property (assign, nonatomic) float lng;

@property (strong, nonatomic) NSString *company;

@property (strong, nonatomic) NSString *logo;

@property (assign, nonatomic) int id_merchant;

- (id)initWithData: (id)data;


@end
