//
//  AOPRouterOpenMediator.h
//  AOPRouter
//
//  Copyright © 2018 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOPRouterOpenMediatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AOPRouterOpenMediator : NSObject

/**
 Open a path
 Should be invoked on main thread if chainly set parameters
 */
@property (class, nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^open)(NSString *urlString);

@end

NS_ASSUME_NONNULL_END

