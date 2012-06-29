//
//  SSettings.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SSettings.h"
#import "SUtil.h"

@implementation SSettings
@synthesize language = _language;

#pragma mark init & dealloc
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        _language = (D3SupportLanguage)[[aDecoder decodeObjectForKey:kSettingsLanguage] integerValue];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithInteger:self.language] forKey:kSettingsLanguage];
}
- (id)init {
    self = [super init];
    if (self) {
        _language = D3SupportLanguageUS_EN;
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark setting manager
+ (NSString *)settingsFilePath {
    return [[SUtil pathGlobalConfiger] stringByAppendingPathComponent:[@"settings" lastPathComponent]];
}
+ (id)resumeSettings {
    NSData *data = [NSData dataWithContentsOfFile:[SSettings settingsFilePath]];
    SSettings *_settings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return _settings;
}
- (BOOL)saveSettings {
    BOOL result = NO;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    result = [data writeToFile:[SSettings settingsFilePath] atomically:YES];
    return result;
}

#pragma mark Language
+ (NSString *)descriptionWithD3language:(D3SupportLanguage)d3language {
    NSString *result = nil;
    switch (d3language) {
        case D3SupportLanguageUS_EN:
        {
            result = @"English (US)";
        }
            break;
        case D3SupportLanguageUS_ES:
        {
            result = @"Español (AL)";
        }
            break;
        case D3SupportLanguageUS_PT:
        {
            result = @"Português (AL)";
        }
            break;
        case D3SupportLanguageEU_DE:
        {
            result = @"Deutsch";
        }
            break;
        case D3SupportLanguageEU_EN:
        {
            result = @"English (EU)";
        }
            break;
        case D3SupportLanguageEU_ES:
        {
            result = @"Español (EU)";
        }
            break;
        case D3SupportLanguageEU_FR:
        {
            result = @"Français";
        }
            break;
        case D3SupportLanguageEU_IT:
        {
            result = @"Italiano";
        }
            break;
        case D3SupportLanguageEU_PL:
        {
            result = @"Polski";
        }
            break;
        case D3SupportLanguageEU_PT:
        {
            result = @"Português (EU)";
        }
            break;
        case D3SupportLanguageEU_RU:
        {
            result = @"Русский";
        }
            break;
        case D3SupportLanguageKR_KO:
        {
            result = @"한국어";
        }
            break;
        case D3SupportLanguageTW_ZH:
        {
            result = @"繁體中文";
        }
            break;
        case D3SupportLanguageSEA_EN:
        {
            result = @"English (US)";
        }
            break;
        default:
            result = @"";
            break;
    }
    return result;
}


@end
