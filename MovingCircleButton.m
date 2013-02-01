//
//  MovingCircleButton.m
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-31.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import "MovingCircleButton.h"

@implementation MovingCircleButton{
    
    CGFloat viewWidth;
    CGFloat viewHeight;
    
    CGFloat movingCount;
    CGFloat lightLengthAngle;
    
}

@synthesize offset;

@synthesize borderWidth, borderLineWidth;
@synthesize borderColor, borderLineColor;

@synthesize beginAngle;
@synthesize movingAngle;
@synthesize tailLengthAngle;

@synthesize beginColor;
@synthesize endColor;

@synthesize movingTimeInterval;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        offset=6;
        
        borderWidth=14.0;
        borderLineWidth=5.0;
        borderColor=[UIColor colorWithRed:200/255.0 green:180/255.0 blue:100/255.0 alpha:1];
        borderLineColor=[UIColor colorWithRed:255/255.0 green:240/255.0 blue:200/255.0 alpha:1];
        
        beginAngle=M_PI;
        movingAngle=M_PI/20.0;
        tailLengthAngle=M_PI*1.5;
        lightLengthAngle=tailLengthAngle/2.0;
        
        movingTimeInterval=0.02;
        movingCount=-0.1;
        
        beginColor=[UIColor colorWithRed:100/255.0 green:220/255.0 blue:100/255.0 alpha:1];
        endColor=borderColor;
        
        [self addObserver:self forKeyPath:@"currentTimeValue" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    viewWidth=self.bounds.size.width;
    viewHeight=self.bounds.size.height;
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    //border
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(offset, offset, self.bounds.size.width-2*offset, self.bounds.size.height-2*offset));
    CGContextAddEllipseInRect(context, CGRectMake(borderWidth+offset, borderWidth+offset, self.bounds.size.width-2*borderWidth-2*offset, self.bounds.size.height-2*borderWidth-2*offset));
    CGContextSetFillColorWithColor(context, [borderColor CGColor]);
    CGContextEOFillPath(context);
    
    //border line
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextSetShadow(context, CGSizeMake(0, 0), 4);
    
    CGContextAddEllipseInRect(context, CGRectMake(offset, offset, self.bounds.size.width-2*offset, self.bounds.size.height-2*offset));
    CGContextSetStrokeColorWithColor(context, [borderLineColor CGColor]);
    CGContextSetLineWidth(context, borderLineWidth);
    CGContextStrokePath(context);
    
    //center
    CGContextAddEllipseInRect(context, CGRectMake(borderWidth+offset, borderWidth+offset, self.bounds.size.width-2*borderWidth-2*offset, self.bounds.size.height-2*borderWidth-2*offset));
    CGContextSetFillColorWithColor(context, [borderLineColor CGColor]);
    CGContextFillPath(context);
    
    if (movingCount>0) {
        //moving belt
        CGContextRestoreGState(context);
        CGContextSaveGState(context);
        [self drawMovingBeltInContext:context];
        
        
        //highlight
        CGContextRestoreGState(context);
        [self drawMovingHighlightInContext:context];
         
         

    }
    
    
}

- (void)drawMovingBeltInContext:(CGContextRef)context{
    //clip
    CGFloat radiSmall=viewWidth/2.0-borderWidth - offset;
    CGFloat radiBig=viewWidth/2.0 - offset - borderLineWidth/2.0;
    
    CGFloat startAngle=beginAngle+movingAngle*movingCount;
    CGFloat endAngle=beginAngle+movingAngle*movingCount-tailLengthAngle;
    
    CGFloat startXSmall=radiBig + offset + radiSmall * cos(startAngle);
    CGFloat startYSmall=radiBig + offset  + radiSmall * sin(startAngle);
    CGFloat endXSmall=radiBig + offset  + radiSmall * cos(endAngle);
    CGFloat endYSmall=radiBig + offset  + radiSmall * sin(endAngle);
    
    [self clipContext:context withRadiBig:radiBig radiSmall:radiSmall startAngle:startAngle endAngle:endAngle];
    
    //gradient
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGColorRef sColor=[beginColor CGColor];
    CGColorRef eColor=[endColor CGColor];
    CFArrayRef colorArray=CFArrayCreate(kCFAllocatorDefault, (const void*[]){sColor,eColor}, 2, nil);
    CGGradientRef gradient=CGGradientCreateWithColors(colorSpace, colorArray, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(startXSmall, startYSmall), CGPointMake(endXSmall, endYSmall), kCGGradientDrawsBeforeStartLocation);
    
    CGColorSpaceRelease(colorSpace);
    //CGColorRelease(sColor);
    //CGColorRelease(eColor);
    CFRelease(colorArray);
    CGGradientRelease(gradient);
}

