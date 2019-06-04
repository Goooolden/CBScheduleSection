//
//  SchedulePageViewController.m
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/17.
//  Copyright © 2019 Golden. All rights reserved.
//

#import "SchedulePageViewController.h"
#import "MyScheduleViewController.h"
#import "AllScheduleViewController.h"
#import "SendScheduleViewController.h"
#import "AddScheduleViewController.h"
#import "InterfaceMacro.h"

@interface SchedulePageViewController ()

@end

@implementation SchedulePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程";
}

- (instancetype)init {
    if (self = [super init]) {
        self.pageAnimatable = NO;
        self.titleSizeSelected = 16;
        self.titleSizeNormal = 16;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleFontName = @"PingFangSC-Medium";
        self.menuView.scrollView.backgroundColor = [UIColor redColor];
        self.menuItemWidth = 80.0f;
        self.progressWidth = 80.0f;
        [self addRightItem];
    }
    return self;
}

- (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:PushToken];
}

- (void)setBaseUrl:(NSString *)baseUrl {
    [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:ScheduleBaseUrl];
}

- (NSArray *)titles {
    return @[@"我的日程",@"全部日程",@"我发起的"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        MyScheduleViewController *myScheduleVC = [[MyScheduleViewController alloc]init];
        return myScheduleVC;
    }else if (index == 1) {
        AllScheduleViewController *allScheduleVC = [[AllScheduleViewController alloc]init];
        return allScheduleVC;
    }else if (index == 2) {
        SendScheduleViewController *sendScheduleVC = [[SendScheduleViewController alloc]init];
        return sendScheduleVC;
    }
    return nil;
}

#pragma mark - Delegate&&DataSource
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 50 + 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50);
}

#pragma mark - ConfigUI
- (void)addRightItem {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"Schedule.bundle/AddLight"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
}

- (void)addBtnClicked:(UIButton *)sender {
    //进入新增页面
    AddScheduleViewController *addVC = [[AddScheduleViewController alloc]init];
//    [self presentViewController:addVC animated:YES completion:nil];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
