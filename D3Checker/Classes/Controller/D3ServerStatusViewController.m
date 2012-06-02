//
//  D3ServerStatusViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ServerStatusViewController.h"
#import "D3ServerStatusCell.h"

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
@synthesize needReloadStatus;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        D3ServerStatusLoader *_loader = [[D3ServerStatusLoader alloc] initWithDelegate:self];
        self.loader = _loader;
        [_loader release];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseNotification:) name:kD3NotificationSupportLanguageChanged object:nil];
        
        self.needReloadStatus = YES;
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kD3NotificationSupportLanguageChanged object:nil];
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
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.needReloadStatus) {
        [self refreshAction:nil];
        self.needReloadStatus = NO;
    }
}

#pragma mark actions
- (void)refreshAction:(id)sender {
    [self.loader checkD3ServerStatus];
}
- (void)responseNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kD3NotificationSupportLanguageChanged]) {
        self.needReloadStatus = YES;
    }
}

#pragma mark refresh
- (void)refreshBarItems {
    [super refreshBarItems];
    self.title = @"Status";
}

#pragma mark loader
- (void)d3loaderDidFinishLoadWith:(D3Loader *)d3loader {
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
            _color = SRGBCOLOR(124, 84, 43);
            break;
        case D3ItemServerStore:
            _color = SRGBCOLOR(125, 84, 43);
            break;    
        default:
            break;
    }
    return _color;
}
- (UIColor *)statusColorWithServer:(D3ItemServer *)server {
    UIColor *_color = nil;
    switch (server.statusType) {
        case D3ItemServerStatusAvailable:
            _color = SRGBCOLOR(107, 162, 0);
            break;
        case D3ItemServerStatusMaintenance:
            _color = SRGBCOLOR(190, 69, 35);
            break;    
        default:
            _color = SRGBCOLOR(107, 162, 0);
            break;
    }
    return _color;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"d3cell";
    D3ServerStatusCell *cell = (D3ServerStatusCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell) {
        cell = [[[D3ServerStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([self.loader.serverStatuses count] > 0) {
        D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:indexPath.section];
        NSInteger _count = [_cs serversTotalCount];
        D3ItemServer *_server = [_cs serverAtIndex:indexPath.row];
        
        cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
        cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
        
        cell.lblTitle.textColor = [self titleColorWithServer:_server];
        cell.lblStatus.textColor = [self statusColorWithServer:_server];
        
        cell.lblTitle.text = _server.title;
        cell.lblStatus.text = _server.status;
    } else {
        cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:1];
        cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:1];
        
        cell.lblTitle.textColor = SRGBCOLOR(0, 0, 0);
        cell.lblTitle.text = @"No Data";
        cell.lblStatus.text = nil;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [D3ServerStatusCell cellHeight];
}
#define kStatusTableSectionHeaderViewHeight   50.0
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kStatusTableSectionHeaderViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *_headerBG = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    _headerBG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _headerBG.backgroundColor = [UIColor clearColor];
    
    UILabel *_category = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 270, kStatusTableSectionHeaderViewHeight)];
    _category.backgroundColor = [UIColor clearColor];
    _category.font = [UIFont boldSystemFontOfSize:20];
    _category.textColor = SRGBCOLOR(238, 224, 196);
    [_headerBG addSubview:_category];
    [_category release];
    
    if ([self.loader.serverStatuses count] > 0) {
        D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:section];
        _category.text = _cs.title;
    }
    
    return _headerBG;
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
