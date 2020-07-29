//
//  CustomizeUIConfigManager.h
//  AppItDepedency
//
//  Created by Sanket Garde on 04/06/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomizeUIConfig.h"
#import "NSStringUtilsDemo.h"

@interface CustomizeUIConfigManager : NSObject

+(CustomizeUIConfig *)getDefaultIDCaptureFrontConfig;

+(CustomizeUIConfig *)getDefaultSecondaryIDCaptureFrontConfig;

+(CustomizeUIConfig *)getDefaultIDCaptureBackConfig;

+(CustomizeUIConfig *)getDefaultSecondaryIDCaptureBackConfig;

+(CustomizeUIConfig *)getDefaultDocCaptureConfig;

+(CustomizeUIConfig *)getDefaultSnippetCaptureConfig;

+(CustomizeUIConfig *)getDefaultFaceCaptureConfig;

+(CustomizeUIConfig *)getDefaultFingerPrintCaptureConfig;

+(CustomizeUIConfig *)getDefaultVoiceCaptureConfig;

+(void)initCustomizeUIConfig;

+(NSMutableDictionary *) getUIConfigDictionary:(NSString *)featureType;

+(void) storeConfig:(NSString *)featureType;

+(NSMutableDictionary *) getCompleteUIConfigDictionary;

+(void)reinitWithLanguageChange:(NSString *)language;

@end
