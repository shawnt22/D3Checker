//
//  D3ServerStatusCell.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3CustomBGCell.h"

@protocol D3CustomBGCellProtocol <NSObject>
@optional
+ (UIColor *)cellBGColorWithIndexPath:(NSIndexPath *)indexPath;
+ (void)refreshCellBGView;
@end

@interface D3ServerStatusCell : D3CustomBGCell

@property (nonatomic, assign) UILabel *lblTitle;
@property (nonatomic, assign) UILabel *lblStatus;
@property (nonatomic, assign) UIImageView *flagStatus;

+ (CGFloat)cellHeight;

@end
