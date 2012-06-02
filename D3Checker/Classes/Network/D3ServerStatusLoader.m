//
//  D3ServerStatusLoader.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ServerStatusLoader.h"

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

- (void)notifyD3loaderDidFinishLoadWith:(D3Loader *)d3loader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(d3loaderDidFinishLoadWith:)]) {
        [self.delegate d3loaderDidFinishLoadWith:d3loader];
    }
}
- (void)notifyD3loaderDidFailLoadWith:(D3Loader *)d3loader Error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(d3loaderDidFailLoadWith:Error:)]) {
        [self.delegate d3loaderDidFailLoadWith:d3loader Error:error];
    }
}
- (void)notifyD3loaderDidCancelLoadWith:(D3Loader *)d3loader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(d3loaderDidCancelLoadWith:)]) {
        [self.delegate d3loaderDidCancelLoadWith:d3loader];
    }
}

@end

#pragma mark - Server Status
@interface D3ServerStatusLoader()
@property (nonatomic, retain) NSURLConnection *connection;
@end

@implementation D3ServerStatusLoader
@synthesize serverStatuses;
@synthesize connection;

- (id)initWithDelegate:(id<D3LoaderDelegate>)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.serverStatuses = nil;
        self.connection = nil;
    }
    return self;
}
- (void)dealloc {
    self.serverStatuses = nil;
    self.connection = nil;
    [super dealloc];
}
- (void)checkD3ServerStatus {
    [self.connection cancel];
    
    NSURLRequest *_request = [NSURLRequest requestWithURL:[NSURL URLWithString:[SUtil checkD3ServerStatus]]];
    NSURLConnection *_connection = [NSURLConnection connectionWithRequest:_request delegate:self];
    self.connection = _connection;
    
    [self.connection start];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSError *_d3error = [SUtil errorWithCode:[error code]];
    _d3error = _d3error ? _d3error : error;
    [self notifyD3loaderDidFailLoadWith:self Error:_d3error];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (![Util isEmptyString:response]) {
        if (![self parserResponse:response withD3Loader:self]) {
            [self notifyD3loaderDidFailLoadWith:self Error:[SUtil errorWithCode:D3ErrorParserFail]];
        } 
    } else {
        [self notifyD3loaderDidFailLoadWith:self Error:[SUtil errorWithCode:D3ErrorParserFail]];
    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self notifyD3loaderDidFinishLoadWith:self];
}
- (BOOL)parserResponse:(id)response withD3Loader:(D3Loader *)d3loader {
    NSError *error = nil;
    NSString *html = (NSString *)response;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        [parser release];
         return NO;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    HTMLNode *wrapperNode = [bodyNode findChildOfClass:@"wrapper"];
    HTMLNode *w_bodyNode = [wrapperNode findChildOfClass:@"body"];
    HTMLNode *w_topNode = [w_bodyNode findChildOfClass:@"body-top"];
    HTMLNode *w_botNode = [w_topNode findChildOfClass:@"server-status"];
    HTMLNode *w_dbNode = [w_botNode findChildOfClass:@"db-directory"];
    HTMLNode *w_db_innerNode = [w_dbNode findChildOfClass:@"db-directory-inner"];
    NSArray *_nodes = [w_db_innerNode children];
    
    NSMutableArray *_serverStatusInfo = [NSMutableArray array];
    
    for (HTMLNode *anode in _nodes) {
        NSString *className = [anode className];
        if ([className length] == 0 || [className isEqualToString:@"clear"]) {
            continue;
        }
        HTMLNode *_categoryNode = [anode findChildOfClass:@"box"];
        D3CategoryServer *_server = [[D3CategoryServer alloc] initWithHTMLNode:_categoryNode];
        [_serverStatusInfo addObject:_server];
        [_server release];
    }
    
    self.serverStatuses = _serverStatusInfo;
    
    [parser release];
    
    return YES;
}

@end
