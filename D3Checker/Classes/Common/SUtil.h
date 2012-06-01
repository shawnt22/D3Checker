//
//  SUtil.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DSupportLanguageEN,         //  英语
    DSupportLanguageCN_TW,      //  繁体中文
}DSupportLanguage;

@interface SUtil : NSObject

#pragma mark - Path
+ (NSString *)pathGlobalConfiger;

#pragma mark - URLPath
+ (NSString *)checkD3ServerStatus;

@end
