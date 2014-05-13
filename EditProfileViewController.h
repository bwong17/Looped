//
//  EditProfileViewController.h
//  Looped
//
//  Created by Barbara Wong on 5/12/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *birthMonth;
@property (weak, nonatomic) IBOutlet UITextField *birthDay;
@property (weak, nonatomic) IBOutlet UITextField *birthYear;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end
