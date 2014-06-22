//
//  ViewController.m
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "ViewController.h"
#import "GetWeather.h"
#import <iAd/iAd.h>

@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController
BOOL weatherCalled = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getWeather:(CLLocation *)location {
    if (weatherCalled == 0) {
        CLLocationCoordinate2D currentLocation = location.coordinate;
        NSLog(@"%f, %f", currentLocation.latitude, currentLocation.longitude);
        GetWeather *weather = [[GetWeather alloc] init];
        [weather getWeatherAtCurrentLocation:currentLocation];
        self.currentLocation.text = weather.currentLocation;
        self.currentTemp.text = weather.currentTemperature;
        self.currentDesc.text = weather.currentDescription;
        
        if(weather.Fvalue > 80) {
            _advice.text = @"Hot hot hot!";
        }
        else if(60 < weather.Fvalue < 80 && [weather.currentDescription rangeOfString:@"Cloudy"].location != NSNotFound) {
            _advice.text = @"It's in between 60 and 80, and cloudy.";
            UIImage *kitty = [UIImage imageNamed:@"kitty.png"];
            [_mamaSays setImage:kitty];
        }
        else {
            _advice.text = @"COLD.";
        }
        /*//Date
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterNoStyle;
        NSString *date = [dateFormatter stringFromDate: now];
        //Time
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        //[timeFormatter setDateFormat:@"hh-mm"];
        timeFormatter.timeStyle = NSDateFormatterShortStyle;
        NSString *time = [timeFormatter stringFromDate: now];*/
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *dateTime = [formatter stringFromDate:now];
        
        NSString * lastUpdated = [NSString stringWithFormat:@"Last updated: %@", dateTime];
        self.lastRetrieved.text = lastUpdated;
        
        weatherCalled = 0;
        
    } else {
        NSLog(@"Weather Check Already in Progress");
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    [self getWeather:location];
    weatherCalled = 1;
}
- (IBAction)refreshTemp:(UIButton *)sender {
    weatherCalled = 0;
    
    [self.locationManager startUpdatingLocation];
}
#pragma mark iAd Delegate Methods
-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0 ];
    [UIView commitAnimations];
}
@end
