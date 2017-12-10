//
//  AOPRouterConfig.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class AOPRouterContext;

@interface AOPRouterConfig : NSObject

/**
 Default missHandler implementation
 */
@property (nonatomic, copy) void (^defaultMissHandler)(AOPRouterContext *context);

@end
