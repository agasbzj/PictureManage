//
//  ImageSavingOperation.h
//  almondz
//
//  Created by 卞中杰 on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageImporterController;
@interface ImageSavingOperation : NSOperation {
    NSString *_path;
    NSString *_category;
    NSString *_detail;
    NSString *_name;
    UIImage *_image;
    NSMutableArray *_imagesArray;
    float progressValue;
    id parent;
}
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, retain) id parent;
@property (nonatomic, assign) float progressValue;


@end
