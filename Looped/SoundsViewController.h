//
//  SoundsViewController.h
//  Looped
//
//  Created by Barbara Wong on 4/22/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundsViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *SoundTableView;
;

@end
