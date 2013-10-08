//
//  VoucherCell.h
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol voucherCellViewDelegate<NSObject>

-(void)merchantClick: (id)sender merchantId: (int)merchantId;

@end

@interface VoucherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *merchantLogo;

@property (weak, nonatomic) IBOutlet UILabel *voucherName;

@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (assign, nonatomic) int merchantId;

@property (nonatomic, assign) id<voucherCellViewDelegate> delegate;


@end
