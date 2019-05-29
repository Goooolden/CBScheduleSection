//
//  ScheduleTableViewCell.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/22.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *siteLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) ScheduleModel *scheduleModel;

@end

NS_ASSUME_NONNULL_END
