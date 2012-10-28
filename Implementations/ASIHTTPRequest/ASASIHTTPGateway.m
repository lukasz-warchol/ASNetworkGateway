//
//  Created by Lukasz Warchol on 5/21/12.
//

#import "ASASIHTTPGateway.h"

#import "ASNetworkRequest.h"
#import "ASSimpleResponse.h"

#import "ASIHTTPRequest.h"
#import "ASNetworkCallbacks.h"
#import "NSURL+ASNetwork.h"
#import "ASASIHTTPPendingContainer.h"
#import "ASDeclares.h"

@implementation ASASIHTTPGateway {
    NSMutableDictionary* _activeRequestsDictionary;
}

#pragma mark - Getters

- (NSSet*) pendingRequests
{
    NSMutableSet* requestsSet = [NSMutableSet setWithCapacity:[[_activeRequestsDictionary allValues] count]];
    for (ASASIHTTPPendingContainer* requestsContainer in [_activeRequestsDictionary allValues]) {
        [requestsSet addObject:requestsContainer.request];
    }
    return requestsSet;
}

#pragma mark - Lifecycle

+ (instancetype)gateway {
    return [ASASIHTTPGateway new];
}

- (id)init
{
    self = [super init];
    if (self) {
        _activeRequestsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self cancelAllPendingRequests];
}

#pragma mark - ASNetworkGateway

- (void)makeRequest:(id <ASNetworkRequest>)request withCallbacks:(ASNetworkCallbacks *)callbacks {
    __block ASIHTTPRequest *httpRequest = [self httpRequestForASRequest:request];
    NSLog(@"Requesting %@", httpRequest.url);

    [httpRequest setStartedBlock:^{
        [callbacks runOnStartWithRequest:request];
    }];
    
    __block __WEAK typeof(self) bSelf = self;
    [httpRequest setCompletionBlock:^{
        NSLog(@"Response code %d for %@", httpRequest.responseStatusCode, httpRequest.url);
        [bSelf removeFromActiveRequestsRequest:request];
        
        ASSimpleResponse * response = [ASSimpleResponse responseWithStatusCode:httpRequest.responseStatusCode
                                                                   httpHeaders:httpRequest.responseHeaders
                                                                          body:httpRequest.responseData];
        [callbacks runOnSuccessWithRequest:request response:response];
    }];

    [httpRequest setFailedBlock:^{
        NSLog(@"Failed response with code %d for %@", httpRequest.responseStatusCode, httpRequest.url);
        NSLog(@"Error: %@", httpRequest.error);
        [bSelf removeFromActiveRequestsRequest:request];
        
        [callbacks runOnFailureWithRequest:request error:httpRequest.error];
    }];
    [httpRequest startAsynchronous];
}

- (void) cancelPendingRequest:(id <ASNetworkRequest>)request
{
    if (request) {
        ASIHTTPRequest* httpRequest = [self activeHttpRequestForRequest:request];
        [httpRequest clearDelegatesAndCancel];
        [self removeFromActiveRequestsRequest:request];
    }
}

- (void) cancelAllPendingRequests
{
    for (ASASIHTTPPendingContainer* pendingRequest in _activeRequestsDictionary.allValues) {
        [pendingRequest.httpRequest clearDelegatesAndCancel];
    }
    [_activeRequestsDictionary removeAllObjects];
}

#pragma mark - Request helpers

- (ASIHTTPRequest *)httpRequestForASRequest:(id <ASNetworkRequest>)request{
    NSURL *url = [NSURL URLForRequest:request];
    ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:url];
    [self addToActiveRequestsHttpRequest:httpRequest forRequest:request];
    [self addHeaders:request.httpHeaders toHttpRequest:httpRequest];
    [self setRequestMethod:request toHttpRequest:httpRequest];
    return httpRequest;
}

- (void) addHeaders:(NSDictionary *)headers toHttpRequest:(ASIHTTPRequest *)httpRequest {
    for (NSString *key in [headers keyEnumerator]) {
        [httpRequest addRequestHeader:key value:[headers valueForKey:key]];
    }
}

- (void) setRequestMethod:(id <ASNetworkRequest>)request toHttpRequest:(ASIHTTPRequest *)httpRequest
{
    if ([request respondsToSelector:@selector(requestMethod)]) {
        if (request.requestMethod) {
            [httpRequest setRequestMethod:[request requestMethod]];
        }
    }
}

#pragma mark - Pending requests managment

- (void) addToActiveRequestsHttpRequest:(ASIHTTPRequest*)httpRequest forRequest:(id <ASNetworkRequest>)request
{
    [_activeRequestsDictionary setObject:
            [ASASIHTTPPendingContainer containerWithASRequest:request ASIRequest:httpRequest]
                                     forKey:[NSValue valueWithPointer:(__bridge const void *)(request)]];
}

- (void) removeFromActiveRequestsRequest:(id <ASNetworkRequest>)request
{
    [_activeRequestsDictionary removeObjectForKey:[NSValue valueWithPointer:(__bridge const void *)(request)]];
}

- (ASIHTTPRequest*) activeHttpRequestForRequest:(id <ASNetworkRequest>)request
{
    ASASIHTTPPendingContainer* requestsContainer = [_activeRequestsDictionary objectForKey:[NSValue valueWithPointer:(__bridge const void *)(request)]];
    return requestsContainer.httpRequest;
}

@end
