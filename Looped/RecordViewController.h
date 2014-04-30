//
//  RecordViewController.h
//  Looped
//
//  Created by Barbara Wong on 4/27/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface RecordViewController : UIViewController <AVAudioPlayerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *LoopingLabel;

@end
