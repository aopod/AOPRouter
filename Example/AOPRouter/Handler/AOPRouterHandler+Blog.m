//
//  AOPRouterHandler+Blog.m
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouterHandler+Blog.h"

@implementation AOPRouterHandler (Blog)

- AOPRouterMethodImpl(+,aop,blog,open)
{
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"http://www.aopod.com"]];
}

- AOPRouterMethodImpl(+,aop,blog,redirect)
{
    context.url = [NSURL URLWithString:kAOPRouterPath(aop_blog_open)];
    [AOPRouter openInternalWithContext:context];
}

@end
