//
//  LoopedSecondViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "PostingViewController.h"


@implementation PostingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)SoundsViewButton:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"soundsView" sender:self];
}

@end
