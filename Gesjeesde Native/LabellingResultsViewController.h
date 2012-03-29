//
//  LabellingResultsViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"
#import "AppDelegate.h"

@interface LabellingResultsViewController : UIViewController {
    
    UIImageView *team1Image;
    UIImageView *team2Image;
    
    Game *game;
}

@property (retain, nonatomic) IBOutlet UIImageView *team1Image;
@property (retain, nonatomic) IBOutlet UIImageView *team2Image;

@property (retain, nonatomic) Game *game;

@end
