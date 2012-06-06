//
//  D3Server.m
//  DiabloNetCheckerParserTest
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3Server.h"

@implementation D3Server
@synthesize title = _serverTitle, status = _serverStatus;

- (id)init {
    self = [super init];
    if (self) {
        self.title = nil;
        self.status = nil;
    }
    return self;
}
- (void)dealloc {
    self.title = nil;
    self.status = nil;
    [super dealloc];
}

@end

@implementation D3CategoryServer
@synthesize gameServer = _gameServer, storeServer = _storeServer;

- (id)initWithHTMLNode:(HTMLNode *)node {
    self = [self init];
    if (self) {
        HTMLNode *_titleNode = [node findChildOfClass:@"category"];
        if (_titleNode) {
            self.title = [_titleNode contents];
        }
        NSArray *_servers = [node findChildrenOfClass:@"server-list"];
        if ([_servers count] >= 2) {
            D3SubcategoryServer *_game = [[D3SubcategoryServer alloc] initWithTitle:nil ServersNode:[_servers objectAtIndex:0] ItemServerType:D3ItemServerGame];
            self.gameServer = _game;
            [_game release];
            
            NSString *_storeTitle = nil;
            HTMLNode *_stnode = [node findChildOfClass:@"subcategory"];
            if (_stnode) {
                _storeTitle = [_stnode contents];
            }
            D3SubcategoryServer *_store = [[D3SubcategoryServer alloc] initWithTitle:_storeTitle ServersNode:[_servers objectAtIndex:1] ItemServerType:D3ItemServerStore];
            self.storeServer = _store;
            [_store release];
        }
    }
    return self;
}
- (void)dealloc {
    self.gameServer = nil;
    self.storeServer = nil;
    [super dealloc];
}

- (NSInteger)serversTotalCount {
    NSInteger _count = 0;
    _count = [self.gameServer.servers count] + [self.storeServer.servers count];
    return _count;
}
- (D3ItemServer *)serverAtIndex:(NSInteger)index {
    D3ItemServer *_server = nil;
    
    if (index < [self.gameServer.servers count]) {
        _server = [self.gameServer.servers objectAtIndex:index];
    } else {
        index = index - [self.gameServer.servers count];
        if (index < [self.storeServer.servers count]) {
            _server = [self.storeServer.servers objectAtIndex:index];
        }
    }
    
    return _server;
}

@end

@implementation D3SubcategoryServer
@synthesize servers = _categoryServers;

- (id)initWithTitle:(NSString *)atitle ServersNode:(HTMLNode *)serversNode ItemServerType:(D3ItemServerType)stype {
    self = [self init];
    if (self) {
        self.title = atitle;
        
        NSArray *_serverNodes = [serversNode children];
        self.servers = [NSMutableArray array];
        for (HTMLNode *_aNode in _serverNodes) {
            if ([[_aNode className] isEqualToString:@"server"] || [[_aNode className] isEqualToString:@"server alt"]) {
                D3ItemServer *_aserver = [[D3ItemServer alloc] initWithHTMLNode:_aNode];
                _aserver.serverType = stype;
                [self.servers addObject:_aserver];
                [_aserver release];
            }
        }
    }
    return self;
}
- (void)dealloc {
    self.servers = nil;
    [super dealloc];
}

@end


@implementation D3ItemServer
@synthesize serverType = _serverType;
@synthesize statusType;

- (id)initWithHTMLNode:(HTMLNode *)node {
    self = [self init];
    if (self) {
        NSArray *_divs = [node findChildTags:@"div"];
        for (HTMLNode *_adiv in _divs) {
            if ([[_adiv className] isEqualToString:@"server-name"]) {
                self.title = [_adiv contents];
                self.title = [self.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                continue;
            }
            if ([[_adiv className] hasPrefix:@"status"]) {
                self.status = [_adiv getAttributeNamed:@"data-tooltip"];
                self.status = [self.status stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                self.statusType = [[_adiv className] hasSuffix:@"up"] ? D3ItemServerStatusAvailable : D3ItemServerStatusMaintenance;
                continue;
            }
        }
    }
    return self;
}

@end


