//
//  AOPRouter.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOPRouterMacros.h"
#import "AOPRouterContext.h"
#import "AOPRouterConfig.h"
#import "AOPRouterHandler.h"
#import "AOPRouterOpenMediatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AOPRouter : NSObject

/**
 Router config
 */
@property (class, nonatomic, strong, readonly) AOPRouterConfig *config;

/**
 AOPRouter.open()
 */
@property (class, nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^open)(NSString *urlString);

#pragma mark - Public Interfaces

+ (void)open:(NSString *)urlString;
+ (void)open:(NSString *)urlString animated:(BOOL)animated;

#pragma mark - Internal Interfaces

+ (void)openInternal:(NSString *)urlString;
+ (void)openInternal:(NSString *)urlString animated:(BOOL)animated;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters animated:(BOOL)animated;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters animated:(BOOL)animated forcePublic:(BOOL)forcePublic;

+ (void)openInternalWithContext:(AOPRouterContext *)context;

#pragma mark - Default miss handler

+ (void)missHandler:(AOPRouterContext *)context;

@end

NS_ASSUME_NONNULL_END
