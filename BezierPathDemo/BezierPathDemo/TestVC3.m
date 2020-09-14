//
//  TestVC3.m
//  BezierPathDemo
//
//  Created by LH on 9/14/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "TestVC3.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define kMaxWaveHeight  100
#define kMiniHeight     100
@interface TestVC3 ()
@property (nonatomic, strong) UIView *l1;
@property (nonatomic, strong) UIView *l2;
@property (nonatomic, strong) UIView *l3;
@property (nonatomic, strong) UIView *c;
@property (nonatomic, strong) UIView *r1;
@property (nonatomic, strong) UIView *r2;
@property (nonatomic, strong) UIView *r3;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addShape];
    [self addPoint];
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
//添加控制点
- (void)addPoint{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDidMove:)];

    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;

    [self.view addGestureRecognizer:pan];
    
    CGFloat w = WIDTH/5;
    _l1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 2, 2)];
    _l1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_l1];
    
    _l2 = [[UIView alloc] initWithFrame:CGRectMake(w, 100, 2, 2)];
    _l2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_l2];
    
    _l3 = [[UIView alloc] initWithFrame:CGRectMake(w*2, 100, 2, 2)];
    _l3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_l3];
    
    _c = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2, 100, 2, 2)];
    _c.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_c];
    
    _r1 = [[UIView alloc] initWithFrame:CGRectMake(w*3, 100, 2, 2)];
    _r1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_r1];
    
    _r2 = [[UIView alloc] initWithFrame:CGRectMake(w*4, 100, 2, 2)];
    _r2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_r2];
    
    _r3 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 100, 2, 2)];
    _r3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_r3];
    [self updateShapeLayer];
}
- (CGPathRef)currentPath {

    CGFloat width = self.view.bounds.size.width;

    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(0, 0)];

    [path addLineToPoint:CGPointMake(0, self.l3.center.y)];

    [path addQuadCurveToPoint:self.l1.center controlPoint:self.l2.center];

    [path addQuadCurveToPoint:self.r1.center controlPoint:self.c.center];
    
    
    //理论上二阶曲线比一阶要更为平滑，但整体效果一样，下面两个可以作为参考对比
    //[path addQuadCurveToPoint:self.r3.center controlPoint:self.r2.center];

    [path addCurveToPoint:self.r3.center

                    controlPoint1:self.r1.center

                   controlPoint2:self.r2.center];

    [path addLineToPoint:CGPointMake(width, 0)];

    [path closePath];

    return path.CGPath;

}
- (void)panDidMove:(UIPanGestureRecognizer *)gesture {

    if (gesture.state == UIGestureRecognizerStateEnded ||

        gesture.state == UIGestureRecognizerStateFailed ||

        gesture.state == UIGestureRecognizerStateCancelled) {
        CGFloat w = WIDTH/5;
        _l1.frame = CGRectMake(0, 100, 2, 2);
        _l2.frame = CGRectMake(w, 100, 2, 2);
        _l3.frame = CGRectMake(w*2, 100, 2, 2);
        _c.frame = CGRectMake(WIDTH/2, 100, 2, 2);
        _r1.frame = CGRectMake(w*3, 100, 2, 2);
        _r2.frame = CGRectMake(w*4, 100, 2, 2);
        _r3.frame = CGRectMake(WIDTH, 100, 2, 2);

        [self updateShapeLayer];

    } else {

        CGFloat additionalHeight = MAX([gesture translationInView:self.view].y, 0);

        CGFloat waveHeight = MIN(additionalHeight*0.6, kMaxWaveHeight);

        CGFloat baseHeight = kMiniHeight + additionalHeight - waveHeight;

        CGFloat locationX = [gesture locationInView:gesture.view].x;

        [self layoutControlPoints:baseHeight waveHeight:waveHeight locationX:locationX];

        [self updateShapeLayer];

    }

}

- (void)layoutControlPoints:(CGFloat)baseHeight

                         waveHeight:(CGFloat)waveHeight

                             locationX:(CGFloat)locationX {

    CGFloat width = self.view.bounds.size.width;

    CGFloat minLeftX = MIN(locationX-width/2*0.28, 0);

    CGFloat maxRightX = MAX(width+(locationX-width)/2 *0.28, width);

    CGFloat leftPartWidth = locationX - minLeftX;

    CGFloat rightPartWidth = maxRightX - locationX;

     self.l3.center = CGPointMake(minLeftX, baseHeight);

    self.l2.center = CGPointMake(minLeftX+leftPartWidth*0.44, baseHeight);

    self.l1.center = CGPointMake(minLeftX+leftPartWidth*0.71, baseHeight+waveHeight*0.64);

   self.c.center = CGPointMake(locationX, baseHeight+waveHeight*1.36);

    self.r1.center = CGPointMake(maxRightX-rightPartWidth*0.71,   baseHeight+waveHeight*0.64);

    self.r2.center = CGPointMake(maxRightX-(rightPartWidth*0.44), baseHeight);

    self.r3.center = CGPointMake(maxRightX, baseHeight);
    

}
- (void)updateShapeLayer {
    self.shapeLayer.path = [self currentPath];

}


@end
