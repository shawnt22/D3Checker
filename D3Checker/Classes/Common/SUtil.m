//
//  SUtil.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SUtil.h"
#import "Util.h"
#import "D3DataManager.h"

@implementation SUtil

@end

#pragma mark - URLPath
@implementation SUtil (URLManager)

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

#pragma mark - URLPath
@implementation SUtil (PathManager)

+ (NSString *)pathGlobalConfiger {
    return [Util filePathWith:@"common/document" isDirectory:YES];
}

@end

#pragma mark - Error
@implementation SUtil (ErrorManager)

+ (NSError *)errorWithCode:(D3Error)code {
    return [SUtil errorWithCode:code Description:[SUtil defaultDescriptionWithErrorCode:code]];
}
+ (NSError *)errorWithCode:(D3Error)code Description:(NSString *)description {
    NSError *error = nil;
    
    description = [Util isEmptyString:description] ? [SUtil defaultDescriptionWithErrorCode:code] : description;
    error = [NSError errorWithDomain:kD3ErrorDomain code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil]];
    
    return error;
}
+ (NSString *)defaultDescriptionWithErrorCode:(D3Error)code {
    NSString *_description = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            switch (code) {
                case D3ErrorParserFail:
                {
                    _description = @"數據解析失敗";
                }
                    break;
                case D3ErrorCanntConnect:
                {
                    _description = @"網絡連接失敗";
                }
                    break;
                default:
                    break;
            }
        }
            break;    
        default: 
        {
            switch (code) {
                case D3ErrorParserFail:
                {
                    _description = @"Oops! Parser Failed.";
                }
                    break;
                case D3ErrorCanntConnect:
                {
                    _description = @"Oops! Can not connect to server.";
                }
                    break;
                default:
                    break;
            }
        }
            break;
    }
    return _description;
}

@end