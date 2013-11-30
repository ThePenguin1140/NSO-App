//
//  AddAlarmViewController.h
//  NSO-App
//
//  Created by C2 on 2013-11-25.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *description;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
