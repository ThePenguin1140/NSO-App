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
@synthesize webViewGym, webViewLibrary, webViewWave;

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
    
    [webViewGym loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://ar.upei.ca/hours-operation"]]];
    webViewGym.scalesPageToFit = YES;
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
        {
            NSLog(@"1");
            
            [webViewGym loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://ar.upei.ca/hours-operation"]]];
            webViewGym.scalesPageToFit = YES;

        }
            break;
        case 1:
        {
            NSLog(@"2");
            NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"library" ofType:@"html"] isDirectory:NO];

            [webViewLibrary loadRequest:[NSURLRequest requestWithURL: htmlFile]];
            webViewLibrary.scalesPageToFit = YES;

            break;
        }
        case 2:
        {
            NSLog(@"3");
            NSString *path = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"pdf"];
            NSURL *targetURL = [NSURL fileURLWithPath:path];
            NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
            [webViewWave loadRequest:request];
            webViewWave.scalesPageToFit = YES;

            break;
        }
       

            
        default:
            break;
    }
}

@end
