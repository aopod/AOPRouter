//
//  AOPRouterContext.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOPRouterContext : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) BOOL forcePublic;                 ///< Force access scope to be public
@property (nonatomic, copy  ) void (^handle)(__nullable id object, AOPRouterContext *context);

@end

NS_ASSUME_NONNULL_END
