//
//  ScheduleManager.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/29.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleManager : NSObject
/**
 记录选中的人员ID及名字
 {
 userId:name;
 }
 */
@property (nonatomic, strong) NSMutableDictionary *selectUserDictionary;

/**
 记录部门被选择的人员数目
 */
@property (nonatomic, strong) NSMutableDictionary *selectDepartDictionary;

/**
 发布消息选择部门信息
 */
@property (nonatomic, strong) NSMutableArray *departMentArray;

/**
 是否可编辑
 */
@property (nonatomic, assign) BOOL isEdite;

/**
 刷新page页面
 */
@property (nonatomic, assign) BOOL refreshPageViewController;

+ (instancetype)sharePushManagerInstance;

@end

NS_ASSUME_NONNULL_END
