//
//  RecordViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/27/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "RecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Variables.h"

#define BOXCOLUMNS 3
#define BOXROWS 5

@implementation RecordViewController

@synthesize timer = mTimer;
@synthesize LoopingLabel;
@synthesize recorder;
@synthesize audioPlayBackPlayer;
@synthesize audioPlayer;


BOOL done = YES;
UIButton *currentSender;
UILongPressGestureRecognizer *recognizer;
NSURL *temporaryRecFile;
int currentRow;
int currentCol;
NSTimeInterval timeInterval;

Box soundBox[BOXROWS][BOXCOLUMNS];

- (void)viewDidLoad
{
    [super viewDidLoad];
    done = YES;
    self.LoopingLabel.text = [NSString stringWithFormat:@"File: %@",soundLooping];
    
    currentRow = 0;
    currentCol = 0;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Looped_Base_Color.png"]forBarMetrics:UIBarMetricsDefault];
    
    /*
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [audioSession setActive:YES error:nil];
    
    temporaryRecFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"sound"]]];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:temporaryRecFile settings:nil error:nil];
    
    NSLog(@"about to record url : %@",temporaryRecFile);
    
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    */
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLooping error:&error];
    
    NSTimeInterval time = [audioPlayer duration];
    
    timeInterval = time / BOXCOLUMNS;

    for(int i = 0; i < BOXROWS;i++){
        for(int j = 0; j < BOXCOLUMNS; j++){
            
            //soundBox[i][j] = malloc(sizeof(Box));
            soundBox[i][j].state = 0;
            
            printf("%d%d(%d)",i,j,soundBox[i][j].state);
        }
        soundBox[i][0].startTime = 0.0 + timeInterval;
        soundBox[i][1].startTime = soundBox[i][0].startTime + timeInterval;
        soundBox[i][2].startTime = soundBox[i][1].startTime + timeInterval;
        
        printf("\n");
    }
    
    for(int i = 0; i < BOXROWS;i++){
        for(int j = 0; j < BOXCOLUMNS; j++){

            printf("Sound box %d %d starting at %f\n",i , j,soundBox[i][j].startTime);
        }
    }
    printf("Total %f\n",audioPlayer.duration);

    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
    }

}

- (IBAction)playRecorded:(UIButton *)sender {
    
    NSLog(@"playing url : %@",temporaryRecFile);
    [audioPlayBackPlayer play];
    
}

 - (IBAction)stopRecording:(id)sender {
    
    NSLog(@"Stop recording");
    [recorder stop];
     
     audioPlayBackPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:temporaryRecFile error:nil];
     
     [audioPlayBackPlayer prepareToPlay];
}

- (IBAction) boxTapped:(UITapGestureRecognizer *) sender {
    
    printf("tapped %d %d with state %d\n",sender.view.accessibilityLabel.intValue,sender.view.tag,soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state);
    
    for(int i = 0; i < BOXROWS;i++){
        for(int j = 0; j < BOXCOLUMNS; j++)
            printf("%d%d(%d)",i,j,soundBox[i][j].state);
        printf("\n");
    }

    //use
    if(soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state == 0){
        sender.view.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(100/255.0) blue:(91/255.0) alpha:1.0];
        soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state = 1;
    }
    //pause
    else if(soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state == 1){
        sender.view.backgroundColor = [UIColor colorWithRed:(229/255.0) green:(212/255.0) blue:(61/255.0) alpha:1.0];
        soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state = 2;
    }
    //ignore
    else if(soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state == 2){
        sender.view.backgroundColor = [UIColor colorWithRed:(213/255.0) green:(213/255.0) blue:(213/255.0) alpha:1.0];
        soundBox[sender.view.accessibilityLabel.intValue][sender.view.tag].state = 0;
    }
    
}
- (IBAction)newPlay:(id)sender {
    [self play];
}

