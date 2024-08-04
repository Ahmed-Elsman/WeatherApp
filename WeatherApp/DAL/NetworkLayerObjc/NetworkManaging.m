//
//  NetworkManaging.m
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

// NetworkManager.m
#import "NetworkManager.h"

@interface NetworkManager ()
@property (nonatomic, strong) id<URLSessionProtocol> session;
@end

@implementation NetworkManager

- (instancetype)initWithSession:(nullable id<URLSessionProtocol>)session {
    self = [super init];
    if (self) {
        _session = session ?: (id<URLSessionProtocol>)[NSURLSession sharedSession];
    }
    return self;
}

- (void)fetchDataFrom:(NSURLRequest *)request completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion {
    [self.session dataWithRequest:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!data || httpResponse.statusCode != 200) {
            NSError *responseError = [NSError errorWithDomain:@"com.example.error" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"Invalid response"}];
            completion(nil, responseError);
            return;
        }
        completion(data, nil);
    }];
}
@end
