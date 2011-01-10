//
//  PlopixPersistentData.h
//  Plopix
//
//  Created by Plopix on 10/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlopixPersistentData : NSObject {
	NSMutableDictionary *hash;
}
@property (nonatomic, retain, readonly) NSMutableDictionary *hash;

+(PlopixPersistentData *)sharedInstance;
-(void) setData:(id)data forKey:(NSString *)k;
-(id)   getDataForKey:(NSString *)k;
-(BOOL) isPersistent:(NSString*) k;
-(void) removeForKey:(NSString*) k;
-(void) removeAll;
@end
