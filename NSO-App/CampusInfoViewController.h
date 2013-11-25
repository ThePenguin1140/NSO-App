//
//  CampusInfoViewController.h
//  NSO-App
//
//  Created by CS212 on 13-11-06.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusInfoViewController : UIViewController
- (IBAction)segmentControlAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webViewGym;
@property (weak, nonatomic) IBOutlet UIWebView *webViewLibrary;
@property (weak, nonatomic) IBOutlet UIWebView *webViewWave;

@end
