//
//  FeaturePictureExplanationViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeatureExampleViewController.h"
#import "DDPageControl.h"
#import "SimpleAudioEngine.h"

@interface FirstIssueExplanationViewController : UIViewController <FeatureExampleViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (assign) BOOL pageControlBeingUsed;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

- (void)scrollPage:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)example:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

@end
