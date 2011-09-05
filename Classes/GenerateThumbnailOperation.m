//
//  GenerateThumbnailOperation.m
//  almondz
//
//  Created by 卞中杰 on 11-7-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GenerateThumbnailOperation.h"

#define THUMBNAIL_WIDTH 80.0
#define THUMBNAIL_HEIGHT 80.0

@implementation GenerateThumbnailOperation
@synthesize thumbnailPath = _thumbnailPath;
@synthesize image = _image;
@synthesize parent;
@synthesize oriImagePath = _oriImagePath;



- (id)initWithImagePath:(NSString *)oriImagePath thumbnailPath:(NSString *)thumbnailPath {
    if ((self = [super init])) {
        _image = [[UIImage imageWithContentsOfFile:oriImagePath] retain];
        _thumbnailPath = [thumbnailPath copy];
    }
    return self;
}

- (void)dealloc {
    [_thumbnailPath release];
    [_oriImagePath release];
    [_image release];
    [parent release];
    [super dealloc];
}

- (void)main {
    UIImage *img = [UIImage imageWithContentsOfFile:_thumbnailPath];
    if (img == nil) {
        //img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(_image.CGImage, CGRectMake(0, 0, 80, 80))];
        img = [self scaleAndRotateImage:_image :THUMBNAIL_WIDTH :THUMBNAIL_HEIGHT];
        NSData *data = UIImagePNGRepresentation(img);
        [data writeToFile:_thumbnailPath atomically:YES];
        [parent performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
}


-(UIImage*) scaleAndRotateImage:(UIImage*)photoimage:(CGFloat)bounds_width:(CGFloat)bounds_height
{
    //int kMaxResolution = 300;
    
    CGImageRef imgRef =photoimage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    /*if (width > kMaxResolution || height > kMaxResolution)
     {
     CGFloat ratio = width/height;
     if (ratio > 1)
     {
     bounds.size.width = kMaxResolution;
     bounds.size.height = bounds.size.width / ratio;
     }
     else
     {
     bounds.size.height = kMaxResolution;
     bounds.size.width = bounds.size.height * ratio;
     }
     }*/
    bounds.size.width = bounds_width;
    bounds.size.height = bounds_height;
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGFloat scaleRatioheight = bounds.size.height / height;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient =photoimage.imageOrientation;
    switch(orient)
    {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid?image?orientation"];
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatioheight);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatioheight);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
@end
