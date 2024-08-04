//
//  APIEndpoint.h
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIEndpoint : NSObject
@property (nonatomic, strong, readonly) NSURLRequest *request;

- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
