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
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AOPSecondaryViewController"];
    [fromVC presentViewController:vc animated:context.animated completion:nil];
}

@end
