//
//  Created by Lukasz Warchol on 5/21/12.
//

#import "ASNetworkCallbacks.h"
#import "ASBasicHTTPValidator.h"


@implementation ASNetworkCallbacks

#pragma mark - Lifecycle

+ (ASNetworkCallbacks *)callbacks {
    return [self callbacksWithOnStart:nil onSuccess:nil onFailure:nil];
}

+ (ASNetworkCallbacks *)callbacksWithOnSuccess:(ASOnSuccessBlock)onSuccess {
    return [self callbacksWithOnStart:nil onSuccess:onSuccess onFailure:nil];
}

+ (ASNetworkCallbacks *)callbacksWithOnSuccess:(ASOnSuccessBlock)onSuccess onFailure:(ASOnFailureBlock)onFailure {
    return [self callbacksWithOnStart:nil onSuccess:onSuccess onFailure:onFailure];
}

+ (ASNetworkCallbacks *)callbacksWithOnStart:(ASOnStartBlock)onStart onSuccess:(ASOnSuccessBlock)onSuccess onFailure:(ASOnFailureBlock)onFailure {
    ASNetworkCallbacks *callbacks = [ASNetworkCallbacks new];
    callbacks.onStart = onStart;
    callbacks.onSuccess = onSuccess;
    callbacks.onFailure = onFailure;
    return callbacks;
}

- (id)init {
    self = [super init];
    if (self) {
        self.httpValidator = [ASBasicHTTPValidator validator];
    }
    return self;
}

#pragma mark - Callbacks running

- (void)runOnStartWithRequest:(id<ASNetworkRequest>)request{
    if (self.onStart) {
        self.onStart(request);
    }
}

- (void)runOnSuccessWithRequest:(id<ASNetworkRequest>)request
                       response:(id<ASNetworkResponse>)response{
    NSError * error = nil;
    if (self.httpValidator == nil
            || [self.httpValidator validateResponse:response
                                         forRequest:request
                                              error:&error]) {
        if (self.onSuccess) {
            self.onSuccess(request, response);
        }
    }else{
        [self runOnFailureWithRequest:request error:error];
    }
}

- (void)runOnFailureWithRequest:(id<ASNetworkRequest>)request
                          error:(NSError*)error{
    if (self.onFailure) {
        self.onFailure(request, error);
    }
}

@end
