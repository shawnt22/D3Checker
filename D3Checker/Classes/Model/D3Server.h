//
//  D3Server.h
//  DiabloNetCheckerParserTest
//
//  Created by 松 滕 on 12-6-1.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLNode.h"
#import "HTMLParser.h"

@interface D3Server : NSObject {
@private
    NSString *_serverTitle;
    NSString *_serverStatus;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *status;

@end

@class D3SubcategoryServer;
@class D3ItemServer;
@interface D3CategoryServer : D3Server {
@private
    D3SubcategoryServer *_gameServer;
    D3SubcategoryServer *_storeServer;
}
@property (nonatomic, retain) D3SubcategoryServer *gameServer;
@property (nonatomic, retain) D3SubcategoryServer *storeServer;

- (id)initWithHTMLNode:(HTMLNode *)node;
- (NSInteger)serversTotalCount;
- (D3ItemServer *)serverAtIndex:(NSInteger)index;

@end


typedef enum {
    D3ItemServerGame,
    D3ItemServerStore,
}D3ItemServerType;
@interface D3SubcategoryServer : D3Server {
@private
    NSMutableArray *_categoryServers;
}
@property (nonatomic, retain) NSMutableArray *servers;
- (id)initWithTitle:(NSString *)title ServersNode:(HTMLNode *)serversNode ItemServerType:(D3ItemServerType)stype;

@end


typedef enum {
    D3ItemServerStatusAvailable,
    D3ItemServerStatusMaintenance,
}D3ItemServerStatusType;
@interface D3ItemServer : D3Server {
@private
    D3ItemServerType _serverType;
}
@property (nonatomic, assign) D3ItemServerType serverType;
@property (nonatomic, assign) D3ItemServerStatusType statusType;

- (id)initWithHTMLNode:(HTMLNode *)node;

@end

