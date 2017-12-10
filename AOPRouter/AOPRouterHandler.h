//
//  AOPRouterHandler.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Route Handler
 *
 * Add route through Category
 */
@interface AOPRouterHandler : NSObject

+ (instancetype)sharedInstance;

// Declare a route, can have comment on it
// @AOPRouterMethodName(scheme,host,path1,path2);

@end
