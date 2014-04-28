//
//  RecordViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/27/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "RecordViewController.h"
#import "Variables.h"


@implementation RecordViewController

@synthesize LoopingLabel;
@synthesize playSound;

BOOL done = YES;
UIButton *currentSender;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)playSound:(UIButton *)sender {
    
    if(done == YES){
        
        [sender setImage:[UIImage imageNamed:@"button-playRed.png"]forState:UIControlStateNormal];
        
        currentSender = sender;
        //currentSoundLabel = sender.titleLabel.text;
        
        //url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:currentSoundLabel ofType:@"mp3"]];
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlLooping error:&error];
        
        if (error)
        {
            NSLog(@"Error in audioPlayer: %@",
                  [error localizedDescription]);
        } else {
            _audioPlayer.delegate = self;
            [_audioPlayer prepareToPlay];
        }
        
        [_audioPlayer play];
        
        done = NO;
    }
    
}

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_audioPlayer stop];
    [currentSender setImage:[UIImage imageNamed:@"button-play.png"]forState:UIControlStateNormal];
    done = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.LoopingLabel.text = [NSString stringWithFormat:@"Looping %@ file",soundLooping];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
