//
//  DefineHeader.h
//  CommonTool
//
//  Created by sgx_05 on 2022/5/30.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define StatusBar_Height     [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度 20,44

#define BottomBar_Height     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0) //底部距离

#define SafeTopAreaHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?24:0) //顶部距离

#define kNavigationBar_Height     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64) // 适配iPhone x 导航栏高度

#define WS(weakSelf)            __weak __typeof(&*self)weakSelf = self;

#define StrongSelf(strongSelf)  __strong __typeof(&*self)strongSelf = weakSelf;

#define Get375Width(w)   (w) * ScreenWidth / 375.0


#endif /* DefineHeader_h */
