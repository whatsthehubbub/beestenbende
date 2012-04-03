//
//  FeaturePickerViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@class FeaturePickerViewController;

@protocol FeaturePickerViewControllerDelegate <NSObject>
-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)feature;
@end;

@interface FeaturePickerViewController : UITableViewController {
    
    Game *game;
}

@property (strong) Game *game;
@property (nonatomic, weak) id <FeaturePickerViewControllerDelegate> delegate;

@end
