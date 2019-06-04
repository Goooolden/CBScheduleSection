//
//  ScheduleModel.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/20.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *stime;
@property (nonatomic, copy) NSString *etime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSArray  *users;

@end

@interface ScheduleUsersModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *isLeader;
@property (nonatomic, copy) NSString *isRead;

@end

@interface ScheduleMonthModel : NSObject

@property (nonatomic, copy) NSString *date;

@end

@interface ScheduleDepartmentModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *discrib;
@property (nonatomic, copy) NSString *layer;
@property (nonatomic, copy) NSString *sortNum;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *telePhone;

@end

@interface SchedulelistCodeModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *layer;
@property (nonatomic, copy) NSString *sys;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *isParent;
@property (nonatomic, copy) NSString *pId;

@end

NS_ASSUME_NONNULL_END
