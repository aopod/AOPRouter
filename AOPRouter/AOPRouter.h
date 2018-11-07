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
 AOPRouter.open(URLString)
 Default values:
 * animated: YES
 * accessInternal: NO
 */
@property (class, nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^open)(NSString *urlString);

+ (void)openInternalWithContext:(AOPRouterContext *)context;

#pragma mark - Default miss handler

+ (void)missHandler:(AOPRouterContext *)context;

#pragma mark Deprecated

#pragma mark - Public Interfaces

+ (void)open:(NSString *)urlString AOPRouterDeprecated("Use AOPRouter.open(*) instead");
+ (void)open:(NSString *)urlString animated:(BOOL)animated AOPRouterDeprecated("Use AOPRouter.open(*).animated(*) instead");

#pragma mark - Internal Interfaces

+ (void)openInternal:(NSString *)urlString AOPRouterDeprecated("Use AOPRouter.open(*).accessInternal(YES) instead");
+ (void)openInternal:(NSString *)urlString animated:(BOOL)animated AOPRouterDeprecated("Use AOPRouter.open(*).accessInternal(YES).animated(*) instead");
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters AOPRouterDeprecated("Use AOPRouter.open(*).accessInternal(YES).parameters(*) instead");
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters animated:(BOOL)animated AOPRouterDeprecated("Use AOPRouter.open(*).accessInternal(YES).parameters(*).animated(*) instead");
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary * _Nullable)parameters animated:(BOOL)animated forcePublic:(BOOL)forcePublic AOPRouterDeprecated("Use AOPRouter.open(*).accessInternal(*).parameters(*).animted(*) instead");

@end

NS_ASSUME_NONNULL_END
