//
//  DragonResolutionViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPageControl.h"

@interface DragonResolutionViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain)  DDPageControl *pageControl;

@property (assign) BOOL pageControlBeingUsed;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

- (void)scrollPage;
- (IBAction)previous;
- (IBAction)next;

- (void)pageControlClicked:(id)sender;

@end
