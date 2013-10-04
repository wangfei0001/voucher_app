//
//  CategoryView.h
//  voucher
//
//  Created by fei wang on 13-9-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Category.h"

@protocol categoryViewDelegate<NSObject>

-(void)categoryClick: (id)sender selectedCat: (Category *)selectedCat;

@end

@interface CategoryView : UIView

@property (strong, nonatomic) NSMutableArray *catsData;

@property (weak, nonatomic) IBOutlet UICollectionView *catsView;

@property (assign, nonatomic) BOOL visible;

@property (nonatomic, assign) id<categoryViewDelegate> delegate;

- (void)show: (UIView *)parentView;

- (void)hide;

@end
