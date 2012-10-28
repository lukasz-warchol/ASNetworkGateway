//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ASASIHTTPPendingContainer.h"
#import "ASNetworkRequest.h"


@implementation ASASIHTTPPendingContainer

+ (ASASIHTTPPendingContainer*)containerWithASRequest:(id <ASNetworkRequest>)request
                                          ASIRequest:(ASIHTTPRequest*) httpRequest
{
    ASASIHTTPPendingContainer* container = [[ASASIHTTPPendingContainer alloc] init];
    container.request = request;
    container.httpRequest = httpRequest;
    return container;
}

@end
