//
//  PlopixModel.m
//  PlopixUtils
//
//  Created by Plopix on 14/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlopixModel.h"

@implementation PlopixModel

- (id)init {
	[super init];
	return self;
}

- (id) initWithKey:(id) key {
	[self init];
	return self;
}
- (id) initWithHash:(NSDictionary *) hash {
	[self init];
	[self fillWithHash:hash];
	return self;
}

- (void) fillWithHash:(NSDictionary *) hash {}
- (NSMutableDictionary*) toDictionnary { return nil;}

- (void) storeInLocal {}

- (void) deleteInLocal {}

- (id) getKey { return nil; }

-(NSString *) description2 {
	NSString *output=@"\n---------\n";
	NSDictionary *t = [self toDictionnary];
	for(NSDictionary *item in t) {
		output = [output stringByAppendingFormat:@"%@ = %@\n",item,[t objectForKey:item]];
	}
	output = [output stringByAppendingString:@"---------"];
	return output;
}
@end
