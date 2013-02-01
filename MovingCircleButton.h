//
//  MovingCircleButton.h
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-31.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingCircleButton : UIButton

@property (assign, nonatomic) CGFloat offset;

@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat borderLineWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) UIColor *borderLineColor;


@property (assign, nonatomic) CGFloat beginAngle;
@property (assign, nonatomic) CGFloat movingAngle;
@property (assign, nonatomic) CGFloat tailLengthAngle;

@property (assign, nonatomic) CGFloat currentTimeValue;
@property (assign, nonatomic) CGFloat movingTimeInterval;

@property (strong, nonatomic) UIColor *beginColor;
@property (strong, nonatomic) UIColor *endColor;


@end
