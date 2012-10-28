//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSURL+ASNetwork.h"
#import "ASNetworkRequest.h"


@implementation NSURL (ASNetwork)

+ (NSURL *)URLForRequest:(id <ASNetworkRequest>)request {
    NSString *queryString = [self searchStringFromParams:request.queryParams];
    if (queryString.length > 0) {
        queryString = [@"?" stringByAppendingString:queryString];
    }

    NSString *urlString = [NSString stringWithFormat:@"%@%@", request.urlString, queryString];
    return [NSURL URLWithString:urlString];
}

+ (NSString *)searchStringFromParams:(NSDictionary *)params {
    NSString *searchString = @"";
    NSString *delimiter = @"";

    for (NSString *key in [params keyEnumerator]) {
        NSString *value = [params valueForKey:key];

        NSString *encodedKey = [self urlEncode:key];
        NSString *encodedValue = [self urlEncode:value];

        NSString *pair = [NSString stringWithFormat:@"%@%@=%@", delimiter, encodedKey, encodedValue];
        searchString = [searchString stringByAppendingString:pair];

        delimiter = @"&";
    }

    return searchString;
}

+ (NSString *)urlEncode:(NSString *)unencodedString {
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
            NULL,
            (__bridge CFStringRef) unencodedString,
            NULL,
            (CFStringRef) @"!*'();:@&=+$,/?%#[]",
            kCFStringEncodingUTF8));
}

@end
