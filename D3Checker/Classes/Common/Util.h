//
//  Util.h
//  ShengHuoQuan
//
//  Created by Teng Song on 11-11-21.
//  Copyright (c) 2011年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Marcos
//  log control
#ifdef TARGET_DEBUG
#define SDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SDPRINT(xx, ...)  ((void)0)
#endif
//  assert control
#ifdef TARGET_DEBUG
#define SDASSERT(xx) { if(!(xx)) { SDPRINT(@"SDASSERT failed: %s", #xx); } } ((void)0)
#else
#define SDASSERT(xx) ((void)0)
#endif
//  time manager
#define S_MINUTE    60
#define S_HOUR      (60 * S_MINUTE)
#define S_DAY       (24 * S_HOUR)
#define S_WORKDAY   (5 * S_DAY)
#define S_WEEK      (7 * S_DAY)
#define S_MONTH     (30.5 * S_DAY)
#define S_YEAR      (365 * S_DAY)
//  color manager
#define SRGBCOLOR(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define SRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]
//  prints the current method's name.
#define SDPRINTMETHODNAME() SDPRINT(@"%s", __PRETTY_FUNCTION__)

/** 设备类型 **/

typedef enum 
{
	UIDeviceUnknown,
	
    UIDevice1GiPod,
	UIDevice2GiPod,
	UIDevice3GiPod,
	UIDevice4GiPod,
    
    UIDevice1GiPad,
    
	UIDevice1GiPhone,
	UIDevice3GiPhone,
	UIDevice3GSiPhone,
	UIDevice4iPhone,
	UIDevice5iPhone,
    
    
	UIDevice2GiPad,
    
} UIDevicePlatform;

@interface Util : NSObject {
}
//  file manager
+ (NSString *)pathShare;
+ (NSString *)filePathWith:(NSString *)name isDirectory:(BOOL)isDirectory;
+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path;
+ (BOOL)removePathAt:(NSString *)path;
+ (BOOL)fileIfExist:(NSString *)filePath;
+ (float)fileSize:(NSString *)filePath;
+ (NSString *)fileModifyDate:(NSString *)filePath;
+ (NSString*)randomFileNameWithExt:(NSString *)ext;
+ (NSString*)DataFileNameWithExt:(NSString *)ext;

//  date formate
+ (NSString*)formatRelativeTime:(NSDate *)date;
+ (NSString*)formatDateTime:(NSDate *)date;
+ (NSString*)formatTime:(NSDate *)date;
+ (NSString*)format:(NSDate *)date style:(NSString*)strFmt;
+ (NSString*)formatTimeWithSecond:(float)second;
+ (NSString *)formatVideoRecordTimeWith:(NSTimeInterval)interval;

//  isEmptyString
+ (BOOL)isEmptyString:(NSString *)string;

//  url encode
+ (NSString *)urlEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding;
+ (NSString *)md5Hash:(NSString *)content;

//  image manager
+ (UIImage *)imageWithName:(NSString *)imgname;
+ (UIImage *)imageWithName:(NSString *)imgname ofType:(NSString *)imgtype;
+ (CGGradientRef)newGradientWithColors:(UIColor**)colors locations:(CGFloat*)locations count:(int)count;

//  rotate manager
+ (void)rotateView:(UIView *)view From:(UIInterfaceOrientation)currentOrientation To:(UIInterfaceOrientation)targetOrientation With:(BOOL)animated Delegate:(id)delegate;
+ (UIDevicePlatform)platformType;

+ (void)replaceDictionaryValue:(NSMutableDictionary*)dict value:(id)value forKey:(id)key;

@end
