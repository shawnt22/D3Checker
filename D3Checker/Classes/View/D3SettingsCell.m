//
//  D3SettingsCell.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3SettingsCell.h"
#import "Util.h"

@implementation D3SettingsCell
@synthesize lblTitle, lblSubtitle;
@synthesize iconImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UILabel *_lt = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, [D3SettingsCell cellHeight])];
//        _lt.backgroundColor = [UIColor clearColor];
//        _lt.font = [UIFont systemFontOfSize:16];
//        _lt.textAlignment = UITextAlignmentLeft;
//        [self.contentView addSubview:_lt];
//        self.lblTitle = _lt;
//        [_lt release];
        self.lblTitle = nil;
        
        UIImageView *_icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, ceilf(([D3SettingsCell cellHeight] - 32)/2), 32, 32)];
        _icon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_icon];
        self.iconImage = _icon;
        [_icon release];
        
        UILabel *_ls = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 170, [D3SettingsCell cellHeight])];
        _ls.backgroundColor = [UIColor clearColor];
        _ls.textColor = SRGBCOLOR(112, 71, 38);
        _ls.font = [UIFont systemFontOfSize:14];
        _ls.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_ls];
        self.lblSubtitle = _ls;
        [_ls release];
    }
    return self;
}
+ (CGFloat)cellHeight {
    return 44.0;
}

@end

@implementation D3SelectLanguageCell
@synthesize lblTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *_lt = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, [D3SettingsCell cellHeight])];
        _lt.backgroundColor = [UIColor clearColor];
        _lt.textColor = SRGBCOLOR(64, 57, 47);
        _lt.font = [UIFont systemFontOfSize:16];
        _lt.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_lt];
        self.lblTitle = _lt;
        [_lt release];
    }
    return self;
}
+ (CGFloat)cellHeight {
    return 44.0;
}

@end