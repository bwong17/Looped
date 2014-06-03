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

@property (weak, nonatomic) IBOutlet UINavigationItem *tabBar;

@property (weak, nonatomic) IBOutlet UITextView *secs_0;
@property (weak, nonatomic) IBOutlet UITextView *secs_5;
@property (weak, nonatomic) IBOutlet UITextView *secs_10;
@property (weak, nonatomic) IBOutlet UITextView *secs_15;
@property (weak, nonatomic) IBOutlet UITextView *secs_20;
@property (weak, nonatomic) IBOutlet UITextView *secs_25;

@property CGPoint startPoint;
@property (weak, nonatomic) IBOutlet UIView *BoxToMove;
@property (nonatomic, retain) IBOutlet UIView *landscapeView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *addCopyButton;

@property (strong, nonatomic) UIViewController *loopVC;
@property (weak, nonatomic) IBOutlet UISlider *sliderRight;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayBackPlayer;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer* timer;

@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *recognizer;

@end

