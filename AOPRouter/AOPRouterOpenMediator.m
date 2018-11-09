//
//  AOPRouterOpenMediator.m
//  AOPRouter
//
//  Copyright © 2018 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouterOpenMediator.h"
#import "AOPRouterContext.h"
#import "AOPRouter.h"

@interface AOPRouterOpenMediator() <
    AOPRouterOpenMediator
>

@property (nonatomic, strong) AOPRouterContext *context;

@end

@implementation AOPRouterOpenMediator

+ (id<AOPRouterOpenMediator> (^)(NSString *))open
{
    id<AOPRouterOpenMediator> (^block)(NSString *) = ^id<AOPRouterOpenMediator>(NSString *urlString) {
        AOPRouterOpenMediator *obj = AOPRouterOpenMediator.new;
        obj.context = ({
            NSURL *url = [NSURL URLWithString:urlString];
            AOPRouterContext *context = AOPRouterContext.new;
            context.url = url;
            context.parameters = [self _queriesFromURL:url];
            context.animated = NO;
            context.forcePublic = YES;
            context;
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [AOPRouter openInternalWithContext:obj.context];
        });
        return obj;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(BOOL))animated
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(BOOL) = ^id<AOPRouterOpenMediator>(BOOL animated) {
        __strong typeof(weakSelf) self = weakSelf;
        self.context.animated = animated;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(BOOL))accessInternal
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(BOOL) = ^id<AOPRouterOpenMediator>(BOOL enabled) {
        __strong typeof(weakSelf) self = weakSelf;
        self.context.forcePublic = !enabled;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(id<NSCopying>, id))parameter
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(id<NSCopying>, id) = ^id<AOPRouterOpenMediator>(id<NSCopying> key, id value) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!key) {
            return self;
        }
        NSMutableDictionary *parameters = @{}.mutableCopy;
        parameters[key] = value;
        self.context.parameters = parameters;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(NSDictionary *))parameters
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(NSDictionary *) = ^id<AOPRouterOpenMediator>(NSDictionary *parameters) {
        __strong typeof(weakSelf) self = weakSelf;
        if (![parameters isKindOfClass:NSDictionary.class]) {
            return self;
        }
        self.context.parameters = parameters;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(id<NSCopying>, __nullable id))setParameter
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(id<NSCopying>, id) = ^id<AOPRouterOpenMediator>(id<NSCopying> key, id value) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!key) {
            return self;
        }
        NSMutableDictionary *parameters = (self.context.parameters ?: @{}).mutableCopy;
        [parameters setObject:value forKey:key];
        self.context.parameters = parameters;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(void (^)(id, AOPRouterContext *)))handle
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(void (^)(id, AOPRouterContext *)) = ^id<AOPRouterOpenMediator>(void (^handle)(id, AOPRouterContext*)) {
        __strong typeof(weakSelf) self = weakSelf;
        self.context.handle = handle;
        return self;
    };
    return block;
}

#pragma mark - Private

+ (NSDictionary *)_queriesFromURL:(NSURL *)url
{
    NSMutableDictionary *queries = @{}.mutableCopy;
    if (url) {
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        NSArray *queryItems = urlComponents.queryItems;
        for (NSURLQueryItem *queryItem in queryItems) {
            [queries setValue:queryItem.value forKey:queryItem.name];
        }
    }
    return queries;
}

#pragma mark Deprecated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (id<AOPRouterOpenMediator> (^)(BOOL))enableInternal
{
    return self.accessInternal;
}
#pragma clang diagnostic pop

@end
