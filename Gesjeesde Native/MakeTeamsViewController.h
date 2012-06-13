//
//  MakeTeamsViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SimpleAudioEngine.h"

@interface MakeTeamsViewController : UIViewController

@property (strong) IBOutlet UILabel *teamYellowLabel;
@property (strong) IBOutlet UILabel *teamBlueLabel;

- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
