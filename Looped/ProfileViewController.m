//
//  ProfileViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "ProfileViewController.h"
#import "Variables.h"
#import "Parse/Parse.h"

@implementation ProfileViewController
@synthesize firstNameLabel;
@synthesize lastNameLabel;
@synthesize profileImage;
@synthesize birthdayDay;
@synthesize birthdayMonth;
@synthesize birthdayYear;
@synthesize emailField;
@synthesize statusIndicator;
@synthesize emailVerified;
@synthesize bar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusIndicator.hidden = NO;
    [statusIndicator startAnimating];
    
    PFUser *currentUser = [PFUser currentUser];
    
    NSString *label = [NSString stringWithFormat:@"%@'s Profile",currentUser.username];
    
    self.bar.title = label;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
            
            
            NSString *firstName = loggedUser[@"firstName"];
            NSString *lastName = loggedUser[@"lastName"];
            NSString *gender = loggedUser[@"gender"];
            NSString *month = loggedUser[@"birthMonth"];
            NSString *day = loggedUser[@"birthDay"];
            NSString *year = loggedUser[@"birthYear"];
            NSString *email = loggedUser[@"email"];
            
            self.firstNameLabel.text = firstName;
            self.lastNameLabel.text = lastName;
            self.birthdayMonth.text = month;
            self.birthdayDay.text = day;
            self.birthdayYear.text = year;
            self.emailField.text = email;
            
            verified = loggedUser[@"emailVerified"];
            
            if(verified.intValue == 1){
                self.emailVerified.text = @"Verified";
                [self.emailVerified setTextColor:[UIColor greenColor]];
            }else{
                self.emailVerified.text = @"Not Verified";
                [self.emailVerified setTextColor:[UIColor redColor]];
            }
            
            if([gender isEqualToString:@"Female"]){
                self.profileImage.image = [UIImage imageNamed:@"woman.png"];
            }else if ([gender isEqualToString:@"Male"]){
                self.profileImage.image = [UIImage imageNamed:@"man.png"];
            }else{
                self.profileImage.image = [UIImage imageNamed:@"camera.png"];
            }
            self.statusIndicator.hidden = YES;
            [statusIndicator stopAnimating];
    }];
    
}
- (IBAction)refreshProfile:(id)sender {
    
    [self viewDidLoad];

}

- (IBAction)editProfileButton:(id)sender {
    
    [self performSegueWithIdentifier:@"editProfile" sender:self];
}

@end
