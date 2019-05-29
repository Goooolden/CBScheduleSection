//
//  ScheduleTableViewCell.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/22.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "ScheduleTableViewCell.h"
#import "Masonry.h"
#import "UIColor+ScheduleColor.h"

@interface ScheduleTableViewCell ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation ScheduleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.layer.cornerRadius = 20;
    [self.backView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backView).offset(10);
        make.width.height.equalTo(@40);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"活动";
    self.titleLabel.numberOfLines = 0;
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.backView.mas_right).offset(-10);
    }];
    
    self.siteLabel = [[UILabel alloc]init];
    self.siteLabel.text = @"407";
    self.siteLabel.numberOfLines = 0;
    [self.backView addSubview:self.siteLabel];
    [self.siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.text = @"1人参与";
    self.numberLabel.numberOfLines = 0;
    [self.backView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.siteLabel.mas_bottom).offset(20);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.backView).multipliedBy(0.3);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-10);
    }];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.text = @"2019/05/08 09:30";
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10);
        make.centerY.equalTo(self.numberLabel.mas_centerY);
        make.width.equalTo(self.backView).multipliedBy(0.4);
    }];
}

- (void)setScheduleModel:(ScheduleModel *)scheduleModel {
    self.titleLabel.text = scheduleModel.content;
    self.siteLabel.text = scheduleModel.address;
    self.numberLabel.text = [NSString stringWithFormat:@"%lu人参与",(unsigned long)scheduleModel.users.count];
    self.timeLabel.text = scheduleModel.date;
    self.iconImageView.image = [UIImage imageNamed:@"Schedule.bundle/icon_Week"];
}

@end
