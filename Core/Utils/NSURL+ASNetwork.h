//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol ASNetworkRequest;

@interface NSURL (ASNetwork)

+ (NSURL *)URLForRequest:(id <ASNetworkRequest>)request;

@end
