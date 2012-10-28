//
//  Created by Lukasz Warchol on 5/21/12.
//

#import "ASHTTPError.h"

@protocol ASNetworkResponse;
@protocol ASNetworkRequest;

@protocol ASHTTPValidator <NSObject>

- (BOOL)validateResponse:(id <ASNetworkResponse>)response
              forRequest:(id <ASNetworkRequest>)request
                   error:(NSError **)error;

@end
