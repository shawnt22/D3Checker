//
//  D3ViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ViewController.h"

@implementation D3ViewController

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseNotification:) name:kD3NotificationSupportLanguageChanged object:nil];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kD3NotificationSupportLanguageChanged object:nil];
    [super dealloc];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SRGBCOLOR(250, 250, 250);
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark refresh
- (void)refreshBarItems {
    self.title = [self controllerTitle];
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
