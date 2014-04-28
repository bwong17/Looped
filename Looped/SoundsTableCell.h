//
//  SoundsTableCellTableViewCell.h
//  Looped
//
//  Created by Barbara Wong on 4/22/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundsTableCell : UITableViewCell <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UIButton *soundLabel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@end
