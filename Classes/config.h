/*
 *  config.h
 *  PlopixUtils
 *
 *  Created by Plopix on 10/01/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */



#define DEBUG_ENABLED 1
#define FINEDEBUG_ENABLED 1
#define BTDEBUG_ENABLED 1
#define WS_DEBUG_ENABLED 1

#if WS_DEBUG_ENABLED
#define DEBUG_REQUEST_STATUS 1
#define DEBUG_FORM_DATA_REQUEST 1
#define DEBUG_THROTTLING 1
#define DEBUG_PERSISTENT_CONNECTIONS 1
#endif

#define BDD_FILENAME @"NEED_TO_SET"


#define HTTPS		0
#define ZONE_HOST		".plopix.net"
#define PREFIX_HOST		"www"
#define ROOT_URL	[NSString stringWithFormat:@"%s://%s%s",(HTTPS==1)?"https":"http",PREFIX_HOST,ZONE_HOST]
