//
//  CircleView.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/31/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

static float radians(double degrees) { return degrees * M_PI / 180; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
    CGFloat y = CGRectGetHeight(parentViewBounds)*0.4;
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // define stroke color
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
    // define line width
    CGContextSetLineWidth(ctx, 4.0);
    
    
    // need some values to draw pie charts
    
    //for open
    float openDegree = self.openNum / (float)(self.openNum + self.closedNum) * 360;
    
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:0.424 green:0.776 blue:0.267 alpha:0.9] CGColor]));
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, 100,  radians(0), radians(openDegree), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    //for closed
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:0.741 green:0.173 blue:0 alpha:0.9 ] CGColor]));
    CGContextMoveToPoint(ctx, x,y);
    CGContextAddArc(ctx, x, y, 100,  radians(openDegree), radians(360),0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
}

@end
