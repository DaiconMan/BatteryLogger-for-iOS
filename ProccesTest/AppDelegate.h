//
//  AppDelegate.h
//  ProccesTest
//
//  Created by 西村顕 on 2015/03/26.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMonitor.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow *window;

@end

