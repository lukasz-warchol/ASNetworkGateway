//
//  Created by Lukasz Warchol on 5/21/12.
//


#import <Foundation/Foundation.h>
#import "ASNetworkResponse.h"


@interface ASSimpleResponse : NSObject<ASNetworkResponse>

+ (instancetype) responseWithStatusCode:(NSInteger)statusCode
                            httpHeaders:(NSDictionary *)headers
                                   body:(NSData*)body;

@end
