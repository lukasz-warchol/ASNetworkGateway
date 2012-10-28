//
//  Created by Lukasz Warchol on 5/21/12.
//

@protocol ASNetworkRequest <NSObject>
@property(nonatomic, copy) NSString *urlString;
@property(nonatomic, strong) NSDictionary *httpHeaders;
@property(nonatomic, strong) NSDictionary *queryParams;
@property(nonatomic, strong) NSDictionary *postParams;

@optional
//HTTP request method, default is GET
@property (nonatomic, copy) NSString* requestMethod;

@end
