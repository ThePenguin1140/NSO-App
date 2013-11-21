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
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   // [self create];
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
        return 0;
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
    [mon3 setDate:@"September 8th"];
    
    
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
    //Do the relationships go bothways????
}

-(void) read {
    MSManagedObject *context = [self managedObjectContext];

    // Build a fresh request for some reason who knows
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];

    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortList = [fetchedObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
    for(Day *day in sortList) {
        NSLog(@"%@:%@",[day name],[day date]);

        NSLog(@"\t\tEvents:");
        NSSet *events = [day events];
        NSSortDescriptor *sortDescDays = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
        NSArray *sortListDays = [events sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescDays]];
        for(Event *event in sortListDays) {
            //Display event info
            NSLog(@"\t\t\t\t%@\n%@\t%@\n%@",[event title],[event time],[event location],[event description]);
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
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
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
@end
