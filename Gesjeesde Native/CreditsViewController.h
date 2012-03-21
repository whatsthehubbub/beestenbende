//
//  CreditsViewController.h
//  Gesjeesde Native
//
//  Created by Alper Çuğun on 21/3/12.
//  Copyright (c) 2012 Aardverschuiving Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreditsViewController;

@protocol CreditsViewControllerDelegate <NSObject>

-(void)creditsViewControllerDidBack:(CreditsViewController *)controller;

@end

@interface CreditsViewController : UIViewController

@property (nonatomic, weak) id <CreditsViewControllerDelegate> delegate;

- (IBAction)back:(id)sender;

@end
