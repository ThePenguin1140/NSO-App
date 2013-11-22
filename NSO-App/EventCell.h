//
//  EventCell.h
//  NSO-App
//
//  Created by CS212 on 13-11-22.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
