//
//  MovingCycleView.h
//  MicrophoneViewDemo
//
//  Created by Jing on 13-6-14.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingCycleView : UIView

@property (nonatomic) CGFloat offset;//to bounds

@property (nonatomic) CGFloat cycleLength;//0-1
@property (nonatomic) CGFloat cycleWidth;

@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;

@property (nonatomic, getter = isHighlighted) BOOL highlight;
@property (nonatomic) CGFloat highlightSize;
@property (nonatomic) CGFloat highlishtPosition;//0-1


@end
