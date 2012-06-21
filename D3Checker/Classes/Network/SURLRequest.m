//
//  SURLRequest.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-21.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "SURLRequest.h"

@implementation SURLRequest
@synthesize responseResult;

- (void)dealloc {
    self.responseResult = nil;
    [super dealloc];
}

@end

#import "SURLDefine.h"
@implementation SURLRequest(D3Checker)
- (id)initWithURL:(NSURL *)newURL {
    self = [super initWithURL:newURL];
    if (self) {
        self.cachePolicy = ASIDoNotWriteToCacheCachePolicy;
        self.downloadCache = [ASIDownloadCache shareDocumentCache];
    }
    return self;
}
@end
