//
//  D3SelectLanguageViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3SelectLanguageViewController.h"
#import "D3SettingsCell.h"

@interface D3SelectLanguageViewController ()
@property (nonatomic, assign) D3TableView *theTableView;

@end

@implementation D3SelectLanguageViewController
@synthesize theTableView;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    
    D3TableView *_tb = [[D3TableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height) style:UITableViewStyleGrouped];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.backgroundColor = [UIColor clearColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    self.theTableView = _tb;
    [_tb release];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark refresh
- (NSString *)controllerTitle {
    return [SUtil titleOfSelectLanguageViewController];
}

#pragma mark table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"d3cell";
    D3SelectLanguageCell *cell = (D3SelectLanguageCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell) {
        cell = [[[D3SelectLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
    }
    cell.lblTitle.text = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell refreshD3CustomBGViewWithIndexPath:indexPath];
    cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:D3SupportLanguageCount];
    cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:D3SupportLanguageCount];
    
    cell.lblTitle.text = [SSettings descriptionWithD3language:indexPath.row];
    if (indexPath.row == [D3DataManager shareInstance].settings.language) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [D3SelectLanguageCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return D3SupportLanguageCount;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [D3DataManager shareInstance].settings.language) {
        return;
    }
    [D3DataManager shareInstance].settings.language = indexPath.row;
    [[D3DataManager shareInstance].settings saveSettings];
    [[NSNotificationCenter defaultCenter] postNotificationName:kD3NotificationSupportLanguageChanged object:nil userInfo:nil];
    
    [self.theTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
