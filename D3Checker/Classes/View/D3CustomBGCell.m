//
//  D3CustomBGCell.m
//  D3Checker
//
//  Created by 松 滕 on 12-6-2.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "D3CustomBGCell.h"

@implementation TCustomBGCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        
        TCustomCellBGView *_bg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        self.backgroundView = _bg;
        [_bg release];
        
        TCustomCellBGView *_sbg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = _sbg;
        [_sbg release];
    }
    return self;
}
- (TCustomCellBGView *)customBackgroundView {
    return [self.backgroundView isKindOfClass:[TCustomCellBGView class]] ? (TCustomCellBGView *)(self.backgroundView) : nil;
}
- (TCustomCellBGView *)customSelectedBackgroundView {
    return [self.selectedBackgroundView isKindOfClass:[TCustomCellBGView class]] ? (TCustomCellBGView *)(self.selectedBackgroundView) : nil;
}

@end

@interface TCustomCellBGView()
@property (nonatomic, assign) BOOL isDrawingLine;
@end

@interface TCustomCellBGView(Draw)
- (void)fillBGWithContext:(CGContextRef)context Rect:(CGRect)rect;
- (void)fillLineWithContext:(CGContextRef)context Rect:(CGRect)rect;
- (void)fillRectWithContext:(CGContextRef)context Rect:(CGRect)rect Color:(UIColor *)color isDrawingLine:(BOOL)isDrawingLine;
@end
@implementation TCustomCellBGView(Draw)

- (void)fillBGWithContext:(CGContextRef)context Rect:(CGRect)rect {
    [self fillRectWithContext:context Rect:rect Color:self.fillColor isDrawingLine:NO];
}
- (void)fillLineWithContext:(CGContextRef)context Rect:(CGRect)rect {
    [self fillRectWithContext:context Rect:rect Color:self.lineColor isDrawingLine:YES];
}
- (void)fillRectWithContext:(CGContextRef)context Rect:(CGRect)rect Color:(UIColor *)color isDrawingLine:(BOOL)isDrawingLine {
    self.isDrawingLine = isDrawingLine;
    
    UIColor *fillColor = color;
    if (!fillColor) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    
    switch (self.bgStyle) {
        case CustomBGCellStyleGroupSingle:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x+self.lineWidth,
                                                     rect.origin.y+self.lineWidth, 
                                                     rect.size.width-self.lineWidth*2, 
                                                     rect.size.height-self.lineWidth*2);
            CGContextMoveToPoint(context, rect.origin.x+rect.size.width/2, rect.origin.y);
            CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2, self.lineRadius);
            CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width/2, rect.size.height+rect.origin.y, self.lineRadius);
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y+rect.size.height, rect.origin.x, rect.origin.y+rect.size.height/2, self.lineRadius);
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x+rect.size.width/4, rect.origin.y, self.lineRadius);
        }
            break;
        case CustomBGCellStyleGroupTop:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x+self.lineWidth,
                                                     rect.origin.y+self.lineWidth, 
                                                     rect.size.width-self.lineWidth*2, 
                                                     rect.size.height-self.lineWidth*2);
            CGContextMoveToPoint(context, rect.origin.x+rect.size.width/2, rect.origin.y);
            CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y, rect.size.width+rect.origin.x, rect.origin.y+rect.size.height, self.lineRadius);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.size.height+rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x, rect.size.height+rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x, rect.size.height/2+rect.origin.y);
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x+rect.size.width/4, rect.origin.y, self.lineRadius);
        }
            break;
        case CustomBGCellStyleGroupMiddle:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x+self.lineWidth,
                                                     rect.origin.y, 
                                                     rect.size.width-self.lineWidth*2, 
                                                     rect.size.height-self.lineWidth);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
        }
            break;
        case CustomBGCellStyleGroupBottom:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x+self.lineWidth,
                                                     rect.origin.y, 
                                                     rect.size.width-self.lineWidth*2, 
                                                     rect.size.height-self.lineWidth);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height, self.lineRadius);
            CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2, self.lineRadius);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
        }
            break;
        case CustomBGCellStylePlainTop:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x,
                                                     rect.origin.y+self.lineWidth, 
                                                     rect.size.width, 
                                                     rect.size.height-self.lineWidth);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
        }
            break;
        case CustomBGCellStylePlainMiddle:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x,
                                                     rect.origin.y+self.lineWidth, 
                                                     rect.size.width, 
                                                     rect.size.height-self.lineWidth);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
        }
            break;
        case CustomBGCellStylePlainBottom:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x,
                                                     rect.origin.y+self.lineWidth, 
                                                     rect.size.width, 
                                                     rect.size.height-self.lineWidth*2);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
        }
            break;
        case CustomBGCellStylePlainSingle:
        {
            rect = isDrawingLine ? rect : CGRectMake(rect.origin.x,
                                                     rect.origin.y+self.lineWidth*2, 
                                                     rect.size.width, 
                                                     rect.size.height-self.lineWidth*2);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
        }
            break;
        default:
            break;
    }
    
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

