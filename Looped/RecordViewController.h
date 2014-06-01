//
//  RecordViewController.h
//  Looped
//
//  Created by Barbara Wong on 4/27/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef struct{
    
    int state;
    NSTimeInterval startTime;
    
}Box;

@interface RecordViewController : UIViewController <AVAudioPlayerDelegate, UIGestureRecognizerDelegate,AVAudioRecorderDelegate>

@property CGPoint startPoint;
@property (weak, nonatomic) IBOutlet UIView *BoxToMove;
@property (nonatomic, retain) IBOutlet UIView *landscapeView;


@property (strong, nonatomic) UIViewController *loopVC;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayBackPlayer;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer* timer;

@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *recognizer;

@end

