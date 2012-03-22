//
//  TeamNamesViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"

@interface TeamNamesViewController : UIViewController <UITextFieldDelegate> {
    UITextField *team1NameField;
    UITextField *team2NameField;
}

@property (nonatomic, retain) IBOutlet UITextField *team1NameField;
@property (nonatomic, retain) IBOutlet UITextField *team2NameField;

@end
