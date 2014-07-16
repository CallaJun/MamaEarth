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
    
    self.canDisplayBannerAds = YES;
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
        
        //WEATHER CASES
        if([weather.currentDescription rangeOfString:@"Sunny"].location != NSNotFound) {
            UIImage *Sunny1 = [UIImage imageNamed:@"Sunny1.png"];
            [_mamaSays setImage:Sunny1];
        }
        //Cloudy or overcast
        else if(60 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Cloudy"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Overcast"].location != NSNotFound))) {
            UIImage *CloudyOvercast1 = [UIImage imageNamed:@"CloudyOvercast1.png"];
            [_mamaSays setImage:CloudyOvercast1];
        }
        else if(60 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Cloudy"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Overcast"].location != NSNotFound))) {
            UIImage *CloudyOvercast2 = [UIImage imageNamed:@"CloudyOvercast2.png"];
            [_mamaSays setImage:CloudyOvercast2];
        }
        //Mist and fog
        else if(60 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"Mist"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Fog"].location != NSNotFound))) {
            UIImage *MistFog1 = [UIImage imageNamed:@"MistFog1.png"];
            [_mamaSays setImage:MistFog1];
        }
        else if(60 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"Mist"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"Fog"].location != NSNotFound))) {
            UIImage *MistFog2 = [UIImage imageNamed:@"MistFog2.png"];
            [_mamaSays setImage:MistFog2];
        }
        //Patchy rain nearby
        else if(50 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy rain nearby"].location != NSNotFound) {
            UIImage *PatchyRainNearby1 = [UIImage imageNamed:@"PatchyRainNearby1.png"];
            [_mamaSays setImage:PatchyRainNearby1];
        }
        else if(50 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy rain nearby"].location != NSNotFound) {
            UIImage *PatchyRainNearby2 = [UIImage imageNamed:@"PatchyRainNearby2.png"];
            [_mamaSays setImage:PatchyRainNearby2];
        }
        //Patchy snow nearby
        else if(15 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy snow nearby"].location != NSNotFound) {
            UIImage *PatchySnowNearby1 = [UIImage imageNamed:@"PatchySnowNearby1.png"];
            [_mamaSays setImage:PatchySnowNearby1];
        }
        else if(15 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy snow nearby"].location != NSNotFound) {
            UIImage *PatchySnowNearby2 = [UIImage imageNamed:@"PatchySnowNearby2.png"];
            [_mamaSays setImage:PatchySnowNearby2];
        }
        //Patchy sleet nearby
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy sleet nearby"].location != NSNotFound) {
            UIImage *PatchySleetNearby1 = [UIImage imageNamed:@"PatchySleetNearby1.png"];
            [_mamaSays setImage:PatchySleetNearby1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Patchy sleet nearby"].location != NSNotFound) {
            UIImage *PatchySleetNearby2 = [UIImage imageNamed:@"PatchySleetNearby2.png"];
            [_mamaSays setImage:PatchySleetNearby2];
        }
        //Freezing drizzle and heavy freezing drizzle
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Freezing drizzle"].location != NSNotFound) {
            UIImage *FreezingDrizzle1 = [UIImage imageNamed:@"FreezingDrizzle1.png"];
            [_mamaSays setImage:FreezingDrizzle1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Freezing drizzle"].location != NSNotFound) {
            UIImage *FreezingDrizzle2 = [UIImage imageNamed:@"FreezingDrizzle2.png"];
            [_mamaSays setImage:FreezingDrizzle2];
        }
        //Thundery outbreaks nearby
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"thundery"].location != NSNotFound) {
            UIImage *Thundery1 = [UIImage imageNamed:@"Thundery1.png"];
            [_mamaSays setImage:Thundery1];
        }
        else if(40 > weather.Fvalue && [weather.currentDescription rangeOfString:@"thundery"].location != NSNotFound) {
            UIImage *Thundery2 = [UIImage imageNamed:@"Thundery2.png"];
            [_mamaSays setImage:Thundery2];
        }
        //Blowing snow
        else if(10 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"blowing snow"].location != NSNotFound) {
            UIImage *BlowingSnow1 = [UIImage imageNamed:@"BlowingSnow1.png"];
            [_mamaSays setImage:BlowingSnow1];
        }
        else if(10 > weather.Fvalue && [weather.currentDescription rangeOfString:@"blowing snow"].location != NSNotFound) {
            UIImage *BlowingSnow2 = [UIImage imageNamed:@"BlowingSnow2.png"];
            [_mamaSays setImage:BlowingSnow2];
        }
        //Blizzard
        else if(10 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"Blizzard"].location != NSNotFound) {
            UIImage *Blizzard1 = [UIImage imageNamed:@"Blizzard1.png"];
            [_mamaSays setImage:Blizzard1];
        }
        else if(10 > weather.Fvalue && [weather.currentDescription rangeOfString:@"Blizzard"].location != NSNotFound) {
            UIImage *Blizzard2 = [UIImage imageNamed:@"Blizzard2.png"];
            [_mamaSays setImage:Blizzard2];
        }
        //Light drizzle and patchy light drizzle
        else if(50 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"light drizzle"].location != NSNotFound) {
            UIImage *LightDrizzle1 = [UIImage imageNamed:@"LightDrizzle1.png"];
            [_mamaSays setImage:LightDrizzle1];
        }
        else if(50 > weather.Fvalue && [weather.currentDescription rangeOfString:@"light drizzle"].location != NSNotFound) {
            UIImage *LightDrizzle2 = [UIImage imageNamed:@"LightDrizzle2.png"];
            [_mamaSays setImage:LightDrizzle2];
        }
        //Light rain and patchy light rain
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"light rain"].location != NSNotFound) {
            UIImage *LightRain1 = [UIImage imageNamed:@"LightRain1.png"];
            [_mamaSays setImage:LightRain1];
        }
        //freezing rain
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"light rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"light freezing rain"].location != NSNotFound))) {
            UIImage *LightRain2 = [UIImage imageNamed:@"LightRain2.png"];
            [_mamaSays setImage:LightRain2];
        }
        //Moderate rain and moderate rain at times
        else if(40 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"moderate rain"].location != NSNotFound) {
            UIImage *ModerateRain1 = [UIImage imageNamed:@"ModerateRain1.png"];
            [_mamaSays setImage:ModerateRain1];
        }
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"moderate rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"moderate freezing rain"].location != NSNotFound))) {
            UIImage *ModerateRain2 = [UIImage imageNamed:@"ModerateRain2.png"];
            [_mamaSays setImage:ModerateRain2];
        }
        //heavy rain and heavy rain at times or Torrential
        else if(40 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"heavy rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"torrential rain"].location != NSNotFound))) {
            UIImage *HeavyRain1 = [UIImage imageNamed:@"HeavyRain1.png"];
            [_mamaSays setImage:HeavyRain1];
        }
        //freezing rain
        else if(40 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"torrential rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"heavy rain"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"heavy freezing rain"].location != NSNotFound))) {
            _advice.text = @"Raincoat, rainboots, and a strong umbrella. And extra layers might help.";
            UIImage *HeavyRain2 = [UIImage imageNamed:@"HeavyRain2.png"];
            [_mamaSays setImage:HeavyRain2];
        }
        //light snow or light sleet or patchy light snow
        else if(20 <= weather.Fvalue && (([weather.currentDescription rangeOfString:@"light snow"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"light sleet"].location != NSNotFound))) {
            _advice.text = @"Waterproof boots are a must. And a good coat. Earmuffs or a beanie are advisable. And gloves.";
            UIImage *LightSnow1 = [UIImage imageNamed:@"LightSnow1.png"];
            [_mamaSays setImage:LightSnow1];
        }
        else if(20 > weather.Fvalue && (([weather.currentDescription rangeOfString:@"light snow"].location != NSNotFound) || ([weather.currentDescription rangeOfString:@"light sleet"].location != NSNotFound))) {
            _advice.text = @"Gloves. Waterproof boots, a good down coat. Layers, lots of them. Earmuffs or a beanie underneath your hood.";
            UIImage *LightSnow2 = [UIImage imageNamed:@"LightSnow2.png"];
            [_mamaSays setImage:LightSnow2];
        }
        //moderate or heavy sleet
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"moderate or heavy sleet"].location != NSNotFound) {
            UIImage *ModerateHeavySleet1 = [UIImage imageNamed:@"ModerateHeavySleet1.png"];
            [_mamaSays setImage:ModerateHeavySleet1];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"moderate or heavy sleet"].location != NSNotFound) {
            UIImage *ModerateHeavySleet2 = [UIImage imageNamed:@"ModerateHeavySleet2.png"];
            [_mamaSays setImage:ModerateHeavySleet2];
        }
        //Moderate snow or patchy moderate snow
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"moderate snow"].location != NSNotFound) {
            _advice.text = @"A warm winter coat, water-proof boots, gloves, long sleeves and pants, a beanie or earmuffs - the whole deal.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"moderate snow"].location != NSNotFound) {
            _advice.text = @"A really warm winter coat, water-proof boots, gloves, long sleeves and pants, a beanie or earmuffs - the whole deal.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        //heavy snow or patchy heavy snow
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"heavy snow"].location != NSNotFound) {
            _advice.text = @"An inpenatrable coat with inpenatrable boots and long sleeves and earmuffs or a beanie, a scarf, gloves...go all out.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"heavy snow"].location != NSNotFound) {
            _advice.text = @"An inpenatrable coat with inpenatrable boots and long sleeves and earmuffs or a beanie, a scarf, gloves, tights under your pants...go all out, Sweetie. It's cold outside.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        //light, moderate, heavy showers of ice pellets, ice pellets
        else if(20 <= weather.Fvalue && [weather.currentDescription rangeOfString:@"ice pellets"].location != NSNotFound) {
            _advice.text = @"Snow clothes - coat, boots, pants, gloves, etc. But bring an umbrella. A good one. Or just stay inside.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        else if(20 > weather.Fvalue && [weather.currentDescription rangeOfString:@"ice pellets"].location != NSNotFound) {
            _advice.text = @"Snow clothes - coat, boots, pants, gloves, etc. But bring an umbrella. A good one. Or just stay inside.";
            UIImage *RutheHopper = [UIImage imageNamed:@"RutheHopper.png"];
            [_mamaSays setImage:RutheHopper];
        }
        //Else
        else {
            _advice.text = @"Mama doesn't know.";
            UIImage *graph = [UIImage imageNamed:@"graph.png"];
            [_mamaSays setImage:graph];
        }

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
