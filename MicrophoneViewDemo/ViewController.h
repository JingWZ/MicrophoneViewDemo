//
//  ViewController.h
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-12.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MicrophoneButton.h"
#import "MovingArrayView.h"
#import "MovingCircleButton.h"

@interface ViewController : UIViewController{
    AVAudioRecorder *mRecorder;
    NSTimer *timer;
    BOOL isRecording;

}

@property (strong, nonatomic) MicrophoneButton *microphoneBtn;
@property (strong, nonatomic) MovingArrayView *movingArrayView;
@property (strong, nonatomic) MovingCircleButton *movingCircleBtn;

@end
