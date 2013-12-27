//
//  EndScreenViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "Flurry.h"

@interface EndScreenViewController : UIViewController

@property (nonatomic, weak) Game *game;

@property (strong) IBOutlet UIImageView *backgroundImage;
@property (strong) IBOutlet UIImageView *winnerPicture;

- (IBAction)mainMenu:(id)sender;

@end
