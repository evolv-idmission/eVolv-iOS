//
//  DownloadTemplateData.h
//  AppItFramework
//
//  Created by Sanket Garde on 06/11/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DownloadTemplateData : NSObject<NSXMLParserDelegate> {
    
}

+(void) download_Template;
+(void) download_Template:(id)instance url:(NSString *)url appCode:(NSString *)appCode loginId:(NSString *)loginId password:(NSString *)password merchantId:(NSString *)merchantId isSDKApiCall:(BOOL)isSDKApiCall;
+(NSMutableArray *)getTemplateFieldArray;

@end

