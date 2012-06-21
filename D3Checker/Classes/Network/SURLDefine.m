//
//  SURLDefine.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-21.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SURLDefine.h"

#pragma mark - ASIDownloadCache
#import "D3DataManager.h"
static ASIDownloadCache *documentCache = nil;
static ASIDownloadCache *unloginDocumentCache = nil;
static ASIDownloadCache *imageCache = nil;

@implementation ASIDownloadCache(CustomCache)
+ (ASIDownloadCache *)shareDocumentCache {
    ASIDownloadCache *result = nil;
    if ([[D3DataManager shareInstance] isLogin]) {
        if (!documentCache) {
            @synchronized(self) {
                documentCache = [[self alloc] init];
                [documentCache setStoragePath:[SUtil pathCUserCacheDocs]];
            }
        }
        result = documentCache;
    } else {
        if (!unloginDocumentCache) {
            @synchronized(self) {
                unloginDocumentCache = [[self alloc] init];
                [unloginDocumentCache setStoragePath:[SUtil pathCacheDocs]];
            }
        }
        result = unloginDocumentCache;
    }
    return result;
}
+ (ASIDownloadCache *)shareImageCache {
    if (!imageCache) {
		@synchronized(self) {
			if (!imageCache) {
				imageCache = [[self alloc] init];
				[imageCache setStoragePath:[SUtil pathCacheImgs]];
			}
		}
	}
	return imageCache;
}
@end


@implementation SURLDefine



@end