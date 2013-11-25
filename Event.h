//
//  Event.h
//  NSO-App
//
//  Created by CS212 on 13-11-20.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * eventDescription;
@property (nonatomic, retain) NSString * eventLocation;
@property (nonatomic, retain) NSString * eventTime;
@property (nonatomic, retain) NSString * eventTitle;
@property (nonatomic, retain) Day *day;

@end
