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
    UIPageControl *pageControl;
    
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@property (nonatomic, retain) DDPageControl *ddPageControl;

- (IBAction)scrollPage;
- (IBAction)previous;
- (IBAction)next;
- (IBAction)done;

- (void)pageControlClicked:(id)sender;

@end
