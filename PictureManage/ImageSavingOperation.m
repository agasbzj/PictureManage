//
//  ImageSavingOperation.m
//  almondz
//
//  Created by 卞中杰 on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageSavingOperation.h"
#import "RotateUIImage.h"

@implementation ImageSavingOperation
@synthesize path = _path;
@synthesize category = _category;
@synthesize detail = _detail;
@synthesize image = _image;
@synthesize imagesArray = _imagesArray;
@synthesize name = _name;
@synthesize parent;
@synthesize progressValue;



- (void)main {
    UIImage *img = [UIImage rotateImage:_image];
    NSData *imgData = UIImagePNGRepresentation(img);
    [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", _path, _name] atomically:YES];
    
    NSString *detailFile = [NSString stringWithFormat:@"%@/Details.plist", _path];
    NSMutableArray *detailArray;
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:detailFile];
    if ([array count])
        detailArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    else
        detailArray = [[NSMutableArray alloc] init];
    NSDictionary *detailDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@.png", _name], @"name", _detail?_detail:@"点击以修改详细信息", @"detail", nil];
    [detailArray addObject:detailDic];
    [detailArray writeToFile:detailFile atomically:YES];
    NSLog(@"SAVEDSAVED");
    [parent performSelectorOnMainThread:@selector(changeImportProgress) withObject:nil waitUntilDone:YES];
    [parent performSelectorOnMainThread:@selector(clearSelected) withObject:nil waitUntilDone:YES];
    [detailArray release];
}


- (void)dealloc {
    [_path release];
    [_category release];
    [_detail release];
    [_image release];
    [_imagesArray release];
    [_name release];
    [parent release];
    [super dealloc];
}
@end
