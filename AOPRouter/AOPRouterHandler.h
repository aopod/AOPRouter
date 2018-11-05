//
//  AOPRouterHandler.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class AOPRouterContext;

NS_ASSUME_NONNULL_BEGIN

/**
 * Route Handler
 *
 * Add route through Category
 */
@interface AOPRouterHandler : NSObject

+ (instancetype)shared;

// Declare a route, can have comment on it
// @AOPRouterMethodName(scheme,host,path1,path2);

+ (void)context:(AOPRouterContext *)context handle:(__nullable id)object default:(void (^)(__nullable id object))defaultAction;

@end

NS_ASSUME_NONNULL_END
