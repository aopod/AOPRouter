//
//  AOPViewController.m
//  AOPRouter_Example
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPViewController.h"
#import "AOPDataModel.h"
#import "AOPRouter.h"
#import "AOPRouterHandler+Blog.h"
#import "AOPRouterHandler+Log.h"
#import "AOPRouterHandler+ViewController.h"

@interface AOPViewController () <
    UITableViewDelegate, UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray<AOPDataModel *> *data;

@end

@implementation AOPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setup];
}

- (void)setup
{
    AOPRouter.config.defaultMissHandler = ^(AOPRouterContext *context) {
        NSLog(@"Miss handler for URL: %@", context.url.absoluteString);
    };
    
    self.data = @[].mutableCopy;
    
    [self.data addObject:[AOPDataModel modelWithTitle:@"Go to Blog" action:^{
        [AOPRouter open:kAOPRouterPath(aop_blog_open)];
    }]];
    [self.data addObject:[AOPDataModel modelWithTitle:@"Miss handler" action:^{
        [AOPRouter open:@"aop://log/does/not/exist"];
    }]];
    [self.data addObject:[AOPDataModel modelWithTitle:@"Log message" action:^{
        [AOPRouter openInternal:kAOPRouterPath(aop_log)
                     parameters:@{
                                  @"message": @"Hello, World!"
                                  } animated:NO];
    }]];
    __weak typeof(self) weakSelf = self;
    [self.data addObject:[AOPDataModel modelWithTitle:@"Present viewController" action:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [AOPRouter openInternal:kAOPRouterPath(aop_vc_present)
                     parameters:@{
                                  @"from": strongSelf,
                                  }
                       animated:YES];
    }]];
    [self.data addObject:[AOPDataModel modelWithTitle:@"Redirect" action:^{
        AOPRouterOpen(aop_blog_redirect);
    }]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AOPDataModel *model = self.data[indexPath.row];
    if (model.action) {
        model.action();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AOPDataModel *model = self.data[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"base" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"[%ld] %@", indexPath.row, model.title];
    return cell;
}

@end
