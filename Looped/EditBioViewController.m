//
//  EditBioViewController.m
//  Looped
//
//  Created by Barbara Wong on 6/2/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "EditBioViewController.h"
#import "Parse/Parse.h"

@interface EditBioViewController ()

@end

@implementation EditBioViewController

@synthesize saveButton;
@synthesize bioBox;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (IBAction)saveBio:(id)sender {
        
    PFUser *user = [PFUser currentUser];
    
    user[@"Bio"] = self.bioBox.text;
    
    [user saveInBackground];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message: @"New bio has been saved" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *user = [PFUser currentUser];
    
    NSString *bio = user[@"Bio"];
    
    self.bioBox.text = bio;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
