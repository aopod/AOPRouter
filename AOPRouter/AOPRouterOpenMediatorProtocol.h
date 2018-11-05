//
//  AOPRouterOpenMediatorProtocol.h
//  AOPRouter
//
//  Created by air on 2018/10/9.
//

#import <Foundation/Foundation.h>

@class AOPRouterContext;

NS_ASSUME_NONNULL_BEGIN

@protocol AOPRouterOpenMediator

@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^animated)(BOOL animated);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^enableInternal)(BOOL enabled);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameter)(id<NSCopying> key, id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameters)(NSDictionary *parameters);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^setParameter)(id<NSCopying> key, __nullable id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^handle)(void (^)(__nullable id object, AOPRouterContext *context));

@end

NS_ASSUME_NONNULL_END
