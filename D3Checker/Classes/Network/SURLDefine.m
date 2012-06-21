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

+ (NSString *)checkD3ServerStatus {
    NSString *url = nil;
    
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageUS_EN:
        {
            url = @"http://us.battle.net/d3/en/status";
        }
            break;
        case D3SupportLanguageUS_ES:
        {
            url = @"http://us.battle.net/d3/es/status";
        }
            break;
        case D3SupportLanguageUS_PT:
        {
            url = @"http://us.battle.net/d3/pt/status";
        }
            break;
        case D3SupportLanguageEU_DE:
        {
            url = @"http://eu.battle.net/d3/de/status";
        }
            break;
        case D3SupportLanguageEU_EN:
        {
            url = @"http://eu.battle.net/d3/en/status";
        }
            break;
        case D3SupportLanguageEU_ES:
        {
            url = @"http://eu.battle.net/d3/es/status";
        }
            break;
        case D3SupportLanguageEU_FR:
        {
            url = @"http://eu.battle.net/d3/fr/status";
        }
            break;
        case D3SupportLanguageEU_IT:
        {
            url = @"http://eu.battle.net/d3/it/status";
        }
            break;
        case D3SupportLanguageEU_PL:
        {
            url = @"http://eu.battle.net/d3/pl/status";
        }
            break;
        case D3SupportLanguageEU_PT:
        {
            url = @"http://eu.battle.net/d3/pt/status";
        }
            break;
        case D3SupportLanguageEU_RU:
        {
            url = @"http://eu.battle.net/d3/ru/status";
        }
            break;
        case D3SupportLanguageKR_KO:
        {
            url = @"http://kr.battle.net/d3/ko/status";
        }
            break;
        case D3SupportLanguageTW_ZH:
        {
            url = @"http://tw.battle.net/d3/zh/status";
        }
            break;
        case D3SupportLanguageSEA_EN:
        {
            url = @"http://us.battle.net/d3/en/status";
        }
            break;
        default:
            break;
    }
    
    return url;
}

@end