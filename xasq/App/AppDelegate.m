//
//  AppDelegate.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LaunchViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "ApplicationData.h"
#import "UserGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ///初始化语言
    [LanguageTool initializeLanguage];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置rootViewController
    [self launchRootController];
    
    [self.window makeKeyAndVisible];
    
    //键盘遮挡
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
//    // 极光推送
//    [self initJPUSHWithOptions:launchOptions];
    
    return YES;
}

- (void)launchRootController {
    if ([[ApplicationData shareData] isFirstLanuch]) {
        //新版本
        UserGuideViewController *guideVC = [[UserGuideViewController alloc] init];
        guideVC.DissmissGuideBlock = ^{
            // 存储新版本
            [[ApplicationData shareData] saveNewVersion];
            [self launchRootController];

        };
        self.window.rootViewController = guideVC;
    } else {
        LaunchViewController *launchVC = [[LaunchViewController alloc] init];
        launchVC.DissmissLaunchBlock = ^{
            RootViewController *rootVC = [[RootViewController alloc] init];
            self.window.rootViewController = rootVC;
        };
        self.window.rootViewController = launchVC;
    }
    
}

- (void)checkNewVersion {
    NSString *currentVersion = [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    [[NetworkManager sharedManager] getRequest:OperationSystemVersion parameters:@{@"currentVersion":currentVersion} success:^(NSDictionary * _Nonnull data) {
        
        NSDictionary *updateInfo = data[@"data"];
        if (updateInfo.allKeys.count > 0) {
            [ApplicationData shareData].showNewVersion = YES;
            [ApplicationData shareData].updateInfo = [UpdateInfoObject modelWithDictionary:updateInfo];
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

/********
 ********
#pragma mark-
    - (void)initJPUSHWithOptions:(NSDictionary *)options {
        //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 12.0, *)) {
            entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
        } else {
            entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        }
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            // 可以添加自定义 categories
            // NSSet<UNNotificationCategory *> *categories for iOS10 or later
            // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
        
        // init Push
        // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
        [JPUSHService setupWithOption:options appKey:@""
                              channel:@""
                     apsForProduction:NO
                advertisingIdentifier:nil];
        
    }

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
    
#pragma mark - JPUSHRegisterDelegate
    // iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        
    }else{
        //从通知设置界面进入应用
    }
}

    // iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
    
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

 ********
 ********/

#pragma mark -
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
