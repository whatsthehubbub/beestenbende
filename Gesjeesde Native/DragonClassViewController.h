//
//  DragonClassViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 1/5/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface DragonClassViewController : UIViewController

@property (strong) Game *game;
@property (strong) Team *currentTeam;

@property (strong) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIButton *mammalButton;
@property (strong) IBOutlet UIButton *fishButton;
@property (strong) IBOutlet UIButton *reptileButton;
@property (strong) IBOutlet UIButton *birdButton;

- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

- (IBAction)buttonPushed:(UIButton *)sender;

@end
