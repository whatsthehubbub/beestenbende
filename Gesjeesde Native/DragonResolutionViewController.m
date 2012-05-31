//
//  DragonResolutionViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonResolutionViewController.h"

@interface DragonResolutionViewController ()

@end

@implementation DragonResolutionViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize pageControlBeingUsed;

@synthesize previousButton;
@synthesize nextButton;

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
	// Do any additional setup after loading the view.
    
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

- (void)scrollPage {
    pageControlBeingUsed = YES;
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)previous {
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage];
    }
    
    self.nextButton.enabled = YES;
    if (self.pageControl.currentPage == 0) {
        self.previousButton.enabled = NO;
    }
}

- (IBAction)next {
    if (self.pageControl.currentPage < pageControl.numberOfPages-1) {
        self.pageControl.currentPage += 1;
        
        [self scrollPage];
    }
    
    self.previousButton.enabled = YES;
    if (self.pageControl.currentPage == pageControl.numberOfPages-1) {
        self.nextButton.enabled = NO;
    }
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
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

@end
