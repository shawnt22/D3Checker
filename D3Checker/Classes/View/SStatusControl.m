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
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *_lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbl.backgroundColor = [UIColor clearColor];
        _lbl.font = [UIFont systemFontOfSize:14];
        _lbl.textAlignment = UITextAlignmentLeft;
        _lbl.textColor = SRGBCOLOR(200, 100, 0);
        self.messageLabel = _lbl;
        [_lbl release];
        
        UIActivityIndicatorView *_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.hidesWhenStopped = YES;
        [self addSubview:_indicator];
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
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicator.center = CGPointMake(ceilf(self.bounds.size.width/2), ceilf(self.bounds.size.height/2));
}

#pragma mark show & hide
- (void)showControlWithAnimated:(BOOL)animated {
    [self showControlWithAnimated:animated needIndicator:YES];
}
- (void)showControlWithAnimated:(BOOL)animated needIndicator:(BOOL)needIndicator {
    if (self.isShowing) {
        
    }
    
    self.hidden = NO;
    self.alpha = 1.0;
    [self.indicator startAnimating];
    [self didFinishShowAnimation];
    
    return;
    if (animated) {
        
    } else {
        self.alpha = 1.0;
        [self didFinishShowAnimation];
    }
}
- (void)didFinishShowAnimation {
    self.isShowing = YES;
}
- (void)hideControlWithAnimated:(BOOL)animated {
    if (self.isShowing) {
        
    }
    
    self.alpha = 0.0;
    [self.indicator stopAnimating];
    [self didFinishHideAnimation];
    
    return;
    if (animated) {
        
    } else {
        [self didFinishHideAnimation];
    }
}
- (void)didFinishHideAnimation {
    self.hidden = YES;
    self.isShowing = NO;
}

#pragma mark draw
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSaveGState(context);
    
    CGRect boxRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
	float radius = 10.0f;
	CGContextBeginPath(context);
	CGContextSetGrayFillColor(context, 0.0f, 0.8);
	CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

@end
