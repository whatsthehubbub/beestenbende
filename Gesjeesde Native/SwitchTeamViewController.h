//
//  SwitchTeamViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 4/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchTeamViewController;


@protocol SwitchTeamViewControllerDelegate

- (void)switchDone:(SwitchTeamViewController *)controller;

@end


@interface SwitchTeamViewController : UIViewController

@property (nonatomic, weak) id <SwitchTeamViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
