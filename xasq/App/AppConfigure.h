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

#define Screen_W            [UIScreen mainScreen].bounds.size.width
#define Screen_H            [UIScreen mainScreen].bounds.size.height

#define Iphone_x            Screen_H / Screen_W  > 2.0 ? true : false

#define StatusBar_H         [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBar_H            44.0
#define Bottom_H            Iphone_x ? 34.0 : 0.0




#endif /* AppConfigure_h */
