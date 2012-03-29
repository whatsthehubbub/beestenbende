//
//  FeatureExampleViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeatureExampleViewController;

@protocol FeatureExampleViewControllerDelegate

- (void)featureExampleDidBack:(FeatureExampleViewController *)controller;
@end

@interface FeatureExampleViewController : UIViewController

@property (nonatomic, weak) id <FeatureExampleViewControllerDelegate> delegate;

- (IBAction)back:(id)sender;

@end
