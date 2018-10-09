//
//  AOPRouterOpenMediator.h
//  AOPRouter
//
//  Copyright © 2018 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AOPRouterOpenMediator

@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^animated)(BOOL animated);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^forcePublic)(BOOL forcePublic);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameter)(id<NSCopying> key, id value);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^parameters)(NSDictionary *parameters);
@property (nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^setParameter)(id<NSCopying> key, id value);

@end

@interface AOPRouterOpenMediator : NSObject

@property (class, nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^open)(NSString *urlString);

@end
