//
//  MovingCycleView.m
//  MicrophoneViewDemo
//
//  Created by Jing on 13-6-14.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import "MovingCycleView.h"

@interface MovingCycleView ()
{
    CGFloat viewWidth;
    CGFloat viewHeight;
}

@end

@implementation MovingCycleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self updateViewSize];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [self updateViewSize];
    [self setNeedsDisplay];
}

- (void)updateViewSize
{
    viewWidth = self.bounds.size.width;
    viewHeight = self.bounds.size.height;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, [self rectWithOffset:_offset]);
    CGContextAddEllipseInRect(context, [self rectWithOffset:(_offset+_cycleWidth)]);
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, [_startColor CGColor]);
    CGContextFillPath(context);
}

- (CGRect)rectWithOffset:(CGFloat)offset
{
    return CGRectMake(offset, offset, viewWidth - 2*offset, viewHeight - 2*offset);
}


@end
