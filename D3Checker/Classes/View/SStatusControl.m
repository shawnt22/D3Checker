//
//  SStatusControl.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-3.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SStatusControl.h"
#import "Util.h"
#import "SUtil.h"

@interface SStatusControl()
@property (nonatomic, assign) StatusControlAnimationType animationType;
@property (nonatomic, retain) UILabel *messageLabel;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) BOOL needIndicator;
- (void)didFinishShowAnimation;
- (void)didFinishHideAnimation;
@end

@implementation SStatusControl
@synthesize message;
@synthesize isShowing;
@synthesize showAnimationTimeInterval, hideAnimationTimeInterval, animationType;
@synthesize messageLabel, indicator, needIndicator;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.message = nil;
        self.isShowing = NO;
        self.showAnimationTimeInterval = self.hideAnimationTimeInterval = 0.3;
        self.animationType = StatusControlAnimationBottom;
        self.needIndicator = YES;
        
        UILabel *_lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbl.backgroundColor = [UIColor clearColor];
        _lbl.font = [UIFont systemFontOfSize:14];
        _lbl.textAlignment = UITextAlignmentLeft;
        _lbl.textColor = SRGBCOLOR(200, 100, 0);
        self.messageLabel = _lbl;
        [_lbl release];
        
        UIActivityIndicatorView *_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.hidesWhenStopped = YES;
        self.indicator = _indicator;
        [_indicator release];
    }
    return self;
}
- (void)dealloc {
    self.message = nil;
    self.messageLabel = nil;
    self.indicator = nil;
    [super dealloc];
}

#pragma mark show & hide
- (void)showControlWithAnimated:(BOOL)animated {
    [self showControlWithAnimated:animated needIndicator:YES];
}
- (void)showControlWithAnimated:(BOOL)animated needIndicator:(BOOL)needIndicator {
    if (self.isShowing) {
        return;
    }
    if (animated) {
        
    } else {
        [self didFinishShowAnimation];
    }
}
- (void)didFinishShowAnimation {}
- (void)hideControlWithAnimated:(BOOL)animated {
    if (self.isShowing) {
        return;
    }
    if (animated) {
        
    } else {
        [self didFinishHideAnimation];
    }
}
- (void)didFinishHideAnimation {}

@end
