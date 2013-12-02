//
//  ExplainFeatureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "DDPageControl.h"
#import "SimpleAudioEngine.h"

@class ExplainFeatureViewController;

@interface ExplainFeatureViewController : UIViewController {
    NSDictionary *feature;
}

@property (strong) Game *game;
@property (strong) Team *currentTeam;

@property (strong) IBOutlet UIImageView *backgroundImage;

@property (strong) IBOutlet UIImageView *featureImageFrame;
@property (nonatomic, retain) IBOutlet UIImageView *featureImage;
@property (nonatomic, retain) IBOutlet UILabel *featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *resultAndExplanationLabel;

@property (strong) IBOutlet UIImageView *pointsImage;

- (IBAction)done:(id)sender;

@end
