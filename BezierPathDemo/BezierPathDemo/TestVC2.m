//
//  TestVC2.m
//  BezierPathDemo
//
//  Created by LH on 9/14/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "TestVC2.h"
#import "DrawView.h"
@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //手绘，借助贝塞尔曲线使手绘线更加平滑
    DrawView *view = [[DrawView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [self.view addSubview:view];
}



@end
