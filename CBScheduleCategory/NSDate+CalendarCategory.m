//
//  NSDate+CalendarCategory.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/22.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "NSDate+CalendarCategory.h"

@implementation NSDate (CalendarCategory)

- (NSString *)formatterDate:(NSString *)formatter {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = formatter;
    NSString *dateString = [dateformatter stringFromDate:self];
    return dateString;
}

@end