@end

@implementation TCustomCellBGView
@synthesize lineColor, lineWidth, lineRadius = _lineRadius, fillColor;
@synthesize bgStyle = _bgStyle, contentInsets;
@synthesize isDrawingLine;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.lineColor = [UIColor colorWithRed:(172/255.0) green:(172/255.0) blue:(172/255.0) alpha:1.0];
        self.lineRadius = 5.0;
        self.lineWidth = 0.5;
        self.fillColor = [UIColor colorWithRed:(253/255.0) green:(253/255.0) blue:(253/255.0) alpha:1.0];
        
        _bgStyle = CustomBGCellStyleGroupSingle;
    }
    return self;
}
- (void)dealloc {
    self.fillColor = nil;
    [super dealloc];
}
- (void)setBgStyle:(TCustomBGCellStyle)bgStyle {
    _bgStyle = bgStyle;
    [self setNeedsDisplay];
}
- (float)lineRadius {
    float result = self.isDrawingLine ? _lineRadius+1 : _lineRadius;
    return result;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect validRect = CGRectMake(rect.origin.x+self.contentInsets.left, 
                                  rect.origin.y+self.contentInsets.top, 
                                  rect.size.width-(self.contentInsets.left+self.contentInsets.right), 
                                  rect.size.height-(self.contentInsets.top+self.contentInsets.bottom));
    [self fillLineWithContext:context Rect:validRect];
    [self fillBGWithContext:context Rect:validRect];
}
+ (TCustomBGCellStyle)groupStyleWithIndex:(NSInteger)index Count:(NSInteger)count {
    if (count > 0) {
        if (count > 1) {
            if (index == 0) {
                return CustomBGCellStyleGroupTop;
            }
            if (index == count - 1) {
                return CustomBGCellStyleGroupBottom;
            }
            return CustomBGCellStyleGroupMiddle;
        }
        return CustomBGCellStyleGroupSingle;
    }
    return CustomBGCellStyleNone;
}
+ (TCustomBGCellStyle)plainStyleWithIndex:(NSInteger)index Count:(NSInteger)count {
    if (count > 0) {
        if (count > 1) {
            if (index == 0) {
                return CustomBGCellStylePlainTop;
            }
            if (index == count - 1) {
                return CustomBGCellStylePlainBottom;
            }
            return CustomBGCellStylePlainMiddle;
        }
        return CustomBGCellStylePlainSingle;
    }
    return CustomBGCellStyleNone;
}

@end



#pragma mark - D3CustomBGCell
#import "Util.h"
@implementation D3CustomBGCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.customBackgroundView.lineRadius = 4.0;
        self.customSelectedBackgroundView.lineRadius = 4.0;
        self.customBackgroundView.lineColor = SRGBCOLOR(40, 36, 29);
        self.customSelectedBackgroundView.lineColor = SRGBCOLOR(40, 36, 29);
        
        self.customSelectedBackgroundView.fillColor = SRGBCOLOR(50, 45, 35);
    }
    return self;
}
- (void)refreshD3CustomBGViewWithIndexPath:(NSIndexPath *)indexPath {
    self.customBackgroundView.fillColor = indexPath.row % 2 == 0 ? SRGBCOLOR(18, 17, 15) : SRGBCOLOR(23, 22, 20);
}

@end