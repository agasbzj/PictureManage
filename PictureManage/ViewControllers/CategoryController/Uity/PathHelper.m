//
//  PathHelper.m
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "PathHelper.h"


@implementation PathHelper

+(BOOL)createPathIfNecessary:(NSString *)name{
    
    BOOL succeeded = YES;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
	NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];

    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:cachePath]){
        succeeded = [fm createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil ];
    }
    
    return succeeded;
}


    
@end

