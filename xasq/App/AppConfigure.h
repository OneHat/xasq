//
//  AppConfigure.h
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#ifndef AppConfigure_h
#define AppConfigure_h

#pragma mark:

#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height

#define IphoneX             (ScreenHeight / ScreenWidth  > 2.0 ? YES : NO)

#define StatusBarHeight     [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBarHeight        44.0
#define BottomHeight        (IphoneX ? 34.0 : 0.0)
#define NavHeight           (NavBarHeight + StatusBarHeight)
#define BarHeight           (BottomHeight + 49)
/** app版本号 */
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** app build版本号 */
#define AppBuild            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#endif /* AppConfigure_h */
