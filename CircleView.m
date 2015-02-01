//
//  CircleView.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/31/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

-(double)radians:(double)degrees
{
    return degrees * M_PI / 180;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
    CGFloat y = CGRectGetHeight(parentViewBounds)*0.382;
    //the golden ratio haha!
    //That's the center position of the Graph
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // define stroke color
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
    // define line width
    CGContextSetLineWidth(ctx, 6.0);
    
    
    // need some values to draw pie charts
    
    
    double open = self.openNumber / (float)(self.openNumber + self.closedNumber)* 1.0 * 360;
    
    //the closed part
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:0.27 green:0.83 blue:0.27 alpha:0.8] CGColor]));
    CGContextMoveToPoint(ctx, x, y);
    //Draw the arc
    CGContextAddArc(ctx, x, y, 120,  [self radians:0], [self radians:open], 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    //the open part
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:0.29 green:0.64 blue:0.97 alpha:0.8 ] CGColor]));
    CGContextMoveToPoint(ctx, x,y);
    //Draw the arc
    CGContextAddArc(ctx, x, y, 120,  [self radians:open], [self radians:360],0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
}

@end
