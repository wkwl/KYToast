//
//  KYToast.m
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#import "KYToast.h"
#import "UIColor+HSFoundation.h"
#import "Masonry.h"
#import "DefineHeader.h"


KYToast  *manager = nil;

@interface KYToast ()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UILabel *msgLab;

@property(nonatomic, assign) BOOL isShow;

@property(nonatomic, assign) CGFloat rowSpace;

@property(nonatomic, assign) CGFloat msgFont;

/**创建延时执行任务*/
@property (nonatomic, strong) dispatch_block_t delayStartBlock;



@end

@implementation KYToast

+ (KYToast *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}


- (void)setUI {
    self.isShow = NO;
    self.rowSpace = 5;
    self.msgFont = 14.0;
    [self.bgView  addSubview:self.msgLab];
    [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
}

- (void)makeCommonSet {
//    if (self.delayStartBlock) {
//        dispatch_block_cancel(self.delayStartBlock);
//    }
}


#pragma mark - 对外调用方法

/** 单例类方法*/

+ (void)showInView:(UIView *)superView  msg:(NSString *)msg duration:(CGFloat)duration {
    KYToast *toast = [KYToast shareManager];
    toast.msgLab.font = [UIFont systemFontOfSize:toast.msgFont];
    [toast makeCommonSet];
    [toast makeCommon:superView msg:msg duration:duration showType:KYToastShowTypeCenter];
    
    
}


+ (void)showToast:(NSString *)msg  duration:(CGFloat)duration  showType:(KYToastShowType)showType {
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    KYToast *toast1 = [KYToast shareManager];
    toast1.msgLab.font = [UIFont systemFontOfSize:toast1.msgFont];
    [toast1 makeCommonSet];
    [toast1  makeCommon:keyView msg:msg duration:duration showType:showType];
   
    
}


+ (void)showToast:(NSString *)msg duration:(CGFloat)duration showType:(KYToastShowType)showType msgRowSpace:(CGFloat)space {
    [KYToast shareManager].rowSpace = space;
    [KYToast shareManager].msgLab.font = [UIFont systemFontOfSize:[KYToast shareManager].msgFont];
    [KYToast showToast:msg duration:duration showType:showType];
}



/** 普通方法*/

- (void)showToast:(NSString *)message duration:(CGFloat)duration showType:(KYToastShowType)showType {
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    [self makeCommon:keyView msg:message duration:duration showType:showType];
}

+ (void)showNormalToast:(NSString *)title duration:(CGFloat)duration showType:(KYToastShowType)showType {
//    BOOL isHaveToast = NO;
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
     KYToast *toast = [[self alloc] init];
     [toast makeCommon:keyView msg:title duration:duration showType:showType];
}



#pragma mark - 内容处理

- (void)makeCommon:(UIView *)superView msg:(NSString *)msg duration:(CGFloat)duration showType:(KYToastShowType)showType{
    if (self.isShow) {
        return;
    }
    self.isShow = YES;
    [self rowSpace:self.rowSpace str:msg];
    [superView addSubview:self];
    [superView addSubview:self.bgView];
    [self directionConstrain:showType view:superView];
    [self removeSubView:duration];


}




//移除显示
- (void)removeSubViews{
    self.isShow = NO;
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

//GCD延时处理Toast
- (void)removeSubView:(CGFloat)duration {
    WS(weakSelf);
    self.delayStartBlock = dispatch_block_create(0, ^{
        /**执行延时操作*/
        [weakSelf removeSubViews];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(),self.delayStartBlock);
}




//根据方向设置约束
- (void)directionConstrain:(KYToastShowType)showType view:(UIView *)supView{
    if (showType == KYToastShowTypeCenter) {
        [self makeConstrains:supView];
    }
    else if (showType == KYToastShowTypeTop) {
        [self makeTopConstrains:supView];
    }
    else if (showType == KYToastShowTypeBottom) {
        [self makeBottomConstrains:supView];
    }
}



#pragma mark - 约束设置

//Toast弹框在父视图中的约束位置
- (void)makeConstrains:(UIView *)view {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
        make.width.lessThanOrEqualTo(view).offset(-20.0);
        make.height.lessThanOrEqualTo(view).offset(-20.0);
    }];
}

//Toast弹框在父视图中的约束位置（添加在keyWindow上）
- (void)makeTopConstrains:(UIView *)view {
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.width.lessThanOrEqualTo(view).offset(-20);
        if ([keyView isEqual:view]) {
            make.top.mas_equalTo(view.mas_top).offset(10+kNavigationBar_Height);
        }else{
            make.top.mas_equalTo(view.mas_top).offset(10);
        }
        make.height.lessThanOrEqualTo(view).offset(-20);
       
    }];
}

//Toast弹框在父视图中的约束位置（添加在keyWindow上）
- (void)makeBottomConstrains:(UIView *)view {
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.width.lessThanOrEqualTo(view).offset(-20);
        if ([keyView isEqual:view]) {
            make.bottom.mas_equalTo(view.mas_bottom).offset(-10-BottomBar_Height);
        }else{
            make.bottom.mas_equalTo(view.mas_bottom).offset(-10);
        }
        make.height.lessThanOrEqualTo(view).offset(-20);
       
    }];
}


#pragma mark -
/** msg 文本行间距*/
- (void)rowSpace:(CGFloat)space str:(NSString *)msg{
    if (!msg) {
        msg = @"";
    }
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:msg];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//设置距离
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attriString addAttribute:NSParagraphStyleAttributeName
    value:paragraphStyle
    range:NSMakeRange(0, [msg length])];
    self.msgLab.attributedText = attriString;
 
}




#pragma mark - lazy load
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [[UIColor Hs_colorWithHexString:@"#000000"] colorWithAlphaComponent:1.0];
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UILabel *)msgLab {
    if (!_msgLab) {
        _msgLab = [[UILabel alloc] init];
        _msgLab.textColor = [UIColor whiteColor];
        _msgLab.font = [UIFont systemFontOfSize:14];
        _msgLab.numberOfLines = 0;
    }
    return _msgLab;
}

@end
