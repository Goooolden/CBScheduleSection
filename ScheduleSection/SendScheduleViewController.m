//
//  SendScheduleViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/17.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "SendScheduleViewController.h"
#import "ScheduleTableViewCell.h"
#import "ScheduleDetailViewController.h"
#import "ScheduleModel.h"
#import "MJExtension.h"

#import "InterfaceMacro.h"
#import "NSDate+CalendarCategory.h"
#import "Masonry.h"
#import "HTTPTool.h"

static NSString *const SendScheduleCellID = @"SendScheduleCellID";

@interface SendScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SendScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestMySendSchedule];
    [self configUI];
}

- (void)configUI {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = false;
    self.myTableView.showsHorizontalScrollIndicator = false;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 150;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerClass:[ScheduleTableViewCell class] forCellReuseIdentifier:SendScheduleCellID];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-150);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
}

#pragma mark - TableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SendScheduleCellID];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.scheduleModel = self.dataArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleDetailViewController *detailVC = [[ScheduleDetailViewController alloc]init];
    detailVC.model = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - Request
- (void)requestMySendSchedule {
    NSString *monday = [[NSDate new] formatterDate:@"yyyy/MM/dd"];
    [HTTPTool postWithURL:ScheduleMySendURL headers:header(Token) params:getScheduleMySendParam(monday) success:^(id json) {
        if ([json[@"result"] isEqual:@(1)]) {
            self.dataArray = [ScheduleModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
