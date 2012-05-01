//
//  DragonClassViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 1/5/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface DragonClassViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong) Game *game;
@property (strong) Team *currentTeam;

@property (strong) IBOutlet UIImageView *teamOverlay;

@property (nonatomic, retain) IBOutlet UIPickerView *classPicker;

- (IBAction)next:(id)sender;

@end
