/*
 *  PlopixMacros.h
 *  PlopixMacros
 *
 *  Created by Plopix on 29/04/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#if DEBUG_ENABLED
#	define PlopixDLog(fmt, ...)		NSLog((@"D:%d:%s " fmt), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#	define PlopixDLog(...)
#endif

#if SQL_DEBUG_ENABLED
#	define PlopixSQLLog(fmt, ...)	NSLog((@"SQL:%d:%s " fmt),__LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#	define PlopixSQLLog(...)
#endif

#if WS_DEBUG_ENABLED
#	define PlopixWSLog(fmt, ...)	NSLog((@"WS:%d:%s " fmt), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#	define PlopixWSLog(...)
#endif

#if FINE_DEBUG_ENABLED
#	define PlopixFLog(fmt, ...)	NSLog((@"FINE:%d:%s " fmt), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#	define PlopixFLog(...)
#endif

#if ACTION_DEBUG_ENABLED
#	define PlopixACTLog(fmt, ...)	NSLog((@"ACTION:%d:%s " fmt), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#	define PlopixACTLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define PlopixALog(fmt, ...)		NSLog((@"A:%d:%s " fmt), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);

#define	PlopixTrad(string, ...)	[NSString	stringWithFormat: NSLocalizedString(string, nil), ##__VA_ARGS__]

typedef enum ApplicationPath {
	APP_DOCUMENTS,	
	APP_TEMP
} ApplicationPath;

#define APP_VERSION	[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleGetInfoString"]
#define USERAPPS_AGENT [NSString stringWithFormat:@"PlopixServiceiPhoneApps"]

#define UDID	[PlopixUtils md5:[UIDevice currentDevice].uniqueIdentifier]
#define MOBILE_USER_AGENT   [PlopixUtils getMobileUserAgent]

#define CONNECTION_TIMEOUT 120


#import "PlopixGANTrack.h"

