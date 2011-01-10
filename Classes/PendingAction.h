//
//  PendingAction.h
//  Plopix
//
//  Created by Plopix on 07/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlopixModel.h"

@interface PendingAction : PlopixModel {

	NSInteger id;
	NSDate *date;
	NSString *action;
	NSMutableDictionary *params;
	NSString *state;
}

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *action;
@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) NSString *state;

+ (NSMutableArray*) getAll;
+ (BOOL) isAlreadyDefined:(PendingAction*) a;

@end
