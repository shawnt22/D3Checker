//
//  D3SettingsViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3SettingsViewController.h"

@implementation D3SettingsViewController

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark refresh
- (void)refreshBarItems {
    [super refreshBarItems];
    self.title = @"Settings";
}

@end
