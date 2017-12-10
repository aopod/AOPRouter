//
//  AOPRouterHandler+Log.m
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouterHandler+Log.h"

@implementation AOPRouterHandler (Log)

/**
 Private URL
 */
- AOPRouterMethodImpl(-,aop,log)
{
    NSString *message = context.parameters[@"message"];
    NSLog(@"log a message: %@", message);
}

#pragma mark - Miss Handlers

/**
 Miss handler for aop://
 */
AOPRouterMissHandler(aop)
{
    NSLog(@"Miss handler: %s", __FUNCTION__);
    return YES;
}

/**
 Miss handler for aop://log
 return NO will fallthrough to miss handler for aop://
 */
AOPRouterMissHandler(aop,log)
{
    NSLog(@"Miss handler: %s", __FUNCTION__);
    return YES;
}

@end
