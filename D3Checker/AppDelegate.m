//
//  AppDelegate.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
- (void)launchViewControllers;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController, settingsViewController, serverStatusViewController;

- (void)dealloc
{
    self.tabBarController = nil;
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[SDataManager shareInstance] prepareData];
    [self launchViewControllers];
    
    return YES;
}
+ (D3ServerStatusViewController *)d3ServerStatusViewController {
    AppDelegate *_appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return _appDelegate.serverStatusViewController;
}
+ (D3SettingsViewController *)d3SettingsViewController {
    AppDelegate *_appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return _appDelegate.settingsViewController;
}

- (void)launchViewControllers {
    D3ServerStatusViewController *_serverStatusVctr = [[D3ServerStatusViewController alloc] init];
    UINavigationController *_serverStatusNctr = [[UINavigationController alloc] initWithRootViewController:_serverStatusVctr];
    self.serverStatusViewController = _serverStatusVctr;
    [_serverStatusVctr release];
    
    D3SettingsViewController *_settingsVctr = [[D3SettingsViewController alloc] init];
    UINavigationController *_settingsNctr = [[UINavigationController alloc] initWithRootViewController:_settingsVctr];
    self.settingsViewController = _settingsVctr;
    [_settingsVctr release];
    
    UITabBarController *_tabBarCtr = [[UITabBarController alloc] init];
    _tabBarCtr.viewControllers = [NSArray arrayWithObjects:_serverStatusNctr, _settingsNctr, nil];
    [_serverStatusNctr release];
    [_settingsNctr release];
    self.tabBarController = _tabBarCtr;
    [_tabBarCtr release];
    
    [self.serverStatusViewController refreshBarItems];
    [self.settingsViewController refreshBarItems];
    
    [self.window addSubview:self.tabBarController.view];
}













- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
