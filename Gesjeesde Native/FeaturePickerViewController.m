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
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.font = [UIFont fontWithName:@"HoeflerText-Regular" size:16.0f];
    
    headerLabel.text = [[self.game.features objectAtIndex:section] objectForKey:@"Group"];
    
    [wrapperView addSubview:headerLabel];
    return wrapperView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.game.features objectAtIndex:section] objectForKey:@"Group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *feature = [[self.game getOrderedFeaturesForGroup:indexPath.section] objectAtIndex:indexPath.row];

    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if ([game feature:[feature objectForKey:@"Label"] presentInAnimal:[game getCorrectAnimalClass]] || [game feature:[feature objectForKey:@"Label"] presentInAnimal:[game getWrongAnimalClass]] || game.issue==3) {
        // This feature is correct for one of two
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        CellIdentifier = @"FeatureCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else {
        CellIdentifier = @"DisabledFeatureCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = [feature objectForKey:@"Label"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *feature = [[self.game getOrderedFeaturesForGroup:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([game feature:[feature objectForKey:@"Label"] presentInAnimal:[game getCorrectAnimalClass]] || [game feature:[feature objectForKey:@"Label"] presentInAnimal:[game getWrongAnimalClass]] || game.issue==3) {
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
