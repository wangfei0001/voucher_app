//
//  UIImage+FrColor.m
//  voucher
//
//  Created by fei wang on 13-10-5.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "UIImage+FrColor.h"

@implementation UIImage (FrColor)

+ (UIImage *)imageWithColor:(UIColor *)color
                       rect: (CGRect)rect
{
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
