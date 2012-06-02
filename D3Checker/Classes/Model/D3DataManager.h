//
//  SDataManager.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSettings.h"
#import "Util.h"
#import "SUtil.h"

@interface D3DataManager : NSObject
@property (nonatomic, retain) SSettings *settings;

+ (D3DataManager *)shareInstance;
- (void)prepareData;

@end
