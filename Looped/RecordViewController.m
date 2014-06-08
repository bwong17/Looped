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
//@synthesize LoopingLabel;
@synthesize recorder;
@synthesize audioPlayerClip;
@synthesize audioPlayerTimeline;
@synthesize BoxToMove;
@synthesize startPoint;
@synthesize recognizer;
@synthesize landscapeView;
@synthesize sliderRight;
@synthesize sliderLeft;
@synthesize tabBar;
@synthesize playButton;
@synthesize addCopyButton;
@synthesize playClip;

@synthesize secs_0;
@synthesize secs_10;
@synthesize secs_15;
@synthesize secs_20;
@synthesize secs_25;

BOOL done = YES;
UIButton *currentSender;
UILongPressGestureRecognizer *recognizer;
NSURL *temporaryRecFile;
int currentRow;
int currentCol;
NSTimeInterval timeInterval;

float currentSliderVal = 1.0;
float maxSoundWidth = 90.0;

// total view
int maxX = 320;
int maxY = 568;

//width and height of sound
int gridWidth = 50;
int gridHeight = 90;

int ylayers = 20;
int xlayers = 0;

int padding;

//highest and lowest ranges to move in view
int highestXrange;
int lowestXrange;

int highestYrange;
int lowestYrange;

// line up in grid
int exactlyYmin;
int exactlyYmax;
int exactlyX;

int paddingMinX;
int paddingMaxX;

int paddingMinY;
int paddingMaxY;

// last position for block 1
int lastPositionX;
int lastPositionY;

int soundCurrentX;
int soundCurrentY;

double currentSoundRightBound;
double currentSoundLeftBound;

Box soundBox[BOXROWS][BOXCOLUMNS];

-(BOOL) shouldAutorotate { return NO; }


-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);

    self.secs_0.transform = trans;
    self.secs_5.transform = trans;
    self.secs_10.transform = trans;
    self.secs_15.transform = trans;
    self.secs_20.transform = trans;
    self.secs_25.transform = trans;
    self.playButton.transform = trans;
    self.addCopyButton.transform = trans;
    self.playClip.transform = trans;
    
    self.tabBar.title = [NSString stringWithFormat:@"Recording %@",soundLooping];
    
    highestXrange = maxX - (gridWidth/2);
    lowestXrange = xlayers + (gridWidth/2);
    
    highestYrange = maxY - ylayers - (gridHeight/2);
    lowestYrange = ylayers + (gridHeight/2);
    
    // line up in grid
    exactlyYmin = lowestYrange;
    exactlyYmax = highestYrange;
    exactlyX = (maxX - xlayers)/2;
    
    // last position for block 1
    lastPositionX = 100;//(maxX - xlayers)/4;
    lastPositionY = 100;//maxY / 2;
    
    padding = gridWidth / 2;
    
    paddingMinX = exactlyX - padding;
    paddingMaxX = exactlyX + padding;

    paddingMinY = lowestYrange - padding;
    paddingMaxY = highestYrange + padding;
    
    soundCurrentX = 230;
    soundCurrentY = 250;
    
    currentSoundLeftBound = soundCurrentY;
    currentSoundRightBound = soundCurrentY + gridHeight;
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundLooping ofType:@"mp3"]];
    
    NSError *error;
    
    audioPlayerClip = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        audioPlayerClip.delegate = self;
        [audioPlayerClip prepareToPlay];
    }
}
   //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    //NSLog(@"%d",[self.loopVC interfaceOrientation]);
    //done = YES;
    //self.LoopingLabel.text = [NSString stringWithFormat:@"File: %@",soundLooping];
    
    //currentRow = 0;
    //currentCol = 0;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Looped_Base_Color.png"]forBarMetrics:UIBarMetricsDefault];
    
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
    /*
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
        soundBox[i][0].startTime = 0.0;
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
     */

//}
/*
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    printf("touch begin ------- \n");
    BoxToMove.layer.borderColor = [UIColor yellowColor].CGColor;
    BoxToMove.layer.borderWidth = 3.0f;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    printf("touch moved ------- ");
    UITouch *myTouch = [touches anyObject];
    
    startPoint = [myTouch locationInView:self.view];
    
    BoxToMove.center = CGPointMake(startPoint.x, startPoint.y);
    
    printf("startPointX: %0.2f    startPointY: %0.2f\n",startPoint.x,startPoint.y);
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    printf("touch ends ------- \n");

    if(startPoint.x > lowestX && startPoint.x < highestX && startPoint.y > lowestY && startPoint.y < highestY){
        printf("in Box\n");
        BoxToMove.center = CGPointMake(startPoint.x, exactlyY);
        lastPositionX = startPoint.x;
        lastPositionY = exactlyY;
    }else{
        printf("Not in box\n");
        BoxToMove.center = CGPointMake(lastPositionX,lastPositionY);
    }
    BoxToMove.layer.borderWidth = 0.0f;
}
 */

