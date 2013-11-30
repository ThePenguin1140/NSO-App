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
    // loads the gym view on first selection of this tab because it is the first in segmented control
    [webViewGym loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://ar.upei.ca/hours-operation"]]];
    webViewGym.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// segmented controller used to display the campus information
- (IBAction)segmentControlAction:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    // gets the value of the segmented controller
    int selectedValue = segControl.selectedSegmentIndex;
    switch (selectedValue) {
        // display the gym information
        // uses web view to display the online upei gym website
        case 0:
        {
            [webViewGym loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://ar.upei.ca/hours-operation"]]];
            webViewGym.scalesPageToFit = YES;
            break;
        }
        // display the library information
        // uses web view to display an offline html file that is included
        case 1:
        {
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"library" withExtension:@"html"];
            NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            [webViewLibrary loadHTMLString:html baseURL:[url URLByDeletingLastPathComponent]];
            break;
        }
        // display the wave information
        // uses web view to display an offline html file that is included and a pdf of the wave menu that is include in the html file
        case 2:
        {
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"wave" withExtension:@"html"];
            NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            [webViewLibrary loadHTMLString:html baseURL:[url URLByDeletingLastPathComponent]];
            break;
        }
        default:
            break;
    }
}
@end
