//
//  AOPRouterOpenMediator.h
//  AOPRouter
//
//  Copyright © 2018 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOPRouterOpenMediatorProtocol.h"

@interface AOPRouterOpenMediator : NSObject

@property (class, nonatomic, strong, readonly) id<AOPRouterOpenMediator> (^open)(NSString *urlString);

@end
