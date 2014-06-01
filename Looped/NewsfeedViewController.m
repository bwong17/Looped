//
//  LoopedFirstViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "NewsfeedViewController.h"
#import "Variables.h"
#import "LoopedAppDelegate.h"
#import "FacebookSDK/FacebookSDK.h"
#import "Parse/Parse.h"


@implementation NewsfeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //orange
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(236/255.0) green:(154/255.0) blue:(61/255.0) alpha:1.0]];
    //[[UITabBar appearance] setTintColor:[UIColor grayColor]];
    
    
    //red
    //[[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(225/255.0) green:(100/255.0) blue:(91/255.0) alpha:1.0]];

    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:(225/255.0) green:(100/255.0) blue:(91/255.0) alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
   
}

-(BOOL) shouldAutorotate { return NO; }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
