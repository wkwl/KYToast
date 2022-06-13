//
//  NSString+HSString.h
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HSString)

- (NSString *)safeSubStringFromIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
