//
//  PlopixFileManager.m
//  Plopix
//
//  Created by Plopix on 01/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixFileManager.h"


@implementation PlopixFileManager

+ (NSString *)getPathIn: (ApplicationPath) path {
	NSString *rpath;
	
	switch (path) {
		case (ApplicationPath)APP_TEMP:
			rpath = NSTemporaryDirectory(); 
		break;
		case (ApplicationPath)APP_DOCUMENTS:{
			NSArray *paths;
			paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			rpath = [paths objectAtIndex:0];
		}
		break;
		default:
			@throw [NSException exceptionWithName:@"PlopixFileManager Exception" reason:@"PlopixFileManager::getPathIn : path is not authorized" userInfo:nil];
		break;
	}
	return rpath;
}

+ (NSString *) fullPath: (NSString *) fileName In: (ApplicationPath) path {
	return [[PlopixFileManager getPathIn:path] stringByAppendingPathComponent:fileName];
}

+ (BOOL)exists: (NSString *) fileName In: (ApplicationPath) path {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	return [fileManager fileExistsAtPath:[PlopixFileManager fullPath:fileName In:path]];
}


+ (void) cacheDictionnary: (NSString *) dictName withDict:(NSMutableDictionary*) dict In: (ApplicationPath) path {
	[dict writeToFile:[[PlopixFileManager getPathIn:path] stringByAppendingPathComponent:dictName] atomically:YES];
}

+ (NSMutableDictionary *) getCachedDictionnary:(NSString *) dictName In: (ApplicationPath) path {
	if ([PlopixFileManager exists:dictName In:path])
		return [NSMutableDictionary dictionaryWithContentsOfFile:[PlopixFileManager fullPath:dictName In:path]];
	else return nil;
}

+ (void) cacheImage: (NSString *) imageName withData:(NSMutableData*) data In: (ApplicationPath) path {
	[data writeToFile:[[PlopixFileManager getPathIn:path] stringByAppendingPathComponent:imageName] atomically:YES];
}

+ (UIImage *) getCachedImage: (NSString *) imageName In: (ApplicationPath) path {
	if ([PlopixFileManager exists:imageName In:path])	
        return [UIImage imageWithContentsOfFile: [PlopixFileManager fullPath:imageName In:path]];
	else
		return nil;
}

+ (void) remove: (NSString *) itemName In: (ApplicationPath) path {
	if ([PlopixFileManager exists:itemName In:path]) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager removeItemAtPath:[PlopixFileManager fullPath:itemName In:path] error:nil];
	}
}

+ (void) rename: (NSString *) sourceName to: (NSString *) destName In: (ApplicationPath) path {
	if ([PlopixFileManager exists:sourceName In:path]) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager moveItemAtPath:[PlopixFileManager fullPath:sourceName In:path] toPath:[PlopixFileManager fullPath:destName In:path] error:nil];
	}
}
@end
