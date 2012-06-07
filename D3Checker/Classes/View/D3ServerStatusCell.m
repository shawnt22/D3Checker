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
@synthesize lblTitle, lblStatus, flagStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *_lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, [D3ServerStatusCell cellHeight])];        //  150 -> 250
        _lblT.backgroundColor = [UIColor clearColor];
        _lblT.font = [UIFont systemFontOfSize:14];
        _lblT.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_lblT];
        self.lblTitle = _lblT;
        [_lblT release];
        
//        UILabel *_lblS = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 135, [D3ServerStatusCell cellHeight])];
//        _lblS.backgroundColor = [UIColor clearColor];
//        _lblS.font = [UIFont systemFontOfSize:14];
//        _lblS.textAlignment = UITextAlignmentRight;
//        [self.contentView addSubview:_lblS];
//        self.lblStatus = _lblS;
//        [_lblS release];
        
        UIImageView *_flag = [[UIImageView alloc] initWithFrame:CGRectMake(260.0, 9.0, 24, 27)];
        _flag.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_flag];
        self.flagStatus = _flag;
        [_flag release];
    }
    return self;
}
+ (CGFloat)cellHeight {
    return 44.0;
}

@end
