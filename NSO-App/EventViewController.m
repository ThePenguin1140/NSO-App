//
//  EventViewController.m
//  NSO-App
//
//  Created by CS212 on 13-11-20.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "EventViewController.h"
#define COMMENT_LABEL_WIDTH 230
#define COMMENT_LABEL_MIN_HEIGHT 65
#define COMMENT_LABEL_PADDING 10
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    if(currentSelectedCell == indexPath.row)
    {
        return [self getLabelHeightForIndex:indexPath.row] + COMMENT_LABEL_PADDING * 2;
    }
    else {
        return COMMENT_LABEL_MIN_HEIGHT + COMMENT_LABEL_PADDING * 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"EventCell";
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (EventCell *)currentObject;
                break;
            }
        }
    }
    if([cell isKindOfClass:[UITableViewCell class]]){
        cell = (EventCell *)cell;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    Event *event = [eventArray objectAtIndex:indexPath.row];
    UILabel *timeAndLocationL = [[UILabel alloc]init];
    timeAndLocationL.text = [NSString stringWithFormat:@"%@ | %@",event.eventTime,event.eventLocation];
    //cell.titleLabel.text = event.eventTitle;
    //cell.subtitleLabel = timeAndLocationL;
    NSLog(@"%@",timeAndLocationL);
   // cell.descriptionLabel.text = event.eventDescription;
    
    //If this is the selected index then calculate the height of the cell based on the amount of text we have
    if(currentSelectedCell == indexPath.row)
    {
        CGFloat labelHeight = [self getLabelHeightForIndex:indexPath.row];
        
        cell.descriptionLabel.frame = CGRectMake(cell.descriptionLabel.frame.origin.x,
                                                 cell.descriptionLabel.frame.origin.y,
                                                 cell.descriptionLabel.frame.size.width,
                                                 labelHeight);
    }
    else {
        
        //Otherwise just return the minimum height for the label.
        cell.descriptionLabel.frame = CGRectMake(cell.descriptionLabel.frame.origin.x,
                                                 cell.descriptionLabel.frame.origin.y,
                                                 cell.descriptionLabel.frame.size.width,
                                                 COMMENT_LABEL_MIN_HEIGHT);
    }
    
    //cell.descriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    //cell.descriptionLabel.text = [[eventArray objectAtIndex:indexPath.row] eventDescription];
    
    return cell;

    */
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil) {
        cell = [[UITableViewCell alloc] init];
        //[[cell detailTextLabel] setLineBreakMode: NSLineBreakByWordWrapping];
        //[[cell detailTextLabel] setNumberOfLines:3];
    }
    
    // Configure the cell...
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    //get the event object
    Event *event = [eventArray objectAtIndex:[indexPath row]];

    //set the cells text and subtitle
    [[cell textLabel] setText:[event eventTitle]];
    // Hopefull this will work
    // if it does the subtitle will display the time and the location
    NSString *subtitle=[NSString stringWithFormat:@"%@\n%@\n%@",[event eventTime],[event eventLocation],[event eventDescription]];
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

//This just a convenience function to get the height of the label based on the comment text
-(CGFloat)getLabelHeightForIndex:(NSInteger)index
{
    CGSize maximumSize = CGSizeMake(COMMENT_LABEL_WIDTH, 10000);
    NSString *textBlock = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",[[eventArray objectAtIndex:index]eventTitle],[[eventArray objectAtIndex:index]eventTime],[[eventArray objectAtIndex:index]eventLocation],[[eventArray objectAtIndex:index]eventDescription]];
    CGSize labelHeighSize = [textBlock sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f] constrainedToSize:maximumSize lineBreakMode:NSLineBreakByWordWrapping];
    return labelHeighSize.height;
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
