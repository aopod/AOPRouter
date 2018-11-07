//
//  AOPRouter.m
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouter.h"
#import "AOPRouterOpenMediator.h"

@implementation AOPRouter

+ (AOPRouterConfig *)config
{
    static AOPRouterConfig *_config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = AOPRouterConfig.new;
    });
    return _config;
}

+ (id<AOPRouterOpenMediator> (^)(NSString *))open
{
    return AOPRouterOpenMediator.open;
}

+ (void)openInternalWithContext:(AOPRouterContext *)context
{
    [self performSelectorOnMainThread:@selector(_openInternalWithContext:) withObject:context waitUntilDone:NO];
}

+ (void)_openInternalWithContext:(AOPRouterContext *)context
{
    NSURL *url = context.url;
    if (url.absoluteString.length == 0) {
        // Default miss handler
        [self missHandler:context];
        return;
    }
    // Replace `-` with `$`, and replace `.` with `$$`
    NSString *scheme = [[url.scheme.lowercaseString
                         stringByReplacingOccurrencesOfString:@"-" withString:@"$"]
                        stringByReplacingOccurrencesOfString:@"." withString:@"$$"];
    NSString *host = url.host.lowercaseString;
    NSArray *pathComponents = [url.pathComponents filteredArrayUsingPredicate:({
        [NSPredicate predicateWithBlock:^BOOL(NSString *  _Nullable path, NSDictionary<NSString *,id> * _Nullable bindings) {
            return path.length > 0 && ![path isEqualToString:@"/"];
        }];
    })];
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
        BOOL canHandle = NO;
        // Find available miss handler
        NSMutableArray *components = [@[scheme,host] arrayByAddingObjectsFromArray:pathComponents].mutableCopy;
        while (components.count > 0) {
            NSString *selectorName = [NSString stringWithFormat:@"missHandler:%@:", [components componentsJoinedByString:@"$"]];
            SEL selector = NSSelectorFromString(selectorName);
            if ([AOPRouterHandler respondsToSelector:selector]) {
                NSInvocation *invocation = [self invokeWithTarget:AOPRouterHandler.class selector:selector context:context];
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
        return;
    }
    
    id target = nil;
    if (hasPublicSelector && forcePublic) {
        target = AOPRouterHandler.class;
    } else if (hasPrivateSelector) {
        target = AOPRouterHandler.shared;
    } else {
        target = AOPRouterHandler.class;
    }
    
    [self invokeWithTarget:target selector:selector context:context];
}

/**
 Default miss handler.
 No need to return value.
 
 @param context AOPRouterContext instance
 */
+ (void)missHandler:(AOPRouterContext *)context
{
    if (self.config.defaultMissHandler) {
        self.config.defaultMissHandler(context);
    }
}

+ (NSInvocation *)invokeWithTarget:(id)target
                          selector:(SEL)selector
                           context:(AOPRouterContext *)context
{
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = target;
    invocation.selector = selector;
    [invocation setArgument:&context atIndex:2];
    [invocation retainArguments];
    [invocation invoke];
    return invocation;
}

#pragma mark Deprecated

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

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
                [queries setValue:queryItem.value forKey:queryItem.name];
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
#pragma clang diagnostic pop

@end
