//
//  WelcomeViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 25/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage;

@end
