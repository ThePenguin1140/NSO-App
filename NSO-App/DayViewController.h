//
//  DayViewController.h
//  NSO-App
//
//  Created by CS212 on 13-11-20.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Event.h"
#import "Day.h"
#import "EventViewController.h"

@interface DayViewController : UITableViewController

@property (strong,nonatomic) NSArray *dayArray;

@end
