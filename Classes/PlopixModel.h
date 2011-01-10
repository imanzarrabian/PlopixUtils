//
//  PlopixModel.h
//  PlopixUtils
//
//  Created by Plopix on 14/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PlopixSqLiteManager.h"
#import "PlopixPersistentData.h"
#import "PlopixModelObjectNotFoundException.h"

@interface PlopixModel : NSObject {
	
}

- (id) initWithKey:(id) key;
- (id) initWithHash:(NSDictionary *) hash;
- (void) fillWithHash:(NSDictionary *) hash;
- (NSMutableDictionary*) toDictionnary;
- (void) storeInLocal;
- (void) deleteInLocal;
- (id) getKey;

@end
