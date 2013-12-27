//
//  DragonResultViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface DragonResultViewController : UIViewController

@property (nonatomic, weak) Game *game;
@property (nonatomic, weak) Team *currentTeam;

@property (strong) IBOutlet UIImageView *backgroundImage;

@property (strong) IBOutlet UILabel *explanationLabel;

- (IBAction)done:(id)sender;

@end
