//
//  MainViewController.h
//  MamaEarth
//
//  Created by Calla on 6/16/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFieldiPad;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFieldiPhone;
- (IBAction)tellMePressediPad:(id)sender;
- (IBAction)tellMePressediPhone:(id)sender;

@end
