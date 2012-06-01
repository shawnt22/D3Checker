//
//  D3ServerStatusLoader.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ServerStatusLoader.h"
#import "HTMLNode.h"
#import "HTMLParser.h"

@implementation D3Loader
@synthesize delegate;

- (id)initWithDelegate:(id<D3LoaderDelegate>)adelegate {
    self = [super init];
    if (self) {
        self.delegate = adelegate;
    }
    return self;
}
- (void)cancelAllRequests {
}

@end

#pragma mark - Server Status
@implementation D3ServerStatusLoader

@end
