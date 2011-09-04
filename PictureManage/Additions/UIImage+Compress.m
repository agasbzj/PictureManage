//
//  UIImage+Compress.m
//  PictureManage
//
//  Created by uzai on 11-9-3.
//  Copyright 2011年 UZAI. All rights reserved.
//
#define MAX_IMAGEPIX 50

@implementation UIImage (Compress)
- (UIImage *)compressedImage {
    
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    
    if (width <= MAX_IMAGEPIX && height<= MAX_IMAGEPIX) {
        
        // no need to compress.
        
        return self;
        
    }
    
    
    if (width == 0 || height == 0) {
        
        // void zero exception
        
        return self;
        
    }
    
    
    UIImage *newImage = nil;
    
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        
        scaleFactor = heightFactor; // scale to fit height
    
    else
        
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth  = width * scaleFactor;
    
    CGFloat scaledHeight = height * scaleFactor;
    
    
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    
    
    [self drawInRect:thumbnailRect];
    
    
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //pop the context to get back to the default
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



- (NSData *)compressedData:(CGFloat)compressionQuality {
    
    assert(compressionQuality<=1.0 && compressionQuality >=0);
    
    return UIImageJPEGRepresentation(self, compressionQuality);
    
}



- (CGFloat)compressionQuality {
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    
    NSUInteger dataLength = [data length];
    
    if(dataLength>50000.0) {
        
        // 5K
        
        return 1.0-50000.0/dataLength;
        
    } else {
        
        return 1.0;
        
    }
    
}



- (NSData *)compressedData {
    
    CGFloat quality = [self compressionQuality];
    
    return [self compressedData:quality];
    
}

@end