- (void) play{
    
    [audioPlayer prepareToPlay];
    
    //use
    if(soundBox[currentRow][currentCol].state == 1){
        
        audioPlayer.volume = 1.0;
        audioPlayer.currentTime = soundBox[currentRow][currentCol].startTime;
        printf("Box %d %d state use at %f to %f\n",currentRow,currentCol, audioPlayer.currentTime,audioPlayer.currentTime + timeInterval);
                
        [audioPlayer play];
        self.timer = [NSTimer
                      scheduledTimerWithTimeInterval: timeInterval
                      target:self selector:@selector(timerFired:)
                      userInfo:nil repeats:NO];
        printf("Play\n");
    }
    //pause
    else if(soundBox[currentRow][currentCol].state == 2){

        audioPlayer.currentTime = soundBox[currentRow][currentCol].startTime;
        printf("Box %d %d state pause between %f to %f\n",currentRow,currentCol,audioPlayer.currentTime,audioPlayer.currentTime + timeInterval);
                
        audioPlayer.volume = 0.0;
        [audioPlayer play];
        self.timer = [NSTimer
                        scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
        printf("Play\n");
            
    }else{
        
        // end of a column so col = 0 and next row continue playing
        if(currentRow == BOXROWS-1 && currentCol == BOXCOLUMNS-1){
            currentCol = 0;
            currentRow = 0;
            printf("Box %d %d state ignore so next box\n",currentRow,currentCol);
        // end of everything no playing
        }else if(currentCol == BOXCOLUMNS-1){
            currentCol = 0;
            currentRow++;
            printf("Box %d %d state ignore so next box\n",currentRow,currentCol);
            [self play];
            // end of a block so next col continue playing
        }else{
            currentCol++;
            printf("Box %d %d state ignore so next box\n",currentRow,currentCol);
            [self play];
        }
    }
}

- (void)timerFired:(NSTimer*)timer
{
    [audioPlayer stop];
    [self.timer invalidate];
    self.timer = nil;
    done = YES;
    
    // end of everything no playing
    if(currentRow == BOXROWS-1 && currentCol == BOXCOLUMNS-1){
        currentCol = 0;
        currentRow = 0;
        printf("timer fired now done");

    // end of a column so col = 0 and next row continue playing
    } else if(currentCol == BOXCOLUMNS-1){
        currentCol = 0;
        currentRow++;
        printf("timer fired now going to play box %d %d\n",currentRow,currentCol);
        [self play];
    
     // end of a block so next col continue playing
    }else{
        currentCol++;
        printf("timer fired now going to play box %d %d\n",currentRow,currentCol);
        [self play];
    }
}
/*
- (IBAction)JustPlay:(UILongPressGestureRecognizer *)sender {
    
    recognizer = sender;
    //NSLog(@"screen TOUCHED...");
    
    if(sender.state == UIGestureRecognizerStateBegan){
        //NSLog(@"Gesture begin");
        if(done == YES){
            //NSLog(@"song available to play");
            
            NSError *error;
            
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLooping error:&error];
            
            if (error)
            {
                NSLog(@"Error in audioPlayer: %@",
                      [error localizedDescription]);
            } else {
                audioPlayer.delegate = self;
                [audioPlayer prepareToPlay];
            }
            
            [audioPlayer play];
            ///NSLog(@"play");
            done = NO;
            //NSLog(@"done %d",done);
        }else{
            //NSLog(@"Song NOT available to play yet");
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        //printf("Gesture Released");
        [audioPlayer stop];
        done = YES;
    }

}

- (IBAction)PlayAndRecord:(UILongPressGestureRecognizer*)sender {
    
    recognizer = sender;
    //NSLog(@"screen TOUCHED...");
    
    if(sender.state == UIGestureRecognizerStateBegan){
        //NSLog(@"Gesture begin");
        if(done == YES){
            //NSLog(@"song available to play");
                        NSError *error;
        
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLooping error:&error];
        
            if (error)
            {
                NSLog(@"Error in audioPlayer: %@",
                  [error localizedDescription]);
            } else {
                audioPlayer.delegate = self;
                [audioPlayer prepareToPlay];
            }
        
            [audioPlayer play];
            //NSLog(@"play");
            //NSLog(@"record");
            [recorder record];
            done = NO;
            //NSLog(@"done %d",done);
        }else{
            //NSLog(@"Song NOT available to play yet");
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
       // printf("Gesture Released");
        
        [audioPlayer stop];
        done = YES;
    }
}
*/
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    printf("audio player finished playing current %d %d\n",currentRow,currentCol);
    [audioPlayer stop];
    done = YES;
    
}

/*
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
}
*/
@end
