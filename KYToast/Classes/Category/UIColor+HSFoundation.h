//
//  UIColor+HSFoundation.h
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HSFoundation)
//判断两者颜色是否相等
+ (BOOL)isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB;
+ (UIColor *)Hs_colorWithHexString:(NSString *)stringToConvert;
+ (UIImage*)Hs_createImageWithColor:(UIColor*)color;
+ (UIColor *)Hs_colorWithHexString:(NSString *)stringToConvert alpha:(float)alpha;

@end

NS_ASSUME_NONNULL_END
