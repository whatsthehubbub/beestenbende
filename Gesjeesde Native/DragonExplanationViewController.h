//
//  DragonExplanationViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 29/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"

@interface DragonExplanationViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (assign) BOOL pageControlBeingUsed;

- (void)scrollPage;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;

- (void)pageControlClicked:(id)sender;

@end
