//
//  TeamPrepareViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TeamPrepareViewController : UIViewController 

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;
@property (strong) IBOutlet UIImageView *teamOverlay;

@property (strong) Game *game;

//- (IBAction)back:(id)sender;

@end
