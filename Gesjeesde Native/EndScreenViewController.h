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

@interface EndScreenViewController : UIViewController

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UIImageView *winnerPicture;

@property (nonatomic, retain) IBOutlet UILabel *winnerLabel;

- (IBAction)mainMenu:(id)sender;

- (IBAction)back:(id)sender;

@end
