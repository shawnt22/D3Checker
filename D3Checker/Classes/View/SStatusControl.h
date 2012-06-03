//
//  SStatusControl.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-3.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    StatusControlAnimationBottom,
    StatusControlAnimationMiddle,
    StatusControlAnimationTop,
}StatusControlAnimationType;

@interface SStatusControl : UIControl
@property (nonatomic, retain) NSString *message;
@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, assign) NSTimeInterval showAnimationTimeInterval;
@property (nonatomic, assign) NSTimeInterval hideAnimationTimeInterval;

- (void)showControlWithAnimated:(BOOL)animated;
- (void)hideControlWithAnimated:(BOOL)animated;
- (void)showControlWithAnimated:(BOOL)animated needIndicator:(BOOL)needIndicator;

@end
