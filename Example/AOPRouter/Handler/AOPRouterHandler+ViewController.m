//
//  AOPRouterHandler+ViewController.m
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPRouterHandler+ViewController.h"
#import "AOPSecondaryViewController.h"

@implementation AOPRouterHandler (ViewController)

/**
 * @param from ViewController
 */
- AOPRouterMethodImpl(+,aop,vc,present)
{
    UIViewController *fromVC = context.parameters[@"from"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AOPSecondaryViewController.class)];
    [fromVC presentViewController:vc animated:context.animated completion:nil];
}

- AOPRouterMethodImpl(+,aop,vc,present,handlevc)
{
    UIViewController *fromVC = context.parameters[@"from"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AOPSecondaryViewController.class)];
    [AOPRouterHandleVC handle:viewController default:^(__kindof UIViewController *vc) {
        [fromVC presentViewController:vc animated:context.animated completion:nil];
    }];
}

@end
