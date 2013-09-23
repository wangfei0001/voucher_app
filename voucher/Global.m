//
//  Global.m
//  voucher
//
//  Created by fei wang on 13-9-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Global.h"

#import "Api.h"

#import "Category.h"

@implementation Global

- (id)init
{
    self = [super init];
    
    if(self){
        [self initCategories];
    }
    return self;
}

- (void)initCategories
{
    
    
    [Api getCategories:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        NSMutableArray *cats = [[NSMutableArray alloc] initWithCapacity:0];
        
        for(id val in JSON){
            Category *cat = [[Category alloc] init];
            cat.id = [[val objectForKey:@"id_category"] intValue];
            cat.name = [val objectForKey:@"name"];
            
            [cats addObject:cat];
        }
        
        self.categories = cats;
    }];
    
    
}

@end
