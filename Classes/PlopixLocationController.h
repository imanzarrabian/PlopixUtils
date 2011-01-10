//
//  PlopixLocationController.h
//  PlopixUtils
//
//  Created by Plopix on 08/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/Mapkit.h"

@protocol PlopixLocationControllerDelegate <NSObject>
@required
-(void)newLocationUpdate;
-(void)newPlacemarkUpdate;
@end


@interface PlopixLocationController : NSObject <CLLocationManagerDelegate,MKReverseGeocoderDelegate> {
	CLLocationManager *locationManager;
	NSMutableString *currentStringLocation;
	NSMutableString *currentReverseLocation;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableString *currentStringLocation;
@property (nonatomic, retain) NSMutableString *currentReverseLocation;
@property (nonatomic, retain) id delegate;

+(PlopixLocationController *)sharedInstance;

@end
