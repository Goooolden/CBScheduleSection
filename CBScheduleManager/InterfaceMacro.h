//
//  Header.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/20.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef InterfaceMacro_h
#define InterfaceMacro_h

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/)\
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
[dictionary setObject:object forKey:@#object]; \
} while (0)

#define setObjectForParameter(object) \
do { \
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil]; \
NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; \
[paramDic setObject:str forKey:@"param"]; \
} while (0)

#define setOptionalObjectForKey(object) \
do { \
isNilOrNull(object) ?: [dictionary setObject:object forKey:@#object]; \
} while (0)

#define ScheduleBaseUrl (@"ScheduleBaseUrl")
#define BaseURL [[NSUserDefaults standardUserDefaults] objectForKey:ScheduleBaseUrl]//@"http://10.5.1.4"

#define PushToken (@"token")
#define Token [[NSUserDefaults standardUserDefaults] objectForKey:PushToken]

#pragma mark - 请求header
NS_INLINE NSDictionary *header(NSString *token) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(token);
    return dictionary;
}

#pragma mark - 日程
//我发送的
#define ScheduleMySendURL [NSString stringWithFormat:@"%@/micro/oa/task/list/send", BaseURL]
NS_INLINE NSDictionary *getScheduleMySendParam(NSString *monday){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(monday);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//我接收的
#define ScheduleMyReceiveURL [NSString stringWithFormat:@"%@/micro/oa/task/list/receive", BaseURL]
NS_INLINE NSDictionary *getScheduleMyReceiveParam(NSString *monday){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(monday);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//所有任务
#define ScheduleALLURL [NSString stringWithFormat:@"%@/micro/oa/task/list/all", BaseURL]
NS_INLINE NSDictionary *getScheduleALLParam(NSString *monday){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(monday);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//我的日程时间
#define ScheduleMonthURL [NSString stringWithFormat:@"%@/micro/oa/task/list/month", BaseURL]
NS_INLINE NSDictionary *getScheduleMonthParam(NSString *monday){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(monday);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//所有日程时间
#define ScheduleAllMonthURL [NSString stringWithFormat:@"%@/micro/oa/task/listAll/month", BaseURL]
NS_INLINE NSDictionary *getScheduleAllMonthParam(NSString *monday){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(monday);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//任务详情
#define ScheduleDetailURL [NSString stringWithFormat:@"%@/micro/oa/task/info", BaseURL]
NS_INLINE NSDictionary *getScheduleDetailParam(NSString *id){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(id);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//添加任务
#define ScheduleAddURL [NSString stringWithFormat:@"%@/micro/oa/task/add", BaseURL]
/**
 @param date 日期
 @param stime 开始时间
 @param etime 结束时间
 @param type 类型id
 @param content 内容
 @param address 地址
 @param users "users": [
 {
 "id": "接收人ID",
 "isLeader": "是否是负责人"
 }
 ]
 */
NS_INLINE NSDictionary *getScheduleAddParam(NSString *date, NSString *stime, NSString *etime, NSString *type, NSString *content, NSString *address, NSArray *users){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(date);
    setObjectForKey(stime);
    setObjectForKey(etime);
    setObjectForKey(type);
    setObjectForKey(content);
    setObjectForKey(address);
    setObjectForKey(users);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//删除任务
#define ScheduleDelURL [NSString stringWithFormat:@"%@/micro/oa/task/del", BaseURL]
NS_INLINE NSDictionary *getScheduleDelParam(NSString *id){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(id);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//获取部门人员
#define ScheduleDepartmentURL [NSString stringWithFormat:@"%@/micro/basis/pub/listDepartUsers",BaseURL]
NS_INLINE NSDictionary *getDepartScheduleParam(NSString *id){
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(id);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

//获取类型
#define SchedulelistByCodeURL [NSString stringWithFormat:@"%@/micro/oa/dic/listByCode",BaseURL]
NS_INLINE NSDictionary *getListByCodeParam(NSString *code) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(code);
    setObjectForParameter(dictionary);
    return paramDic.copy;
}

#endif /* Header_h */
