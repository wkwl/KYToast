//
//  KYToast.h
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,KYToastShowType) {
    KYToastShowTypeCenter, //Toast弹框显示在父视图中间
    KYToastShowTypeTop,    //Toast弹框显示在父视图顶部居中
    KYToastShowTypeBottom  //Toast弹框显示在父视图底部居中显示
};

@interface KYToast : UIView



/** 单例*/
+ (KYToast *)shareManager;






#pragma mark - 单例方法

/**
 *  superView :往superView上添加Toast
 *  msg:Toast提示内容
 *  duration:弹框停留时间
 */
+(void)showInView:(UIView *)superView
               msg:(NSString *)msg
         duration:(CGFloat)duration;



/**
 *  msg:Toast提示内容
 *  duration:弹框停留时间
 *  showType: Toast弹框显示位置
 */
+ (void)showToast:(NSString *)msg
         duration:(CGFloat)duration
         showType:(KYToastShowType)showType;



/**
 *  msg:Toast提示内容
 *  duration:弹框停留时间
 *  showType: Toast弹框显示位置
 *  msgRowSpace:富文本行间距
 */
+ (void)showToast:(NSString *)msg
         duration:(CGFloat)duration
         showType:(KYToastShowType)showType
      msgRowSpace:(CGFloat)space;


#pragma mark - 普通方法

/**
 *  message:Toast提示内容
 *  duration:弹框停留时间
 *  showType: Toast弹框显示位置
 *
 */
- (void)showToast:(NSString *)message
         duration:(CGFloat)duration
         showType:(KYToastShowType)showType;



+ (void)showNormalToast:(NSString *)title
         duration:(CGFloat)duration
         showType:(KYToastShowType)showType;
@end

NS_ASSUME_NONNULL_END
