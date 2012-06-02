//
//  SDataManager.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SDataManager.h"

SDataManager *_instance = nil;
@implementation SDataManager
@synthesize settings;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        SSettings *_settings = [[SSettings alloc] init];
        self.settings = _settings;
        [_settings release];
    }
    return self;
}
- (void)dealloc {
    self.settings = nil;
    [super dealloc];
}
+ (SDataManager *)shareInstance {
    if (_instance) {
        _instance = [[SDataManager alloc] init];
    }
    return _instance;
}

#pragma mark prepare
- (void)prepareData {
    [Util createDirectoryIfNecessaryAtPath:[SUtil pathGlobalConfiger]];
    
    SSettings *_settings = [SSettings resumeSettings];
    if (_settings) {
        self.settings = _settings;
    }
}

@end
