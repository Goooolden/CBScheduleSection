//
//  ScheduleDetailTableViewCell.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/23.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *siteLabel;
@property (nonatomic, strong) UILabel *managerLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) ScheduleModel *model;

@end

NS_ASSUME_NONNULL_END
