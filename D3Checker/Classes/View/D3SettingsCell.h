//
//  D3SettingsCell.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3CustomBGCell.h"

@interface D3SettingsCell : TCustomBGCell
@property (nonatomic, assign) UILabel *lblTitle;
@property (nonatomic, assign) UILabel *lblSubtitle;

+ (CGFloat)cellHeight;

@end

@interface D3SelectLanguageCell : TCustomBGCell
@property (nonatomic, assign) UILabel *lblTitle;

+ (CGFloat)cellHeight;

@end