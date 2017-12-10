# AOPRouter

A URL routing solution for iOS. With features such as:

* Autocomplete
* Comment available
* Duplication check
* Miss handler
* Simple Public/Private access control
* Xcode friendly
* etc.

## Usage Examples

### Declare routes

```objc
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
```

### Get parameters

```objc
- AOPRouterMethodImpl(-,aop,log)
{
    NSString *message = context.parameters[@"message"];
    NSLog(@"log a message: %@", message);
}
```

### Call routes

```objc
[AOPRouter open:kAOPRouterPath(aop_blog_open)];

[AOPRouter open:@"aop://blog/open"];

[AOPRouter openInternal:kAOPRouterPath(aop_log)
                     parameters:@{
                                  @"message": @"Hello, World!"
                                  } animated:NO];

AOPRouterOpen(aop_blog_redirect);
```


### Declare miss handlers

```objc
AOPRouterMissHandler(aop)
{
    NSLog(@"Miss handler: %s", __FUNCTION__);
    return YES;
}

AOPRouterMissHandler(aop,log)
{
    NSLog(@"Miss handler: %s", __FUNCTION__);
    return YES;
}
```


## More Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

AOPRouter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AOPRouter'
```

## Author

aopodcom, aopodcom@gmail.com

## License

AOPRouter is available under the MIT license. See the LICENSE file for more info.
