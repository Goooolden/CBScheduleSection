//
//  AllScheduleViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/17.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "AllScheduleViewController.h"
#import "ScheduleDetailViewController.h"
#import "LTSCalendarManager.h"
#import "InterfaceMacro.h"
#import "HTTPTool.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "ScheduleModel.h"
#import "NSDate+CalendarCategory.h"


@interface AllScheduleViewController ()<LTSCalendarEventSource,LTSCalendarScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSString *selectedDateString;
@property (nonatomic, strong) LTSCalendarManager *manager;
@property (nonatomic, strong) UIButton *lastMonthButton;
@property (nonatomic, strong) UIButton *nextMonthButton;
@property (nonatomic, strong) UILabel  *dateLabel;

@end

@implementation AllScheduleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([LTSCalendarAppearance share].isShowSingleWeek) {
        [self.manager.calenderScrollView scrollToSingleWeek];
        [self.manager.calenderScrollView.calendarView setSingleWeek:true];
    }else {
        [self.manager.calenderScrollView scrollToAllWeek];
        [self.manager.calenderScrollView.calendarView setSingleWeek:false];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self requestListMonth:@"2019/05/23"];
}

#pragma mark - configUI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc]init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    //改变该图片的方向
    UIImage *backImage = [UIImage imageNamed:@"Schedule.bundle/icon_RightAccessory"];
    backImage = [UIImage imageWithCGImage:backImage.CGImage
                                    scale:backImage.scale
                              orientation:UIImageOrientationDown];
    //上个月
    self.lastMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lastMonthButton setImage:backImage forState:UIControlStateNormal];
    [self.lastMonthButton addTarget:self action:@selector(lastBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.lastMonthButton];
    [self.lastMonthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(14);
        make.left.equalTo(headerView.mas_left).offset(72);
        make.width.height.offset(22);
    }];
    
    //下个月
    self.nextMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextMonthButton setImage:[UIImage imageNamed:@"Schedule.bundle/icon_RightAccessory"] forState:UIControlStateNormal];
    [self.nextMonthButton addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.nextMonthButton];
    [self.nextMonthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(14);
        make.right.equalTo(headerView.mas_right).offset(-72);
        make.width.height.offset(22);
    }];
    
    //日期
    self.dateLabel = [[UILabel alloc]init];
    [headerView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(self.lastMonthButton.mas_right).offset(62);
    }];
    
    self.manager = [[LTSCalendarManager alloc]init];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30)];
    [self.view addSubview:self.manager.weekDayView];
    
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.manager.weekDayView.frame) - 200)];
    self.manager.calenderScrollView.tableViewDelegate = self;
    [self.view addSubview:self.manager.calenderScrollView];
    self.automaticallyAdjustsScrollViewInsets = false;
}

#pragma mark - DoAction
- (void)lastBtnClicked:(UIButton *)sender {
    [self.manager loadPreviousPage];
}

- (void)nextBtnClicked:(UIButton *)sender {
    [self.manager loadNextPage];
}

#pragma mark - CalendaerEventSource
//当前 选中的日期  执行的方法
- (void)calendarDidSelectedDate:(NSDate *)date {
    NSString *key = [date formatterDate:@"yyyy年MM月"];
    self.dateLabel.text = key;
    
    self.selectedDateString = [date formatterDate:@"yyyy/MM/dd"];
    [self requestReceiveSchedule:self.selectedDateString];
    [self requestListMonth:self.selectedDateString];
}

//该日期是否有事件
- (BOOL)calendarHaveEventWithDate:(NSDate *)date {
    NSString *key = [date formatterDate:@"yyyy/MM/dd"];
    for (ScheduleMonthModel *model in self.monthArray) {
        if ([key isEqualToString:model.date]) {
            return YES;
        }
    }
    return NO;
}

- (void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleDetailViewController *detailVC = [[ScheduleDetailViewController alloc]init];
    detailVC.model = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - RequestAPI
- (void)requestListMonth:(NSString *)current {
    [HTTPTool postWithURL:ScheduleAllMonthURL headers:header(Token) params:getScheduleAllMonthParam(current) success:^(id json) {
        if ([json[@"result"] isEqual:@(1)]) {
            self.monthArray = [ScheduleMonthModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestReceiveSchedule:(NSString *)selectedDate {
    [HTTPTool postWithURL:ScheduleALLURL headers:header(Token) params:getScheduleALLParam(selectedDate) success:^(id json) {
        if ([json[@"result"] isEqual:@(1)]) {
            self.dataArray = [ScheduleModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            self.manager.calenderScrollView.dataArray = self.dataArray;
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
