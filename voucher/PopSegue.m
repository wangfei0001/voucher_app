//
//  PopSegue.m
//  coolTab
//
//  Created by fei wang on 24/02/13.
//  Copyright (c) 2013 fei wang. All rights reserved.
//

#import "PopSegue.h"

@implementation PopSegue

- (void) perform {
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    [src.navigationController popViewControllerAnimated:YES];
}

@end
