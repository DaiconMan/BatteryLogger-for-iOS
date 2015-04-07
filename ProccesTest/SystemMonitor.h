//
//  SystemMonitor.h
//  ProccesTest
//
//  Created by 西村顕 on 2015/03/30.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach/mach.h>

// time_value_t型を msec に変換
#define tval2msec(tval) ((tval.seconds * 1000) + (tval.microseconds / 1000))

@interface SystemMonitor : NSObject

+ (void)dump;

@end
