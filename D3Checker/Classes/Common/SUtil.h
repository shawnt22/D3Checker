//
//  SUtil.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark SupportLanguage
typedef enum {
    //  America
    D3SupportLanguageUS_EN = 0,         
    D3SupportLanguageUS_ES,
    D3SupportLanguageUS_PT,
    //  Europe
    D3SupportLanguageEU_DE,
    D3SupportLanguageEU_EN,
    D3SupportLanguageEU_ES,
    D3SupportLanguageEU_FR,
    D3SupportLanguageEU_IT,
    D3SupportLanguageEU_PL,
    D3SupportLanguageEU_PT,
    D3SupportLanguageEU_RU,
    //  Korea
    D3SupportLanguageKR_KO,
    //  China
    D3SupportLanguageTW_ZH,
    
    D3SupportLanguageCount,
    
    //  SouthEast Asia
    D3SupportLanguageSEA_EN,
    
}D3SupportLanguage;

#pragma mark Common
@interface SUtil : NSObject

+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message;

@end

#pragma mark - Message
@interface SUtil (Message)

+ (NSString *)titleOfServerStatusViewController;
+ (NSString *)titleOfSettingsViewController;
+ (NSString *)titleOfSelectLanguageViewController;
+ (NSString *)messageOfServerStatusTableEmptyData;
+ (NSString *)descriptionOfSettingsTableLanguage;
+ (NSString *)descriptionOfSettingsTableEmailMe;
+ (NSString *)descriptionOfSettingsTableAboutMe;

@end

#pragma mark - URLPath
@interface SUtil (URLManager)

+ (NSString *)checkD3ServerStatus;

@end

#pragma mark - Path
@interface SUtil (PathManager)

+ (NSString *)pathCacheImgs;
+ (NSString *)pathCacheDocs;
+ (NSString *)pathGlobalConfiger;
+ (NSString *)pathCUserCacheDocs;
+ (NSString *)pathCUserConfiger;

@end

#pragma mark - Error
#define kD3ErrorDomain  @"D3CheckerErrorDomain"
typedef enum {
    D3ErrorParserFail,
    D3ErrorCanntConnect,
}D3Error;

@interface SUtil (ErrorManager)

+ (NSError *)errorWithCode:(D3Error)code;
+ (NSError *)errorWithCode:(D3Error)code Description:(NSString *)description;
+ (NSString *)defaultDescriptionWithErrorCode:(D3Error)code;

@end

#pragma mark - Notification
#define kD3NotificationSupportLanguageChanged   @"language_changed"
