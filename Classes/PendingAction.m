//
//  PendingAction.m
//  Plopix
//
//  Created by Plopix on 07/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PendingAction.h"


@implementation PendingAction

@synthesize id,date,action,params,state;

- (NSString *) description {
	return [NSString stringWithFormat:@"[ %d | %@ | %@ | %@ | %@ ]",(int)self.id,[date description],action,params,state];
	
}

- (id) initWithKey:(id) key {
	[super init];
	NSString* query = @"SELECT rowid, ACTION_date, ACTION_action, ACTION_params,ACTION_state FROM TBL_pending_actions WHERE rowid = ?";
	sqlite3_stmt* compiledQuery = [[PlopixSqLiteManager sharedInstance] compileQueryOrGetFromCache: query];
	sqlite3_bind_int(compiledQuery, 1, (int)key);	
	if (sqlite3_step(compiledQuery) == SQLITE_ROW) {
		NSPropertyListFormat format;
		NSString *errorStr = nil;
		NSData *blob;
		self.id = sqlite3_column_int(compiledQuery, 0);
		self.date = [NSDate dateWithTimeIntervalSince1970:(int)sqlite3_column_int(compiledQuery,1)];
		
		if ((char *)sqlite3_column_text(compiledQuery,2))
			self.action = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledQuery,2)];
		
		
		blob = [[NSData alloc] initWithBytes:sqlite3_column_blob(compiledQuery, 3) length: sqlite3_column_bytes(compiledQuery, 3)];    
		self.params = [NSPropertyListSerialization propertyListFromData:blob
															   mutabilityOption: NSPropertyListImmutable
																		 format: &format
															   errorDescription: &errorStr];
		if ((char *)sqlite3_column_text(compiledQuery,4))
			self.state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledQuery,4)];
		
	}
	if (self.id<=0) {
		@throw [PlopixModelObjectNotFoundException exceptionWithName:@"OBJECT NOT FOUND IN LOCAL" reason:query userInfo:nil];
	}
	[query release];
	return self;
}

- (id) getKey {
	return (id)self.id;
}
	
- (void) fillWithHash:(NSDictionary *) hash {
	// must be a NSDate of course
	if ([hash objectForKey:@"date"] != nil)
		self.date = [hash objectForKey:@"date"];
	if ([hash objectForKey:@"action"] != nil) {
		self.action = [hash objectForKey:@"action"];
		if (![self.action isKindOfClass:[NSString class]])
			self.action = [[hash objectForKey:@"action"] stringValue];
	}
	if ([hash objectForKey:@"params"] != nil) {
		self.params = [hash objectForKey:@"params"];
	}
	
	if ([hash objectForKey:@"state"] != nil) {
		self.state = [hash objectForKey:@"state"];
		if (![self.state isKindOfClass:[NSString class]])
			self.state = [[hash objectForKey:@"state"] stringValue];
	}
}
 
- (void) storeInLocal {
	NSString *query;
	BOOL actionUpdate;
	@try {
		if (self.id == 0) {
			actionUpdate = FALSE;
		}else {
			PendingAction *t = [[PendingAction alloc] initWithKey:(id)self.id];
			actionUpdate = YES;
			[t release];
		}
	}
	@catch (PlopixModelObjectNotFoundException * e) {
		actionUpdate = NO;
	}
	
	if (actionUpdate) {
		query = @"UPDATE TBL_pending_actions SET "
		@"ACTION_date = ?, "
		@"ACTION_action = ?, "
		@"ACTION_params = ?, "
		@"ACTION_state = ? "
		@" WHERE rowid = ? ";		
	}else {
		query = @"INSERT INTO TBL_pending_actions ( "
		@"ACTION_date, "
		@"ACTION_action, "
		@"ACTION_params, "
		@"ACTION_state "
		@" ) "
		@"VALUES (?, ?, ?, ?)";
	}
	NSData *blob;
	sqlite3_stmt* compiledQuery = [[PlopixSqLiteManager sharedInstance] compileQueryOrGetFromCache: query];
	sqlite3_bind_int(	compiledQuery, 1,  (int)[self.date timeIntervalSince1970]);
	sqlite3_bind_text(	compiledQuery, 2, [self.action UTF8String], -1, SQLITE_STATIC);
	blob = [NSPropertyListSerialization dataFromPropertyList: self.params format: NSPropertyListXMLFormat_v1_0 errorDescription: nil];
	sqlite3_bind_blob(	compiledQuery, 3, [blob bytes] , [blob length] , SQLITE_TRANSIENT);
	sqlite3_bind_text(	compiledQuery, 4, [self.state UTF8String], -1, SQLITE_STATIC);	
	if (actionUpdate) sqlite3_bind_int(	compiledQuery, 5, self.id);
	sqlite3_step(compiledQuery);
	if (!actionUpdate) self.id = [[PlopixSqLiteManager sharedInstance] lastInsertId];
}

+ (BOOL) isAlreadyDefined:(PendingAction*) a {
	NSString* query = @"SELECT rowid FROM TBL_pending_actions WHERE ACTION_action = ? AND ACTION_params = ? AND ACTION_state = ?";
	sqlite3_stmt* compiledQuery = [[PlopixSqLiteManager sharedInstance] compileQueryOrGetFromCache: query];
	sqlite3_bind_text(	compiledQuery, 1, [a.action UTF8String], -1, SQLITE_STATIC);
	NSData *blob;
	blob = [NSPropertyListSerialization dataFromPropertyList: a.params format: NSPropertyListXMLFormat_v1_0 errorDescription: nil];
	sqlite3_bind_blob(	compiledQuery, 2, [blob bytes] , [blob length] , SQLITE_TRANSIENT);
	sqlite3_bind_text(	compiledQuery, 3, [a.state UTF8String], -1, SQLITE_STATIC);
	if (sqlite3_step(compiledQuery) == SQLITE_ROW) {
		return YES;
	}
	return NO;
}

- (void) deleteInLocal {
	NSString* query = @"DELETE FROM TBL_pending_actions WHERE rowid = ?";
	sqlite3_stmt* compiledQuery = [[PlopixSqLiteManager sharedInstance] compileQueryOrGetFromCache: query];
	sqlite3_bind_int(compiledQuery, 1, self.id);
	sqlite3_step(compiledQuery);
}

+ (NSMutableArray*) getAll {	
	NSString* query = @"SELECT rowid FROM TBL_pending_actions ORDER BY ACTION_date ASC";
	sqlite3_stmt* compiledQuery = [[PlopixSqLiteManager sharedInstance] compileQueryOrGetFromCache: query];
	NSMutableArray *results = [[NSMutableArray alloc] init];
	while(sqlite3_step(compiledQuery) == SQLITE_ROW) {
		PendingAction* action = [[PendingAction alloc] initWithKey:(id)sqlite3_column_int(compiledQuery, 0)];
		[results addObject:action];
		[action release];		
	}
	[query release];
	return [results autorelease];
}

@end
