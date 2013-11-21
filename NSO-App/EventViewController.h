//
//  EventViewController.h
//  NSO-App
//
//  Created by CS212 on 13-11-20.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Day.h"
#import "Event.h"

@interface EventViewController : UITableViewController

@property (strong, nonatomic) NSArray *eventArray;
@property (nonatomic) int currentSelectedCell;

@property (strong, nonatomic) NSManagedObjectID *dayID;

@end
