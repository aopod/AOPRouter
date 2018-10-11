//
//  AOPRouterOpenMediatorProtocol.h
//  AOPRouter
//
//  Created by air on 2018/10/9.
//

#import <Foundation/Foundation.h>

@class AOPRouterContext;

@protocol AOPRouterOpenMediator

@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^animated)(BOOL animated);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^enableInternal)(BOOL enabled);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameter)(id<NSCopying> key, id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameters)(NSDictionary *parameters);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^setParameter)(id<NSCopying> key, id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^handle)(void (^)(id object, AOPRouterContext *context));

@end
