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
    
    CGRect frame1;
    frame1.origin.x = self.scrollView.frame.size.width * 0;
    frame1.origin.y = 0;
    frame1.size = self.scrollView.frame.size;
    
    UIView *subview1 = [[UIView alloc] initWithFrame:frame1];
    subview1.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:subview1];
    
    CGRect frame2;
    frame2.origin.x = self.scrollView.frame.size.width;
    frame2.origin.y = 0;
    frame2.size = self.scrollView.frame.size;

    UIView *subview2 = [[UIView alloc] initWithFrame:frame2];
    subview2.backgroundColor = [UIColor greenColor];

    [self.scrollView addSubview:subview2];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
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

- (IBAction)changePage {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // From: http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
}

@end
