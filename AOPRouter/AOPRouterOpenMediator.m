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
        obj.context = AOPRouterContext.new;
        obj.context.url = [NSURL URLWithString:urlString];
        obj.context.animated = NO;
        obj.context.forcePublic = NO;
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
        [parameters setObject:value forKeyedSubscript:key];
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
        if (parameters && ![parameters isKindOfClass:NSDictionary.class]) {
            return self;
        }
        self.context.parameters = parameters;
        return self;
    };
    return block;
}

- (id<AOPRouterOpenMediator> (^)(id<NSCopying>, id))setParameter
{
    __weak typeof(self) weakSelf = self;
    id<AOPRouterOpenMediator> (^block)(id<NSCopying>, id) = ^id<AOPRouterOpenMediator>(id<NSCopying> key, id value) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!key) {
            return self;
        }
        NSMutableDictionary *parameters = (self.context.parameters ?: @{}).mutableCopy;
        [parameters setObject:value forKeyedSubscript:key];
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

#pragma mark Deprecated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (id<AOPRouterOpenMediator> (^)(BOOL))enableInternal
{
    return self.accessInternal;
}
#pragma clang diagnostic pop

@end
