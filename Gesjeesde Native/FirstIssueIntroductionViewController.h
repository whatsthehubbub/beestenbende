//
//  FirstIssueIntroductionViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstIssueIntroductionViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)scrollPage;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;

- (IBAction)done:(id)sender;

@end
