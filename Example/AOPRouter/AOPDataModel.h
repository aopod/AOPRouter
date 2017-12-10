//
//  AOPDataModel.h
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOPDataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^action)(void);

+ (instancetype)modelWithTitle:(NSString *)title action:(void (^)(void))action;

@end
