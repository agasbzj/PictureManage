//
//  HomeViewDataSource.m
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "HomeViewDataSource.h"


@implementation HomeViewDataSource


+ (NSArray *)imagesInfoWithCategory:(NSString *)category {
    NSArray *array = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/%@/Details.plist", NSHomeDirectory(), category]];
    if (array) 
        return array;
    else
        return nil;
}

@end
