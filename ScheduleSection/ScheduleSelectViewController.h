//
//  ScheduleSelectViewController.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/28.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleSelectViewController : UIViewController

@property (nonatomic, copy  ) NSString *departmentID;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
