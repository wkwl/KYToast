//
//  NSString+HSString.m
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import "NSString+HSString.h"

@implementation NSString (HSString)


- (NSString *)safeSubStringFromIndex:(NSUInteger)index
{
    if (index > self.length) {
        return @"";
    }
    NSString *str = [self substringFromIndex:index];
    return str;
}


@end
