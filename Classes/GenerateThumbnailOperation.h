//
//  GenerateThumbnailOperation.h
//  almondz
//
//  Created by 卞中杰 on 11-7-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GenerateThumbnailOperation : NSOperation {
    NSString *_thumbnailPath;   //缩略图路径
    NSString *_oriImagePath;    //原始图片路径
    UIImage *_image;    //原始图片
    id parent;
}
@property (nonatomic, retain) NSString *thumbnailPath;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic ,retain) NSString *oriImagePath;
@property (nonatomic, retain) id parent;

- (id)initWithImagePath:(NSString *)oriImagePath thumbnailPath:(NSString *)thumbnailPath;
-(UIImage*) scaleAndRotateImage:(UIImage*)photoimage:(CGFloat)bounds_width:(CGFloat)bounds_height;
@end
