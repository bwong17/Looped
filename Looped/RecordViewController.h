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

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayBackPlayer;
@property (weak, nonatomic) IBOutlet UILabel *LoopingLabel;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer* timer;
//@property (nonatomic, strong) Box *soundBox;
@end

