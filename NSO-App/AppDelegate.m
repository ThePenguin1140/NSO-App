//
//  AppDelegate.m
//  NSO-App
//
//  Created by CS212 on 13-11-06.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "AppDelegate.h"
#import "Day.h"
#import "Event.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self create];
    
    // Handle launching from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
    }

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)create {
    
    //Get context
    NSManagedObjectContext *context = [self managedObjectContext];
    if(!context){
        NSLog(@"Context Error: Context not loaded");
        return;
    }
    //create and onvifgure the day entity and set it's attributes
    Day *sat1 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [sat1 setName:@"Saturday"];
    [sat1 setDate:@"September 1st"];
    Day *sun2 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [sun2 setName:@"Sunday"];
    [sun2 setDate:@"September 2nd"];
    Day *mon3 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [mon3 setName:@"Monday"];
    [mon3 setDate:@"September 3d"];
    Day *tue4 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [tue4 setName:@"Tuesday"];
    [tue4 setDate:@"September 4th"];
    Day *wed5 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [wed5 setName:@"Wednesday"];
    [wed5 setDate:@"September 5th"];
    Day *thu6 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [thu6 setName:@"Thursday"];
    [thu6 setDate:@"September 6th"];
    Day *sat8 = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
    [sat8 setName:@"Saturday"];
    [sat8 setDate:@"September 8th"];
    
    
    //create and configure the event entity and set it's attributes
    //generate events 34
    Event *event[34];
    for(int i=0;i<34;i++){
        event[i]= [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    }
    for(int i=0;i<34;i++){
        [event[i] setEventDescription:@""];
        [event[i] setEventLocation:@""];
        [event[i] setEventTime:@""];
        [event[i] setEventTitle:@""];
    }
    int offset=0;
    for(int i=0;i<5;i++){
        [event[i+offset] setDay:sat1];
        [sat1 addEventObject:event[i+offset]];
    }
    offset+=5;
    for(int i=0;i<7;i++){
        [event[i+offset] setDay:sun2];
        [sun2 addEventObject:event[i+offset]];
    }
    offset+=7;
    for(int i=0;i<8;i++){
        [event[i+offset] setDay:mon3];
        [mon3 addEventObject:event[i+offset]];
    }
    offset+=8;
    for(int i=0;i<5;i++){
        [event[i+offset] setDay:tue4];
        [tue4 addEventObject:event[i+offset]];
    }
    offset+=5;
    for(int i=0;i<5;i++){
        [event[i+offset] setDay:wed5];
        [wed5 addEventObject:event[i+offset]];
    }
    offset+=5;
    for(int i=0;i<1;i++){
        [event[i+offset]setDay:thu6];
        [thu6 addEventObject:event[i+offset]];
    }
    offset+=1;
    for(int i=0;i<3;i++){
        [event[i+offset]setDay:sat8];
        [sat8 addEventObject:event[i+offset]];
    }
    [event[0] setEventTime:@"9 am–4 pm"];
    [event[0] setEventLocation:@"McDougall Hall 246"];
    [event[0] setEventTitle:@"NSO Pack Pick-Up/Registration"];
    [event[0] setEventDescription:@"Come and pick up your NSO pack. It has lots of goodies and information inside. Meet the leaders and get your schedule for the week! "];
    [event[1] setEventTime:@"4–6 pm "];
    [event[1] setEventLocation:@"Residence Floors & McDougall Hall 242"];
    [event[1] setEventTitle:@"Residence & non-Residence"];
    [event[1] setEventDescription:@"information meetings"];
    [event[2] setEventTime:@"6–8 pm "];
    [event[2] setEventLocation:@"Meet in the Quadrangle "];
    [event[2] setEventTitle:@"Team Meetings & Flag Making "];
    [event[2] setEventDescription:@"Meet your teammates and plan how you will win the Game of NSO 2012! "];
    [event[3] setEventTime:@"8-10:30pm"];
    [event[3] setEventLocation:@"UPEI Turf Field"];
    [event[3] setEventTitle:@"NSO 2012 Kick-Off and PlayFair"];
    [event[3] setEventDescription:@" "];
    [event[4] setEventTime:@"10:30 pm - 12:30 am"];
    [event[4] setEventLocation:@"CARI Pool"];
    [event[4] setEventTitle:@"POOL Part with DJ Alex"];
    [event[4] setEventDescription:@"  "];
    [event[5] setEventTime:@"8:30–10 am"];
    [event[5] setEventLocation:@"UPEI Chaplaincy Centre"];
    [event[5] setEventTitle:@"Chaplaincy Centre Breakfast"];
    [event[5] setEventDescription:@"Come enjoy pancakes, sausages, and timespent with friends."];
    [event[6] setEventTime:@"10–10:30 am"];
    [event[6] setEventLocation:@"Meet in the Quadrangle"];
    [event[6] setEventTitle:@"Team Meetings"];
    [event[6] setEventDescription:@"Meet with your team to discuss the events forthe day and any questions you may have."];
    [event[7] setEventTime:@"10:30 am–12:10 pm"];
    [event[7] setEventLocation:@"McDougall Hall"];
    [event[7] setEventTitle:@"UPEI 101: Sessions A, B, C, D"];
    [event[7] setEventDescription:@""];
    [event[8] setEventTime:@"12:10 –12:30 pm"];
    [event[8] setEventLocation:@"McDougall Hall"];
    [event[8] setEventTitle:@"Team Challenge"];
    [event[8] setEventDescription:@"Is your team the fastest, smartest, andthe winners of this team challenge?"];
    [event[9] setEventTime:@"12:30–4 pm"];
    [event[9] setEventLocation:@"Residence Fields"];
    [event[9] setEventTitle:@"NSO 2012 Picnic"];
    [event[9] setEventDescription:@"Enjoy subs sponsored by Quiznos, inflatablegames, games, prizes, and more.There will be water games at this event"];
    [event[10] setEventTime:@"6 pm"];
    [event[10] setEventLocation:@"UPEI Chaplaincy Centre"];
    [event[10] setEventTitle:@"Mass"];
    [event[10] setEventDescription:@""];
    [event[11] setEventTime:@"9 pm–2 am"];
    [event[11] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[11] setEventTitle:@"Dance Party"];
    [event[11] setEventDescription:@"Dance ‘til you drop to the tunes ofDJ Ray Ray and DJ Bagera."];
    [event[12] setEventTime:@"9–9:30 am"];
    [event[12] setEventLocation:@"Meet in the Quadrangle "];
    [event[12] setEventTitle:@"Team Meetings"];
    [event[12] setEventDescription:@"Meet with your team to discuss the events for the day and any questions you may have."];
    [event[13] setEventTime:@"9:30 am–12 pm"];
    [event[13] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[13] setEventTitle:@"NSO Scavenger hunt"];
    [event[13] setEventDescription:@"Not just a campus tour but a lot of fun as well. "];
    [event[14] setEventTime:@"12–1:30 pm  "];
    [event[14] setEventLocation:@"W.A. Murphy Student Centre "];
    [event[14] setEventTitle:@"BBQ Sponsored By UPEISU"];
    [event[14] setEventDescription:@"Meet the UPEISU executive and councillors and have some yummy treats as well. "];
    [event[15] setEventTime:@"1:30–3 pm  "];
    [event[15] setEventLocation:@"W.A. Murphy Student Centre "];
    [event[15] setEventTitle:@"Drew Dudley"];
    [event[15] setEventDescription:@"Funny, inspiring, and loves penguins—come listen to the wonderful words of Drew Dudley! "];
    [event[16] setEventTime:@"3–3:30 pm  "];
    [event[16] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[16] setEventTitle:@"Bling Bling! "];
    [event[16] setEventDescription:@"How much $$ can your team raise for Shinerama in 30 minutes? You’re about to find out! "];
    [event[17] setEventTime:@"3:30–4:30 pm"];
    [event[17] setEventLocation:@"McDougall Hall 242 "];
    [event[17] setEventTitle:@"UPEI 101: Sessions E & F"];
    [event[17] setEventDescription:@""];
    [event[18] setEventTime:@"4:30–5:30 pm  "];
    [event[18] setEventLocation:@"Webster Centre in the Robertson Library"];
    [event[18] setEventTitle:@"Webster Center Welcome! "];
    [event[18] setEventDescription:@"Find out what services the Webster Centre offers—plus prizes, food, and games to play."];
    [event[19] setEventTime:@"8–11:30 pm  "];
    [event[19] setEventLocation:@"The Wave "];
    [event[19] setEventTitle:@"Night Of Sounds"];
    [event[19] setEventDescription:@"Karaoke and good times"];
    [event[20] setEventTime:@"9–9:30 am"];
    [event[20] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[20] setEventTitle:@"Team Meetings"];
    [event[20] setEventDescription:@"Find out where will you be for the day,what will your team be doing, and how will you get to your location? "];
    [event[21] setEventTime:@"9:30 am–6:30 pm"];
    [event[21] setEventLocation:@"Charlottetown"];
    [event[21] setEventTitle:@"Shine Day!"];
    [event[21] setEventDescription:@"Raise ALL the money for cystic fibrosis research and treatment. "];
    [event[22] setEventTime:@"9–11 pm"];
    [event[22] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[22] setEventTitle:@"Damien the Hypnotist"];
    [event[22] setEventDescription:@"He will amaze you. Donations to Shinerama will be collected at the door "];
    [event[23] setEventTime:@"7:30–8 am"];
    [event[23] setEventLocation:@"W.A. Murphy Student Centre"];
    [event[23] setEventTitle:@"Shine Day Registration"];
    [event[23] setEventDescription:@"Get your Shiner Kit & have some breakfast."];
    [event[24] setEventTime:@"8-9am"];
    [event[24] setEventLocation:@"W.A. Murphy Sudent Centre"];
    [event[24] setEventTitle:@"Shine Day Kick-Off"];
    [event[24] setEventDescription:@"Discover what Shinerama is all about.Thank you for making a differencein the lives of those with cystic fibrosis!Please wear orange & blue!"];
    [event[25] setEventTime:@"4-7pm"];
    [event[25] setEventLocation:@"Duffy 135"];
    [event[25] setEventTitle:@"Faculty Welcome Ceremonies"];
    [event[25] setEventDescription:@"Science"];
    [event[26] setEventTime:@"4-7pm"];
    [event[26] setEventLocation:@"Main (Faculty Lounge)"];
    [event[26] setEventTitle:@"Faculty Welcome Ceremonies"];
    [event[26] setEventDescription:@"Arts"];
    [event[27] setEventTime:@"4-7pm"];
    [event[27] setEventLocation:@"McDougall 242"];
    [event[27] setEventTitle:@"Faculty Welcome Ceremonies"];
    [event[27] setEventDescription:@"Business"];
    [event[28] setEventTime:@"7-7:45pm "];
    [event[28] setEventLocation:@"Meet in the Quadrangle"];
    [event[28] setEventTitle:@"Team Challenge"];
    [event[28] setEventDescription:@"  "];
    [event[29] setEventTime:@"8-11pm "];
    [event[29] setEventLocation:@"Meet in the Quadrangle"];
    [event[29] setEventTitle:@"ManHunt"];
    [event[29] setEventDescription:@"  "];
    [event[30] setEventTime:@"6–9 pm"];
    [event[30] setEventLocation:@"Wanda Wyatt Dining Hall"];
    [event[30] setEventTitle:@"NSO Final Banquet"];
    [event[30] setEventDescription:@"Time to celebrate the finish of New StudentOrientation 2012 with new and old friends, aswell as faculty & staff. Awards to be given andthe 2012 Shinerama total will be announced."];
    [event[31] setEventTime:@"2pm "];
    [event[31] setEventLocation:@"UPEI Turf Field"];
    [event[31] setEventTitle:@"Panther Home Game Openers"];
    [event[31] setEventDescription:@"Women's SoccerCome out and cheer on our Panther athletes!Half-time games to incorporate NSO teams."];
    [event[32] setEventTime:@"3pm"];
    [event[32] setEventLocation:@"UPEI Turf Field"];
    [event[32] setEventTitle:@"Panther Home Game Openers"];
    [event[32] setEventDescription:@"Women's RugbyCome out and cheer on our Panther athletes!Half-time games to incorporate NSO teams."];
    [event[33] setEventTime:@"4:15pm"];
    [event[33] setEventLocation:@"UPEI Turf Field"];
    [event[33] setEventTitle:@"Men's Soccer"];
    [event[33] setEventDescription:@"Come out and cheer on our Panther athletes!Half-time games to incorporate NSO teams."];
}

-(void) read {
    NSManagedObjectContext *context = [self managedObjectContext];

    // Build a fresh request for some reason who knows
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];

    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest: fetchRequest error:&error];

    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortList = [fetchedObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
    for(Day *day in sortList) {
        NSLog(@"%@:%@",[day name],[day date]);

        NSLog(@"\t\tEvents:");
        NSSet *events = [day event];
        NSSortDescriptor *sortDescDays = [NSSortDescriptor sortDescriptorWithKey:@"eventTime" ascending:YES];
        NSArray *sortListDays = [events sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescDays]];
        for(Event *event in sortListDays) {
            //Display event info
            NSLog(@"\t\t\t\t%@\n%@\t%@\n%@",[event eventTitle],[event eventTime],[event eventLocation],[event eventDescription]);
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}



// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Schedule" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Schedule"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}


@end
