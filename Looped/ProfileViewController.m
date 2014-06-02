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
#import <QuartzCore/QuartzCore.h>
#import "AssetsLibrary/AssetsLibrary.h"

@implementation ProfileViewController
@synthesize NameLabel;
@synthesize profileImage;
@synthesize birthdayDay;
@synthesize birthdayMonth;
@synthesize birthdayYear;
@synthesize emailField;
@synthesize statusIndicator;
@synthesize emailVerified;
@synthesize bar;
@synthesize facebookLogo;

-(BOOL) shouldAutorotate { return NO; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusIndicator.hidden = NO;
    [statusIndicator startAnimating];
    
    PFUser *currentUser = [PFUser currentUser];
    
    NSString *label = [NSString stringWithFormat:@"%@'s Profile",currentUser.username];
    
    self.bar.title = label;
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
            
            
            NSString *firstName = loggedUser[@"firstName"];
            NSString *lastName = loggedUser[@"lastName"];
            NSString *gender = loggedUser[@"gender"];
            NSString *month = loggedUser[@"birthMonth"];
            NSString *day = loggedUser[@"birthDay"];
            NSString *year = loggedUser[@"birthYear"];
            NSString *email = loggedUser[@"email"];
            
            self.NameLabel.text = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
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

            
            if(loggedUser[@"profilePic"] == NULL){
                if([gender isEqualToString:@"Female"]){
                    self.profileImage.image = [UIImage imageNamed:@"woman.png"];
                }else if ([gender isEqualToString:@"Male"]){
                    self.profileImage.image = [UIImage imageNamed:@"man.png"];
                }else{
                    self.profileImage.image = [UIImage imageNamed:@"camera.png"];
                }
            }else{
                ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
                {
                    ALAssetRepresentation *rep = [myasset defaultRepresentation];
                    @autoreleasepool {
                        CGImageRef iref = [rep fullScreenImage];
                        if (iref) {
                            UIImage *temp = [UIImage imageWithCGImage:iref];
                            self.profileImage.image = temp;
                            iref = nil;
                        }
                    }
                };
                
                ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
                {
                    NSLog(@"Can't get image - %@",[myerror localizedDescription]);
                };
                
                NSURL *url = [NSURL URLWithString:loggedUser[@"profilePic"]];
                
                ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
                [assetslibrary assetForURL:url
                               resultBlock:resultblock
                              failureBlock:failureblock];
                
                if (![PFFacebookUtils isLinkedWithUser:currentUser])
                    [facebookLogo setImage:[UIImage imageNamed: @"facebook.png"]];
                else
                    [facebookLogo setImage:[UIImage imageNamed: @"facebook_blue.png"]];
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

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

@end
