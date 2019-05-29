//
//  NSDate+CalendarCategory.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/22.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CalendarCategory)

/**
 格式化时间
 
 @param formatter yyyy-MM-dd/YYYY-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss
 @return 格式化后的时间String
 */
- (NSString *)formatterDate:(NSString *)formatter;

@end

NS_ASSUME_NONNULL_END
