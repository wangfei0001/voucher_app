//
//  VoucherCell.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "VoucherCell.h"

@implementation VoucherCell{
    UIImageView *backgroundImage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        //self.contentView.backgroundColor = [UIColor
        //                        redColor];
        backgroundImage =[[UIImageView alloc] init];
        backgroundImage.image = [UIImage imageNamed:@"voucher_bg.png"];
        
        //add the subView to the cell
        [self.contentView insertSubview:backgroundImage atIndex:0];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRectangle = CGRectMake(10,0.0f,300.0f,80.0f); //cells are 44 px high
    backgroundImage.frame = imageRectangle;
}

//cell.backgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
//cell.selectedBackgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_pressed.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];

@end
