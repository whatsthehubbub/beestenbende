//
//  DragonIntroductionViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 29/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface DragonIntroductionViewController : UIViewController

@property (nonatomic, weak) Game *game;

@property (strong) IBOutlet UIImageView *team1Picture;
@property (strong) IBOutlet UIImageView *team2Picture;

@property (strong) IBOutlet UIImageView *team1Proofs;
@property (strong) IBOutlet UIImageView *team2Proofs;

@property (strong) IBOutlet UILabel *explanation;

- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

@end
