//
//  AOPRouterHandler+ViewController.h
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <AOPRouter/AOPRouter.h>

@interface AOPRouterHandler (ViewController)

/**
 Present a secondary ViewController
 */
@AOPRouterMethodName(aop,vc,present);

/**
 Handle result manually and with a default action
 */
@AOPRouterMethodName(aop,vc,present,handlevc);

@end
