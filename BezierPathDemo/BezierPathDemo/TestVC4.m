//
//  TestVC4.m
//  BezierPathDemo
//
//  Created by LH on 9/14/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    [self timingFunction];
}

- (void)timingFunction{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 300,100 ,100 )];
    demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:demoView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = @(CGPointMake(50, 300));
    animation.toValue = @(CGPointMake([[UIScreen mainScreen] bounds].size.width-50, 300));
    animation.duration = 5.0f;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    //设置速率曲线
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.48 :0.01 :0.48 :1.01];
    [demoView.layer addAnimation:animation forKey:@"position"];
}

@end
