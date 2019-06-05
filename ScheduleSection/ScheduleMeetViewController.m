//
//  ScheduleMeetViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/28.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "ScheduleMeetViewController.h"
#import "ScheduleSelectViewController.h"
#import "InterfaceMacro.h"
#import "Masonry.h"
#import "HTTPTool.h"

static NSString *const CellID = @"CellID";

@interface ScheduleMeetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy  ) NSArray *sectionNameArray;
@property (nonatomic, copy  ) NSArray *sectionImageArray;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ScheduleMeetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择参会人员";
    self.sectionNameArray = @[@"按部门选择",@"按年级选择",@"按分组选择"];
    self.sectionImageArray = @[@"",@"",@""];
    [self configUI];
}

- (void)configUI {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = false;
    self.myTableView.showsHorizontalScrollIndicator = false;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 150;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
}

#pragma mark - UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = self.sectionNameArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ScheduleSelectViewController *selectVC = [[ScheduleSelectViewController alloc]init];
    [self.navigationController pushViewController:selectVC animated:YES];
}

@end
