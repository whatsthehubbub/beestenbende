//
//  SecondIssueIntroductionViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 19/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "Flurry.h"

@interface SecondIssueIntroductionViewController : UIViewController {
    Game *game;
}

@property (strong) Game *game;

- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
