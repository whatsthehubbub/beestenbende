//
//  PresentResultViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface TeamRunningTotalViewController : UIViewController {
    Game *game;
}

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

@property (nonatomic, retain) IBOutlet UILabel *team1featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2featureLabel;

@property (nonatomic, retain) IBOutlet UIImageView *team1featureImage;
@property (nonatomic, retain) IBOutlet UIImageView *team2featureImage;

@property (nonatomic, retain) IBOutlet UIImageView *team1pointsImage;
@property (nonatomic, retain) IBOutlet UIImageView *team2pointsImage;

@property (nonatomic, retain) IBOutlet UIImageView *animalImage;
@property (nonatomic, retain) IBOutlet UILabel *animalRequiresLabel;
@property (nonatomic, retain) IBOutlet UILabel *proofsRequiredLabel;

//@property (nonatomic, retain) FeaturePicture *team1fp;
//@property (nonatomic, retain) FeaturePicture *team2fp;

@property (strong) FeaturePicture *currentFeaturePicture;

- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
