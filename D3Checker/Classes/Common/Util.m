//
//  Util.m
//  ShengHuoQuan
//
//  Created by Teng Song on 11-11-21.
//  Copyright (c) 2011年 shawnt22@gmail.com. All rights reserved.
//

#import "Util.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#import <objc/runtime.h>

@implementation Util

#pragma mark -
#pragma mark File Manager
+ (NSString *)pathShare
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	if ([paths count] > 0) {		
        
		NSString *dPath = [NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
        return dPath;
	}	
	return nil; 
}
+ (NSString *)filePathWith:(NSString *)name isDirectory:(BOOL)isDirectory
{
	NSString *path = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	if ([paths count] > 0) {	
		name = isDirectory ? name : [name lastPathComponent];
		path = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
	}
	return path;
}
+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path
{
	BOOL succeeded = YES;
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSError *err = [[NSError alloc] init];
		succeeded = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
		if (!succeeded) {
			SDPRINT(@"Create Path Error : %@", err);
		}
		[err release];
	}
	return succeeded;
}
+ (BOOL)removePathAt:(NSString *)path
{
	BOOL succeeded = YES;
    
    //File Not Exist return Yes
    if (![self fileIfExist:path]) {
        return YES;
    }
    
	NSError *err = [[NSError alloc] init];
	succeeded = [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
	if (!succeeded) {
		SDPRINT(@"Remove Path Error : %@", err);
	}
	[err release];
	return succeeded;
}
+ (BOOL)fileIfExist:(NSString *)filePath
{
    BOOL rtn = YES;
    //EmptyPath return file Not Exist
    if([self isEmptyString:filePath])  return NO;
    
    NSFileManager *file_manager = [NSFileManager defaultManager];
    rtn =  [file_manager fileExistsAtPath:filePath];
    return rtn;
}
+ (float)fileSize:(NSString *)filePath
{
    float rtn = 0.0;
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:filePath]) {
        NSDictionary * attributes = [file_manager attributesOfItemAtPath:filePath error:nil];
        // file size
        NSNumber *theFileSize;
        theFileSize = [attributes objectForKey:NSFileSize];
        if (theFileSize) {
            rtn = [theFileSize floatValue];
        }
    }
    return rtn;
}
+ (NSString *)fileModifyDate:(NSString *)filePath
{
    NSString * rtn = nil;
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:filePath]) {
        NSDictionary * attributes = [file_manager attributesOfItemAtPath:filePath error:nil];
        NSDate * date = [attributes objectForKey:NSFileModificationDate];
        
        rtn = [Util format:date style:@"M月d日"];
    }
    return rtn;
}
+ (NSString*)randomFileNameWithExt:(NSString *)ext
{
    NSMutableString * rtn = [[NSMutableString alloc] init];
    NSString * dictionary = @"abcdefghijklmnopqrstuvwsyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //srandom(time(NULL));
    for (int i=0 ; i< 20; i++) {
        int r = arc4random() % [dictionary length];
        [rtn appendString:[dictionary substringWithRange:NSMakeRange(r, 1)]];
    }
    if (![self isEmptyString:ext]) {
        [rtn appendFormat:@".%@",ext];
    }
    return rtn;
}
+ (NSString*)DataFileNameWithExt:(NSString *)ext
{
    NSMutableString * rtn = [[NSMutableString alloc] init];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"ddMMMyyyyHHmmss"];
    [rtn appendFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    
    if (![self isEmptyString:ext]) {
        [rtn appendFormat:@".%@",ext];
    }
    // fix
    return [rtn autorelease];
}
#pragma mark -
#pragma mark Date Formate
+ (NSString*)formatRelativeTime:(NSDate *)date 
{	
	NSTimeInterval elapsed = abs([date timeIntervalSinceNow]);
	if (elapsed < S_MINUTE) {
		int secds = (int)floor(elapsed);
		return secds < 2 ? @"刚刚" : [NSString stringWithFormat:@"%d秒前",secds];
	}
	if (elapsed < S_HOUR) {
		int mins = (int)floor(elapsed/S_MINUTE);
		return [NSString stringWithFormat:@"%d分钟前",mins];
	}
	if (elapsed < S_DAY) {
		int hours = (int)floor(elapsed/S_HOUR);
		return [NSString stringWithFormat:@"%d小时前",hours];
	}
	int days = (int)floor((elapsed+S_DAY/2)/S_DAY);
	if (days < 2) {
		return @"昨天";
	}
	if (days < 3) {
		return @"前天";
	}
	return [Util formatDateTime:date];
}
+ (NSString*)formatDateTime:(NSDate *)date 
{
	NSTimeInterval diff = abs([date timeIntervalSinceNow]);
	return diff < S_DAY ? [Util format:date style:@"h:mm a"] : [Util format:date style:@"M月d日 H:mm"];
}
+ (NSString*)formatTime:(NSDate *)date 
{
	return [Util format:date style:@"h:mm a"];
}
+ (NSString*)format:(NSDate *)date style:(NSString*)strFmt
{
	NSString *result = nil;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:strFmt];
	result = [formatter stringFromDate:date];
	[formatter release];	
	return result;
}
+ (NSString*)formatTimeWithSecond:(float)formatSecond
{
    NSString * rtn = nil;
    NSString * secondString = nil;
    NSString * miniteString = nil;
    
    NSInteger second = ceilf(formatSecond);
    
    if (second < S_MINUTE) 
    {
        secondString = [NSString stringWithFormat:@"%02d", second];
        miniteString = [NSString stringWithString:@"00"];
	}
	else if (second < S_HOUR) 
    {
        NSInteger tmpMinite =  second / S_HOUR;
        miniteString = [NSString stringWithFormat:@"%02d", tmpMinite];
        NSInteger tmpSecond = (int)(second-tmpMinite*S_MINUTE) % S_MINUTE;
        secondString = [NSString stringWithFormat:@"%02d", tmpSecond];
	}
    
    rtn = [NSString stringWithFormat:@"%@:%@",miniteString,secondString];
    
    return rtn;
}
+ (NSString *)formatVideoRecordTimeWith:(NSTimeInterval)interval
{
    NSString *result = [NSString stringWithString:@"00:00:00"];
    
    if (interval < 0) return result;
    
    NSInteger hour = (NSInteger)floor(interval/S_HOUR);
    interval -= hour * S_HOUR;
    NSInteger minute = (NSInteger)floor(interval/S_MINUTE);
    interval -= minute * S_MINUTE;
    NSInteger second = (NSInteger)floor(interval);
    result = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    return result;
}

