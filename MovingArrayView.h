//
//  MovingArrayView.h
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-28.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingArrayView : UIView

@property (assign, nonatomic) CGFloat currentTimeValue;

@property (assign, nonatomic) CGFloat topOffset;
@property (assign, nonatomic) CGFloat leftOffset;

@property (assign, nonatomic) NSInteger arrayCount;
@property (assign, nonatomic) CGFloat movingOffset;
@property (assign, nonatomic) CGFloat intervalToMove;
@property (assign, nonatomic) NSInteger movingCount;

@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor *lineColor;





@end
