//
//  DragonIntroductionViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 29/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface DragonIntroductionViewController : UIViewController

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UIImageView *team1Picture;
@property (nonatomic, retain) IBOutlet UIImageView *team2Picture;

@property (nonatomic, retain) IBOutlet UILabel *team1Label;
@property (nonatomic, retain) IBOutlet UILabel *team2Label;

@property (nonatomic, retain) IBOutlet UIImageView *team1Proofs;
@property (nonatomic, retain) IBOutlet UIImageView *team2Proofs;

@property (nonatomic, retain) IBOutlet UILabel *explanation;

- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

@end
