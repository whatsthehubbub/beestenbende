//
//  WelcomeViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 25/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize scrollView;
@synthesize pageControl;

@synthesize previousButton;
@synthesize nextButton;

@synthesize pageControlBeingUsed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *nautilus = [NSArray arrayWithObjects:@"d01_nautilus_1.wav", @"d01_nautilus_2.wav", @"d01_nautilus_3.wav", @"d01_nautilus_4.wav", @"d01_nautilus_5.wav", @"d01_nautilus_6.wav", @"d01_nautilus_7.wav", @"d01_nautilus_8.wav", @"d01_nautilus_9.wav", @"d01_nautilus_10.wav", @"d01_nautilus_11.wav", nil];
    [[SimpleAudioEngine sharedEngine] playEffect:[nautilus objectAtIndex:arc4random() % [nautilus count]]];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    
    self.pageControl = [[DDPageControl alloc] init];
    
    [pageControl setCenter: CGPointMake(self.scrollView.center.x, self.scrollView.center.y + self.scrollView.bounds.size.height/2 - 20)] ;
    
    [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    
    pageControlBeingUsed = NO;
    
    self.previousButton.enabled = NO;
    
    [self.view addSubview:pageControl];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)scrollPage {
    pageControlBeingUsed = YES;
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)checkButtons {
    self.previousButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if (self.pageControl.currentPage == 0) {
        self.previousButton.enabled = NO;
    }
    
    if (self.pageControl.currentPage == pageControl.numberOfPages-1) {
        self.nextButton.enabled = NO;
    }
}

- (IBAction)previous {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i05_carouselverderterug.wav"];
    
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage];
    }
    
    [self checkButtons];
}

- (IBAction)next {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i05_carouselverderterug.wav"];
    
    if (self.pageControl.currentPage < pageControl.numberOfPages-1) {
        self.pageControl.currentPage += 1;
        
        [self scrollPage];
    }
    
    [self checkButtons];
}

- (IBAction)done {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:self];
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DDPageControl triggered actions
- (void)pageControlClicked:(id)sender
{
	DDPageControl *thePageControl = (DDPageControl *)sender;
    
    self.pageControl.currentPage = thePageControl.currentPage;
    [self scrollPage];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!pageControlBeingUsed) {
        // From: http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        self.pageControl.currentPage = page;
    }
    
    [self checkButtons];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

@end
