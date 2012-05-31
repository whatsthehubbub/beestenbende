//
//  SecondIssueExplanationViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 23/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPageControl.h"

@interface SecondIssueExplanationViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

@property (assign) BOOL pageControlBeingUsed;

- (void)scrollPage;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

@end