#pragma marc -
#pragma marc Empty String
+ (BOOL)isEmptyString:(NSString *)string
{
    BOOL result = NO;
    if (string == nil || [string length] == 0 || [string isEqualToString:@""]) {
        result = YES;
    }
    return result;
}

#pragma marc -
#pragma marc URL Encode
+ (NSString *)urlEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding
{
    if ([Util isEmptyString:originalString]) {
		return nil;
	}	
	//!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
	//%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
							@"@" , @"&" , @"=" , @"+" ,	@"$" , @"," ,
							@"!", @"'", @"(", @")", @"*", nil];	
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F" , @"%3F" , @"%3A" , 
							 @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
							 @"%21", @"%27", @"%28", @"%29", @"%2A", nil];	
    int len = [escapeChars count];	
	NSString *temp = [originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding];	
    for(int i = 0; i < len; i++) {
        temp = [temp stringByReplacingOccurrencesOfString:[escapeChars objectAtIndex:i]
											   withString:[replaceChars objectAtIndex:i]
												  options:NSLiteralSearch
													range:NSMakeRange(0, [temp length])];
    }	
    NSString *outString = [NSString stringWithString:temp];	
    return outString;
}

+ (NSString *)md5Hash:(NSString *)content
{
	const char* str = [content UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(str, strlen(str), result);
	
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];
}

#pragma marc -
#pragma marc Image Manager
+ (UIImage *)imageWithName:(NSString *)imgname
{
	return [Util imageWithName:imgname ofType:@"png"];
}
+ (UIImage *)imageWithName:(NSString *)imgname ofType:(NSString *)imgtype
{
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgname ofType:imgtype]];
}
+ (CGGradientRef)newGradientWithColors:(UIColor**)colors locations:(CGFloat*)locations
								 count:(int)count {
	CGFloat* components = malloc(sizeof(CGFloat)*4*count);
	for (int i = 0; i < count; ++i) {
		UIColor* color = colors[i];
		size_t n = CGColorGetNumberOfComponents(color.CGColor);
		const CGFloat* rgba = CGColorGetComponents(color.CGColor);
		if (n == 2) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[0];
			components[i*4+2] = rgba[0];
			components[i*4+3] = rgba[1];
		} else if (n == 4) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[1];
			components[i*4+2] = rgba[2];
			components[i*4+3] = rgba[3];
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
	free(components);
	return gradient;
}

#pragma mark -
#pragma mark Rotate
+ (void)rotateView:(UIView *)view From:(UIInterfaceOrientation)currentOrientation To:(UIInterfaceOrientation)targetOrientation With:(BOOL)animated Delegate:(id)delegate
{
	UIInterfaceOrientation current = currentOrientation;
	UIInterfaceOrientation orientation = targetOrientation;    
    
    if ( current == orientation )
        return;
    
    // direction and angle
    CGFloat angle = 0.0;
    switch ( current )
    {
        case UIInterfaceOrientationPortrait:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
    }
	
	UIView *v = view;
	if (animated) {	
		[UIView beginAnimations:@"RotateAnimation" context:NULL];
		[UIView setAnimationDuration:0.3];
		//v.transform = CGAffineTransformRotate(v.transform, angle);
        v.layer.transform = CATransform3DRotate(v.layer.transform, angle, 0.0, 0.0, 1.0);
		[UIView commitAnimations];
	}else {
		//v.transform = CGAffineTransformRotate(v.transform, angle);
        v.layer.transform = CATransform3DRotate(v.layer.transform, angle, 0.0, 0.0, 1.0);
	}
}

+ (void)replaceDictionaryValue:(NSMutableDictionary*)dict value:(id)value forKey:(id)key
{
	[dict removeObjectForKey:key];
	[dict setObject:value forKey:key];
}

#pragma mark Sysctlbyname Utils
#pragma ---

+ (NSString *)getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	free(answer);
	return results;
}

+ (NSString *)platform
{
	return [Util getSysInfoByName:"hw.machine"];
}

+ (UIDevicePlatform)platformType
{
	NSString *platform = [Util platform];
    if ([platform hasPrefix:@"iPhone3"])			return UIDevice4iPhone;
	if ([platform hasPrefix:@"iPhone4"])			return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone2"])	        return UIDevice3GSiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])	return UIDevice3GiPhone;
    
    if ([platform isEqualToString:@"iPad1,1"])      return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"])      return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;
	
    if ([platform isEqualToString:@"iPod3,1"])      return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"])      return UIDevice4GiPod;
    if ([platform isEqualToString:@"iPod1,1"])      return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])      return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPhone1,1"])	return UIDevice1GiPhone;
	return UIDeviceUnknown;
}

@end
