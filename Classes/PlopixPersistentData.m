//
//  PlopixPersistentData.m
//  Plopix
//
//  Created by Plopix on 10/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixPersistentData.h"

static PlopixPersistentData *singletonInstance =nil;

@implementation PlopixPersistentData

@synthesize hash;

-(void) setData:(id)data forKey:(NSString *)k {
	[self.hash setObject:data forKey:k];
}

-(id) getDataForKey:(NSString *)k {
	return [self.hash objectForKey:k];
}

-(BOOL) isPersistent:(NSString*) k {
	return ([self.hash objectForKey:k] != nil);
}

-(void) removeForKey:(NSString*) k {
	[self.hash removeObjectForKey:k];
}

-(void) removeAll {
	[self.hash removeAllObjects];
}

-(void) setupHash {
	hash = [[NSMutableDictionary alloc] init];
}

// setup the data collection
- (id) init {
	if (self = [super init]) {
		[self setupHash];
	}
	return self;
}

#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

+(PlopixPersistentData *)sharedInstance {
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
