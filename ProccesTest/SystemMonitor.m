//
//  SystemMonitor.m
//  ProccesTest
//
//  Created by 西村顕 on 2015/03/30.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import "SystemMonitor.h"

@implementation SystemMonitor

+ (void)dump {
    DLog(
         @"[SystemMonitor] [Memory Use=%3u(MB) Free=%3u(MB)], [CPU User=%4.1lf(sec) System=%4.1lf(sec)] [Battery=%3u(%%)] [Brightness=%3u(%%)]",
         [self getMemoryUse] / 1000 / 1000,
         [self getFreeMemory] / 1000 / 1000,
         [self getUserCPUTime] / 1000.0,
         [self getSystemCPUTime] / 1000.0,
         [self getBatterySupply],
         [self getBrightness]
    );
}

// メモリ使用量を取得（bytes）
+ (unsigned int)getMemoryUse {
    struct task_basic_info basicInfo;
    mach_msg_type_number_t basicInfoCount = TASK_BASIC_INFO_COUNT;
    
    if (task_info(current_task(), TASK_BASIC_INFO, (task_info_t)&basicInfo, &basicInfoCount) != KERN_SUCCESS) {
        DLog(@"[SystemMonitor] %s", strerror(errno));
        
        return -1;
    }
    
    return basicInfo.resident_size;
}

// 空きメモリ量を取得（bytes）
+ (unsigned int)getFreeMemory {
    mach_port_t hostPort;
    mach_msg_type_number_t hostSize;
    vm_size_t pagesize;
    
    hostPort = mach_host_self();
    hostSize = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(hostPort, &pagesize);
    vm_statistics_data_t vmStat;
    
    if (host_statistics(hostPort, HOST_VM_INFO, (host_info_t)&vmStat, &hostSize) != KERN_SUCCESS) {
        DLog(@"[SystemMonitor] Failed to fetch vm statistics");
        
        return -1;
    }
    
    natural_t freeMemory = vmStat.free_count * pagesize;
    
    return (unsigned int)freeMemory;
}

// ユーザCPU時間を取得 (msec)
+ (unsigned int)getUserCPUTime {
    struct task_thread_times_info threadTimesInfo;
    mach_msg_type_number_t threadTimesInfoCount = TASK_THREAD_TIMES_INFO_COUNT;
    kern_return_t status;
    
    status = task_info(current_task(), TASK_THREAD_TIMES_INFO, (task_info_t)&threadTimesInfo, &threadTimesInfoCount);
    
    if (status != KERN_SUCCESS) {
        DLog(@"[SystemMonitor] %s(): Error in task_info(): %s", __FUNCTION__, strerror(errno));
        
        return -1;
    }
    
    return tval2msec(threadTimesInfo.user_time);
}

// システムCPU時間を取得（msec）
+ (unsigned int)getSystemCPUTime {
    struct task_thread_times_info threadTimesInfo;
    mach_msg_type_number_t threadTimesInfoCount = TASK_THREAD_TIMES_INFO_COUNT;
    kern_return_t status;
    
    status = task_info(current_task(), TASK_THREAD_TIMES_INFO, (task_info_t)&threadTimesInfo, &threadTimesInfoCount);
    
    if (status != KERN_SUCCESS) {
        DLog(@"[SystemMonitor] %s(): Error in task_info(): %s", __FUNCTION__, strerror(errno));
        
        return -1;
    }
    
    return tval2msec(threadTimesInfo.system_time);
}

/**
 *  バッテリ残量を取得
 *
 *  @return バッテリ残量[%]
 */
+ (unsigned int)getBatterySupply {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [UIDevice currentDevice].batteryLevel * 100;
}

+ (unsigned int)getBrightness {
    return [[UIScreen mainScreen] brightness] * 100;
}

@end
