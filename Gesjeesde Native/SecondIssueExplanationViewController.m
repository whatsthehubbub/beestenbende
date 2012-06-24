//
//  SecondIssueExplanationViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 23/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "SecondIssueExplanationViewController.h"

@interface SecondIssueExplanationViewController ()

@end

@implementation SecondIssueExplanationViewController

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
	// Do any additional setup after loading the view.
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"d07_vissen_hulp.wav"];
    
    
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

- (void)scrollPage {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    [self checkButtons];
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

- (IBAction)previous:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i05_carouselverderterug.wav"];
    
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage];
    }
}

- (IBAction)next:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i05_carouselverderterug.wav"];
    
    if (self.pageControl.currentPage < 4) {
        self.pageControl.currentPage += 1;
        [self scrollPage];
    }
}

- (IBAction)done:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (NO && /* Short circuit for quicker testing. TODO */ self.pageControl.currentPage != 3) {
        [self next:self];
    } else {
        [self performSegueWithIdentifier:@"Next" sender:self];
    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DDPageControl triggered actions
- (void)pageControlClicked:(id)sender {
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
