//
//  SecondIssueIntroductionViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 19/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SecondIssueIntroductionViewController : UIViewController {
    Game *game;
}

@property (strong) Game *game;

- (IBAction)next:(id)sender;

@end
