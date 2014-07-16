//
//  ViewController.h
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <iAd/iAd.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate, ADBannerViewDelegate> {
}
@property (weak, nonatomic) IBOutlet UILabel *currentLocation;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lastRetrieved;
@property (weak, nonatomic) IBOutlet UILabel *advice;
@property (weak, nonatomic) IBOutlet UILabel *currentDesc;
@property (weak, nonatomic) IBOutlet UIImageView *mamaSays;

- (IBAction)refreshTemp:(UIButton *)sender;
@end
