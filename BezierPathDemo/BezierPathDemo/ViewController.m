//
//  ViewController.m
//  BezierPathDemo
//
//  Created by LH on 9/12/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//  本demo主要演示了贝塞尔曲线的以下用法
//  用法1：简单地画图形
//  用法2：用贝塞尔曲线圆滑绘图（手绘）
//  用法3：用贝塞尔曲线做变形  （拉伸动画）
//  用法4：用贝塞尔曲线做缓冲动画 (animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :1 :1 :1];)
#import "ViewController.h"
#import "DrawView.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy  ) NSArray     *listArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"贝塞尔曲线应用实例";
    _listArr = @[@{@"TestVC1":@"绘图"},
                 @{@"TestVC2":@"手绘"},
                 @{@"TestVC3":@"拉拽动画"},
                 @{@"TestVC4":@"缓冲动画"}];
    [self.view addSubview:self.tableView];
    _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);

    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dic =  _listArr[indexPath.row];
    cell.textLabel.text = dic.allValues.firstObject;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =  _listArr[indexPath.row];
    NSString *class = dic.allKeys.firstObject;
    UIViewController *nextVC = [NSClassFromString(class) new];
    nextVC.view.backgroundColor = [UIColor whiteColor];
    nextVC.title = dic.allValues.firstObject;
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
    }
    return _tableView;
}

@end