- (void)drawMovingHighlightInContext:(CGContextRef)context{
    
    //clip
    CGFloat radiSmall=viewWidth/2.0-borderWidth - offset- borderLineWidth/2.0;
    CGFloat radiBig=viewWidth/2.0 - offset ;
    
    CGFloat startAngle=beginAngle+movingAngle*movingCount;
    CGFloat endAngle=beginAngle+movingAngle*movingCount-tailLengthAngle;

    [self clipContext:context withRadiBig:radiBig radiSmall:radiSmall startAngle:startAngle endAngle:endAngle];
    
    CGFloat lightCenterX=radiBig + offset + (radiSmall+borderWidth/2.0) * cos(startAngle-0.2) + borderLineWidth/2.0;
    CGFloat lightCenterY=radiBig + offset  + (radiSmall+borderWidth/2.0) * sin(startAngle-0.2) + borderLineWidth/2.0;;

    //gradient
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    //200/255.0 green:180/255.0 blue:100/255.0 alpha:1]
    CGColorRef color1=CGColorCreate(colorSpace, (CGFloat[]){1, 1, 1, 0.9});
    CGColorRef color2=CGColorCreate(colorSpace, (CGFloat[]){200/255.0, 180/255.0, 100/255.0, 0.1});
    CFArrayRef colorArray2=CFArrayCreate(kCFAllocatorDefault, (const void*[]){color1,color2}, 2, nil);
    CGGradientRef gradient2=CGGradientCreateWithColors(colorSpace, colorArray2, NULL);
    CGPoint lightCenter=CGPointMake(lightCenterX, lightCenterY);
    CGContextDrawRadialGradient(context, gradient2, lightCenter, borderWidth/4.0, lightCenter, viewWidth/2.0, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
    
    CGColorSpaceRelease(colorSpace);
    CGColorRelease(color1);
    CGColorRelease(color2);
    CFRelease(colorArray2);
    CGGradientRelease(gradient2);

}

- (void)clipContext:(CGContextRef)context withRadiBig:(CGFloat)radiBig radiSmall:(CGFloat)radiSmall startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    /*
        CGFloat startXBig=radiBig - offset  + radiBig * cos(startAngle);
    CGFloat startYBig=radiBig - offset  + radiBig * sin(startAngle);
     

    CGFloat endXSmall=radiBig - offset  + radiSmall * cos(endAngle);
    CGFloat endYSmall=radiBig - offset  + radiSmall * sin(endAngle);
    */
    CGFloat startXSmall=radiBig + offset + radiSmall * cos(startAngle);
    CGFloat startYSmall=radiBig + offset  + radiSmall * sin(startAngle);

    CGFloat roundX=radiBig + offset  + (radiSmall+borderWidth/2.0) * cos(startAngle+borderWidth/2.0/(radiSmall+borderWidth/2.0));
    CGFloat roundY=radiBig + offset  + (radiSmall+borderWidth/2.0) * sin(startAngle+borderWidth/2.0/(radiSmall+borderWidth/2.0));

    CGFloat endXBig=radiBig + offset  + radiBig * cos(endAngle);
    CGFloat endYBig=radiBig + offset  + radiBig * sin(endAngle);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, viewWidth/2.0, viewHeight/2.0, radiSmall, startAngle, endAngle, YES);
    CGContextAddLineToPoint(context, endXBig, endYBig);
    CGContextAddArc(context, viewWidth/2.0, viewHeight/2.0, radiBig, endAngle, startAngle, NO);
    CGContextAddArcToPoint(context, roundX, roundY, startXSmall, startYSmall, borderWidth/2.0);
    
    CGContextClosePath(context);
    
    CGContextClip(context);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (self.currentTimeValue>movingTimeInterval) {
            movingCount++;
            self.currentTimeValue=0;
            [self setNeedsDisplay];
        }
    
    
    
}

@end
