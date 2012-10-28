//
//  Created by Lukasz Warchol on 5/21/12.
//

#import <Foundation/Foundation.h>

typedef enum {
    ASHTTPErrorAuthentication,
    ASHTTPErrorServerInternalError,
    ASHTTPErrorClientError
}ASHTTPError;

extern NSString* const ASHTTPErrorDomain;
extern NSString* const ASHTTPErrorResponseUserInfoKey;
extern NSString* const ASHTTPErrorStatusCodeUserInfoKey;
