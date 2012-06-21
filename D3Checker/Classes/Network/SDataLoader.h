//
//  SDataLoader.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-21.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDataLoaderProtocol.h"
#import "SURLRequest.h"

#import "SURLDefine.h"
#import "SResponseDefine.h"

#import "Util.h"
#import "SUtil.h"

@interface SDataLoader : NSObject<ASIHTTPRequestDelegate> {
@private
    
}
@property (nonatomic, assign) id<SDataLoaderDelegate> delegate;

- (id)initWithDelegate:(id<SDataLoaderDelegate>)adelegate;
- (void)startRequest:(SURLRequest *)request;
- (void)cancelRequest:(SURLRequest *)request;
- (void)cancelAllRequests;

- (BOOL)parseRequest:(SURLRequest *)request Response:(id)response;

- (void)notifyDataloader:(SDataLoader *)dataloader didFinishRequest:(SURLRequest *)request;
- (void)notifyDataloader:(SDataLoader *)dataloader didFailRequest:(SURLRequest *)request Error:(NSError *)error;

@end
