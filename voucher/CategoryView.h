//
//  CategoryView.h
//  voucher
//
//  Created by fei wang on 13-9-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIView

@property (strong, nonatomic) NSMutableArray *catsData;

@property (weak, nonatomic) IBOutlet UICollectionView *catsView;

@property (assign, nonatomic) BOOL visible;

- (void)show: (UIView *)parentView;

- (void)hide;

@end
