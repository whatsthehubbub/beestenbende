//
//  ExplainFeatureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "DDPageControl.h"

@class ExplainFeatureViewController;

@interface ExplainFeatureViewController : UIViewController {
    NSDictionary *feature;
}

@property (strong) Game *game;

@property (nonatomic, retain) NSDictionary *feature;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) DDPageControl *pageControl;
@property (assign) BOOL pageControlBeingUsed;

@property (nonatomic, retain) IBOutlet UILabel *team1NameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *team1FeatureImage;
@property (nonatomic, retain) IBOutlet UILabel *team1FeatureLabel;
@property (nonatomic, retain) IBOutlet UILabel *team1ResultAndExplanationLabel;

@property (nonatomic, retain) IBOutlet UILabel *team2NameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *team2FeatureImage;
@property (nonatomic, retain) IBOutlet UILabel *team2FeatureLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2ResultAndExplanationLabel;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

- (void)scrollPage;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

@end
