//
//  ExplainFeatureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ExplainFeatureViewController.h"

@interface ExplainFeatureViewController ()

@end

@implementation ExplainFeatureViewController

@synthesize game;

@synthesize feature;

@synthesize scrollView;

@synthesize pageControl;
@synthesize pageControlBeingUsed;

@synthesize team1NameLabel;
@synthesize team1FeatureImage;
@synthesize team1FeatureLabel;
@synthesize team1ResultAndExplanationLabel;

@synthesize team2NameLabel;
@synthesize team2FeatureImage;
@synthesize team2FeatureLabel;
@synthesize team2ResultAndExplanationLabel;

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
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    
    self.pageControl = [[DDPageControl alloc] init];
    
    [pageControl setCenter: CGPointMake(self.scrollView.center.x, self.scrollView.center.y + self.scrollView.bounds.size.height/2 - 20)] ;
    
    [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    
    pageControlBeingUsed = NO;
    
    [self.view addSubview:pageControl];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    

    FeaturePicture *team1fp = [game.team1 featurePictureForTurn:game.turn];
    team1NameLabel.text = [game.team1 getTeamName];
    team1FeatureImage.image = team1fp.image;
    team1FeatureLabel.text = team1fp.feature;
    
    // Lots of code to generate the result
    NSString *team1Explanation = [[game getFeatureWithName:team1fp.feature] objectForKey:@"Explanation"];
    int team1Points = [game pointsForFeaturePicture:team1fp];
    
    NSString *team1Result = @"Fout";
    if (abs(team1Points) == 5) team1Result = @"Goed"; else if (team1Points == 10) team1Result = @"Uniek"; 
    team1ResultAndExplanationLabel.text = [NSString stringWithFormat:@"%@ want: %@", team1Result, team1Explanation];
    
    // Do exactly the same thing for team 2
    FeaturePicture *team2fp = [game.team2 featurePictureForTurn:game.turn];
    
    team2NameLabel.text = [game.team2 getTeamName];
    team2FeatureImage.image = team2fp.image;
    team2FeatureLabel.text = team2fp.feature;
    
    // Lots of code to generate the result
    NSString *team2Explanation = [[game getFeatureWithName:team2fp.feature] objectForKey:@"Explanation"];
    int team2Points = [game pointsForFeaturePicture:team2fp];
    
    NSString *team2Result = @"Fout";
    if (abs(team2Points) == 5) team2Result = @"Goed"; else if (team2Points == 10) team2Result = @"Uniek"; 
    team2ResultAndExplanationLabel.text = [NSString stringWithFormat:@"%@ want: %@", team2Result, team2Explanation];
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

- (IBAction)previous:(id)sender {
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage];
    }
}

- (IBAction)next:(id)sender {
    if (self.pageControl.currentPage < self.pageControl.numberOfPages-1) {
        self.pageControl.currentPage += 1;
        
        [self scrollPage];
    }
}

- (IBAction)done:(id)sender {
    [game.team1 purgeUsedFeaturePictures];
    [game.team2 purgeUsedFeaturePictures];
    
    if (game.required > 0 && game.team1.featurePictures.count > 0 && game.team2.featurePictures.count > 0) {
        game.turn += 1;
        
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"AnotherRoundFirstIssue" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"AnotherRoundSecondIssue" sender:sender];
        }
    } else {
        // TODO show something if the proof was completed by a lack of features
        
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"FirstProofComplete" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"SecondProofComplete" sender:sender];
        }
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
