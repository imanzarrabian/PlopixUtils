//
//  PlopixSqLiteManager.m
//  PlopixUtils
//
//  Created by Plopix on 14/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlopixSqLiteManager.h"
#import "PlopixFileManager.h"

static PlopixSqLiteManager *singletonInstance =nil;

@implementation PlopixSqLiteManager


- (id) init {
	[super init];
	//init
	@try {
		[self copyDbFromRessourceIfNeeded];
		[self openDatabase];
	}
	@catch (id e) {
		PlopixDLog(@"Error initialization SqLiteManager : %@",[e description]);
		return nil;
	}
	return self;
}


- (void) copyDbFromRessourceIfNeeded {
	if (![PlopixFileManager exists:BDD_FILENAME In:APP_DOCUMENTS]) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString* ressourceDbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:BDD_FILENAME];
		NSError* fileManagerError;
		if (![fileManager copyItemAtPath:ressourceDbPath
								  toPath:[PlopixFileManager fullPath:BDD_FILENAME In:APP_DOCUMENTS]
							   error:&fileManagerError])
			@throw [NSException exceptionWithName:@"FILE_ERROR" reason:@"Imposible to copy blank database from ressources" userInfo:nil];

	}
}


- (void) openDatabase {
	NSString *dbPath = [PlopixFileManager fullPath:BDD_FILENAME In:APP_DOCUMENTS];
	if (sqlite3_open_v2([dbPath UTF8String], &database, SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
		NSFileManager* fileManager = [NSFileManager defaultManager];
		NSError* fileManagerError;
		if (![fileManager removeItemAtPath:dbPath error:&fileManagerError])
			@throw [NSException exceptionWithName:@"DB_ERROR" reason:@"Database was corrupt, and impossible to delete it to start again with a new one" userInfo:nil];
		[self copyDbFromRessourceIfNeeded];
	}
}


-(NSInteger) lastInsertId {
	return sqlite3_last_insert_rowid(database);
}

#pragma mark Compilation des queries et cache

- (sqlite3_stmt*) compileQueryOrGetFromCache:(NSString*) query {
	PlopixSQLLog(@" %@",query);
	NSValue* encapsulatedCompiledQuery;
	sqlite3_stmt* compiledQuery;
	// on tente de sortir la query compilée du dico de cache
	encapsulatedCompiledQuery = [compiledQueries objectForKey: query];
	// si on l'a on desencapsule, on clear les bindings (car si on l'a, c'est qu'elle a forcement servi avant)
	// et on retourne la query
	if (encapsulatedCompiledQuery != nil) {
		[encapsulatedCompiledQuery getValue:&compiledQuery];
		sqlite3_reset(compiledQuery);
		sqlite3_clear_bindings(compiledQuery);
		return compiledQuery;
	}
	compiledQuery = [self compileQuery:query];
	encapsulatedCompiledQuery = [[NSValue alloc] initWithBytes:compiledQuery objCType:@encode(sqlite3_stmt*)];
	[compiledQueries setValue:encapsulatedCompiledQuery forKey:query];
	return compiledQuery;
}

- (sqlite3_stmt*) compileQuery:(NSString*) query { 	
	sqlite3_stmt* compiledQuery;
	if (sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledQuery, NULL) != SQLITE_OK)
		@throw [NSException exceptionWithName:@"QUERY_COMPILE_ERROR" reason:@"sqlite3_prepare_v2 was unable to compile the query" userInfo:nil];
	return compiledQuery;
}

#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

+(PlopixSqLiteManager *)sharedInstance{
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

- (id)copyWithZone:(NSZone *)zone
{
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
