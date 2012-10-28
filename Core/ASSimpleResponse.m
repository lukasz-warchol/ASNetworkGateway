//
//  Created by Lukasz Warchol on 5/21/12.
//


#import "ASSimpleResponse.h"

@interface ASSimpleResponse ()
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSDictionary *httpHeaders;
@property (nonatomic, strong) NSData* body;
@end

@implementation ASSimpleResponse

+ (instancetype) responseWithStatusCode:(NSInteger)statusCode
                            httpHeaders:(NSDictionary *)headers
                                   body:(NSData*)body;
{
    ASSimpleResponse * response = [[ASSimpleResponse alloc] init];
    response.statusCode = statusCode;
    response.httpHeaders = headers;
    response.body = body;
    return response ;
}

@end
