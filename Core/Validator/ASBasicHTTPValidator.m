//
//  Created by Lukasz Warchol on 5/21/12.
//

#import "ASBasicHTTPValidator.h"
#import "ASNetworkResponse.h"
#import "ASNetworkRequest.h"


@implementation ASBasicHTTPValidator {

}

+ (id)validator {
    return [self new];
}

- (NSDictionary *) userInfoWithResponse:(id <ASNetworkResponse>)response
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInteger:response.statusCode] forKey:ASHTTPErrorStatusCodeUserInfoKey];
    if (response.body) {
        NSString *message = [[NSString alloc] initWithData:response.body encoding:NSUTF8StringEncoding];
        [userInfo setObject:message forKey:ASHTTPErrorResponseUserInfoKey];
    }
    return userInfo;
}

- (BOOL)validateResponse:(id <ASNetworkResponse>)response forRequest:(id <ASNetworkRequest>)request error:(NSError **)error {
    BOOL result = YES;
    NSString *domain = nil;
    NSInteger code = -1;
    if (response.statusCode == 401) {
        result = NO;
        domain = ASHTTPErrorDomain;
        code = ASHTTPErrorAuthentication;
    }
    else if (response.statusCode/100 == 5) {
        result = NO;
        domain = ASHTTPErrorDomain;
        code = ASHTTPErrorServerInternalError;
    }
    if (!result) {
        if (error) {
            *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:[self userInfoWithResponse:response]];
        }
    }
    return result;
}

@end
