//
//  ScheduleDetailTableViewCell.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/23.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "ScheduleDetailTableViewCell.h"
#import "Masonry.h"

@interface ScheduleDetailTableViewCell ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation ScheduleDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backView = [[UIView alloc]init];
    self.backView.layer.cornerRadius = 10;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.numberOfLines = 0;
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backView).offset(10);
        make.right.equalTo(self.backView).offset(-10);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
    [self.backView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@1);
    }];

    self.dateLabel = [[UILabel alloc]init];
    [self.backView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(lineLabel.mas_bottom).offset(10);
        make.width.equalTo(self.backView).multipliedBy(0.4);
    }];

    self.timeLabel = [[UILabel alloc]init];
    [self.backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right).offset(40);
        make.centerY.equalTo(self.dateLabel.mas_centerY);
    }];

    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.numberOfLines = 0;
    [self.backView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
    }];

    self.siteLabel = [[UILabel alloc]init];
    self.siteLabel.numberOfLines = 0;
    [self.backView addSubview:self.siteLabel];
    [self.siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
    }];
    
    UILabel *otherline = [[UILabel alloc]init];
    otherline.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
    [self.backView addSubview:otherline];
    [otherline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.siteLabel.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    self.managerLabel = [[UILabel alloc]init];
    self.managerLabel.numberOfLines = 0;
    [self.backView addSubview:self.managerLabel];
    [self.managerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(otherline.mas_bottom).offset(10);
    }];
    
    self.userLabel = [[UILabel alloc]init];
    self.userLabel.numberOfLines = 0;
    [self.backView addSubview:self.userLabel];
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.managerLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.backView).offset(-10);
    }];
}

- (void)setModel:(ScheduleModel *)model {
    self.titleLabel.text = model.content;
    self.dateLabel.text = [NSString stringWithFormat:@"日期：%@",model.date];
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@-%@",model.stime,model.etime];
    self.typeLabel.text = [NSString stringWithFormat:@"类型：%@",model.typeName];
    self.siteLabel.text = [NSString stringWithFormat:@"地点：%@",model.address];
    self.managerLabel.text = [NSString stringWithFormat:@"负责人：%@",model.userName];
    
    NSMutableArray *usersName = [[NSMutableArray alloc]init];
    for (ScheduleUsersModel *userModel in model.users) {
        [usersName addObject:userModel.name];
    }
    self.userLabel.text = [NSString stringWithFormat:@"参加人：%@",[usersName componentsJoinedByString:@","]];
}

@end
