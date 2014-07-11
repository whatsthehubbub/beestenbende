//
//  TeamPrepareViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "UIImageView+UncachedImageView.h"

@interface TeamFlipViewController : UIViewController 

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, weak) IBOutlet UIImageView *teamPhoto;
@property (nonatomic, weak) IBOutlet UIImageView *photoFrame;

@property (nonatomic, weak) Game *game;

- (IBAction)next:(id)sender;

@end
