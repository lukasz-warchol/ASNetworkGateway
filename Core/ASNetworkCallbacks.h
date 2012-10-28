//
//  Created by Lukasz Warchol on 5/21/12.
//

#import <Foundation/Foundation.h>
#import "ASNetworkRequest.h"
#import "ASNetworkResponse.h"

@protocol ASHTTPValidator;

typedef void (^ASOnStartBlock)(id<ASNetworkRequest> request);
typedef void (^ASOnSuccessBlock)(id<ASNetworkRequest> request, id<ASNetworkResponse> response);
typedef void (^ASOnFailureBlock)(id<ASNetworkRequest> request, NSError* error);

@interface ASNetworkCallbacks : NSObject
@property (nonatomic, copy) ASOnStartBlock onStart;
@property (nonatomic, copy) ASOnSuccessBlock onSuccess;
@property (nonatomic, copy) ASOnFailureBlock onFailure;

@property (nonatomic, retain) id<ASHTTPValidator> httpValidator;

+ (ASNetworkCallbacks *)callbacks;
+ (ASNetworkCallbacks *)callbacksWithOnSuccess:(ASOnSuccessBlock)onSuccess;
+ (ASNetworkCallbacks *)callbacksWithOnSuccess:(ASOnSuccessBlock)onSuccess onFailure:(ASOnFailureBlock)onFailure;
+ (ASNetworkCallbacks *)callbacksWithOnStart:(ASOnStartBlock)onStart onSuccess:(ASOnSuccessBlock)onSuccess onFailure:(ASOnFailureBlock)onFailure;

- (void)runOnStartWithRequest:(id<ASNetworkRequest>)request;
- (void)runOnSuccessWithRequest:(id<ASNetworkRequest>)request response:(id<ASNetworkResponse>)response;
- (void)runOnFailureWithRequest:(id<ASNetworkRequest>)request error:(NSError*)error;

@end
