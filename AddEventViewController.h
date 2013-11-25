//
//  AddEventViewController.h
//  NSO-App
//
//  Created by C2 on 2013-11-24.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (BOOL)disablesAutomaticKeyboardDismissal;


@end
