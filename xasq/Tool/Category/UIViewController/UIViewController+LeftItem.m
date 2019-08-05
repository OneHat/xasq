//
//  UIViewController+LeftItem.m
//  xasq
//
//  Created by dssj on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+LeftItem.h"
#import <objc/runtime.h>

@implementation UIViewController (LeftItem)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method dssj_viewWillAppear = class_getInstanceMethod(self, @selector(dssj_viewWillAppear:));
        method_exchangeImplementations(viewWillAppear, dssj_viewWillAppear);
        
    });
}

- (void)dssj_viewWillAppear:(BOOL)animated {
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *leftImage = [[UIImage imageNamed:@"leftBar_back"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:leftImage
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(leftBtnAction)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    [self dssj_viewWillAppear:animated];
}

@end
