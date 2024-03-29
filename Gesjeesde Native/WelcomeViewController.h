//
//  WelcomeViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 25/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPageControl.h"
#import "SimpleAudioEngine.h"

@interface WelcomeViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet DDPageControl *pageControl;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

@property (assign) BOOL pageControlBeingUsed;

- (IBAction)scrollPage;
- (void)checkButtons;

- (IBAction)previous;
- (IBAction)next;
- (IBAction)done;
- (IBAction)back:(id)sender;

- (void)pageControlClicked:(id)sender;

@end
