//
//  FeaturePickerViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@class FeaturePickerViewController;

@protocol FeaturePickerViewControllerDelegate <NSObject>
-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)feature;
@end;

@interface FeaturePickerViewController : UIViewController {
    Game *game;
}

@property (strong) Game *game;
@property (nonatomic, weak) id <FeaturePickerViewControllerDelegate> delegate;

- (BOOL)disableFeature:(NSString *)feature;

- (IBAction)back:(id)sender;

@end
