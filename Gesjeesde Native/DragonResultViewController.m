//
//  DragonResultViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonResultViewController.h"

@interface DragonResultViewController ()

@end

@implementation DragonResultViewController

@synthesize game;
@synthesize currentTeam;

@synthesize classLabel;

@synthesize teamOverlay;

@synthesize featureImage;
@synthesize featureLabel;
@synthesize explanationLabel;

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
    
    // Get the team that has to take the picture
    currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    if (currentTeam.number != 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    // Check the result
    FeaturePicture *featurePicture = currentTeam.featurePictures.lastObject;
    
    self.featureImage.image = featurePicture.image;
    
    NSString *class = [[game getClasses] objectAtIndex:currentTeam.dragonClass];
    self.featureLabel.text = [NSString stringWithFormat:@"De draak is een %@ want hij heeft %@.", class, featurePicture.feature];
    
    int points = [game pointsForFeaturePicture:featurePicture];
        
    NSString *explanation = [[game getFeatureWithName:featurePicture.feature] objectForKey:@"Explanation"];
    
    if (currentTeam.dragonClass == 0) {
        if (points > 0) {
            // Correct feature
            self.explanationLabel.text = [NSString stringWithFormat:@"Goed want: %@", explanation];
            
            currentTeam.dragonProofs += 1;
            
            // Add the issues points for this team
            currentTeam.points += 10;
        } else {
            // Wrong feature
            self.explanationLabel.text = [NSString stringWithFormat:@"Fout want: %@", explanation];
        }
    } else {
        // Wrong class alltogether so plain wrong
        self.explanationLabel.text = [NSString stringWithFormat:@"Fout want: %@ Maar ik ben geen %@!", explanation, class];
    }
    
    
    // Only now we can move over to the next team
    currentTeam.tookFeaturePictures = YES;
    
    // If both teams now have taken feature pictures, reset
    if (currentTeam.tookFeaturePictures && [game otherTeamForTeam:currentTeam].tookFeaturePictures) {
        // Increment turn so the other team can start
        game.turn += 1;
        
        currentTeam.tookFeaturePictures = NO;
        [game otherTeamForTeam:currentTeam].tookFeaturePictures = NO;
    }
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

- (IBAction)done:(id)sender {
    [self performSegueWithIdentifier:@"DragonAgain" sender:sender];
}

@end
