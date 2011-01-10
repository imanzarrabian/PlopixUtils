//
//  PlopixGANTrack.h
//  PlopixGANTrack
//
//  Created by Plopix on 05/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANTracker.h"

@interface PlopixGANTrack : NSObject {

}

+ (void) trackPage:(NSString *)_page;
+ (void) trackEventWithCategory:(NSString *) _category Action:(NSString*) _action;

@end
