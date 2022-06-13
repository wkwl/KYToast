//
//  UIColor+HSFoundation.m
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import "UIColor+HSFoundation.h"
#import "NSString+HSString.h"

@implementation UIColor (HSFoundation)

+ (BOOL)isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB
{
    if (CGColorEqualToColor(colorA.CGColor, colorB.CGColor)) {
        return YES;
   }else {
           return NO;
   }
}

+ (UIColor *)Hs_colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)Hs_colorWithRGBHex:(UInt32)hex alpha:(float)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)Hs_colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString1 = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString1 length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString1 hasPrefix:@"0X"])
        cString1 = [cString1 safeSubStringFromIndex:2];
    if ([cString1 hasPrefix:@"#"])
        cString1 = [cString1 safeSubStringFromIndex:1];
    if ([cString1 length] != 6)
        return [UIColor clearColor];

    NSScanner *scanner = [NSScanner scannerWithString:cString1];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor Hs_colorWithRGBHex:hexNum];
}

+ (UIImage*)Hs_createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);CGContextFillRect(context, rect);
    UIImage * theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *)Hs_colorWithHexString:(NSString *)stringToConvert alpha:(float)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString safeSubStringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString safeSubStringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor Hs_colorWithRGBHex:hexNum alpha:alpha];
}



@end
