//
//  AOPRouter.m
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouter.h"
#import "AOPRouterContext.h"

@implementation AOPRouter

#pragma mark - Public Interfaces

+ (void)open:(NSString *)urlString
{
    [self open:urlString animated:YES];
}

+ (void)open:(NSString *)urlString animated:(BOOL)animated
{
    [self openInternal:urlString parameters:nil animated:animated forcePublic:YES];
}

#pragma mark - Private Interfaces

+ (void)openInternal:(NSString *)urlString
{
    [self openInternal:urlString animated:YES];
}

+ (void)openInternal:(NSString *)urlString animated:(BOOL)animated
{
    [self openInternal:urlString parameters:nil animated:animated forcePublic:NO];
}

+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters
{
    [self openInternal:urlString parameters:parameters animated:YES];
}

+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    [self openInternal:urlString parameters:parameters animated:animated forcePublic:NO];
}

+ (void)openInternal:(NSString *)urlString parameters:(NSDictionary *)parameters animated:(BOOL)animated forcePublic:(BOOL)forcePublic
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *mParameters = ({
        NSMutableDictionary *queries = @{}.mutableCopy;
        if (url) {
            NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
            NSArray *queryItems = urlComponents.queryItems;
            for (NSURLQueryItem *queryItem in queryItems) {
                [queries setObject:queryItem.value ?: @"" forKey:queryItem.name];
            }
        }
        queries;
    });
    // Parameters passed in have higher priorities than queries in URL
    if ([parameters isKindOfClass:NSDictionary.class]) {
        [mParameters addEntriesFromDictionary:parameters];
    }
    AOPRouterContext *context = AOPRouterContext.new;
    context.url = url;
    context.parameters = mParameters.copy;
    context.animated = animated;
    context.forcePublic = forcePublic;
    [self openInternalWithContext:context];
}

+ (void)openInternalWithContext:(AOPRouterContext *)context
{
    if (context.url.absoluteString == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Default miss handler
            [self missHandler:context];
        });
        return;
    }
    NSURL *url = context.url;
    // Replace `-` with `$`, and replace `.` with `$$`
    NSString *scheme = [[url.scheme.lowercaseString
                         stringByReplacingOccurrencesOfString:@"-" withString:@"$"]
                        stringByReplacingOccurrencesOfString:@"." withString:@"$$"];
    NSString *host = url.host.lowercaseString;
    NSArray *pathComponents = [url.pathComponents filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *  _Nullable path, NSDictionary<NSString *,id> * _Nullable bindings) {
        return path.length > 0 && ![path isEqualToString:@"/"];
    }]];
    NSString *selectorName = ({
        NSArray *components = [@[host] arrayByAddingObjectsFromArray:pathComponents];
        NSString *selectorName = [NSString stringWithFormat:@"route_%@:%@:", scheme, [components componentsJoinedByString:@"$"]];
        [[selectorName stringByReplacingOccurrencesOfString:@"-" withString:@"$"]
         stringByReplacingOccurrencesOfString:@"." withString:@"$$"];
    });
    BOOL hasPublicSelector = NO;
    BOOL hasPrivateSelector = NO;
    SEL selector = NSSelectorFromString(selectorName);
    if ([AOPRouterHandler respondsToSelector:selector]) {
        hasPublicSelector = YES;
    }
    BOOL forcePublic = context.forcePublic;
    if (!forcePublic && [AOPRouterHandler instancesRespondToSelector:selector]) {
        hasPrivateSelector = YES;
    }
    if (!hasPublicSelector && !hasPrivateSelector) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL canHandle = NO;
            // Find available miss handler
            NSMutableArray *components = [@[scheme,host] arrayByAddingObjectsFromArray:pathComponents].mutableCopy;
            while (components.count > 0) {
                NSString *selectorName = [NSString stringWithFormat:@"missHandler:%@:", [components componentsJoinedByString:@"$"]];
                SEL selector = NSSelectorFromString(selectorName);
                if ([AOPRouterHandler respondsToSelector:selector]) {
                    NSMethodSignature *methodSignature = [AOPRouterHandler methodSignatureForSelector:selector];
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                    invocation.target = AOPRouterHandler.class;
                    invocation.selector = selector;
                    AOPRouterContext volatile *aContext = context;
                    [invocation setArgument:&aContext atIndex:2];
                    [invocation invoke];
                    [invocation getReturnValue:&canHandle];
                }
                if (canHandle) {
                    break;
                }
                [components removeLastObject];
            }
            if (!canHandle) {
                [self missHandler:context];
            }
        });
        return;
    }
    
    id target = nil;
    if (hasPublicSelector && forcePublic) {
        target = AOPRouterHandler.class;
    } else if (hasPrivateSelector) {
        target = [AOPRouterHandler sharedInstance];
    } else {
        target = AOPRouterHandler.class;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = target;
        invocation.selector = selector;
        AOPRouterContext volatile *aContext = context;
        [invocation setArgument:&aContext atIndex:2];
        [invocation invoke];
    });
}

/**
 General miss handler.
 No need to return value.
 
 @param context AOPRouterContext instance
 */
+ (void)missHandler:(AOPRouterContext *)context
{
    if (self.config.defaultMissHandler) {
        self.config.defaultMissHandler(context);
    }
}

#pragma mark - Getter
+ (AOPRouterConfig *)config
{
    static AOPRouterConfig *_config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = AOPRouterConfig.new;
    });
    return _config;
}

@end