/*
- (IBAction)pinchBox1:(UIPinchGestureRecognizer*)sender {
    
    CGAffineTransform zoomTransform = CGAffineTransformMakeScale([sender scale],[sender scale]);
    
    [[sender view] setTransform:zoomTransform];
}
*/
- (IBAction)playClip:(id)sender {
    
    [audioPlayerClip play];
    self.playClip.backgroundColor = [UIColor grayColor];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(player == audioPlayerClip)
        self.playClip.backgroundColor = [UIColor orangeColor];
}

- (IBAction)sliderRightValueChanged:(id)sender {
    
    printf("currentSoundRightBound:%0.2f\n",currentSoundRightBound);
    
    if(sliderRight.value == 1){
        currentSoundRightBound = maxSoundWidth;
        printf("hit max %0.2f\n",currentSoundRightBound);
    }
    else{
        currentSoundRightBound = gridHeight * sliderRight.value;
        printf("now %0.2f with slider value \n",currentSoundRightBound);
    }
    
    self.BoxToMove.frame = CGRectMake(soundCurrentX, soundCurrentY, gridWidth, currentSoundRightBound);
}
- (IBAction)sliderLeftValueChanged:(id)sender {

    printf("currentSoundLeftBound:%0.2f\n",currentSoundLeftBound);
    
    if(sliderLeft.value == 0.1){
        printf("hit max %0.2f\n",currentSoundLeftBound);
        soundCurrentY = 250;
        currentSoundRightBound = soundCurrentY + gridHeight;
        
        self.BoxToMove.frame = CGRectMake(soundCurrentX, soundCurrentY, gridWidth, gridHeight);

    }
    else{
        
        double temp = sliderLeft.value * gridHeight;
        double tempTopY = soundCurrentY + temp/2;
        double tempBottomY = (soundCurrentY + gridHeight) - temp/2;
        
        printf("now %0.2f -> %0.2f with slider value %0.2f\n",tempTopY, tempBottomY, sliderLeft.value);
        
        self.BoxToMove.frame = CGRectMake(soundCurrentX, tempTopY, gridWidth, tempBottomY - tempTopY);

    }
    
    
}

- (IBAction)moveBox1:(UILongPressGestureRecognizer*)sender {
    
    startPoint = [sender locationInView:self.view];
    
    BoxToMove.center = CGPointMake(startPoint.x, startPoint.y);

    int pointX = 0;
    int pointY = 0;

    //done
    if(recognizer.state == 1){
        BoxToMove.layer.borderColor = [UIColor yellowColor].CGColor;
        BoxToMove.layer.borderWidth = 3.0f;
    }
    else if(recognizer.state == 3){
        
        if(startPoint.x > paddingMinX && startPoint.x < paddingMaxX && startPoint.y > paddingMinY && startPoint.y < paddingMaxY){
            
            printf("in Box\n");
            
            if(startPoint.y < exactlyYmin){
                BoxToMove.center = CGPointMake(exactlyX, exactlyYmin);
                lastPositionY = exactlyYmin;
                
                soundCurrentY = exactlyYmin;
            }
            else if(startPoint.y > exactlyYmax){
                BoxToMove.center = CGPointMake(exactlyX, exactlyYmax);
                lastPositionY = exactlyYmax;
                
                soundCurrentY = exactlyYmax;
            }
            else{
                BoxToMove.center = CGPointMake(exactlyX, startPoint.y);
                lastPositionY = startPoint.y;
                
                soundCurrentY = startPoint.y;
                
            }
            lastPositionX = exactlyX;
            soundCurrentX = exactlyX;
            
        }else{
            
            printf("Not in box ");

            pointX = startPoint.x;
            pointY = startPoint.y;
            
            if(pointX > highestXrange){
                pointX = highestXrange;
                printf("highest ");
            }
            else if(pointX < lowestXrange){
                pointX = lowestXrange;
                printf("lowest ");
            }
            else if(pointX > (exactlyX - (gridWidth/2)) && pointX < paddingMinX){
                printf("middle ");
                pointX = paddingMaxX - gridWidth;
            }
            else
                pointX = startPoint.x;
            
            if(pointY > highestYrange)
                pointY = highestYrange;
            if(pointY < lowestYrange)
                pointY = lowestYrange;
            else
                pointY = startPoint.y;
            
            BoxToMove.center = CGPointMake(pointX,pointY);
            soundCurrentX = pointX;
            soundCurrentY = pointY;
        }
        printf("so place in X: %0.2d    Y: %0.2d\n",pointX, pointY);
        BoxToMove.layer.borderWidth = 0.0f;
    }
    printf("state: %d   ",recognizer.state);

    printf("startPointX: %0.2f    startPointY: %0.2f\n",startPoint.x,startPoint.y);

}

/*
- (IBAction)moveBox2:(UILongPressGestureRecognizer *)sender {
    
    startPoint = [sender locationInView:self.view];
    
    BoxToMove2.center = CGPointMake(startPoint.x, startPoint.y);
}
 */

/*
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
 */
/*
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
 */
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
/*
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    printf("audio player finished playing current %d %d\n",currentRow,currentCol);
    [audioPlayer stop];
    done = YES;
    
}
*/
/*
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
}
*/
@end
