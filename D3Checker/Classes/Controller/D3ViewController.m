//
//  D3ViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ViewController.h"

@implementation D3ViewController
@synthesize progressControl = _progressControl;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseNotification:) name:kD3NotificationSupportLanguageChanged object:nil];
    }
    return self;
}
- (void)dealloc {
    [self hideProgressHUDWithAnimated:NO];
    self.progressControl = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kD3NotificationSupportLanguageChanged object:nil];
    [super dealloc];
}

#pragma mark progress HUD
- (void)showProgressHUDWithAnimated:(BOOL)animated {
    [self.view bringSubviewToFront:self.progressControl];
    [self.progressControl showControlWithAnimated:animated];
}
- (void)hideProgressHUDWithAnimated:(BOOL)animated {
    [self.progressControl hideControlWithAnimated:animated];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SRGBCOLOR(250, 250, 250);
    
    UIImageView *_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height)];
    _bg.image = [Util imageWithName:@"bg_status_314x360"];
    [self.view addSubview:_bg];
    [_bg release];
    
    CGFloat _ctrWH = 60.0;
    SStatusControl *_sctr = [[SStatusControl alloc] initWithFrame:CGRectMake(ceilf((self.view.bounds.size.width-_ctrWH)/2), ceilf((self.view.bounds.size.height-93-_ctrWH)/2), _ctrWH, _ctrWH)];
    _sctr.hidden = YES;
    [self.view addSubview:_sctr];
    self.progressControl = _sctr;
    [_sctr release];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    [self hideProgressHUDWithAnimated:NO];
}

#pragma mark refresh
- (void)refreshBarItems {
    self.title = [self controllerTitle];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}
- (void)responseNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kD3NotificationSupportLanguageChanged]) {
        self.title = [self controllerTitle];
        return;
    }
}
- (NSString *)controllerTitle {
    return nil;
}

@end
