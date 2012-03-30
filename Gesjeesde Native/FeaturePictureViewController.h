//
//  FeaturePictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturePictureViewController : UIViewController {
    UILabel *timeLabel;
    
    NSTimer *timer;
    int secondsLeft;
    
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@property (nonatomic, retain) NSTimer *timer;
@property (readwrite) int secondsLeft;

- (void)decrementTimer;

@end
