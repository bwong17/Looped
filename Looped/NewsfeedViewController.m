//
//  LoopedFirstViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "NewsfeedViewController.h"
#import "Variables.h"


@implementation NewsfeedViewController

- (void)viewDidLoad
{
    if(backFromSounds){
        backFromSounds = NO;
        [self performSegueWithIdentifier:@"back" sender:self];
    }
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
