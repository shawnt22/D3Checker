//
//  D3ViewController.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D3DataManager.h"
#import "SUtil.h"
#import "Util.h"
#import "SStatusControl.h"

@interface D3ViewController : UIViewController {
@private
    SStatusControl *_progressControl;
}
@property (nonatomic, retain) SStatusControl *progressControl;

- (void)showProgressHUDWithAnimated:(BOOL)animated;
- (void)hideProgressHUDWithAnimated:(BOOL)animated;

- (void)refreshBarItems;
- (void)responseNotification:(NSNotification *)notification;
- (NSString *)controllerTitle;

@end
