//
//  PlopixSqLiteManager.h
//  PlopixUtils
//
//  Created by Plopix on 14/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PlopixSqLiteManager : NSObject {
	sqlite3* database;
	NSMutableDictionary* compiledQueries;
	
}

+(PlopixSqLiteManager*) sharedInstance;
- (sqlite3_stmt*) compileQueryOrGetFromCache:(NSString*) query;
- (sqlite3_stmt*) compileQuery:(NSString*) query;

- (void) copyDbFromRessourceIfNeeded;
- (void) openDatabase;
- (NSInteger) lastInsertId;

@end
