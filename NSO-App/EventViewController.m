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

// Initialize the cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set cell identifier for reusable cells
    static NSString *CellIdentifier = @"myEventCell";
    // cell is of custom type EventCell
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil) {
        // if cell is new then allocate new EventCell
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // retrieves the cells contents
    NSArray *subview = [[cell contentView] subviews];
    // for cell content debugging
    /*
    for (UILabel *a in subview)
        NSLog(@"CELL CONTENT BEFORE LABEL %@",a.text);
     */
    
    //creates a new UILabelView
    // Frame origin is at precalculated coordinates,
    // Frame width is width of cell - 100 pixles so that description fills cell even in landscape mode
    // Frame height is based on the height that the event description would require
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                             70,
                                             cell.frame.size.width-100,
                                                                     [self tableView:tableView heightForLabelAtIndexPath:indexPath])];
    
    // get the event objects from the event array
    Event *event = [eventArray objectAtIndex:[indexPath row]];

    // configure the description label
    description.lineBreakMode = NSLineBreakByWordWrapping; 
    CGSize heightOfLine = [[event eventDescription]sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    // calculates number of lines based on how high one line would be divided by the total height as calculated previously
    description.numberOfLines = ([self tableView:tableView heightForLabelAtIndexPath:indexPath]/heightOfLine.height)+1;
    [description setTextAlignment:NSTextAlignmentLeft];
    [description setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    // set the background to match the tableview
    [description setBackgroundColor:tableView.backgroundColor];
    
    //set the cells text and subtitle
    cell.title.text = event.eventTitle;
    //NSLog(@"Cell title %@",cell.title.text);
    cell.time.text = event.eventTime;
    cell.location.text = event.eventLocation;
    // if the cell is dequed and the description label exists in the cell
    // it needs to be removed from the cell in order for this to function properly
    if([subview count]==4)
        [[subview objectAtIndex:3] removeFromSuperview];
    description.text = event.eventDescription;
    //NSLog(@"Cell description %@", description.text);
    [[cell contentView]addSubview:description];
    // for debug
    /*
    for (UILabel *a in subview)
        NSLog(@"CELL CONTENT AFTER LABEL %@",a.text);
    */
    return cell;
}

// returns the height of a number of lines of a string
-(CGFloat)tableView:(UITableView *)tableView heightForLabelAtIndexPath:(NSIndexPath *)indexPath
{
    // retrieve cell
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myEventCell"];
    // calculate maximum size of description based on cell size
    CGSize maximumSize = CGSizeMake(cell.frame.size.width-100,cell.frame.size.height-70);
    // calculates the size (in pixles) high text would be based on NSStrings sizeWithFont: size: constrainedToSize: lineBreakMode:
    // method, which takes into account font, line break mode, and size of container
    CGSize labelHeightSize = [[[eventArray objectAtIndex:indexPath.row] eventDescription] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f] constrainedToSize:maximumSize lineBreakMode:NSLineBreakByWordWrapping];
    // get the height of the description from the CGSize object
    CGFloat labelHeight = labelHeightSize.height;
    return labelHeight;
}

// returns the height of a cell, called when cell is instantiated
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // returns the height of a cell based on how high the description is
    // plus 80 pixles for buffer
    CGFloat descriptionHeight = [self tableView:tableView heightForLabelAtIndexPath:indexPath];
    return 80 + descriptionHeight;
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
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc]initWithKey:@"eventHours" ascending:YES];
    NSArray *sortList = [[NSArray alloc]initWithObjects:sortDesc,nil];
    [fetchRequest setSortDescriptors:sortList];

    NSError *error = nil;
    eventArray = [context executeFetchRequest:fetchRequest error:&error];
    [[self tableView] reloadData];
}
@end
