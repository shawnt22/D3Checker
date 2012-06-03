//
//  D3SettingsViewController.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3SettingsViewController.h"
#import "D3SettingsCell.h"
#import "D3SelectLanguageViewController.h"

@interface D3SettingsViewController()
@property (nonatomic, assign) D3TableView *theTableView;

- (void)emailMeAction:(id)sender;
- (void)changeLanagerAction:(id)sender;
@end

@implementation D3SettingsViewController
@synthesize theTableView;

#define kD3SettingsTableSectionNumber 2
#define kD3SettingsTableConfigerRowNumber 1
#define kD3SettingsTableAboutRowNumber 2

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

#pragma mark actions
- (void)emailMeAction:(id)sender {
    
}
- (void)changeLanagerAction:(id)sender {
    D3SelectLanguageViewController *_slvctr = [[D3SelectLanguageViewController alloc] init];
    [self.navigationController pushViewController:_slvctr animated:YES];
    [_slvctr refreshBarItems];
    [_slvctr release];
}
- (void)showAboutAction:(id)sender {
    
}
- (void)responseNotification:(NSNotification *)notification {
    [super responseNotification:notification];
    if ([[notification name] isEqualToString:kD3NotificationSupportLanguageChanged]) {
        [self.theTableView reloadData];
        return;
    }
}

#pragma mark refresh
- (NSString *)controllerTitle {
    return [SUtil titleOfSettingsViewController];
}

#pragma mark table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"d3cell";
    D3SettingsCell *cell = (D3SettingsCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell) {
        cell = [[[D3SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.lblTitle.text = nil;
    cell.lblSubtitle.text = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableConfigerRowNumber];
            cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableConfigerRowNumber];
            
            cell.lblTitle.text = [SUtil descriptionOfSettingsTableLanguage];
            cell.lblSubtitle.text = [SSettings descriptionWithD3language:[D3DataManager shareInstance].settings.language];
        }
            break;
        case 1:
        {
            cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableAboutRowNumber];
            cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableAboutRowNumber];
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.lblTitle.text = [SUtil descriptionOfSettingsTableEmailMe];
                }
                    break;
                case 1:
                {
                    cell.lblTitle.text = [SUtil descriptionOfSettingsTableAboutMe];
                }
                    break;    
                default:
                    break;
            }
        }
            break;    
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [D3SettingsCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return kD3SettingsTableConfigerRowNumber;
            break;
        case 1:
            return kD3SettingsTableAboutRowNumber;
            break;    
        default:
            break;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kD3SettingsTableSectionNumber;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            [self changeLanagerAction:nil];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self emailMeAction:nil];
                }
                    break;
                case 1:
                {
                    [self showAboutAction:nil];
                }
                    break;    
                default:
                    break;
            }
        }
            break;    
        default:
            break;
    }
}

@end
