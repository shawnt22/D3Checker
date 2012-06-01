//
//  SUtil.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SUtil.h"
#import "Util.h"
#import "SDataManager.h"

@implementation SUtil

#pragma mark - Path
+ (NSString *)pathGlobalConfiger {
    return [Util filePathWith:@"common/document" isDirectory:YES];
}

#pragma mark - URLPath
+ (NSString *)checkD3ServerStatus {
    NSString *url = nil;
    
    switch ([SDataManager shareInstance].settings.language) {
        case DSupportLanguageCN_TW:
        {
            url = @"http://tw.battle.net/d3/zh/status";
        }
            break;
        case DSupportLanguageEN:
        {
            url = @"http://tw.battle.net/d3/zh/status";
        }
            break;
        default:
            break;
    }
    
    return url;
}

@end
