//
//  AddressViewController.m
//  NSO-App
//
//  Created by C2 on 2013-11-21.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "AddressViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

// use enums to define data types which will take only some specific values
// makes switch statement more readable
enum TableRowSelected
{
	displayPickerRow = 0,
	createNewContactRow,
	displayContactRow,
};

@interface AddressViewController () < ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate,
ABNewPersonViewControllerDelegate>

@property (nonatomic, assign) ABAddressBookRef addressBook;
@property (nonatomic, strong) NSMutableArray *menuArray;


@end

@implementation AddressViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
  
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    self.menuArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
	self.menuArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    [self.tableView reloadData];
}
// returns the number of contacts in the table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.menuArray count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *contactCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    contactCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    contactCell.textLabel.textAlignment = NSTextAlignmentCenter;
    //displays the title from the Menu.plst
	contactCell.textLabel.text = [[self.menuArray objectAtIndex:indexPath.section] valueForKey:@"title"];
	return contactCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section)
	{
		case displayPickerRow:
			[self showPeoplePickerController];
			break;
		case createNewContactRow:
			[self showNewPersonViewController];
			break;
            
		default:
			[self showPeoplePickerController];
			break;
	}
}

#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.
-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	picker.displayedProperties = displayedItems;
	// Show the picker
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark Create a new person
// allows user to create a new contact
-(void)showNewPersonViewController
{
	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
	
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	return YES;
}

// cancels request of user to display a contact
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ABNewPersonViewControllerDelegate methods
// used when user cancels creating a new user
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark Memory management
- (void)didReceiveMemoryWarning
{
    // Release the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end