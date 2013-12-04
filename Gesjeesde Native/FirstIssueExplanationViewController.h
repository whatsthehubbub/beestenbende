//
//  FeaturePictureExplanationViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeatureExampleViewController.h"
#import "SimpleAudioEngine.h"

@interface FirstIssueExplanationViewController : UIViewController <FeatureExampleViewControllerDelegate>

- (IBAction)example:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
