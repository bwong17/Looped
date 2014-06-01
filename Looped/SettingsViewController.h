//
//  SettingsViewController.h
//  Looped
//
//  Created by Barbara Wong on 4/28/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *connectFacebookButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak, nonatomic) IBOutlet UIButton *editPermissionsButton;
@property (weak, nonatomic) IBOutlet UIImageView *facebookLogo2;
@end
