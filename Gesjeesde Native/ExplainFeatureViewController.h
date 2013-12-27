//
//  ExplainFeatureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@class ExplainFeatureViewController;

@interface ExplainFeatureViewController : UIViewController {
}

@property (nonatomic, weak) Game *game;
@property (nonatomic, weak) Team *currentTeam;

@property (strong) IBOutlet UIImageView *backgroundImage;

@property (strong) IBOutlet UIImageView *featureImageFrame;
@property (strong) IBOutlet UIImageView *featureImage;
@property (strong) IBOutlet UILabel *featureLabel;
@property (strong) IBOutlet UILabel *resultAndExplanationLabel;

@property (strong) IBOutlet UIImageView *pointsImage;

- (IBAction)done:(id)sender;

@end
