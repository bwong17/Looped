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

//NSArray *soundsArray;
//NSString *string;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.SoundTableView.delegate = self;
    self.SoundTableView.dataSource = self;
    [super viewDidLoad];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Looped_Base_Color.png"]forBarMetrics:UIBarMetricsDefault];
    /*
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    */
    //[[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], [UIFont fontWithName:@"System" size:21.0], nil]];
    
    /*
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     */
    
    soundsArray = [[NSMutableArray alloc]init];
    soundsArray = @[@"bubbles",@"clay",@"confetti",@"corona",@"dotted-spiral",@"flash-1",@"flash-2",@"flash-3",@"glimmer",@"moon",@"pinwheel",@"piston-1",@"piston-2",@"piston-3",@"prism-1",@"prism-2",@"prism-3",@"splits",@"squiggle",@"strike",@"suspension",@"timer",@"ufo",@"veil",@"wipe",@"zig-zag",];
    
    // API CALL TO GET THE SOUND STRINGS
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Sounds"];
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"soundsName" notEqualTo:@""];
    [query findObjectsInBackgroundWithBlock:^(NSArray *parseArray, NSError *error){
        
        //NSArray *tempArray = [query findObjects];
        soundsArray = [[NSMutableArray alloc] initWithArray:parseArray];
        NSLog(@"query %lu",(unsigned long)soundsArray.count);
     
        if (!error) {
            for(PF  Object *object in parseArray)
               [soundsArray addObject:object[@"soundName"]];
        } else
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        NSLog(@"After loops count is %lu",(unsigned long)soundsArray.count);
     
        //NSLog(@"ScoreArray %@",tempArray);
    }];
*/
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return soundsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    SoundsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    int row = [indexPath row];
    
    [cell.soundLabel setText:soundsArray[row]];
    
    [cell.playButton setTitle:soundsArray[row]
        forState:UIControlStateNormal];
    [cell.playButton setTitle:soundsArray[row] forState:UIControlStateSelected];
    
    [cell.loopButton setTitle:soundsArray[row]
                     forState:UIControlStateNormal];
    [cell.loopButton setTitle:soundsArray[row] forState:UIControlStateSelected];
    
    
    return cell;
    
}
@end
