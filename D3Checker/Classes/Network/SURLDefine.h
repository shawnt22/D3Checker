//
//  SURLDefine.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-21.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"

@interface ASIDownloadCache(CustomCache)
+ (ASIDownloadCache *)shareDocumentCache;
+ (ASIDownloadCache *)shareImageCache;
@end

typedef enum {
    SURLRequestInvalid = 0,
}SURLRequestTag;

@interface SURLDefine : NSObject

+ (NSString *)checkD3ServerStatus;

@end