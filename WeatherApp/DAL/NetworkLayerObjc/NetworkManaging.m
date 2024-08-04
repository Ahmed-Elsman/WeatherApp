//
//  NetworkManaging.m
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import "NetworkManager.h"

@interface NetworkManager ()
@property (nonatomic, strong) id<URLSessionProtocol> session;
@end

@implementation NetworkManager

- (instancetype)initWithSession:(id<URLSessionProtocol>)session {
    self = [super init];
    if (self) {
        _session = session ? session : [NSURLSession sharedSession];
    }
    return self;
}

- (void)fetchDataFrom:(NSURLRequest *)request completion:(void (^)(id _Nullable, NSError * _Nullable))completion {
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

        NSError *jsonError = nil;
        id decodedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completion(nil, jsonError);
        } else {
            completion(decodedData, nil);
        }
    }];
}

@end

