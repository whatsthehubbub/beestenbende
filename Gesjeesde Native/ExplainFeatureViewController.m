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
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    

    FeaturePicture *team1fp = [game.team1 featurePictureForTurn:game.turn];
    team1NameLabel.text = [game.team1 getTeamName];
    team1FeatureImage.image = team1fp.image;
    team1FeatureLabel.text = team1fp.feature;
    
    // TODO fix this result
    team1ResultAndExplanationLabel.text = @"result";
    
    FeaturePicture *team2fp = [game.team2 featurePictureForTurn:game.turn];
    
    team2NameLabel.text = [game.team2 getTeamName];
    team2FeatureImage.image = team2fp.image;
    team2FeatureLabel.text = team2fp.feature;
    
    // TODO fix this result
    team2ResultAndExplanationLabel.text = @"result";
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

- (IBAction)scrollPage:(id)sender {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)previous:(id)sender {
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage:sender];
    }
}

- (IBAction)next:(id)sender {
    if (self.pageControl.currentPage < 1) {
        self.pageControl.currentPage += 1;
        
        [self scrollPage:sender];
    }
}

- (IBAction)done:(id)sender {
    [game.team1 purgeUsedFeaturePictures];
    [game.team2 purgeUsedFeaturePictures];
    
    if (game.required > 0 && game.team1.featurePictures.count > 0 && game.team2.featurePictures.count > 0) {
        game.turn += 1;
        
        [self performSegueWithIdentifier:@"AnotherRound" sender:self];
    } else {
        // TODO show something if the proof was completed by a lack of features
        
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"FirstProofComplete" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"SecondProofComplete" sender:sender];
        }
    }
}

@end
