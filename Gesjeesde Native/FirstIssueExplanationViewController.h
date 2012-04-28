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

@interface FirstIssueExplanationViewController : UIViewController <FeatureExampleViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (assign) BOOL pageControlBeingUsed;

- (IBAction)scrollPage:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;
@end
