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

- (IBAction)backButtonPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"SoundsViewToTab" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
    
    [cell.soundLabel setTitle:soundsArray[row] forState:UIControlStateNormal];
    [cell.soundLabel setTitle:soundsArray[row] forState:UIControlStateSelected];
    
    return cell;
    
}
@end
