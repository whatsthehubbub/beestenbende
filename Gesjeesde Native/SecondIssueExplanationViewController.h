//
//  SecondIssueExplanationViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 23/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondIssueExplanationViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)scrollPage:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

@end