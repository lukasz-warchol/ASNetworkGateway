//
//  Created by Lukasz Warchol on 5/21/12.
//

@protocol ASNetworkRequest;
@class ASNetworkCallbacks;

@protocol ASNetworkGateway <NSObject>
@property (nonatomic, retain, readonly) NSSet/*<ASNetworkRequest>*/ *pendingRequests;

- (void) makeRequest:(id <ASNetworkRequest>)request withCallbacks:(ASNetworkCallbacks *)callbacks;
- (void) cancelPendingRequest:(id <ASNetworkRequest>)request;
- (void) cancelAllPendingRequests;

@end
