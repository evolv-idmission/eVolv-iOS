//
//  LabelUtils.h
//  AppItDepedency
//
//  Created by  on 04/04/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelUtils : NSObject

+(void)initializeCurrentLabels:(NSString*)language;
+(void) initializePickerLabels:(NSString*)language;
+(NSString*)getLabelForKey:(NSString*)key;
+(NSString*)getKeyForLabel:(NSString*)label;
+(NSString*)getKeyForPickerLabel:(NSString*)label;
+(NSString*)getLabelForPickerKey:(NSString*)key;
@end

