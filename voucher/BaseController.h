//
//  BaseController.h
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "VoucherView.h"

#import "VoucherCell.h"

#import "Api.h"

@interface BaseController : UIViewController<voucherViewDelegate,
voucherCellViewDelegate,
UIActionSheetDelegate,
WeiboRequestDelegate,
WeiboAuthDelegate,
UIAlertViewDelegate
>

@property (nonatomic, weak) AppDelegate *appDelegate;

@property (weak, nonatomic) VoucherView *voucherView;

@property (weak, nonatomic) IBOutlet UITableView *mainTable;


@property (strong, nonatomic) NSMutableArray *data;     //voucher data

- (void)showVoucherView: (id)data;

- (void)showNotFound;

- (void)hideNotFound;

@end
