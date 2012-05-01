//
//  DragonResultViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface DragonResultViewController : UIViewController

@property (strong) Game *game;
@property (strong) Team *currentTeam;

@property (nonatomic, retain) IBOutlet UILabel *classLabel;

@property (strong) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIImageView *featureImage;
@property (strong) IBOutlet UILabel *featureLabel;

@property (strong) IBOutlet UILabel *explanationLabel;

- (IBAction)done:(id)sender;

@end
