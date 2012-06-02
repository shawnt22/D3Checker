//
//  D3ServerStatusLoader.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"
#import "SUtil.h"

#pragma mark Protocol
@class D3Loader;

@protocol D3LoaderDelegate <NSObject>
@optional
- (void)d3loaderDidFinishLoadWith:(D3Loader *)d3loader;
- (void)d3loaderDidFailLoadWith:(D3Loader *)d3loader Error:(NSError *)error;
- (void)d3loaderDidCancelLoadWith:(D3Loader *)d3loader;
@end

@protocol D3LoaderProtocol <NSObject>
@optional
- (id)initWithDelegate:(id<D3LoaderDelegate>)delegate;
- (BOOL)parserResponse:(id)response withD3Loader:(D3Loader *)d3loader;
- (void)cancelAllRequests;

- (void)notifyD3loaderDidFinishLoadWith:(D3Loader *)d3loader;
- (void)notifyD3loaderDidFailLoadWith:(D3Loader *)d3loader Error:(NSError *)error;
- (void)notifyD3loaderDidCancelLoadWith:(D3Loader *)d3loader;
@end

#pragma mark - Base
@interface D3Loader : NSObject<D3LoaderProtocol>
@property (nonatomic, assign) id <D3LoaderDelegate> delegate;

@end

#pragma mark - Server Status
#import "D3Server.h"
@interface D3ServerStatusLoader : D3Loader <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, retain) NSMutableArray *serverStatuses;

- (void)checkD3ServerStatus;

@end
