//
//  Created by Lukasz Warchol on 5/21/12.
//

@protocol ASNetworkResponse <NSObject>
@property (nonatomic, assign, readonly) NSInteger statusCode;
@property (nonatomic, strong, readonly) NSDictionary *httpHeaders;
@property (nonatomic, strong, readonly) NSData* body;
@end
