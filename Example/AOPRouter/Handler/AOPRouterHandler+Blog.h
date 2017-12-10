//
//  AOPRouterHandler+Blog.h
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <AOPRouter/AOPRouter.h>

@interface AOPRouterHandler (Blog)

/**
 Open my blog
 aop://blog/open
 */
@AOPRouterMethodName(aop,blog,open);

/**
 Redirect to aop://blog/open
 */
@AOPRouterMethodName(aop,blog,redirect);


@end
