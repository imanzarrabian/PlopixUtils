//
//  PlopixLocationController.m
//  PlopixUtils
//
//  Created by Plopix on 08/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlopixLocationController.h"

static PlopixLocationController *singletonInstance =nil;

@implementation PlopixLocationController

@synthesize locationManager,delegate,currentStringLocation,currentReverseLocation;

MKReverseGeocoder *rGeo;

- (id) init {
	[super init];
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self; // Tells the location manager to send updates to this object
	self.currentStringLocation = [[NSMutableString alloc] init];
	self.currentReverseLocation = [[NSMutableString alloc] init];
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	// Timestamp
	[currentStringLocation setString:@""];
	// Horizontal coordinates
	if (signbit(newLocation.horizontalAccuracy)) {
		// Negative accuracy means an invalid or unavailable measurement
		[currentStringLocation appendString:@"Latitude / Longitude unavailable"];
	} else {
		// CoreLocation returns positive for North & East, negative for South & West
		[currentStringLocation appendFormat:@"Location: %.4f° %@, %.4f° %@", // This format takes 4 args: 2 pairs of the form coordinate + compass direction
		 fabs(newLocation.coordinate.latitude), signbit(newLocation.coordinate.latitude) ? @"South" : @"North",
		 fabs(newLocation.coordinate.longitude),	signbit(newLocation.coordinate.longitude) ? @"West" : @"East"];
		[currentStringLocation appendString:@"\n"];
		[currentStringLocation appendFormat:@"(accuracy %.0f meters)", newLocation.horizontalAccuracy];
	}
	[currentStringLocation appendString:@"\n\n"];
	// Altitude
	if (signbit(newLocation.verticalAccuracy)) {
		// Negative accuracy means an invalid or unavailable measurement
		[currentStringLocation appendString:@"Altitude unavailable"];
	} else {
		// Positive and negative in altitude denote above & below sea level, respectively
		[currentStringLocation appendFormat:@"Altitude: %.2f meters %@", fabs(newLocation.altitude),	(signbit(newLocation.altitude)) ? @"below sea level" : @"above sea level"];
		[currentStringLocation appendString:@"\n"];
		[currentStringLocation appendFormat:@"(accuracy %.0f meters)", newLocation.verticalAccuracy];
	}
	[currentStringLocation appendString:@"\n\n"];
	
	//Reverse geocoding 
	if (rGeo == nil) rGeo = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
	
	rGeo.delegate = self;
	[rGeo start];	
	[self.delegate newLocationUpdate];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	PlopixDLog(@"locationManager:didFailWithError");
}
 
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	PlopixDLog(@"reverseGeocoder:didFailWithError");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	[currentReverseLocation setString:@""];
	[currentReverseLocation appendFormat:@"%@, %@ %@",placemark.thoroughfare, placemark.postalCode, placemark.locality];
	[self.delegate newPlacemarkUpdate];
}

#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

+(PlopixLocationController *)sharedInstance {
    @synchronized(self) {
        if (singletonInstance == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return singletonInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (singletonInstance == nil) {
            singletonInstance = [super allocWithZone:zone];
            return singletonInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}




@end
