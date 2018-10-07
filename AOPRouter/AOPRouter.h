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

@interface AOPRouter : NSObject

@property (class, nonatomic, strong, readonly) AOPRouterConfig *config;

#pragma mark - Public Interfaces

+ (void)open:(NSString *)urlString;
+ (void)open:(NSString *)urlString animated:(BOOL)animated;

#pragma mark - Private Interfaces

+ (void)openInternal:(NSString *)urlString;
+ (void)openInternal:(NSString *)urlString animated:(BOOL)animated;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters animated:(BOOL)animated;
+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters animated:(BOOL)animated forcePublic:(BOOL)forcePublic;
+ (void)openInternalWithContext:(AOPRouterContext *)context;
+ (void)missHandler:(AOPRouterContext *)context;

@end
