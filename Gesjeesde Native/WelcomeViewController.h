//
//  WelcomeViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 25/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPageControl.h"

@interface WelcomeViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet DDPageControl *pageControl;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

@property (assign) BOOL pageControlBeingUsed;

- (IBAction)scrollPage;
- (IBAction)previous;
- (IBAction)next;
- (IBAction)done;

- (void)pageControlClicked:(id)sender;

@end
