//
//  TestVC1.m
//  BezierPathDemo
//
//  Created by LH on 9/14/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong ) UITableView  *tableView;
@property (nonatomic,copy   ) NSArray      *listArr;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    _tableView.frame = CGRectMake(0, 0, 100, [[UIScreen mainScreen] bounds].size.height-88);
    _listArr = @[@{@"example1":@"绘图"},
                 @{@"example2":@"多边形"},
                 @{@"example3":@"矩形"},
                 @{@"example4":@"圆或椭圆"},
                 @{@"example5":@"圆角矩形"},
                 @{@"example6":@"自定义圆角"},
                 @{@"example7":@"圆弧"},
                 @{@"example8":@"扇形"},
                 @{@"example9":@"一阶曲线"},
                 @{@"example10":@"二阶曲线"},
                 @{@"example11":@"反向镂空"},];
    
    
    [self addShape];
    [self example1];
}
//添加shapeLayer
- (void)addShape{
    _shapeLayer = [CAShapeLayer layer];
    //路径宽度
    _shapeLayer.lineWidth = 5.f;
    //路径颜色
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //图形填充颜色
    _shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    //起点
    _shapeLayer.strokeStart = 0;
    //终点
    _shapeLayer.strokeEnd = 1.;
    //设置虚线
    //_shapeLayer.lineDashPattern = @[@20,@20];
    //线拐点处的样式：
    _shapeLayer.lineJoin = kCALineJoinRound;
    //线终点的样式
    _shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:_shapeLayer];
}
//添加路径动画
- (void)addAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1.f);
    animation.duration = 2.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode  = kCAFillModeForwards;
    [_shapeLayer addAnimation:animation forKey:@"strokeEnd"];
}

//折线
- (void)example1{
    // 线的路径
    _path = [UIBezierPath bezierPath];
    // 起点
    [_path moveToPoint:CGPointMake(120, 120)];
    // 其他点
    [_path addLineToPoint:CGPointMake(280, 260)];
    [_path addLineToPoint:CGPointMake(300, 150)];
    _shapeLayer.path = _path.CGPath;
}
//多边形
- (void)example2{
    _path = [UIBezierPath bezierPath];
    //这是起点
    [_path moveToPoint:CGPointMake(260.0, 200.0)];
    //添加点
    [_path addLineToPoint:CGPointMake(350.0, 240.0)];
    [_path addLineToPoint:CGPointMake(310, 340)];
    [_path addLineToPoint:CGPointMake(190.0, 340)];
    [_path addLineToPoint:CGPointMake(160.0, 240.0)];
    [_path closePath]; //第五条线通过调用closePath方法得到的
    _shapeLayer.path = _path.CGPath;
}
//矩形
- (void)example3{
    _path = [UIBezierPath bezierPathWithRect:CGRectMake(200, 100, 100, 100)];
    _shapeLayer.path = _path.CGPath;
}
//圆或椭圆
- (void)example4{
    _path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(160, 100, 180, 100)];
    _shapeLayer.path = _path.CGPath;
}
//圆角矩形
- (void)example5{
    _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(160, 100, 180, 100) cornerRadius:25];
    _shapeLayer.path = _path.CGPath;
}
//自定义圆角矩形
- (void)example6{
    _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(160, 100, 180, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(25, 25)];
    _shapeLayer.path = _path.CGPath;
}
//圆弧
- (void)example7{
//    center       圆心
//    radius       半径
//    startAngle   开始角度
//    endAngle     结束角度
//    clockwise    顺时针or逆时针
    _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(260, 200) radius:80 startAngle:0 endAngle:M_PI clockwise:YES];
    _shapeLayer.path = _path.CGPath;
}
//折线和弧线构成的曲线
- (void)example8{

    // 线的路径
    CGPoint viewCenter = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0); // 画弧的中心点，相对于view
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:viewCenter];
    [_path addArcWithCenter:viewCenter radius:50 startAngle:0 endAngle:M_PI/4*3 clockwise:YES]; // 添加一条弧线
    [_path closePath];
    _shapeLayer.path = _path.CGPath;

}
//一阶曲线
- (void)example9{
    
    _path = [UIBezierPath bezierPath];
    _path.lineWidth = 5.0;//宽度
    _path.lineCapStyle = kCGLineCapRound;  //线条拐角
    _path.lineJoinStyle = kCGLineJoinRound;  //终点处理
    //起始点
    [_path moveToPoint:CGPointMake(120, 200)];
    //添加两个控制点
    [_path addQuadCurveToPoint:CGPointMake(320, 200) controlPoint:CGPointMake(220, 0)];
    _shapeLayer.path = _path.CGPath;
}
//二阶曲线
- (void)example10{
    _path = [UIBezierPath bezierPath];
    _path.lineWidth = 5.0;
    _path.lineCapStyle = kCGLineCapRound;  //线条拐角
    _path.lineJoinStyle = kCGLineCapRound;  //终点处理
    //起始点
    [_path moveToPoint:CGPointMake(130, 200)];
    //添加两个控制点
    [_path addCurveToPoint:CGPointMake(290, 200) controlPoint1:CGPointMake(165, 0) controlPoint2:CGPointMake(255, 400)];
    _shapeLayer.path = _path.CGPath;

}
//反向绘制
- (void)example11{
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, WIDTH, HEIGHT)];    //bezierPathByReversingPath表示反向绘制     （利用反向绘制掏出需要高亮的部分）
    UIBezierPath *reversingPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(160, 100, 180, 100) cornerRadius:25] bezierPathByReversingPath];
     [bpath appendPath: reversingPath];
    //创建一个CAShapeLayer 图层，黑色半透明背景
    CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor colorWithDisplayP3Red:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    shapeLayer.path = bpath.CGPath;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    [bgView.layer addSublayer:shapeLayer];
}









//#########################################################################

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     NSDictionary *dic =  _listArr[indexPath.row];
    cell.textLabel.text = dic.allValues.firstObject;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =  _listArr[indexPath.row];
    NSString *selector = dic.allKeys.firstObject;
    [self performSelector:NSSelectorFromString(selector)];
    //添加路径动画
    [self addAnimation];
}
@end
