//
//  ProfileViewController.h
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *birthdayMonth;
@property (weak, nonatomic) IBOutlet UITextField *birthdayDay;
@property (weak, nonatomic) IBOutlet UITextField *birthdayYear;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *ProfileLabel;
@end
