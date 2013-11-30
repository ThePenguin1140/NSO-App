//
//  AddAlarmViewController.m
//  NSO-App
//
//  Created by C2 on 2013-11-25.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "AddAlarmViewController.h"

@interface AddAlarmViewController ()

@end

@implementation AddAlarmViewController

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
    
    self.description.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// saves an alarm
- (IBAction)save:(id)sender {
    [self.description resignFirstResponder];
    
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    // displays the entered description
    localNotification.alertBody = self.description.text;
    // sets the timezone
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Dismiss the view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
// cancels adding an alarm
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
// resigns first responder so the keyboard disappears 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.description resignFirstResponder];
    return NO;
}
@end
