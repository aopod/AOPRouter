//
//  AOPRouterOpenMediatorProtocol.h
//  AOPRouter
//
//  Copyright © 2018 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOPRouterMacros.h"

@class AOPRouterContext;

NS_ASSUME_NONNULL_BEGIN

@protocol AOPRouterOpenMediator

@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^animated)(BOOL animated);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^accessInternal)(BOOL enabled);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameter)(id<NSCopying> key, id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameters)(NSDictionary *parameters);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^setParameter)(id<NSCopying> key, __nullable id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^handle)(void (^)(__nullable id object, AOPRouterContext *context));

#pragma mark Deprecated

@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^enableInternal)(BOOL enabled) AOPRouterDeprecated("Use `accessInternal` instead");

@end

NS_ASSUME_NONNULL_END
