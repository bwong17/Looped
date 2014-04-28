//
//  SoundsTableCellTableViewCell.m
//  Looped
//
//  Created by Barbara Wong on 4/22/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "SoundsTableCell.h"
#import "Variables.h"

NSString *currentSoundLabel;
UIButton *currentSender;
BOOL currentDone = YES;
NSURL *url;

@implementation SoundsTableCell

@synthesize soundLabel;
@synthesize playButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (IBAction)playButtonPressed: (UIButton*)sender
{
    
    if(currentDone == YES){
        
        [sender setImage:[UIImage imageNamed:@"button-playRed.png"]forState:UIControlStateNormal];

        currentSender = sender;
        currentSoundLabel = sender.titleLabel.text;
        
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:currentSoundLabel ofType:@"mp3"]];
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        if (error)
        {
           NSLog(@"Error in audioPlayer: %@",
        [error localizedDescription]);
        } else {
            _audioPlayer.delegate = self;
            [_audioPlayer prepareToPlay];
        }
        
        [_audioPlayer play];
        
        currentDone = NO;
    }
}

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
        [_audioPlayer stop];
        [currentSender setImage:[UIImage imageNamed:@"button-play.png"]forState:UIControlStateNormal];
        currentDone = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    //NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:currentSoundLabel ofType:@"mp3"]];
    //NSError *error;
    
    //_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //if (error)
    //{
     ////   NSLog(@"Error in audioPlayer: %@",
              //[error localizedDescription]);
    //} else {
        //_audioPlayer.delegate = self;
       // [_audioPlayer prepareToPlay];
    //}
    //[self performSegueWithIdentifier:@"toStartRecordingView" sender:self];
}


@end
