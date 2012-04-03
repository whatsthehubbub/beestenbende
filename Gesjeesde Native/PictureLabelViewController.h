//
//  PictureLabelViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeaturePickerViewController.h"

@interface PictureLabelViewController : UIViewController <FeaturePickerViewControllerDelegate> {
    UIButton *featureButton;
}

@property (nonatomic, retain) IBOutlet UIButton *featureButton;

@end
