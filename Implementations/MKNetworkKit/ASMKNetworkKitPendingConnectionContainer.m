//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ASMKNetworkKitPendingConnectionContainer.h"
#import "MKNetworkKit.h"
#import "ASNetworkRequest.h"


@implementation ASMKNetworkKitPendingConnectionContainer

+ (instancetype)containerWithASRequest:(id <ASNetworkRequest>)request
                           MKOperation:(MKNetworkOperation*)operation
{
    ASMKNetworkKitPendingConnectionContainer *container = [self new];
    container.request = request;
    container.operation = operation;
    return container;
}

@end
