//
//  AOPDataModel.m
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPDataModel.h"

@implementation AOPDataModel

+ (instancetype)modelWithTitle:(NSString *)title action:(void (^)(void))action
{
    AOPDataModel *model = AOPDataModel.new;
    model.title = title;
    model.action = action;
    return model;
}

@end
