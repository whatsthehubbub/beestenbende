//
//  MostPicturesViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 26/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface MostPicturesViewController : UIViewController

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UIImageView *team1Image;
@property (nonatomic, retain) IBOutlet UILabel *team1Label;
@property (nonatomic, retain) IBOutlet UILabel *team1PictureCount;

@property (nonatomic, retain) IBOutlet UIImageView *team2Image;
@property (nonatomic, retain) IBOutlet UILabel *team2Label;
@property (nonatomic, retain) IBOutlet UILabel *team2PictureCount;

@property (nonatomic, retain) IBOutlet UILabel *systemText;

- (IBAction)done:(id)sender;

@end
