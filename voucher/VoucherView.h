//
//  VoucherView.h
//  voucher
//
//  Created by fei wang on 13-8-24.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol voucherViewDelegate<NSObject>

-(void)showMerchantOnMapClick:(id)sender;

@end

@interface VoucherView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *closeButton;

@property (weak, nonatomic) IBOutlet UITextView *description;

@property (weak, nonatomic) IBOutlet UIImageView *showMapView;

@property (nonatomic, assign) id<voucherViewDelegate> delegate;


@end
