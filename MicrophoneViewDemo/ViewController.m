//
//  ViewController.m
//  MicrophoneViewDemo
//
//  Created by apple on 13-1-12.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import "ViewController.h"

#import "MovingCycleView.h"

#define kTimeInterval 0.005


@interface ViewController ()

@end

@implementation ViewController

#pragma mark - action


- (void)microphoneBtnPressed{
    
    if (isRecording) {
        isRecording=NO;
        [mRecorder stop];
        
        [timer invalidate];
        timer=nil;
        
        [self.microphoneBtn isMoving:NO];
        [self.microphoneBtn setCurrentValueRate:0];
        
    }else{
        isRecording=YES;
        [mRecorder record];
        
        timer=[NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(updateValue) userInfo:nil repeats:YES];
        
    }
    
}

- (void)updateValue{
    [mRecorder updateMeters];
    float volume=[mRecorder averagePowerForChannel:0];
    float value=(volume+60)/80;
    
    [self.microphoneBtn setCurrentValueRate:value];
    
    //self.movingArrayView.currentTimeValue=self.movingArrayView.currentTimeValue+kTimeInterval;
    
    self.movingCircleBtn.currentTimeValue=self.movingCircleBtn.currentTimeValue+kTimeInterval;
    
}


#pragma mark - init

- (void)initMovingCircleView{
    self.movingCircleBtn=[[MovingCircleButton alloc] initWithFrame:CGRectMake(90, 170, 140, 140)];
    [self.movingCircleBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.movingCircleBtn];
    
}

- (void)initMovingArayView{
    self.movingArrayView=[[MovingArrayView alloc] initWithFrame:CGRectMake(110, 60, 100, 100)];
    [self.movingArrayView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.movingArrayView];
}

- (void)initMicrophoneBtn{
    
    
    self.microphoneBtn=[[MicrophoneButton alloc] initWithFrame:CGRectMake(135, 195, 50, 90)];
    [self.microphoneBtn setBackgroundColor:[UIColor clearColor]];
    [self.microphoneBtn setColorType:kColorTypeGreenToWhite];
    [self.microphoneBtn setMicrophoneLineColor:[UIColor colorWithRed:200/255.0 green:180/255.0 blue:100/255.0 alpha:1]];
    [self.microphoneBtn setMovingPointColor:[UIColor orangeColor]];
    [self.view addSubview:self.microphoneBtn];
    [self.microphoneBtn addTarget:self action:@selector(microphoneBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initAudioRecorder{
    NSArray *directories=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[directories objectAtIndex:0];
    NSString *recordPath=[documentPath stringByAppendingPathComponent:@"record.m4a"];
    
    NSURL *recordURL=[NSURL fileURLWithPath:recordPath];
    
    NSDictionary *setting=[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                           [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                           [NSNumber numberWithInt:1],AVNumberOfChannelsKey, nil];
    
    mRecorder=[[AVAudioRecorder alloc] initWithURL:recordURL settings:setting error:nil];
    [mRecorder setMeteringEnabled:YES];
    [mRecorder prepareToRecord];
    
}

- (void)showCycle
{
    MovingCycleView *cycleView = [[MovingCycleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [cycleView setOffset:10.0];
    [cycleView setStartColor:[UIColor redColor]];
    
    [self.view addSubview:cycleView];
    
}

#pragma mark - VC lifecycle


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //[self showCycle];
    
    [self initAudioRecorder];
    //[self initMovingArayView];
    [self initMovingCircleView];
    [self initMicrophoneBtn];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
