//
//  CampusInfoViewController.h
//  NSO-App
//
//  Created by CS212 on 13-11-06.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)segmentControlAction:(id)sender;
@end
