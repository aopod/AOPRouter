//
//  AOPRouterHandler.m
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouterHandler.h"

@implementation AOPRouterHandler

+ (instancetype)sharedInstance
{
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = self.new;
    });
    return _shared;
}

// Implement a route
/*
- AOPRouterMethodImpl(+,scheme,host,path1,path2)
{
    // Includes an implicit variable named context
    AOPRouterContext *aContext = context;
}
 */

@end
