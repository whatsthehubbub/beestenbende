//
//  ConvinceFirstAnimalViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 14/6/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPageControl.h"
#import "SimpleAudioEngine.h"

@interface ConvinceFirstAnimalViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) DDPageControl *pageControl;

@property (strong) IBOutlet UIButton *previousButton;
@property (strong) IBOutlet UIButton *nextButton;

@property (assign) BOOL pageControlBeingUsed;

- (void)scrollPage;
- (void)checkButtons;
- (IBAction)previous;
- (IBAction)next;

- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

- (void)pageControlClicked:(id)sender;

@end
