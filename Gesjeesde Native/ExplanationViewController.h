//
//  ExplanationViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/6/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SimpleAudioEngine.h"
#import "DDPageControl.h"


@interface ExplanationViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (assign) BOOL pageControlBeingUsed;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

- (void)scrollPage;
- (void)checkButtons;

- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

@end
