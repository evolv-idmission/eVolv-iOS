//
//  NSStringUtilsDemo.h
//  AppItDepedency
//
//  Created by  on 16/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ArrayObjectController.h"

@interface NSStringUtilsDemo : NSObject

+(BOOL)stringIsNilOrEmpty:(NSString*)aString;
+(BOOL)isInteger:(NSString*)nsString;
+(void)setLabelStyle:(UILabel*)label;
+(void)setEditTextUITextFieldStyle:(UITextField*)editUITextField;
+(void)setEditTextUILabelStyle:(UILabel*)editTextUILabel;
+(CGSize)getUILabelSizeFromLabel:(NSString*)labelText size:(float)size;
+(void)setOtherEditTextUILabelStyle:(UILabel*)editTextUILabel;
@end
