//
//  EventCell.m
//  NSO-App
//
//  Created by CS212 on 13-11-22.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize descriptionLabel;
@synthesize subtitleLabel;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
