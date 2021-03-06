//
//  VoucherView.h
//  voucher
//
//  Created by fei wang on 13-8-24.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol voucherViewDelegate<NSObject>

-(void)showMerchantOnMapClick: (id)sender;

-(void)redeemVoucherClick: (id)sender;

-(void)favouriteClick: (id)sender;

-(void)shareClick: (id)sender;

@end

@interface VoucherView : UIView

@property (weak, nonatomic) IBOutlet UILabel *voucherTitle;

@property (weak, nonatomic) IBOutlet UIImageView *merchantLogo;

@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (weak, nonatomic) IBOutlet UIImageView *closeButton;

@property (weak, nonatomic) IBOutlet UITextView *description;

@property (weak, nonatomic) IBOutlet UIImageView *showMapView;

@property (weak, nonatomic) IBOutlet UIButton *redeemBut;

@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;


@property (nonatomic, assign) id<voucherViewDelegate> delegate;

- (void)updateView: (BOOL)favourite;

@end
