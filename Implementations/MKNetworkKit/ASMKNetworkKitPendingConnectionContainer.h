//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class MKNetworkOperation;
@protocol ASNetworkRequest;

@interface ASMKNetworkKitPendingConnectionContainer : NSObject
@property(nonatomic, strong) id <ASNetworkRequest> request;
@property(nonatomic, strong) MKNetworkOperation *operation;

+ (instancetype)containerWithASRequest:(id <ASNetworkRequest>)request
                           MKOperation:(MKNetworkOperation*)operation;

@end
