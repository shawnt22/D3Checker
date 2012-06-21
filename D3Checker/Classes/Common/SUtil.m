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

+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message {
    UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [_alert show];
    [_alert release];
}

@end

#pragma mark - Message
@implementation SUtil (Message)

+ (NSString *)messageOfServerStatusTableEmptyData {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"暫無數據";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"데이터가 없습니다";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Pas de données";
        }
            break; 
        default: 
        {
            _result = @"No Data";
        }
            break;
    }
    return _result;
}
+ (NSString *)titleOfServerStatusViewController {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"伺服器狀態";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"서버 현황";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Serveur";
        }
            break; 
        default: 
        {
            _result = @"Server Status";
        }
            break;
    }
    return _result;
}
+ (NSString *)titleOfSettingsViewController {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"設置";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"설정";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Configuration";
        }
            break; 
        default: 
        {
            _result = @"Settings";
        }
            break;
    }
    return _result;
}
+ (NSString *)titleOfSelectLanguageViewController {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"選擇語言";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"언어를 선택하십시오";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Sélectionnez Langue";
        }
            break; 
        default: 
        {
            _result = @"Select Language";
        }
            break;
    }
    return _result;
}
+ (NSString *)descriptionOfSettingsTableLanguage {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"語言";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"언어";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Langue";
        }
            break; 
        default: 
        {
            _result = @"Language";
        }
            break;
    }
    return _result;
}
+ (NSString *)descriptionOfSettingsTableEmailMe {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"反饋";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"피드백";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"Réaction";
        }
            break; 
        default: 
        {
            _result = @"Feedback";
        }
            break;
    }
    return _result;
}
+ (NSString *)descriptionOfSettingsTableAboutMe {
    NSString *_result = nil;
    switch ([D3DataManager shareInstance].settings.language) {
        case D3SupportLanguageTW_ZH:
        {
            _result = @"關於";
        }
            break;  
        case D3SupportLanguageKR_KO:
        {
            _result = @"약";
        }
            break; 
        case D3SupportLanguageEU_FR:
        {
            _result = @"sur";
        }
            break; 
        default: 
        {
            _result = @"About";
        }
            break;
    }
    return _result;
}

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

+ (NSString *)pathCacheImgs {
	return [Util filePathWith:@"common/cache_image" isDirectory:YES];
}
+ (NSString *)pathCacheDocs {
	return [Util filePathWith:@"common/cache_document" isDirectory:YES];
}
+ (NSString *)pathGlobalConfiger {
	return [Util filePathWith:@"common/document" isDirectory:YES];
}
+ (NSString *)pathCUserCacheDocs {
    return nil;
//	return [Util filePathWith:[[NSString stringWithFormat:@"%@", [D3DataManager shareInstance].currentUser.ID] stringByAppendingPathComponent:@"cache_document"] isDirectory:YES];
}
+ (NSString *)pathCUserConfiger {
    return nil;
//	return [Util filePathWith:[[NSString stringWithFormat:@"%@", [SDataManager shareInstance].currentUser.ID] stringByAppendingPathComponent:@"document"] isDirectory:YES];
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
    
    switch (code) {
        case D3ErrorParserFail:
        {
            switch ([D3DataManager shareInstance].settings.language) {
                case D3SupportLanguageTW_ZH:
                {
                    _description = @"數據解析失敗";
                }
                    break; 
                default: 
                {
                    _description = @"Oops! Parser Failed.";
                }
                    break;
            }
        }
            break;
        case D3ErrorCanntConnect:
        {
            switch ([D3DataManager shareInstance].settings.language) {
                case D3SupportLanguageTW_ZH:
                {
                    _description = @"網絡連接失敗";
                }
                    break;
                default: 
                {
                    _description = @"Oops! Can not connect to server.";
                }
                    break;
            }
        }
            break;
        default:
        {
            switch ([D3DataManager shareInstance].settings.language) {
                case D3SupportLanguageTW_ZH:
                {
                    _description = @"出錯了";
                }
                    break;
                default: 
                {
                    _description = @"Oops! Something with wrong.";
                }
                    break;
            }
        }
            break;
    }
    return _description;
}

@end