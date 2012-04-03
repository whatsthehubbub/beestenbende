//
//  FeaturePictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePicture.h"

@interface FeaturePictureViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UILabel *timeLabel;
    
    UIView *imagesView;
    
    NSTimer *timer;
    int secondsLeft;
    
    Game *game;
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UIView *imagesView;

@property (nonatomic, retain) NSTimer *timer;
@property (readwrite) int secondsLeft;

@property (strong) Game *game;

- (void)decrementTimer:(NSTimer *)theTimer;

- (IBAction)takeFeaturePicture:(id)sender;

@end
