//
//  WelcomeViewController.m
//  Gesjeesde Beesten
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

@synthesize ddPageControl;

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
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    
    
    // Page control taken from
    // http://www.ddeville.me/2011/01/ddpagecontrol-a-custom-uipagecontrol/
    self.ddPageControl = [[DDPageControl alloc] init];
    [ddPageControl setCenter: CGPointMake(self.scrollView.center.x, self.scrollView.center.y + self.scrollView.bounds.size.height/2 - 20)] ;
    [ddPageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    ddPageControl.numberOfPages = 3;
    ddPageControl.currentPage = 0;
    
    [ddPageControl setType: DDPageControlTypeOnEmptyOffFull] ;
    [ddPageControl setOnColor: [UIColor grayColor]];
    [ddPageControl setOffColor: [UIColor grayColor]];
    [ddPageControl setIndicatorDiameter: 10.0f] ;
    [ddPageControl setIndicatorSpace: 15.0f] ;
    [self.view addSubview:ddPageControl];
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
        
        [ddPageControl setCurrentPage:self.pageControl.currentPage];
    }
}

- (IBAction)next {
    if (self.pageControl.currentPage < 2) {
        self.pageControl.currentPage += 1;
        [self scrollPage];
        
        [ddPageControl setCurrentPage:self.pageControl.currentPage];
    }
}

- (IBAction)done {
    [self performSegueWithIdentifier:@"Next" sender:self];
}

#pragma mark -
#pragma mark DDPageControl triggered actions
- (void)pageControlClicked:(id)sender
{
	DDPageControl *thePageControl = (DDPageControl *)sender ;
    
	// we need to scroll to the new index
	[scrollView setContentOffset: CGPointMake(scrollView.bounds.size.width * thePageControl.currentPage, scrollView.contentOffset.y) animated: YES] ;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // From: http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
    
    [ddPageControl setCurrentPage:page];
}

@end
