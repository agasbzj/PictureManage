//
//  UIImage+Compress.h
//  PictureManage
//
//  Created by uzai on 11-9-3.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  UIImage(Compress)
- (UIImage *)compressedImage;

- (CGFloat)compressionQuality;

- (NSData *)compressedData;

- (NSData *)compressedData:(CGFloat)compressionQuality;

@end
