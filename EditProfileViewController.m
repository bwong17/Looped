//
//  EditProfileViewController.m
//  Looped
//
//  Created by Barbara Wong on 5/12/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "Variables.h"
#import "AssetsLibrary/AssetsLibrary.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize firstName;
@synthesize lastName;
@synthesize userName;
@synthesize birthDay;
@synthesize birthMonth;
@synthesize birthYear;
@synthesize emailField;
@synthesize spinner;
@synthesize resetButton;


int photoTaken;

-(BOOL) shouldAutorotate { return NO; }

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.firstName setDelegate:self];
    [self.lastName setDelegate:self];
    [self.userName setDelegate:self];
    [self.birthYear setDelegate:self];
    [self.birthMonth setDelegate:self];
    [self.birthDay setDelegate:self];
    [self.emailField setDelegate:self];
    
    self.spinner.hidden = NO;
    [spinner startAnimating];
    
    if(verified.intValue == 1)
        resetButton.enabled = YES;
    else
        resetButton.enabled = NO;
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
    
        
        self.firstName.text = loggedUser[@"firstName"];
        self.lastName.text = loggedUser[@"lastName"];
        self.userName.text = loggedUser[@"username"];
        self.birthMonth.text = loggedUser[@"birthMonth"];
        self.birthDay.text = loggedUser[@"birthDay"];
        self.birthYear.text = loggedUser[@"birthYear"];
        self.emailField.text = loggedUser[@"email"];
        
        self.spinner.hidden = YES;
        [spinner stopAnimating];
    }];
}


- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction) resetPassword:(id)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
        
        NSString *emailToVerify = currentUser[@"email"];
        
        [PFUser requestPasswordResetForEmailInBackground:emailToVerify];
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent" message:@"Check your email for a reset password link"delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alert show];
}
- (IBAction)edittedFirst:(id)sender {

    PFUser *currentUser = [PFUser currentUser];

    currentUser[@"firstName"] = self.firstName.text;
    [currentUser saveInBackground];
    
}
- (IBAction)edittedLast:(id)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    
    currentUser[@"lastName"] = self.lastName.text;
    [currentUser saveInBackground];
    
}

- (IBAction)edittedUser:(id)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    
    currentUser[@"username"] = self.userName.text;
    [currentUser saveInBackground];
}

- (IBAction)edittedEmail:(id)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    
    if([self.emailField hasText] > 0)
        currentUser[@"email"] = self.emailField.text;
    
    [currentUser saveInBackground];
    
}


 - (IBAction)edittedBirthMonth:(UITextField *)sender {
 
 PFUser *currentUser = [PFUser currentUser];
 
 if(self.birthMonth.text.intValue < 12 && self.birthMonth.text.intValue > 1){
 currentUser[@"birthMonth"] = self.birthMonth.text;
 [currentUser saveInBackground];
 }
 else{
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth month is invalid. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
 [alert show];
 }
}

- (IBAction)edittedBirthDay:(UITextField *)sender {
 
 PFUser *currentUser = [PFUser currentUser];
 
 if(self.birthDay.text.intValue < 31 && self.birthDay.text.intValue > 0){
 currentUser[@"birthDay"] = self.birthDay.text;
 [currentUser saveInBackground];
 }
 else{
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth day is invalid. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
 [alert show];
 }
 
}

 - (IBAction)edittedBirthYear:(UITextField *)sender {
 
 PFUser *currentUser = [PFUser currentUser];
 
 if(self.birthYear.text.intValue < 1996 && self.birthYear.text.intValue > 1930){
 currentUser[@"birthYear"] = self.birthYear.text;
 
 [currentUser saveInBackground];
 }else{
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth year is invalid. Must be 18 years or older. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
 [alert show];
 }
}
- (IBAction)changeProfilePicture:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Profile Picture" message:@"Choose an option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take Photo", @"Choose Existing",nil];
    
    [alert show];
    
}

-(void) takePhoto{
    
    printf("taking photo\n");
    
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];

    [self presentViewController:picker animated:YES completion:NULL];
    //[picker release];
    
    photoTaken = 1;
    
}

-(void) chooseExisting{
    
    printf("choosing from existing\n");
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
    //[picker2 release];
    
    photoTaken = 0;
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    PFUser *currentUser = [PFUser currentUser];
    NSURL *imageFileURL;
    
    if(photoTaken){
        // to save picture if taken
        UIImage *temp = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSLog(@"new photo taken %@",temp);
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        // Request to save the image to camera roll
        [library writeImageToSavedPhotosAlbum:[temp CGImage] orientation:(ALAssetOrientation)[temp imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
                NSLog(@"error");
            } else {
                NSLog(@"url %@", assetURL);
            }
            
            currentUser[@"profilePic"] = [NSString stringWithFormat:@"%@",assetURL];
            
            [currentUser saveInBackground];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:@"New profile picture set."
                                                           delegate:self cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }];  
        
    }else{
        imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
         NSLog(@"url %@",imageFileURL);
        
        currentUser[@"profilePic"] = [NSString stringWithFormat:@"%@",imageFileURL];
        
        [currentUser saveInBackground];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"New profile picture set."
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    else // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"Image saved to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    [alert show];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)[self takePhoto];
    if (buttonIndex == 2)[self chooseExisting];

}

@end
