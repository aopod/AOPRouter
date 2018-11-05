//
//  AOPRouterConfig.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class AOPRouterContext;

NS_ASSUME_NONNULL_BEGIN

@interface AOPRouterConfig : NSObject

/**
 Default missHandler implementation
 */
@property (nonatomic, copy) void (^ __nullable defaultMissHandler)(AOPRouterContext *context);

@end

NS_ASSUME_NONNULL_END
