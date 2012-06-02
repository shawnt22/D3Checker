//
//  AppDelegate.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D3ServerStatusLoader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, D3LoaderDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
