//
//  MovingArrayView.m
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-28.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import "MovingArrayView.h"

@implementation MovingArrayView{
    CGFloat viewWidth;
    CGFloat viewHeight;
}
@synthesize currentTimeValue;
@synthesize topOffset, leftOffset;
@synthesize arrayCount, movingOffset, intervalToMove, movingCount;
@synthesize lineWidth, lineColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        viewWidth=self.bounds.size.width;
        viewHeight=self.bounds.size.height;
        
        topOffset=viewHeight/10.0;
        leftOffset=viewWidth/4.0;
        arrayCount=4;
        intervalToMove=0.1;
        movingCount=3;
        
        lineWidth=3.0;
        lineColor=[UIColor grayColor];
        
        [self addObserver:self forKeyPath:@"currentTimeValue" options:NSKeyValueObservingOptionNew context:nil];


    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    /*
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //clip
    CGContextClipToRect(context, CGRectMake(leftOffset, topOffset, viewWidth-2*leftOffset, viewHeight-2*topOffset));
    
    
    //画线
    CGMutablePathRef path=CGPathCreateMutable();
    
    CGFloat arrayLength=(viewHeight-2*topOffset)/arrayCount;
    CGFloat singleDistance=arrayLength/(movingCount+1);
    CGFloat middleY=0+movingOffset+topOffset;
    CGFloat beginY=-arrayLength+movingOffset+topOffset;
    
    
    for (int i=0; i<=arrayCount; i++) {
        CGPathMoveToPoint(path, NULL, leftOffset, beginY+arrayLength*i);
        CGPathAddLineToPoint(path, NULL, viewWidth/2.0, middleY+arrayLength*i);
        CGPathAddLineToPoint(path, NULL, viewWidth-leftOffset, beginY+arrayLength*i);
    }
    CGContextAddPath(context, path);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetLineWidth(context, lineWidth);
    CGContextStrokePath(context);
    
    movingOffset+=singleDistance;
    movingOffset=(movingOffset>=arrayLength?0:movingOffset);
    
    //gradient
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGColorRef startColor=CGColorCreate(colorSpace, (CGFloat[]){0, 0, 0, 0.5});
    CGColorRef endColor=CGColorCreate(colorSpace, (CGFloat[]){0, 1, 0, 0.5});
    CFArrayRef colorArray=CFArrayCreate(kCFAllocatorDefault, (const void*[]){startColor,endColor}, 2, nil);
    CGGradientRef gradient=CGGradientCreateWithColors(colorSpace, colorArray, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(viewWidth/2.0, 0), CGPointMake(viewWidth/2.0, viewHeight), kCGGradientDrawsBeforeStartLocation);
*/
     }

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.currentTimeValue>intervalToMove) {
        [self setNeedsDisplay];
        self.currentTimeValue=0;
    }

}


@end
