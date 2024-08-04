//
//  APIEndpoint.m
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import "APIEndpoint.h"

@implementation APIEndpoint

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _request = [NSURLRequest requestWithURL:url];
    }
    return self;
}

@end

