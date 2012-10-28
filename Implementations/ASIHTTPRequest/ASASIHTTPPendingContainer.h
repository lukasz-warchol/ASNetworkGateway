//
// Created by lukewar on 28/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol ASNetworkRequest;
@class ASIHTTPRequest;

@interface ASASIHTTPPendingContainer : NSObject
@property (nonatomic, strong) id<ASNetworkRequest> request;
@property (nonatomic, strong) ASIHTTPRequest* httpRequest;

+ (ASASIHTTPPendingContainer*)containerWithASRequest:(id <ASNetworkRequest>)request
                                          ASIRequest:(ASIHTTPRequest*) httpRequest;

@end
