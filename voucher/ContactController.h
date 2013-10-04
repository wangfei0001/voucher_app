//
//  ContactController.h
//  voucher
//
//  Created by fei wang on 13-10-1.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtContent;

@property (weak, nonatomic) IBOutlet UITextField *txtContact;

@end
