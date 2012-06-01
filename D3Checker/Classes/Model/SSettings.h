//
//  SSettings.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSettingsProtocol <NSObject>
@required
+ (NSString *)settingsFilePath;
+ (id)resumeSettings;
- (BOOL)saveSettings;
@optional
- (BOOL)clearSettings;
- (void)resetSettings;
@end

#pragma mark - SSettings
#import "SUtil.h"
#define kSettingsLanguage   @"language"
@interface SSettings : NSObject<SSettingsProtocol, NSCoding> {
@private
    DSupportLanguage _language;
}
@property (nonatomic, assign) DSupportLanguage language;

@end
