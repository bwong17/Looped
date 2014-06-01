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
@property (weak, nonatomic) IBOutlet UILabel *birthdayMonth;
@property (weak, nonatomic) IBOutlet UILabel *birthdayDay;
@property (weak, nonatomic) IBOutlet UILabel *birthdayYear;
@property (weak, nonatomic) IBOutlet UILabel *emailField;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusIndicator;
@property (weak, nonatomic) IBOutlet UINavigationItem *bar;
@property (weak, nonatomic) IBOutlet UILabel *emailVerified;
@property (weak, nonatomic) IBOutlet UIImageView *facebookLogo;
@end
