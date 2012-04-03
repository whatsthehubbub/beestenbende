//
//  FeaturePickerViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface FeaturePickerViewController : UITableViewController {
    
    Game *game;
}

@property (strong) Game *game;

@end
