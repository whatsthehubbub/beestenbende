//
//  MenuViewController.h
//  Gesjeesde Native
//
//  Created by Alper Çuğun on 21/3/12.
//  Copyright (c) 2012 Aardverschuiving Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CreditsViewController.h"

#import "SimpleAudioEngine.h"

@interface MenuViewController : UIViewController <CreditsViewControllerDelegate>

- (IBAction)next:(id)sender;

@end
