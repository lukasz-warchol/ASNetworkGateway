//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ASMKNetworkKitGateway.h"
#import "ASNetworkCallbacks.h"
#import "MKNetworkKit.h"
#import "NSURL+ASNetwork.h"
#import "ASAPNetworkKitPendingConnectionContainer.h"
#import "ASSimpleResponse.h"
#import "ASDeclares.h"

@implementation ASMKNetworkKitGateway{
    NSMutableArray *_pendingConnectionsContainers;
}

#pragma mark - Lifecycle

+ (instancetype)gateway {
    return [ASMKNetworkKitGateway new];
}

- (id)init {
    self = [super init];
    if (self) {
        _pendingConnectionsContainers = [NSMutableArray new];
        self.networkEngine = [MKNetworkEngine new];
    }
    return self;
}

- (void)dealloc {
    [self cancelAllPendingRequests];
}

#pragma mark - ASNetworkGateway

- (NSSet *)pendingRequests {
    NSMutableSet *pendingRequests = [NSMutableSet setWithCapacity:_pendingConnectionsContainers.count];
    for (ASAPNetworkKitPendingConnectionContainer *container in _pendingConnectionsContainers) {
        [pendingRequests addObject:container.request];
    }
    return pendingRequests;
}

- (void)makeRequest:(id <ASNetworkRequest>)request withCallbacks:(ASNetworkCallbacks *)callbacks {
    NSString *requestMethod = request.requestMethod;
    if (!requestMethod) {
        requestMethod = @"GET";
    }
    MKNetworkOperation *operation = [self.networkEngine operationWithURLString:[[NSURL URLForRequest:request] absoluteString]
                                                                        params:[request.postParams mutableCopy]
                                                                    httpMethod:requestMethod];

    [self addOperationToPendingConnections:operation forRequest:request];

    __block __WEAK typeof(self) bSelf = self;
    [operation onCompletion:^(MKNetworkOperation *completedOperation) {
        ASSimpleResponse *response = [ASSimpleResponse responseWithStatusCode:completedOperation.HTTPStatusCode
                                                                   httpHeaders:completedOperation.readonlyRequest.allHTTPHeaderFields
                                                                          body:completedOperation.responseData];

        [bSelf removePendingConnectionContainerForRequest:request];
        [callbacks runOnSuccessWithRequest:request response:response];
    } onError:^(NSError *error) {
        [bSelf removePendingConnectionContainerForRequest:request];
        [callbacks runOnFailureWithRequest:request error:error];
    }];

    [callbacks runOnStartWithRequest:request];
    [self.networkEngine enqueueOperation:operation];
}

- (void)cancelPendingRequest:(id <ASNetworkRequest>)request {
    ASAPNetworkKitPendingConnectionContainer *container = [self pendingConnectionContainerForRequest:request];
    [_pendingConnectionsContainers removeObject:container];
    [container.operation cancel];
}

- (void)cancelAllPendingRequests {
    NSArray * connectionsContainersCopy = [_pendingConnectionsContainers copy];
    [_pendingConnectionsContainers removeAllObjects];
    for (ASAPNetworkKitPendingConnectionContainer *container in connectionsContainersCopy) {
        [container.operation cancel];
    }
}

#pragma mark - Helper methods

- (void)addOperationToPendingConnections:(MKNetworkOperation *)operation forRequest:(id <ASNetworkRequest>)request {
    ASAPNetworkKitPendingConnectionContainer* container = [ASAPNetworkKitPendingConnectionContainer containerWithASRequest:request
                                                         MKOperation:operation];
    [_pendingConnectionsContainers addObject:container];
}

- (void)removePendingConnectionContainerForRequest:(id <ASNetworkRequest>)request {
    ASAPNetworkKitPendingConnectionContainer *container = [self pendingConnectionContainerForRequest:request];
    [_pendingConnectionsContainers removeObject:container];
}

- (ASAPNetworkKitPendingConnectionContainer *)pendingConnectionContainerForRequest:(id <ASNetworkRequest>)request {
    ASAPNetworkKitPendingConnectionContainer *matchingContainer = nil;
    for (ASAPNetworkKitPendingConnectionContainer *container in _pendingConnectionsContainers) {
        if (container.request == request) {
            matchingContainer = container;
            break;
        }
    }
    return matchingContainer;
}

@end
