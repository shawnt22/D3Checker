//
//  D3ServerStatusViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ServerStatusViewController.h"
#import "D3CustomBGCell.h"

@interface D3ServerStatusViewController ()
@property (nonatomic, assign) D3TableView *theTableView;
@property (nonatomic, retain) D3ServerStatusLoader *loader;
- (void)refreshAction:(id)sender;
- (UIColor *)titleColorWithServer:(D3ItemServer *)server;
- (UIColor *)statusColorWithServer:(D3ItemServer *)server;
@end
@implementation D3ServerStatusViewController
@synthesize theTableView;
@synthesize loader;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        D3ServerStatusLoader *_loader = [[D3ServerStatusLoader alloc] initWithDelegate:self];
        self.loader = _loader;
        [_loader release];
    }
    return self;
}
- (void)dealloc {
    [self.loader cancelAllRequests];
    self.loader = nil;
    [super dealloc];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *_refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
    self.navigationItem.rightBarButtonItem = _refresh;
    [_refresh release];
    
    D3TableView *_tb = [[D3TableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height) style:UITableViewStyleGrouped];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.backgroundColor = self.view.backgroundColor;
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    self.theTableView = _tb;
    [_tb release];
    
    [self refreshAction:nil];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark actions
- (void)refreshAction:(id)sender {
    [self.loader checkD3ServerStatus];
}

#pragma mark refresh
- (void)refreshBarItems {
    [super refreshBarItems];
    self.title = @"Status";
}

#pragma mark loader
- (void)d3loaderDidFinishLoadWith:(D3Loader *)d3loader {
    D3ServerStatusLoader *_ld = self.loader;
    NSLog(@"%d", [_ld.serverStatuses count]);
    [self.theTableView reloadData];
}
- (void)d3loaderDidFailLoadWith:(D3Loader *)d3loader Error:(NSError *)error {
    NSLog(@"%@", error);
}
- (void)d3loaderDidCancelLoadWith:(D3Loader *)d3loader {}

#pragma mark table
- (UIColor *)titleColorWithServer:(D3ItemServer *)server {
    UIColor *_color = [UIColor blackColor];
    switch (server.serverType) {
        case D3ItemServerGame:
            _color = SRGBCOLOR(1, 1, 1);
            break;
        case D3ItemServerStore:
            _color = SRGBCOLOR(243, 54, 66);
            break;    
        default:
            break;
    }
    return _color;
}
- (UIColor *)statusColorWithServer:(D3ItemServer *)server {
    UIColor *_color = [UIColor blackColor];
    switch (server.serverType) {
        case D3ItemServerGame:
            _color = SRGBCOLOR(1, 1, 1);
            break;
        case D3ItemServerStore:
            _color = SRGBCOLOR(243, 54, 66);
            break;    
        default:
            break;
    }
    return _color;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"d3cell";
    TCustomBGCell *cell = (TCustomBGCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell) {
        cell = [[[TCustomBGCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([self.loader.serverStatuses count] > 0) {
        D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:indexPath.section];
        NSInteger _count = [_cs serversTotalCount];
        D3ItemServer *_server = [_cs serverAtIndex:indexPath.row];
        
        cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
        cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
        
        cell.textLabel.textColor = [self titleColorWithServer:_server];
        cell.detailTextLabel.textColor = [self statusColorWithServer:_server];
        
        cell.textLabel.text = _server.title;
        cell.detailTextLabel.text = _server.status;
    } else {
        cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:1];
        cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:1];
        
        cell.textLabel.textColor = SRGBCOLOR(0, 0, 0);
        cell.textLabel.text = @"No Data";
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.loader.serverStatuses count] > 0) {
        D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:section];
        return [_cs serversTotalCount];
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger _sections = [self.loader.serverStatuses count];
    _sections = _sections > 0 ? _sections : 1;
    return _sections;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.loader.serverStatuses count] > 0) {
        D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:section];
        return _cs.title;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
