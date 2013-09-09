//
//  VoucherView.m
//  voucher
//
//  Created by fei wang on 13-8-24.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "VoucherView.h"

#import <QuartzCore/QuartzCore.h>

@implementation VoucherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        self.description.contentInset = UIEdgeInsetsMake(-8,-8,-8,-8);
//        self.description.font = [UIFont fontWithName:@"Arial" size:12];
//        [self.description setNeedsDisplay];
        
        //Adds a shadow to sampleView
        CALayer *layer = self.layer;
        layer.shadowOffset = CGSizeMake(1, 1);
        layer.shadowColor = [[UIColor blackColor] CGColor];
        layer.shadowRadius = 5.0f;
        layer.shadowOpacity = 0.40f;
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSIndexPath *indexPath = [(UITableView *)self.superview indexPathForCell: self];
    
    UITouch *touch = touches.anyObject;
    
    if(touch.view == self.closeButton){
        [self removeView];
    }else if(touch.view == self){
        [self removeView];
    }else if(touch.view == self.showMapView){      //inner view
        
        [self.delegate showMerchantOnMapClick:self];
    }
}

- (void)removeView
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect finalRect = self.frame;
                         finalRect.origin.x = -320;
                         [self setFrame:finalRect];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}


- (IBAction)redeemClick:(id)sender
{
    [self.delegate redeemVoucherClick:sender];
}


@end
