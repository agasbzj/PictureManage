//
//  Hash.h
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Hash : NSObject {
    
}
+(NSString*) md5:(NSString*) str;
+(NSString *)file_md5:(NSString*) path;
@end
