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
        _language = (DSupportLanguage)[[aDecoder decodeObjectForKey:kSettingsLanguage] integerValue];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithInteger:self.language] forKey:kSettingsLanguage];
}
- (id)init {
    self = [super init];
    if (self) {
        _language = DSupportLanguageEN;
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


@end
