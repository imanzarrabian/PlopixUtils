//
//  PlopixPendingActionsManager.m
//  PlopixPendingActionsManager
//
//  Created by Plopix on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixPendingActionsManager.h"

static PlopixPendingActionsManager *singletonInstance=nil;

@implementation PlopixPendingActionsManager

@synthesize serviceRunDelegates;

- (id) init {
	[super init];
	@try {
		self.serviceRunDelegates = [[NSMutableArray alloc] init];
	}
	@catch (id e) {
		PlopixACTLog(@"Error initialization PendingActionsManager : %@",[e description]);
		return nil;
	}
	return self;
}

- (void) interruptAllServices  {
	for(PlopixService* serviceDelegate in serviceRunDelegates) {
		@try {             
			PlopixDLog(@"CancelService :%@",[serviceDelegate description]);
		}
		@catch (NSException * e) {}
	}
	[serviceRunDelegates removeAllObjects];
}

-(void) serviceFinished:(PlopixService *) service {
	PlopixACTLog(@"DEL : %@",service.action);
	[service.action deleteInLocal];
	[serviceRunDelegates removeObject:service];
	PlopixACTLog(@"DEL OK");
}


-(void) serviceFailed:(PlopixService *) service{
	PlopixACTLog(@"serviceFailed");
	[serviceRunDelegates removeObject:service];	
}


#pragma mark ---- Methods ----
-(BOOL) addPendingAction:(NSString *) action withParams:(NSMutableDictionary*) params andCommit:(BOOL) commit {
	return [self addPendingAction:action forObject:nil withParams:params andCommit:commit];
}

-(BOOL) addPendingAction:(NSString *) action forObject:(id) object withParams:(NSMutableDictionary*) params andCommit:(BOOL) commit {
	NSString *actionName = action;
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	if (object !=nil) {
		NSString *className = NSStringFromClass([object class]);
		actionName = [NSString stringWithFormat:@"%@-%@",className,action];		
		[dict setObject:[NSNumber numberWithInt:(int)[object getKey]] forKey:PAIDOBJ];
	}
	if(params != nil) [dict addEntriesFromDictionary:params];
	NSDictionary *dictAction = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSDate date],@"date",
						  actionName,@"action",
						  dict,@"params",
						  @"added",@"state",
						  nil
						  ];
	PlopixACTLog(@"New Action : %@",dict);
	PendingAction *a =  [[PendingAction alloc]  initWithHash:dictAction];
	if (![PendingAction isAlreadyDefined:a]) {
		[a storeInLocal];
	}else {
		PlopixACTLog(@"%@ existe deja",a);
	}
	[a release];
	if (commit == YES)	[self commit];
	return YES;
}

-(BOOL) commit {
	PlopixACTLog(@"==== COMMIT (MUST BE OVERRIDE) ====");
	return NO;
}


#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

+ (PlopixPendingActionsManager *)sharedInstance {
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
