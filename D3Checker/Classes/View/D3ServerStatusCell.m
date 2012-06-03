//
//  D3ServerStatusCell.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3ServerStatusCell.h"
#import "Util.h"

@interface D3ServerStatusCell()
@end

@implementation D3ServerStatusCell
@synthesize lblTitle, lblStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.customBackgroundView.fillColor = SRGBCOLOR(15, 14, 13);
//        self.customBackgroundView.lineColor = SRGBCOLOR(30, 27, 22);
//        
//        self.customSelectedBackgroundView.fillColor = SRGBCOLOR(18, 17, 16);
//        self.customSelectedBackgroundView.lineColor = SRGBCOLOR(30, 27, 22);
        
        UILabel *_lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, [D3ServerStatusCell cellHeight])];
        _lblT.backgroundColor = [UIColor clearColor];
        _lblT.font = [UIFont systemFontOfSize:14];
        _lblT.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_lblT];
        self.lblTitle = _lblT;
        [_lblT release];
        
        UILabel *_lblS = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 135, [D3ServerStatusCell cellHeight])];
        _lblS.backgroundColor = [UIColor clearColor];
        _lblS.font = [UIFont systemFontOfSize:14];
        _lblS.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_lblS];
        self.lblStatus = _lblS;
        [_lblS release];
    }
    return self;
}
+ (CGFloat)cellHeight {
    return 44.0;
}

@end
