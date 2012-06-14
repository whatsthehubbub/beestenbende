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
    self.featureLabel.text = [NSString stringWithFormat:@"De draak is een %@ want hij heeft: %@.", [class lowercaseString], featurePicture.feature];
    
//    int points = [game pointsForFeaturePicture:featurePicture];

    NSString *explanation = [[game getFeatureWithName:featurePicture.feature] objectForKey:@"Explanation"];
    
    if (currentTeam.dragonClass == 0) {
        // If fish has been chosen
        
        if ([game feature:featurePicture presentInAnimal:@"Fish"]) {
            // And a fish feature
            self.explanationLabel.text = [NSString stringWithFormat:@"Goed want: %@", explanation];
            
            currentTeam.dragonProofs += 1;
            
            // Add the issues points for this team
            currentTeam.points += 10;
        } else {
            // A not fish feature is wrong
            self.explanationLabel.text = [NSString stringWithFormat:@"Fout want: %@", explanation];
        }
    } else {
        // Wrong class alltogether so wrong in any case
        NSDictionary *feature = [game getFeatureWithName:featurePicture.feature];
        
        if  ((currentTeam.dragonClass == 1 && [[feature objectForKey:@"Zoogdier"] intValue] == 2)
             ||
             (currentTeam.dragonClass == 2 && [[feature objectForKey:@"Reptiel"] intValue] == 2)
             ||
             (currentTeam.dragonClass == 3 && [[feature objectForKey:@"Vogel"] intValue] == 2)) {
            // Feature and class do not match
            self.explanationLabel.text = [NSString stringWithFormat:@"Fout want: %@", explanation];
        } else {
            // Feature and class do match, but it is the wrong class
            self.explanationLabel.text = [NSString stringWithFormat:@"Fout want: %@ Maar ik ben geen %@!", explanation, [class lowercaseString]];
        }
    }
    
    
    // Only now we can move over to the next team
    currentTeam.tookFeaturePictures = YES;
    
    // If both teams now have taken feature pictures, reset
    if (currentTeam.tookFeaturePictures && [game otherTeamForTeam:currentTeam].tookFeaturePictures) {
        // We don't have the concept of turns here, it just goes back and forth with the team with the most points starting
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
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"DragonAgain" sender:sender];
}

@end
