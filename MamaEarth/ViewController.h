//
//  ViewController.h
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate> {
}
@property (weak, nonatomic) IBOutlet UILabel *currentLocation;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lastRetrieved;
@property (weak, nonatomic) IBOutlet UILabel *currentDesc;
@property (weak, nonatomic) IBOutlet UIImageView *mamaSays;
@property (weak, nonatomic) IBOutlet UIButton *refresh;

- (IBAction)refreshTemp:(UIButton *)sender;
@end
