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
    
//    CGRect frame1;
//    frame1.origin.x = self.scrollView.frame.size.width * 0;
//    frame1.origin.y = 0;
//    frame1.size = self.scrollView.frame.size;
//    
//    UIView *subview1 = [[UIView alloc] initWithFrame:frame1];
//    subview1.backgroundColor = [UIColor redColor];
//    
//    [self.scrollView addSubview:subview1];

//    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
//    
//    [textLabel1 setText:@"Paniek! Een paar gesjeesde beesten zetten hier alles op z’n kop. Ze zijn in de war en weten niet meer of ze vis, vogel, zoogdier of reptiel zijn. Hulp nodig dus! Ook van de papa’s, mama’s, opa’s en oma’s."];
//    
//    [self.scrollView addSubview:textLabel1];
//    
//    CGRect frame2;
//    frame2.origin.x = self.scrollView.frame.size.width;
//    frame2.origin.y = 0;
//    frame2.size = self.scrollView.frame.size;
//
//    UIView *subview2 = [[UIView alloc] initWithFrame:frame2];
//    subview2.backgroundColor = [UIColor greenColor];
//
//    [self.scrollView addSubview:subview2];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
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
    }
}

- (IBAction)next {
    if (self.pageControl.currentPage < 2) {
        self.pageControl.currentPage += 1;
        [self scrollPage];
    }
}

- (IBAction)done {
    [self performSegueWithIdentifier:@"Next" sender:self];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // From: http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
}

@end
