//
//  HomeViewDataSource.h
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataSource.h"

@interface HomeViewDataSource : TableViewDataSource{
    
}

//获取category下的plist文件信息
+ (NSArray *)imagesInfoWithCategory:(NSString *)category;

@end
