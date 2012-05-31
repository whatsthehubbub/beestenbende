//
//  FeaturePictureExplanationViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FirstIssueExplanationViewController.h"

@interface FirstIssueExplanationViewController ()

@end

@implementation FirstIssueExplanationViewController

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
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height);
    
    self.pageControl = [[DDPageControl alloc] init];
    
    [pageControl setCenter: CGPointMake(self.scrollView.center.x, self.scrollView.center.y + self.scrollView.bounds.size.height/2 - 20)] ;
    
    [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    
    pageControl.numberOfPages = 4;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FeatureExample"]) {
        FeatureExampleViewController *fev = segue.destinationViewController;
        fev.delegate = self;
    }
}

- (void)scrollPage:(id)sender {
    pageControlBeingUsed = YES;
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)previous:(id)sender {
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage:self];
    }
    
    self.nextButton.enabled = YES;
    if (self.pageControl.currentPage == 0) {
        self.previousButton.enabled = NO;
    }
}

- (IBAction)next:(id)sender {
    if (self.pageControl.currentPage < 4) {
        self.pageControl.currentPage += 1;
        [self scrollPage:self];
    }
    
    self.previousButton.enabled = YES;
    if (self.pageControl.currentPage == pageControl.numberOfPages-1) {
        self.nextButton.enabled = NO;
    }
}

- (IBAction)done:(id)sender {
    if (NO && /* Short circuit for quicker testing. TODO */ self.pageControl.currentPage != 3) {
        [self next:self];
    } else {
        [self performSegueWithIdentifier:@"Next" sender:self];
    }
}

#pragma mark -
#pragma mark DDPageControl triggered actions
- (void)pageControlClicked:(id)sender
{
	DDPageControl *thePageControl = (DDPageControl *)sender;
    
    self.pageControl.currentPage = thePageControl.currentPage;
    [self scrollPage:sender];
    
    //	// we need to scroll to the new index
    //	[scrollView setContentOffset: CGPointMake(scrollView.bounds.size.width * thePageControl.currentPage, scrollView.contentOffset.y) animated: YES] ;
}

#pragma mark - FeatureExampleViewControllerDelegate

- (void)featureExampleDidBack:(FeatureExampleViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!pageControlBeingUsed) {
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
