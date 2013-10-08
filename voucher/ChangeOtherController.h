//
//  ChangeOtherController.h
//  voucher
//
//  Created by fei wang on 13-10-7.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define USER_PROFILE_USERNAME       1

#define USER_PROFILE_EMAIL          2

@interface ChangeOtherController : UIViewController<UITextFieldDelegate>

@property (assign, nonatomic) int changeType;       //username or email or other text field

@property (weak, nonatomic) IBOutlet UITextField *txtValue;

@end
