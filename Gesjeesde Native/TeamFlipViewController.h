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

@interface TeamFlipViewController : UIViewController 

@property (strong) IBOutlet UILabel *headerLabel;
@property (strong) IBOutlet UIImageView *backgroundImage;

@property (strong) IBOutlet UIImageView *teamPhoto;
@property (strong) IBOutlet UIImageView *photoFrame;

@property (nonatomic, weak) Game *game;

- (IBAction)next:(id)sender;

@end
