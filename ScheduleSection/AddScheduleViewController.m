//
//  AddScheduleViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/27.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "AddScheduleViewController.h"
#import "ScheduleMeetViewController.h"
#import "ChoiceTableViewCell.h"
#import "TextfieldTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "Masonry.h"
#import "LYSDatePicker.h"
#import "NSDate+CalendarCategory.h"
#import "HTTPTool.h"
#import "InterfaceMacro.h"

#define Tag 999
static NSString *const AddChoiceCellID    = @"AddChoiceCellID";
static NSString *const AddTextFieldCellID = @"AddTextFieldCellID";
static NSString *const AddTextViewCellID  = @"AddTextViewCellID";

@interface AddScheduleViewController ()<
UITableViewDelegate,
UITableViewDataSource,
LYSDatePickerDelegate,
LYSDatePickerDataSource>

@property (nonatomic, copy  ) NSArray *sectionName;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) LYSDatePicker *pickerView;

@end

@implementation AddScheduleViewController

- (LYSDatePicker *)pickerView {
    if (!_pickerView) {
        _pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
        LYSDateHeaderBarItem *cancelItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"取消" target:self action:@selector(cancelAction:)];
        cancelItem.tintColor = [UIColor whiteColor];
        
        LYSDateHeaderBarItem *commitItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"确定" target:self action:@selector(commitAction:)];
        commitItem.tintColor = [UIColor whiteColor];
        
        LYSDateHeaderBar *headerBar = [[LYSDateHeaderBar alloc] init];
        headerBar.leftBarItem = cancelItem;
        headerBar.rightBarItem = commitItem;
        _pickerView.headerView.headerBar = headerBar;
        _pickerView.headerView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发布日程";
    [self createLeftItem];
    [self createRightItem];
    self.sectionName = @[@[@"日期",@"类型",@"开始时间",@"结束时间",@"地点"],@[@"负责人",@"参会人员"],@[@"详细内容"]];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = false;
    self.myTableView.showsHorizontalScrollIndicator = false;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 150;
    [self.myTableView registerClass:[ChoiceTableViewCell class] forCellReuseIdentifier:AddChoiceCellID];
    [self.myTableView registerClass:[TextfieldTableViewCell class] forCellReuseIdentifier:AddTextFieldCellID];
    [self.myTableView registerClass:[TextViewTableViewCell class] forCellReuseIdentifier:AddTextViewCellID];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - UITableViewDelegate&&DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionName.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionName[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0 && indexPath.row < 4) || indexPath.section == 1) {
        ChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddChoiceCellID];
        cell.nameLabel.text = self.sectionName[indexPath.section][indexPath.row];
        cell.infoLabel.text = @"请选择";
        return cell;
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        TextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddTextFieldCellID];
        cell.nameLabel.text = self.sectionName[indexPath.section][indexPath.row];
        cell.infoTextView.text = @"请输入";
        [cell textViewDidChange:^{
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        } withDidEndEditingBlock:^(NSString *string) {
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        }];
        return cell;
    }else if (indexPath.section == 2) {
        TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddTextViewCellID];
        cell.nameLabel.text = self.sectionName[indexPath.section][indexPath.row];
        cell.wordLimt = 200;
        cell.infoTextView.text = @"请输入内容";
        [cell textViewDidChange:^{
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        } withDidEndEditingBlock:^(NSString *string) {
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        }];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3)) {
        //选择日期 开始时间 结束时间
        if (indexPath.row == 0) {
            self.pickerView.datePickerMode = LYSDatePickerModeYearAndDate;
        }else {
            self.pickerView.datePickerMode = LYSDatePickerModeTime;
        }
        self.pickerView.date = [NSDate date];
        self.pickerView.tag  = Tag + indexPath.row;
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.view addSubview:self.pickerView];
        [UIView animateWithDuration:0.3 animations:^{
            self.pickerView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 256, CGRectGetWidth(self.view.frame), 256);
        }];
    }else if (indexPath.section == 1) {
        ScheduleMeetViewController *meetVC = [[ScheduleMeetViewController alloc]init];
        [self.navigationController pushViewController:meetVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

#pragma mark - CreateItem

- (void)createLeftItem {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    itemBtn.titleLabel.textColor = [UIColor darkGrayColor];
    [itemBtn setTitle:@"取消" forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(itemLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
}

- (void)createRightItem {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    itemBtn.titleLabel.textColor = [UIColor darkGrayColor];
    [itemBtn setTitle:@"提交" forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(itemRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
}

- (void)itemLeftClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)itemRightClicked:(NSString *)sender {
    NSLog(@"提交");
}

#pragma mark - LYSDatePicker

- (void)cancelAction:(UIButton *)sender {
    [self LYSDatePickerDismiss];
}

- (void)commitAction:(UIButton *)sender {
    NSLog(@"---%@  %ld",self.pickerView.date,(long)self.pickerView.tag);
    [self LYSDatePickerDismiss];
}

- (void)LYSDatePickerDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 256);
    }];
    self.pickerView = nil;
}

#pragma mark - RequestAdd

- (void)requestAddSchedule {
//    [HTTPTool postWithURL:ScheduleAddURL headers:header(Token) params:getScheduleAddParam(<#NSString *date#>, <#NSString *stime#>, <#NSString *etime#>, <#NSString *type#>, <#NSString *content#>, <#NSString *address#>, <#NSArray *users#>) success:^(id json) {
//
//    } failure:^(NSError *error) {
//
//    }];
}

@end
