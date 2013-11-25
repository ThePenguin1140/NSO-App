//
//  EventViewController.m
//  NSO-App
//
//  Created by CS212 on 13-11-20.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

@synthesize eventArray;
@synthesize dayID;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:@"NSO Events"];
    [self loadTableData];
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [eventArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    //get the event object
    Event *event = [eventArray objectAtIndex:[indexPath row]];

    //set the cells text and subtitle
    [[cell textLabel] setText:[event eventTitle]];
    // Hopefull this will work
    // if it does the subtitle will display the time and the location
    NSString *subtitle=[NSString stringWithFormat:@"%@\t%@\n%@",[event eventTime],[event eventLocation],[event eventDescription]];
    [[cell detailTextLabel] setText:subtitle];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

// fetch and reload table
- (void) loadTableData {
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];

    //build fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day == %@",[context objectWithID:[self dayID]]];
    [fetchRequest setPredicate:predicate];

    //add sort desc
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc]initWithKey:@"eventTime" ascending:YES];
    NSArray *sortList = [[NSArray alloc]initWithObjects:sortDesc,nil];
    [fetchRequest setSortDescriptors:sortList];

    NSError *error = nil;
    eventArray = [context executeFetchRequest:fetchRequest error:&error];
    [[self tableView] reloadData];
}
@end
