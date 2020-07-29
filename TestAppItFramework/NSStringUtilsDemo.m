//
//  NSStringUtilsDemo.m
//  AppItDepedency
//
//  Created by  on 16/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "NSStringUtilsDemo.h"

@implementation NSStringUtilsDemo


+(BOOL)stringIsNilOrEmpty:(NSString*)aString {
    if(aString == nil){
        return true;
    }
    
    NSString *trimmed = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(trimmed.length == 0){
        return true;
    }
    return false;
}

+(BOOL)isInteger:(NSString*)nsString{
    NSScanner* scan = [NSScanner scannerWithString:nsString];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(void)setLabelStyle:(UILabel*)label{
    //    [label setTextColor:[UIColor colorWithRed:69/255.f green:69/255.f blue:69/255.f alpha:0.5]];
    //    [label setTextColor:[UIColor colorWithRed:58/255.f green:58/255.f blue:58/255.f alpha:0.5]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(2.0, 2.0)];
}

+(void)setEditTextUITextFieldStyle:(UITextField*)editUITextField{
    editUITextField.textAlignment = NSTextAlignmentCenter;
    editUITextField.layer.cornerRadius = 5;
    editUITextField.layer.borderWidth = 1.0;
    editUITextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [editUITextField setAlpha:0.7];
    editUITextField.borderStyle = UITextBorderStyleRoundedRect;
    [editUITextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
}

+(void)setEditTextUILabelStyle:(UILabel*)editTextUILabel{
    [editTextUILabel setFont:[UIFont systemFontOfSize:11]];
    [editTextUILabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:0.95]];
//    [editTextUILabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [editTextUILabel setTextColor:[UIColor grayColor]];
    [editTextUILabel setTextAlignment:NSTextAlignmentLeft];
}

+(void)setOtherEditTextUILabelStyle:(UILabel*)editTextUILabel {
    [editTextUILabel setFont:[UIFont systemFontOfSize:14]];
    [editTextUILabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:0.95]];
    //    [editTextUILabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [editTextUILabel setTextColor:[UIColor grayColor]];
    [editTextUILabel setTextAlignment:NSTextAlignmentLeft];
}

+(CGSize)getUILabelSizeFromLabel:(NSString*)labelText size:(float)size{
//        size = size + 2.0; //Adding little bit padding
    size = size + 1.0; //Adding little bit padding
    CGSize sizeDynamic  = [labelText sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:size] constrainedToSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeDynamic;
}

@end
