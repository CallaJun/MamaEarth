//
//  MainViewController.m
//  MamaEarth
//
//  Created by Calla on 6/16/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "MainViewController.h"
#import "Weather.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    Weather *theWeather;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    theWeather = [[Weather alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction)tellMePressediPad:(id)sender {
    [theWeather getCurrent:self.locationTextFieldiPad.text];
    
    NSString *report = [NSString stringWithFormat:
                        @"Weather in %@:\n"
                        @"%@\n"
                        @"Current temp.: %2.1f C\n"
                        @"High: %2.1f C\n"
                        @"Low: %2.1f C\n",
                        theWeather.city,
                        theWeather.conditions[0][@"description"],
                        theWeather.tempCurrent,
                        theWeather.tempMax,
                        theWeather.tempMin
                        ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Weather"
                                                    message:report
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (IBAction)tellMePressediPhone:(id)sender {
    [theWeather getCurrent:self.locationTextFieldiPhone.text];
    
    NSString *report = [NSString stringWithFormat:
                        @"Weather in %@:\n"
                        @"%@\n"
                        @"Current temp.: %2.1f C\n"
                        @"High: %2.1f C\n"
                        @"Low: %2.1f C\n",
                        theWeather.city,
                        theWeather.conditions[0][@"description"],
                        theWeather.tempCurrent,
                        theWeather.tempMax,
                        theWeather.tempMin
                        ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Weather"
                                                    message:report
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)textFieldReturn:(id)sender
{
        [sender resignFirstResponder];
}
@end
