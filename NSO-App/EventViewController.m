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
@synthesize currentSelectedCell;

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
    static NSString *CellIdentifier = @"myEventCell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    //dynamically allocates the description label height
    cell.description.frame = CGRectMake(cell.description.frame.origin.x,
                                             cell.description.frame.origin.y,
                                             cell.description.frame.size.width,
                                             [self tableView:tableView heightForLabelAtIndexPath:indexPath]);

    // Configure the cell...
    //get the event object
    Event *event = [eventArray objectAtIndex:[indexPath row]];

    //set the cells text and subtitle
    NSLog(@"Event title %@",event.eventTitle);
    cell.title.text = event.eventTitle;
    NSLog(@"Cell title %@",cell.title.text);
    cell.time.text = event.eventTime;
    cell.location.text = event.eventLocation;
    cell.description.text = event.eventDescription;
    // Hopefull this will work
    return cell;
}

// returns the height of a number of lines of a string based on font, font size, width, and wrapping type
-(CGFloat)tableView:(UITableView *)tableView heightForLabelAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize maximumSize = CGSizeMake(280, 10000);
    
    CGSize labelHeightSize = [[[eventArray objectAtIndex:indexPath.row] eventDescription] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f] constrainedToSize:maximumSize lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat labelHeight = labelHeightSize.height;
    return labelHeight;
}

// returns the height of a cell, in this case dependent on description label
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat descriptionHeight = [self tableView:tableView heightForLabelAtIndexPath:indexPath];
    return 75 + descriptionHeight;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITextView *desField = [[UITextView alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
    [desField setTextColor:[UIColor blackColor]];
    [desField setBackgroundColor:[UIColor whiteColor]];
    [desField setTextAlignment:NSTextAlignmentLeft];
    [desField setText:@"This is a test string"];
    UITableViewCell *cell = [[self tableView]cellForRowAtIndexPath:indexPath];
    [[cell contentView] addSubview:desField];
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
