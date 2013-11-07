//
//  CampusInfoViewController.m
//  NSO-App
//
//  Created by CS212 on 13-11-06.
//  Copyright (c) 2013 Jason&Cory. All rights reserved.
//

#import "CampusInfoViewController.h"

@interface CampusInfoViewController ()

@end

@implementation CampusInfoViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //BE SURE TO LOAD THE FIRST HTML FILE INTO THE WEBVIEW
    
    //Implement path getting things where the path to html file is
    // relative!
    
    NSURL *url = [NSURL URLWithString:@"/Users/cs212/Desktop/Project/NSO-App/webView1.html"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentControlAction:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    int selectedValue = segControl.selectedSegmentIndex;
    switch (selectedValue) {
        case 0:
            NSLog(@"1");
            break;
        case 1:
            NSLog(@"2");
            break;
        case 2:
            NSLog(@"3");
            break;
        default:
            break;
    }
}
@end
