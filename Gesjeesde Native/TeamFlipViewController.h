//
//  TeamPrepareViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface TeamFlipViewController : UIViewController 

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;
@property (strong) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIImageView *teamImage;

@property (strong) IBOutlet UILabel *explanationLabel;

@property (strong) Game *game;

- (IBAction)next:(id)sender;

@end
