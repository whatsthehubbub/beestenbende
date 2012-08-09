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
    
    NSString *class = [[game getClasses] objectAtIndex:currentTeam.dragonClass];
        
    if (currentTeam.dragonClass == 0) {
        // If fish has been chosen
        
        NSDictionary *feature = [game getFeatureWithName:featurePicture.feature];
        
        if ([[feature objectForKey:@"Vis"] intValue] == 0) {
            self.explanationLabel.text = [NSString stringWithFormat:@"Uitstekend bewijs! Ik ben een vis, want alleen vissen hebben %@. Kan je nog meer bewijs vinden?", [featurePicture.feature lowercaseString]];
            
            [currentTeam.dragonFeaturesGuessed addObject:[feature objectForKey:@"Label"]];
            currentTeam.points += 10;
        } else if ([[feature objectForKey:@"Vis"] intValue] == 1) {
            self.explanationLabel.text = [NSString stringWithFormat:@"Goed! Ik heb %@. Maar vissen zijn niet de enige groep met dit kenmerk. Kun je iets bij mij vinden dat alleen vissen hebben?", [featurePicture.feature lowercaseString]];
            
            [currentTeam.dragonFeaturesGuessed addObject:[feature objectForKey:@"Label"]];
            currentTeam.points += 5;
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
                self.explanationLabel.text = [NSString stringWithFormat:@"Ja, ik heb inderdaad %@, maar ik ben geen %@. Denk goed na: welke diergroep heeft ook dit kenmerk?", [featurePicture.feature lowercaseString], [class lowercaseString]];
                
                [self eliminateAnimalClass];
            } else {
                // Correct for dragon but not for chosen class
                self.explanationLabel.text = [NSString stringWithFormat:@"Inderdaad, ik heb %@. Maar een %@ heeft dit toch niet! Denk goed na: welke diergroep heeft wel dit kenmerk?", [featurePicture.feature lowercaseString], [class lowercaseString]];
            }
        } else {
            // Correct for neither
            self.explanationLabel.text = [NSString stringWithFormat:@"Haha! Gefopt. Ik heb helemaal geen %@. Kijk nog eens goed.", [[featurePicture featureForNegation] lowercaseString]];
        }
    }
    
    
    // Only now we can move over to the next team
    currentTeam.tookFeaturePictures = YES;
    
    // If both teams now have taken feature pictures, reset
    if (currentTeam.tookFeaturePictures && [game otherTeamForTeam:currentTeam].tookFeaturePictures) {
        // We don't have the concept of turns here, it just goes back and forth with the team with the most points starting
        // TODO check if we still need this
        currentTeam.tookFeaturePictures = NO;
        [game otherTeamForTeam:currentTeam].tookFeaturePictures = NO;
    }
}

- (void)eliminateAnimalClass {
    switch (currentTeam.dragonClass) {
        case 1:
            currentTeam.mammalEliminated = YES;
            break;
        case 2:
            currentTeam.reptileEliminated = YES;
            break;
        case 3:
            currentTeam.birdEliminated = YES;
            break;
        default:
            break;
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
