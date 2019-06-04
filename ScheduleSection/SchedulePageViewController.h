//
//  SchedulePageViewController.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/17.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "WMPageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchedulePageViewController : WMPageController

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *token;

@end

NS_ASSUME_NONNULL_END
