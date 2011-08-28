//
//  Picture.h
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Picture : NSObject {
    NSString *  imageUrl;  //1.jpg
    NSString *  imageDescript;
    NSString *  belongCategory;
}


@property(nonatomic,retain) NSString *  imageUrl;
@property(nonatomic,retain) NSString *  imageDescript;
@property(nonatomic,retain) NSString *  belongCategory;
@end
