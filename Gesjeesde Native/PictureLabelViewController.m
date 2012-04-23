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
@synthesize currentImage;

@synthesize teamLabel;
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
    
    self.currentTeam = game.team1;
    [self.teamLabel setText:[NSString stringWithFormat:@"Team %@", self.currentTeam.getTeamName]];
    
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
        FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:currentPictureIndex];
        
        self.currentImage.image = fp.image;
        if (fp.deleted) {
            [self.featureButton setTitle:@"Wordt verwijderd" forState:UIControlStateNormal];
        } else {
            [self.featureButton setTitle:fp.feature forState:UIControlStateNormal];
        }
        
        [self.currentLabel setText:[NSString stringWithFormat:@"Foto %d van %d", self.currentPictureIndex+1, self.currentTeam.featurePictures.count]];
        
        if (fp.deleted) {
            [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-on.png"] forState:UIControlStateNormal];
        } else {
            [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-off.png"] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)deleted:(id)sender {
    FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:currentPictureIndex];
    fp.deleted = !fp.deleted;
    
    if (fp.deleted) {
        fp.feature = @"";
        [self.featureButton setTitle:@"Wordt verwijderd" forState:UIControlStateNormal];
        
        [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-on.png"] forState:UIControlStateNormal];
    } else {
        [self.featureButton setTitle:@"" forState:UIControlStateNormal];
        
        [self.deleteButton setImage:[UIImage imageNamed:@"toggle-trash-off.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)done:(id)sender {
    // TODO done button only appears if all pictures have been labelled / or deleted
    
    // Delete feature pictures marked for deletion
    [self.currentTeam purgeDeletedFeaturePictures];
    
    if (self.currentTeam.number == 1) {
        //
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
    
    FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:currentPictureIndex];
    fp.feature = feature;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
