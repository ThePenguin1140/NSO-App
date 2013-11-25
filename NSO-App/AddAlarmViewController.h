//
//  AddAlarmViewController.h
//  NSO-App
//
//  Created by C2 on 2013-11-25.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
