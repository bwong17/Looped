//
//  SoundsViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/22/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "SoundsViewController.h"
#import "SoundsTableCell.h"
#import "Parse/Parse.h"
#import "Variables.h"

@interface SoundsViewController ()

@end

@implementation SoundsViewController
@synthesize SoundTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(BOOL) shouldAutorotate { return NO; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.SoundTableView.delegate = self;
    self.SoundTableView.dataSource = self;
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SoundList" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.sounds = dict;
    
    NSArray *array = [[_sounds allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.keys = array;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (IBAction)loopButtonPressed:(UIButton*)sender {
    
    soundLooping = sender.titleLabel.text;
    NSLog(@"Set sound looping to %@",soundLooping);
    urlLooping = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundLooping ofType:@"mp3"]];
    
    [self performSegueWithIdentifier:@"toRecord" sender:self];
}

-(NSInteger)numberOfSectionsInTableView :(UITableView *) tableView
{
    return [_keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *key = [_keys objectAtIndex:section];
    
    NSArray *sound = [_sounds objectForKey:key];
    
    return [sound count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    NSArray *sound = [_sounds objectForKey:key];
    
    static NSString *cellID = @"TableCell";
    
    SoundsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil){
        cell = [[SoundsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.soundLabel.text = [sound objectAtIndex:indexPath.row];
    
    [cell.playButton setTitle:[sound objectAtIndex:indexPath.row]
                     forState:UIControlStateNormal];
    
    //NSLog(@"set play button title to %@",cell.playButton.titleLabel);
    
    [cell.playButton setTitle:[sound objectAtIndex:indexPath.row] forState:UIControlStateSelected];
    
    [cell.loopButton setTitle:[sound objectAtIndex:indexPath.row]
                     forState:UIControlStateNormal];
    [cell.loopButton setTitle:[sound objectAtIndex:indexPath.row] forState:UIControlStateSelected];

    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [_keys objectAtIndex:section];
    
    return key;
}
@end
