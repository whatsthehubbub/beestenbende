//
//  TeamFeaturePickerViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Team.h"
#import "FeaturePicture.h"
#import "SimpleAudioEngine.h"

@class TeamFeaturePickerViewController;

@protocol TeamFeaturePickerViewControllerDelegate <NSObject>

- (void)teamFeaturePickerViewController:(TeamFeaturePickerViewController *)controller didSelectFeature:(int)index;

@end

@interface TeamFeaturePickerViewController : UITableViewController {
}

@property (nonatomic, weak) id <TeamFeaturePickerViewControllerDelegate> delegate;
@property (nonatomic, weak) Team *team;

@end
