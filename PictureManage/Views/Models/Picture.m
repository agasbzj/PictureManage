//
//  Picture.m
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "Picture.h"


@implementation Picture
@synthesize imageUrl,imageDescript,belongCategory;
-(void)dealloc{
    [imageUrl release];
    [imageDescript release];
    [belongCategory  release];
    [super dealloc];
    
}
@end
