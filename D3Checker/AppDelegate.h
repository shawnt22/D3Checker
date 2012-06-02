//
//  AppDelegate.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D3SettingsViewController.h"
#import "D3ServerStatusViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, assign) D3SettingsViewController *settingsViewController;
@property (nonatomic, assign) D3ServerStatusViewController *serverStatusViewController;

+ (D3ServerStatusViewController *)d3ServerStatusViewController;
+ (D3SettingsViewController *)d3SettingsViewController;

@end
