//
//  AddScheduleViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/27.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "AddScheduleViewController.h"
#import "ScheduleMeetViewController.h"
#import "PickerSelectView.h"
#import "ChoiceTableViewCell.h"
#import "TextfieldTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "ScheduleManager.h"
#import "ScheduleModel.h"
#import "MJExtension.h"
#import "InterfaceMacro.h"
#import "HTTPTool.h"
#import "Masonry.h"
#import "LYSDatePicker.h"
#import "UITextView+Placeholder.h"
#import "UIColor+ScheduleColor.h"
#import "NSDate+CalendarCategory.h"
#import "CombancHUD.h"

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
@property (nonatomic, strong) NSMutableArray *listCodeArray;
@property (nonatomic, strong) NSMutableDictionary *managerDic;      //会议负责人
@property (nonatomic, strong) NSMutableDictionary *participateDic;  //参会人员
@property (nonatomic, assign) BOOL isSelectManager;

@property (nonatomic, copy  ) NSString *address;
@property (nonatomic, copy  ) NSString *selectDate;
@property (nonatomic, copy  ) NSString *beginTime;
@property (nonatomic, copy  ) NSString *endTime;
@property (nonatomic, copy  ) NSString *selectTypeName;
@property (nonatomic, copy  ) NSString *selectTypeID;
@property (nonatomic, copy  ) NSString *content;

@end

@implementation AddScheduleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isSelectManager) {
        self.managerDic = [[ScheduleManager sharePushManagerInstance].selectUserDictionary mutableCopy];
    }else {
        self.participateDic = [[ScheduleManager sharePushManagerInstance].selectUserDictionary mutableCopy];
    }
    [[ScheduleManager sharePushManagerInstance].selectUserDictionary removeAllObjects];
    [[ScheduleManager sharePushManagerInstance].selectDepartDictionary removeAllObjects];
    [ScheduleManager sharePushManagerInstance].departMentArray = [[NSMutableArray alloc]initWithObjects:@"部门", nil];
    if (self.myTableView) {
        [self.myTableView reloadData];
    }
}

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
    
    [self requestListByCode];
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
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.infoLabel.text = self.selectDate;
        }else if (indexPath.section == 0 && indexPath.row == 1) {
            cell.infoLabel.text = self.selectTypeName;
        }else if (indexPath.section == 0 && indexPath.row == 2) {
            cell.infoLabel.text = self.beginTime;
        }else if (indexPath.section == 0 && indexPath.row == 3) {
            cell.infoLabel.text = self.endTime;
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            cell.infoLabel.text = [[self.managerDic allValues] componentsJoinedByString:@","];
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            cell.infoLabel.text = [[self.participateDic allValues] componentsJoinedByString:@","];
        }
        return cell;
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        TextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddTextFieldCellID];
        cell.nameLabel.text = self.sectionName[indexPath.section][indexPath.row];
        [cell.infoTextView setPlaceholder:@"请输入" placeholderColor:[UIColor colorWithHex:@"#c7c7c7"]];
        [cell textViewDidChange:^{
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        } withDidEndEditingBlock:^(NSString *string) {
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
            self.address = string;
        }];
        return cell;
    }else if (indexPath.section == 2) {
        TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddTextViewCellID];
        cell.nameLabel.text = self.sectionName[indexPath.section][indexPath.row];
        cell.wordLimt = 200;
        [cell.infoTextView setPlaceholder:@"请输入内容" placeholderColor:[UIColor colorWithHex:@"#c7c7c7"]];
        [cell textViewDidChange:^{
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        } withDidEndEditingBlock:^(NSString *string) {
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
            self.content = string;
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
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        NSMutableArray *listArray  = [NSMutableArray new];
        for (SchedulelistCodeModel *model in self.listCodeArray) {
            [listArray addObject:model.name];
        }
        [PickerSelectView showPickerSelecterWithTitle:@"类型" selectInfo:@[listArray] resultBlock:^(NSArray *selectValue) {
            self.selectTypeName = [selectValue firstObject];
            for (SchedulelistCodeModel *model in self.listCodeArray) {
                if ([model.name isEqualToString:self.selectTypeName]) {
                    self.selectTypeID = model.id;
                }
            }
            [self.myTableView reloadData];
        }];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.isSelectManager = YES;
        }else {
            self.isSelectManager = NO;
        }
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
    [self requestAddSchedule];
}

#pragma mark - LYSDatePicker

- (void)cancelAction:(UIButton *)sender {
    [self LYSDatePickerDismiss];
}

- (void)commitAction:(UIButton *)sender {
    if (self.pickerView.tag == Tag) {
        self.selectDate = [self.pickerView.date formatterDate:@"yyyy/MM/dd"];
    }else if (self.pickerView.tag == Tag + 2) {
        self.beginTime = [self.pickerView.date formatterDate:@"HH:mm"];
    }else if (self.pickerView.tag == Tag + 3) {
        self.endTime = [self.pickerView.date formatterDate:@"HH:mm"];
    }
    [self.myTableView reloadData];
    [self LYSDatePickerDismiss];
}

- (void)LYSDatePickerDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 256);
    }];
    self.pickerView = nil;
}

#pragma mark - RequestAdd

- (void)requestListByCode {
    [HTTPTool postWithURL:SchedulelistByCodeURL headers:header(Token) params:getListByCodeParam(@"task_type") success:^(id json) {
        if ([json[@"result"] isEqual:@(1)]) {
            self.listCodeArray = [SchedulelistCodeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestAddSchedule {
    NSMutableArray *userArray = [[NSMutableArray alloc]init];
    for (NSString *nameid in [self.participateDic allKeys]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *name = [self.participateDic objectForKey:nameid];
        [dic setValue:name forKey:@"name"];
        [dic setValue:nameid forKey:@"id"];
        [dic setValue:@"false" forKey:@"isLeader"];
        [userArray addObject:dic];
    }
    [HTTPTool postWithURL:ScheduleAddURL headers:header(Token) params:getScheduleAddParam(self.selectDate, self.beginTime, self.endTime, self.selectTypeID, self.content, self.address, userArray) success:^(id json) {
        if ([json[@"result"] isEqual:@(1)]) {
            [CombancHUD showSuccessMessage:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [CombancHUD showErrorMessage:@"网络错误，请稍后再试"];
    }];
}

@end
