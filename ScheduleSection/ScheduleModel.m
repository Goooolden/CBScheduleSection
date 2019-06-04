//
//  ScheduleModel.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/20.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "ScheduleModel.h"
#import "MJExtension.h"

@implementation ScheduleModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"users":@"ScheduleUsersModel"};
}

@end

@implementation ScheduleUsersModel

@end

@implementation ScheduleMonthModel

@end

@implementation ScheduleDepartmentModel

@end

@implementation SchedulelistCodeModel

@end
