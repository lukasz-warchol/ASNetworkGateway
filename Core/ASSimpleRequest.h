//
//  Created by Lukasz Warchol on 5/21/12.
//

#import <Foundation/Foundation.h>
#import "ASNetworkRequest.h"


@interface ASSimpleRequest : NSObject <ASNetworkRequest>

+ (id)requestWithURLString:(NSString *)urlString;

@end
