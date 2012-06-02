//
//  D3CustomBGCell.h
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomBGCellStyleNone,
    
    CustomBGCellStyleGroupTop,
    CustomBGCellStyleGroupMiddle,
    CustomBGCellStyleGroupBottom,
    CustomBGCellStyleGroupSingle,
    
    CustomBGCellStylePlainTop,
    CustomBGCellStylePlainMiddle,
    CustomBGCellStylePlainBottom,
    CustomBGCellStylePlainSingle,
}TCustomBGCellStyle;

#define kCustomCellSelectedBGColor [UIColor colorWithRed:(232/255.0) green:(233/255.0) blue:(237/255.0) alpha:1.0]

@class TCustomCellBGView;
@protocol TCustomCellBGViewProtocol <NSObject>
@required
@property (nonatomic, readonly) TCustomCellBGView *customBackgroundView;
@property (nonatomic, readonly) TCustomCellBGView *customSelectedBackgroundView;
@end

@interface TCustomBGCell : UITableViewCell<TCustomCellBGViewProtocol> {
}

@end


@interface TCustomCellBGView : UIView {
@private
    TCustomBGCellStyle _bgStyle;
    float _lineRadius;
}
//  style
@property (nonatomic, assign) TCustomBGCellStyle bgStyle;
//  valid rect
@property (nonatomic, assign) UIEdgeInsets contentInsets;
//  line
@property (nonatomic, retain) UIColor *lineColor;   //  default = blackColor
@property (nonatomic, assign) float lineWidth;
@property (nonatomic, assign) float lineRadius;
//  background
@property (nonatomic, retain) UIColor *fillColor;   //  default = nil

+ (TCustomBGCellStyle)groupStyleWithIndex:(NSInteger)index Count:(NSInteger)count;  //  table style 为 UITableViewStyleGrouped
+ (TCustomBGCellStyle)plainStyleWithIndex:(NSInteger)index Count:(NSInteger)count;  //  table style 为 UITableViewStylePlain

@end
