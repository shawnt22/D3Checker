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

@property (nonatomic, retain) UIImage *flagStatusAvailable;
@property (nonatomic, retain) UIImage *flagStatusMaintenance;

- (void)refreshAction:(id)sender;
- (UIColor *)titleColorWithServer:(D3ItemServer *)server;
- (UIColor *)statusColorWithServer:(D3ItemServer *)server;
- (void)updateTableFooterView;
@end
@implementation D3ServerStatusViewController
@synthesize theTableView;
@synthesize loader;
@synthesize flagStatusAvailable, flagStatusMaintenance;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        D3ServerStatusLoader *_loader = [[D3ServerStatusLoader alloc] initWithDelegate:self];
        self.loader = _loader;
        [_loader release];
        
        UIImage *_flags = [Util imageWithName:@"bg_status_flag" ofType:@"gif"];
        self.flagStatusAvailable = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(_flags.CGImage, CGRectMake(24, 0, 24, 27))];
        self.flagStatusMaintenance = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(_flags.CGImage, CGRectMake(0, 0, 24, 27))];
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
    _tb.backgroundColor = [UIColor clearColor];
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
    [self showProgressHUDWithAnimated:YES];
    [self.loader checkD3ServerStatus];
}
- (void)responseNotification:(NSNotification *)notification {
    [super responseNotification:notification];
    if ([[notification name] isEqualToString:kD3NotificationSupportLanguageChanged]) {
        [self refreshAction:nil];
        return;
    }
}

#pragma mark refresh
- (void)refreshBarItems {
    [super refreshBarItems];
    
    UIImage *_settingsImage = [UIImage imageNamed:@"bg_status.png"];
    self.navigationController.tabBarItem.image = _settingsImage;
}
- (NSString *)controllerTitle {
    return [SUtil titleOfServerStatusViewController];
}

#pragma mark loader
- (void)d3loaderDidFinishLoadWith:(D3Loader *)d3loader {
    [self hideProgressHUDWithAnimated:YES];
    [self.theTableView reloadData];
    [self updateTableFooterView];
}
- (void)d3loaderDidFailLoadWith:(D3Loader *)d3loader Error:(NSError *)error {
    [self hideProgressHUDWithAnimated:YES];
    [SUtil alertWithTitle:nil Message:[error localizedDescription]];
}
- (void)d3loaderDidCancelLoadWith:(D3Loader *)d3loader {}

#pragma mark table
- (void)updateTableFooterView {
    UILabel *_footer = nil;
    
    if ([self.loader.serverStatuses count] <= 0) {
        _footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.theTableView.bounds.size.width, 40)];
        _footer.backgroundColor = [UIColor clearColor];
        _footer.font = [UIFont systemFontOfSize:16];
        _footer.textAlignment = UITextAlignmentCenter;
        _footer.text = [SUtil messageOfServerStatusTableEmptyData];
    }
    
    self.theTableView.tableFooterView = _footer;
}
- (UIColor *)titleColorWithServer:(D3ItemServer *)server {
    UIColor *_color = [UIColor blackColor];
    switch (server.serverType) {
        case D3ItemServerGame:
            _color = SRGBCOLOR(123, 109, 85);
            break;
        case D3ItemServerStore:
            _color = SRGBCOLOR(169, 152, 111);
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
    
    D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:indexPath.section];
    NSInteger _count = [_cs serversTotalCount];
    D3ItemServer *_server = [_cs serverAtIndex:indexPath.row];
    
    [cell refreshD3CustomBGViewWithIndexPath:indexPath];
    cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
    cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:_count];
    
    cell.lblTitle.textColor = [self titleColorWithServer:_server];
    cell.lblTitle.textAlignment = UITextAlignmentLeft;
    //cell.lblStatus.textColor = [self statusColorWithServer:_server];
    
    cell.lblTitle.text = _server.title;
    //cell.lblStatus.text = _server.status;
    cell.flagStatus.image = _server.statusType == D3ItemServerStatusAvailable ? self.flagStatusAvailable : self.flagStatusMaintenance;
    
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
    _category.textColor = SRGBCOLOR(243, 230, 208);
    [_headerBG addSubview:_category];
    [_category release];
    
    D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:section];
    _category.text = _cs.title;
    
    return _headerBG;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    D3CategoryServer *_cs = [self.loader.serverStatuses objectAtIndex:section];
    return [_cs serversTotalCount];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.loader.serverStatuses count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
