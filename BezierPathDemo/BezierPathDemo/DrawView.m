//
//  DrawView.m
//  BezierPathDemo
//
//  Created by LH on 9/12/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "DrawView.h"
@interface DrawView()
{
    UIBezierPath *path;
    CGPoint previousPoint;
}
@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create a path to connect lines

        path = [UIBezierPath bezierPath];

        // Capture touches

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];

        pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;

        [self addGestureRecognizer:pan];

    }
    return self;
}
- (void)pan:(UIPanGestureRecognizer *)pan {

        CGPoint currentPoint = [pan locationInView:self];

        CGPoint midPoint = midpoint(previousPoint, currentPoint);

        if (pan.state == UIGestureRecognizerStateBegan) {

            [path moveToPoint:currentPoint];

        } else if (pan.state == UIGestureRecognizerStateChanged) {

           [path addQuadCurveToPoint:midPoint controlPoint:previousPoint];

        }

        previousPoint = currentPoint;

        [self setNeedsDisplay];

}



- (void)drawRect:(CGRect)rect {

    [[UIColor blackColor] setStroke];

    [path stroke];

}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {

    return (CGPoint) {

        (p0.x + p1.x) / 2.0,

        (p0.y + p1.y) / 2.0

   };

}


@end
