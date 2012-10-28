//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ASNetworkGateway.h"

@class MKNetworkEngine;


@interface ASMKNetworkKitGateway : NSObject<ASNetworkGateway>

@property(nonatomic, strong) MKNetworkEngine *networkEngine;

+ (instancetype)gateway;

@end
