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
