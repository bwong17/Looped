//
//  EditBioViewController.h
//  Looped
//
//  Created by Barbara Wong on 6/2/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBioViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *bioBox;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
