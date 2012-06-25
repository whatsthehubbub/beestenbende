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
        
    if (currentTeam.dragonClass == 0) {
        // If fish has been chosen
        
        NSDictionary *feature = [game getFeatureWithName:featurePicture.feature];
        
        if ([[feature objectForKey:@"Vis"] intValue] == 0) {
            self.explanationLabel.text = [NSString stringWithFormat:@"Uitstekend bewijs! Ik ben een vis, want alleen vissen hebben %@. Kan je nog meer bewijs vinden? We hebben nog %d bewijs/zen nodig om iedereen te overtuigen.", [featurePicture.feature lowercaseString], 3-currentTeam.dragonProofs];
            
            currentTeam.dragonProofs += 1;
            currentTeam.points += 10;
        } else if ([[feature objectForKey:@"Vis"] intValue] == 1) {
            self.explanationLabel.text = [NSString stringWithFormat:@"Goed! Ik heb %@. Ik ben een vis! En vissen hebben %@. Maar wij zijn niet de enige groep met %@. Zie je ook iets aan mij dat alleen vissen hebben? We hebben nog %d bewijs/zen nodig om iedereen te overtuigen.", [featurePicture.feature lowercaseString], [featurePicture.feature lowercaseString], [featurePicture.feature lowercaseString], 3-currentTeam.dragonProofs];
            
            currentTeam.dragonProofs += 1;
            currentTeam.points += 10;
        } else {
            self.explanationLabel.text = [NSString stringWithFormat:@"Huh? Heb jij wel eens een vis gezien met %@? Daar geloof ik niets van! Kijk nog eens goed.", [featurePicture.feature lowercaseString]];
        }
    } else {
        // Wrong class alltogether so wrong in any case
        
        if ([game feature:featurePicture.feature presentInAnimal:@"Vis"]) {
            if ((currentTeam.dragonClass == 1 && [game feature:featurePicture.feature presentInAnimal:@"Zoogdier"]) || 
                (currentTeam.dragonClass == 2 && [game feature:featurePicture.feature presentInAnimal:@"Reptiel"]) ||
                (currentTeam.dragonClass == 3 && [game feature:featurePicture.feature presentInAnimal:@"Vogel"])) {
                // Correct for dragon and for chosen class
                self.explanationLabel.text = [NSString stringWithFormat:@"Ja, ik heb inderdaad %@, maar ik ben geen %@. Denk goed na: welke diergroep heeft ook %@?", [featurePicture.feature lowercaseString], [class lowercaseString], [featurePicture.feature lowercaseString]];
            } else {
                // Correct for dragon but not for chosen class
                self.explanationLabel.text = [NSString stringWithFormat:@"Inderdaad, ik heb %@. Maar een %@ heeft toch geen %@! Denk goed na: welke diergroep heeft wel %@?", [featurePicture.feature lowercaseString], [class lowercaseString], [featurePicture.feature lowercaseString], [featurePicture.feature lowercaseString]];
            }
        } else {
            // Correct for neither
            self.explanationLabel.text = [NSString stringWithFormat:@"Haha! Gefopt. Ik heb helemaal geen %@. Kijk nog eens goed.", [featurePicture.feature lowercaseString]];
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
