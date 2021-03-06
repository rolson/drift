//
//  YLPAppDelegate.m
//  YelpAPI
//
//  Created by David Chen on 12/07/2015.
//  Copyright (c) 2015 David Chen. All rights reserved.
//

#import "YLPAppDelegate.h"

@import YelpAPI;

@interface YLPAppDelegate ()
@property (strong, nonatomic) YLPClient *client;
@end

@implementation YLPAppDelegate

+ (YLPClient *)sharedClient {
    YLPAppDelegate *appDelegate = (YLPAppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.client;
}

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //#warning Fill in the API keys below with your developer v3 keys.
    [YLPClient authorizeWithAppId:@"d2m6ISsK1MUKyPO_75TZ9Q" secret:@"m5TQIeSgmI7iwudxBHRnGuQKixN9gE9gB2CVeYYjoNC0My6v8Ir7gmQJAGJs3xk3" completionHandler:^(YLPClient *client, NSError *error) {
        self.client = client;
        if (!client) {
            NSLog(@"Authentication failed: %@", error);
        }
    }];

    return YES;
}

@end
