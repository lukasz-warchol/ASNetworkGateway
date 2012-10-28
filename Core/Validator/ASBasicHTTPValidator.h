//
//  Created by Lukasz Warchol on 5/21/12.
//

#import <Foundation/Foundation.h>
#import "ASHTTPValidator.h"

//! Validates for 401 authorisation error and all of errors form 5xx group
@interface ASBasicHTTPValidator : NSObject<ASHTTPValidator>
+ (id)validator;

- (NSDictionary *) userInfoWithResponse:(id <ASNetworkResponse>)response;

@end
