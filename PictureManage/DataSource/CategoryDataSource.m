//
//  CategoryDataSource.m
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "CategoryDataSource.h"

static  NSArray * gCategorys;

@implementation CategoryDataSource


+(NSArray *)categorys{


    gCategorys=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil];

    
    
    return gCategorys;

}





@end

