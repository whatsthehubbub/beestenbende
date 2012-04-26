//
//  PictureLabelViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "PictureLabelViewController.h"

@interface PictureLabelViewController ()

@end

@implementation PictureLabelViewController

@synthesize featureButton;
@synthesize deleteButton;
@synthesize doneButton;
@synthesize currentImage;
@synthesize overlayImage;

@synthesize headerLabel;
@synthesize currentLabel;

@synthesize currentPictureIndex;

@synthesize currentTeam;
@synthesize game;       

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // Find the current team
    self.currentTeam = game.team1;
    
    if (currentTeam.number != 1) {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    self.currentPictureIndex = 0;
    
#ifdef DEBUG
    doneButton.hidden = NO;
#else
    doneButton.hidden = YES;
#endif
    
    [self displayPicture];
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
    if ([segue.identifier isEqualToString:@"PickFeature"]) {
        FeaturePickerViewController *fpvc = segue.destinationViewController;
        fpvc.delegate = self;
    }
}

-(IBAction)next:(id)sender {
    self.currentPictureIndex = (self.currentPictureIndex+1) % self.currentTeam.featurePictures.count;
    
    [self displayPicture];
}

-(IBAction)previous:(id)sender {
    self.currentPictureIndex -= 1;
    if (self.currentPictureIndex < 0) {
        self.currentPictureIndex += self.currentTeam.featurePictures.count;
    }

    [self displayPicture];
}

-(void)displayPicture {
    if (self.currentTeam.featurePictures.count > 0) {
        FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:self.currentPictureIndex];
        
        [self.currentLabel setText:[NSString stringWithFormat:@"Foto %d van %d", self.currentPictureIndex+1, self.currentTeam.featurePictures.count]];
        
        self.currentImage.image = fp.image;
        
        if (fp.deleted) {
            [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-on.png"] forState:UIControlStateNormal];
            [self.featureButton setTitle:@"Wordt verwijderd" forState:UIControlStateNormal];
        } else {
            [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-off.png"] forState:UIControlStateNormal];
            [self.featureButton setTitle:fp.feature forState:UIControlStateNormal];
        }
    }
}

-(IBAction)deleted:(id)sender {
    FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:self.currentPictureIndex];
    fp.deleted = !fp.deleted;
    
    [self displayPicture];

    if ([currentTeam allFeaturePicturesLabelledOrDeleted]) {
        doneButton.hidden = NO;
    } else {
        doneButton.hidden = YES;
    }
}

-(IBAction)done:(id)sender {
    // TODO done button only appears if all pictures have been labelled / or deleted
    
    // Delete feature pictures marked for deletion
    [self.currentTeam purgeDeletedFeaturePictures];
    
    if (self.currentTeam.number == 1) {
        // Start segue back to this view for other team to take picture
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeam = game.team2;
        self.currentPictureIndex = 0;
        overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
        headerLabel.text = @"Geel benoem je foto's";
        
#ifndef DEBUG
        doneButton.hidden = YES;
#endif

        [self displayPicture];
            
        [UIView commitAnimations];
    } else {
        if (self.game.issue == 1) {
            [self performSegueWithIdentifier:@"LabellingDone" sender:self];
        } else {
            [self performSegueWithIdentifier:@"LabellingDoneSecond" sender:self];
        }
    }
}

#pragma mark - FeaturePickerViewControllerDelegate

-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)feature {
    [self.featureButton setTitle:feature forState:UIControlStateNormal];
    
    FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:self.currentPictureIndex];
    fp.feature = feature;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([currentTeam allFeaturePicturesLabelledOrDeleted]) {
        doneButton.hidden = NO;
    } else {
        doneButton.hidden = YES;
    }
}

@end
