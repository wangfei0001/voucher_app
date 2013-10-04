//
//  CategoryView.m
//  voucher
//
//  Created by fei wang on 13-9-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "CategoryView.h"

//#import "Category.h"

#define CATS_VIEW_HEIGHT 220

@implementation CategoryView{

}

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
        self.visible = NO;
        
        [self setBackgroundColor: [UIColor colorWithWhite:0.0 alpha:0.2]];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    UINib *cellNib = [UINib nibWithNibName:@"CategoryCell" bundle:nil];
    [self.catsView registerNib:cellNib forCellWithReuseIdentifier:@"CategoryCell"];
    
    self.catsView.frame = CGRectMake(0, CATS_VIEW_HEIGHT * -1 + 44, 320, CATS_VIEW_HEIGHT);
    
    self.catsView.backgroundColor = [UIColor whiteColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)show: (UIView *)parentView
{
    if(!self.visible){
        [parentView addSubview:self];
        
        
        CGRect newFrame = CGRectMake(0, 44, 320, CATS_VIEW_HEIGHT);
        [UIView animateWithDuration:0.3 animations:^{
            self.catsView.frame = newFrame;
        } completion:^(BOOL finished) {
            self.visible = YES;
        }];
    }
}

- (void)hide
{
    if(self.visible){
        CGRect newFrame = CGRectMake(0, CATS_VIEW_HEIGHT * -1 + 44, 320, CATS_VIEW_HEIGHT);
        [UIView animateWithDuration:0.3 animations:^{
            self.catsView.alpha = 0;
        } completion:^(BOOL finished) {
            self.catsView.frame = newFrame;
            self.catsView.alpha = 1;
            [self removeFromSuperview];
            self.visible = NO;
        }];
        
        

    }
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.catsData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Category *cat = [self.catsData objectAtIndex:indexPath.row];

    UILabel *label = (UILabel *)[cell viewWithTag:51];
    label.text = cat.name;
    
    //NSLog(@"%f %f", rect.size.width, rect.size.height);
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0,0,0);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Category *cat = [self.catsData objectAtIndex:indexPath.row];
    
    [self hide];
    
    [self.delegate categoryClick:self selectedCat:cat];
}



#pragma Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch *touch = touches.anyObject;
    
    if(touch.view == self){
        [self hide];
    }
}

@end
