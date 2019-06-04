//
//  ScheduleManager.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/29.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "ScheduleManager.h"

static ScheduleManager *manager;

@implementation ScheduleManager

+ (instancetype)sharePushManagerInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ScheduleManager alloc]init];
        manager.selectUserDictionary = [[NSMutableDictionary alloc]init];
        manager.selectDepartDictionary = [[NSMutableDictionary alloc]init];
        manager.departMentArray = [[NSMutableArray alloc]initWithObjects:@"部门", nil];
    });
    return manager;
}

@end
