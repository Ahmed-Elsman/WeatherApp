//
//  URLSessionProtocol.m
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//


#import "URLSessionProtocol.h"

@implementation NSURLSession (URLSessionProtocol)

- (void)dataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completion];
    [task resume];
}

@end

