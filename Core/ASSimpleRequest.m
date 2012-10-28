//
//  Created by Lukasz Warchol on 5/21/12.
//

#import "ASSimpleRequest.h"

@implementation ASSimpleRequest
@synthesize urlString = _urlString;
@synthesize httpHeaders = _httpHeaders;
@synthesize queryParams = _queryParams;
@synthesize postParams = _postParams;
@synthesize requestMethod = _requestMethod;

#pragma mark - Lifecycle

+ (id)requestWithURLString:(NSString *)urlString {
    ASSimpleRequest *request = [self new];
    request.urlString = urlString;
    return request;
}

- (id)init {
    self = [super init];
    if (self) {
        self.requestMethod = @"GET";
        self.httpHeaders = [NSDictionary dictionary];
        self.queryParams = [NSDictionary dictionary];
    }
    return self;
}

@end
