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
- (UIImage *)iconWithIndex:(NSIndexPath *)indexPath;
@end

@implementation D3SettingsViewController
@synthesize theTableView;

#define kD3SettingsTableSectionNumber 1
#define kD3SettingsTableConfigerRowNumber 2
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
    _tb.backgroundColor = [UIColor clearColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    self.theTableView = _tb;
    [_tb release];
    
    UIView *_bgFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.theTableView.bounds.size.width, 240)];
    _bgFooter.backgroundColor = [UIColor clearColor];
    
    CGFloat _cpHeight = 30.0;
    UILabel *_cpright = [[UILabel alloc] initWithFrame:CGRectMake(0, _bgFooter.bounds.size.height-_cpHeight, _bgFooter.bounds.size.width, _cpHeight)];
    _cpright.backgroundColor = [UIColor clearColor];
    _cpright.textColor = SRGBCOLOR(123, 123, 123);
    _cpright.textAlignment = UITextAlignmentCenter;
    _cpright.font = [UIFont systemFontOfSize:12];
    _cpright.text = @"Copyright shawnt22@gmail.com. All rights reserved.";
    [_bgFooter addSubview:_cpright];
    [_cpright release];
    
    UILabel *_version = [[UILabel alloc] initWithFrame:CGRectMake(_cpright.frame.origin.x, _cpright.frame.origin.y-_cpright.frame.size.height, _cpright.frame.size.width, _cpright.frame.size.height)];
    _version.backgroundColor = _cpright.backgroundColor;
    _version.textColor = _cpright.textColor;
    _version.font = _cpright.font;
    _version.textAlignment = _cpright.textAlignment;
    _version.text = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    [_bgFooter addSubview:_version];
    [_version release];
    
    self.theTableView.tableFooterView = _bgFooter;
    [_bgFooter release];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark actions
- (void)emailMeAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:shawnt22@gmail.com"]];
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
- (void)refreshBarItems {
    [super refreshBarItems];
    
    UIImage *_settingsImage = [UIImage imageNamed:@"bg_settings.png"];
    self.navigationController.tabBarItem.image = _settingsImage;
}
- (NSString *)controllerTitle {
    return [SUtil titleOfSettingsViewController];
}

#pragma mark table
- (UIImage *)iconWithIndex:(NSIndexPath *)indexPath {
    UIImage *icon = nil;
    switch (indexPath.row) {
        case 0:
        {
            icon = [Util imageWithName:@"bg_language"];
        }
            break;
        case 1:
        {
            icon = [Util imageWithName:@"bg_mail"];
        }
            break;    
        default:
            break;
    }
    return icon;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"d3cell";
    D3SettingsCell *cell = (D3SettingsCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell) {
        cell = [[[D3SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.lblTitle.text = nil;
    cell.lblSubtitle.text = nil;
    [cell refreshD3CustomBGViewWithIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.customBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableConfigerRowNumber];
            cell.customSelectedBackgroundView.bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:kD3SettingsTableConfigerRowNumber];
            
            cell.iconImage.image = [self iconWithIndex:indexPath];
            if (indexPath.row == 0) {
                cell.lblSubtitle.text = [SSettings descriptionWithD3language:[D3DataManager shareInstance].settings.language];
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
            switch (indexPath.row) {
                case 0:
                {
                    [self changeLanagerAction:nil];
                }
                    break;
                case 1:
                {
                    [self emailMeAction:nil];
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
