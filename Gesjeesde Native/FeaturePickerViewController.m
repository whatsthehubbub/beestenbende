//
//  FeaturePickerViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePickerViewController.h"

@interface FeaturePickerViewController ()

@end

@implementation FeaturePickerViewController {
    NSUInteger selectedIndex;
}

@synthesize game;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    selectedIndex = 0;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)disableFeature:(NSString *)feature {
    BOOL disable = NO;
    Team *currentTeam = [game getCurrentTeam];
    
    // For the dragon disable a feature if it has been used by that team already
    if (game.issue == 3 && [currentTeam.dragonFeaturesGuessed containsObject:feature]) {
        disable = YES;
    }
    
    if (game.issue == 1 || game.issue == 2) {
        // Disable a cell only if it does not fit
        if ([feature isEqualToString:@"een ei"] ||
            [game feature:feature presentInAnimal:[game getCorrectAnimalClass]] ||
            [game feature:feature presentInAnimal:[game getWrongAnimalClass]]) {
            
        } else {
            disable = YES;
        }
        
        // Disable a cell if the feature has already been used
        if ([game featureUsedSuccesfully:feature]) {
            disable = YES;
        }
    }
    
    return disable;
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.game.features.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.game.features objectAtIndex:section] objectForKey:@"Features"] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // http://www.iphonedevsdk.com/forum/iphone-sdk-development/5172-font-size-color-tableview-header.html
//    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];

    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    
    headerLabel.font = [UIFont fontWithName:@"LindenHill" size:50.0];
    
    headerLabel.text = [[self.game.features objectAtIndex:section] objectForKey:@"Group"];
    
//    [wrapperView addSubview:headerLabel];
//    return wrapperView;
    
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.game.features objectAtIndex:section] objectForKey:@"Group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *feature = [[self.game getOrderedFeaturesForGroup:indexPath.section] objectAtIndex:indexPath.row];

    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    // Bizarre code needed to figure out which team is on during issue 3, will only be used during issue 3
//    Team *currentTeam = [game getCurrentTeam];
//    
//    NSLog(@"Current team %@", currentTeam.dragonFeaturesGuessed);
//    NSLog(@"Current feature %@", [feature objectForKey:@"Label"]);
//    NSLog(@"Boolean: %d", ![currentTeam.dragonFeaturesGuessed containsObject:[feature objectForKey:@"Label"]]);
    
    BOOL disableCell = [self disableFeature:[feature objectForKey:@"Label"]];
    
    if (!disableCell) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        CellIdentifier = @"FeatureCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else {
//        NSLog(@"Cell disabled");
        CellIdentifier = @"DisabledFeatureCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
        CGFloat fontSize = cell.textLabel.font.pointSize;
        cell.textLabel.font = [UIFont fontWithName:@"LindenHill" size:fontSize];
    }
    
    cell.textLabel.text = [feature objectForKey:@"Label"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *feature = [[self.game getOrderedFeaturesForGroup:indexPath.section] objectAtIndex:indexPath.row];
    
    BOOL disable = [self disableFeature:[feature objectForKey:@"Label"]];
    
    // TODO refactor this twice used if to a method on game
    if (!disable) {
        // This feature is correct for one of two animals, so this cell is selectable
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"i11_menu-select-close.wav"];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (selectedIndex != NSNotFound) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:indexPath.section]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        selectedIndex = indexPath.row;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.delegate featurePickerViewController:self didSelectFeature:[feature objectForKey:@"Label"]];
    }
}

@end
