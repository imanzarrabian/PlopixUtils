//
//  PlopixFileManager.h
//  Plopix
//
//  Created by Plopix on 01/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlopixFileManager : NSObject {
	
}

	
+ (NSString *)getPathIn: (ApplicationPath) path;
+ (NSString *) fullPath: (NSString *) fileName In: (ApplicationPath) path;
+ (BOOL)exists: (NSString *) fileName In: (ApplicationPath) path;	
+ (void) cacheDictionnary: (NSString *) dictName withDict:(NSMutableDictionary*) dict In: (ApplicationPath) path;	
+ (NSMutableDictionary *) getCachedDictionnary:(NSString *) dictName In: (ApplicationPath) path;	
+ (void) cacheImage: (NSString *) imageName withData:(NSMutableData*) data In: (ApplicationPath) path;	
+ (UIImage *) getCachedImage: (NSString *) imageName In: (ApplicationPath) path;
+ (void) remove: (NSString *) itemName In: (ApplicationPath) path;
+ (void) rename: (NSString *) sourceName to: (NSString *) destName In: (ApplicationPath) path;

@end