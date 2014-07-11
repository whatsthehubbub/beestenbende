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
#import "UIImageView+UncachedImageView.h"
#import "UINavigationController+ClearViewControllers.h"

@class ExplainFeatureViewController;

@interface ExplainFeatureViewController : UIViewController {
}

@property (nonatomic, weak) Game *game;
@property (strong) Team *currentTeam;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, weak) IBOutlet UIImageView *featureImageFrame;
@property (nonatomic, weak) IBOutlet UIImageView *featureImage;
@property (nonatomic, weak) IBOutlet UILabel *featureLabel;
@property (nonatomic, weak) IBOutlet UILabel *resultAndExplanationLabel;

@property (nonatomic, weak) IBOutlet UIImageView *pointsImage;

- (IBAction)done:(id)sender;

@end
