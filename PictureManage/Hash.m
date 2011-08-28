//
//  Hash.m
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Hash.h"
#import <commoncrypto/CommonDigest.h> 


@implementation Hash


+(NSString*) md5:(NSString*) str {  
    const char *cStr = [str UTF8String];  
    unsigned char result[CC_MD5_DIGEST_LENGTH];  
    CC_MD5( cStr, strlen(cStr), result );  
    
    return [NSString stringWithFormat:  
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",  
            result[0], result[1], result[2], result[3],  
            result[4], result[5], result[6], result[7],  
            result[8], result[9], result[10], result[11],  
            result[12], result[13], result[14], result[15]  
            ];  
}  

#define CHUNK_SIZE 1024  
+(NSString *)file_md5:(NSString*) path {  
    NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:path];  
    if(handle == nil)  
        return nil;  
    
    CC_MD5_CTX md5_ctx;  
    CC_MD5_Init(&md5_ctx);  
    
    NSData* filedata;  
    do {  
        filedata = [handle readDataOfLength:CHUNK_SIZE];  
        CC_MD5_Update(&md5_ctx, [filedata bytes], [filedata length]);  
    }  
    while([filedata length]);  
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];  
    CC_MD5_Final(result, &md5_ctx);  
    
    [handle closeFile];  
    
    return [NSString stringWithFormat:  
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",  
            result[0], result[1], result[2], result[3],  
            result[4], result[5], result[6], result[7],  
            result[8], result[9], result[10], result[11],  
            result[12], result[13], result[14], result[15]  
            ];  
}  

@end
