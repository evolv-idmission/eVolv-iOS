//
//  ArrayObjectController.m
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "ArrayObjectController.h"
#import <UIKit/UIKit.h>
#import "NSStringUtilsDemo.h"

static NSArray *snippetDictionary;
static NSString *titleStringForController;
static id pageDelegate;
static NSString *selectedServiceType;
static CGFloat pageControlHeight;
static CGFloat pageControlY;
static NSString *IdType, *CountryType, *StateType, *FaceImageType, *IdFaceType, *IdType_sec, *CountryType_sec, *StateType_sec;
static int serviceID;
static NSString *emailId, *mobileNumber, *notificationType, *employeeCode, *overrideEmpCode;
static NSString *responseOTP;
static bool isContinueProcess;
static bool clearFormKey;

//Additional data
static NSMutableDictionary* additionalData;

//Address Data
static NSMutableDictionary* addressData;

//Employee Data
static NSMutableDictionary* employeeData;

//Dictionary for Service ID
static NSMutableDictionary *serviceIdDictionary;

//Previous Service Number Mutanle Array
static NSMutableArray *preServiceNumberArray;

//
static BOOL enableCaptureEmployee = false;

static bool custUIConfig = false;

static bool captureSecondaryIDCapture = false;

static bool hideSecondaryIdBack = false;

@implementation ArrayObjectController {
}

+(NSArray *)getSnippetFieldDict {
    return snippetDictionary;
}

+(void)setSnippetFieldDict:(NSArray*)snippetFieldDict {
    snippetDictionary = snippetFieldDict;
}

+(NSString *)getTitleStringForDictionary {
    return titleStringForController;
}

+(void)setTitleStringForDictionary:(NSString *)titleString {
    titleStringForController = titleString;
}

+(id )getPageDelegate {
    return pageDelegate;
}

+(void)setPageDelegate:(id)pageSelf {
    pageDelegate = pageSelf;
}

+(NSString *)getServiceType {
    return selectedServiceType;
}

+(void)setServiceType:(NSString *)serviceType {
    selectedServiceType = serviceType;
}

+(CGFloat)getPageControlHeight {
    return pageControlHeight;
}

+(void)setPageControlHeight:(CGFloat)pageHieght {
    pageControlHeight = pageHieght;
}

+(CGFloat)getPageControlY {
    return pageControlY;
}

+(void)setPageControlY:(CGFloat)pageY {
    pageControlY = pageY;
}

+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

+(NSString*)retrieveSetting:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+(void)addLinearGradientToView:(UIView*)view TopColor:(UIColor*)topColor BottomColor:(UIColor*)bottomColor
{
    for(CALayer* layer in view.layer.sublayers)
    {
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    //top down gradient
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = view.bounds;
    
    
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
}

//IdType, CountryType, StateType, FaceImageType, IdFaceType;
//ID Type
+(NSString *)getIdType {
    return IdType;
}

+(void)setIdType:(NSString *)idType{
    IdType = idType;
}

//Secondary Type
+(NSString *)getSecondaryIdType {
    return IdType_sec;
}

+(void)setSecondaryIdType:(NSString *)idType{
    IdType_sec = idType;
}

//Country type
+(NSString *)getCountryType {
   return CountryType;
}

+(void)setCountryType:(NSString *)countryType {
    CountryType = countryType;
}

//Secondary Country Type
+(NSString *)getSecondaryCountryType {
    return CountryType_sec;
}

+(void)setSecondaryCountryType:(NSString *)countryType {
    CountryType_sec = countryType;
}


//State Type
+(NSString *)getStateType {
    return StateType;
}

+(void)setStateType:(NSString *)stateType {
    StateType = stateType;
}

// Secondary State Type
+(NSString *)getSecondaryStateType {
    return StateType_sec;
}

+(void)setSecondaryStateType:(NSString *)stateType {
    StateType_sec = stateType;
}

//Face Image Type
+(NSString *)getFaceImageType {
    return FaceImageType;
}

+(void)setFaceImageType:(NSString *)faceImageType {
    FaceImageType = faceImageType;
}

//Id Face Type
+(NSString *)getIdFaceType {
    return IdFaceType;
}

+(void)setIdFaceType:(NSString *)idFaceType {
    IdFaceType = idFaceType;
}

//Additional Data Dict
+(NSMutableDictionary *)getAdditionalDataDictionary{
    if(additionalData == nil){
        additionalData = [[NSMutableDictionary alloc] init];
    }
    if(serviceID != 0){
        [additionalData setObject:@(serviceID).stringValue forKey:@"Service_ID"];
    }
    return additionalData;
}
+(void)setAdditionalDataDictionary:(NSMutableDictionary*)additionalDataDictionary{
    additionalData = additionalDataDictionary;
}

//Address Dict
+(NSMutableDictionary *)getAddressDataDictionary{
    return addressData;
}
+(void)setAddressDataDictionary:(NSMutableDictionary*)addressDataDictionary{
    addressData = addressDataDictionary;
}

//Employee Dict
+(NSMutableDictionary *)getEmployeeDataDictionary{
    return employeeData;
}
+(void)setEmployeeDataDictionary:(NSMutableDictionary*)employeeDataDictionary{
    employeeData = employeeDataDictionary;
}

//Employee Code
+(NSString *)getEmployeeCode {
    return employeeCode;
}

+(void)setEmployeeCode:(NSString *)empCode {
    employeeCode = empCode;
}

+(NSString *)getOverrideEmpCode{
    return overrideEmpCode;
}
+(void)setOverrideEmpCode:(NSString *)empCode{
    overrideEmpCode = empCode;
}

+(int)getServiceId {
    return serviceID;
}

+(void)setServiceId:(int)serviceId {
    serviceID = serviceId;
}

//Email Id
+(NSString *)getEmailId {
    return emailId;
}

+(void)setemailId:(NSString *)emailID {
    emailId = emailID;
}

//Mobile Number
+(NSString *)getMobNum {
    return mobileNumber;
}

+(void)setMobNum:(NSString *)mobNum {
    mobileNumber = mobNum;
}

//Notification Type
+(NSString *)geNotType {
    return notificationType;
}

+(void)setNotType:(NSString *)notType {
    notificationType = notType;
}

//Reponse OTP Type
+(NSString *)getResponseType {
    return responseOTP;
}

+(void)setResponseType:(NSString *)responseType {
    responseOTP = responseType;
}

//enableCaptureEmployee
+(void)setEnableCaptureEmployee:(BOOL)captureEmployeeBool {
    enableCaptureEmployee = captureEmployeeBool;
}

+(BOOL)getEnableCaptureEmployee {
    return enableCaptureEmployee;
}

//Customized UI Config
+(void)setCustomizedUIConfig:(BOOL)customizedUIConfig {
    custUIConfig = customizedUIConfig;
}
+(BOOL)getCustomizedUIConfig {
    return custUIConfig;
}

//ContinueProcess
+(void)setIsContinueProcess:(BOOL)isClearForKey {
    isContinueProcess = isClearForKey;
}

+(BOOL)getIsContinueProcess {
    return isContinueProcess;
}

//CaptureIDCapture
+(void)setIsSecondaryIdCaptureImage:(BOOL)isSecondaryIdCaptureImage {
    captureSecondaryIDCapture = isSecondaryIdCaptureImage;
}

+(BOOL)getIsSecondaryIDCaptureImage {
    return captureSecondaryIDCapture;
}

//ClearFormKey
+(void)setClearFormKey:(BOOL)isClearForKey {
    clearFormKey = isClearForKey;
}

+(BOOL)getClearFormKey {
    return clearFormKey;
}

+(void)setServiceDetails:(NSMutableDictionary*)_serviceIdDictionary {
    serviceIdDictionary = _serviceIdDictionary;
}

+(NSMutableDictionary *)getServiceDetails {
    return serviceIdDictionary;
}

+(void)setPrevServiceNumberArray:(NSMutableArray*)_previousServiceNumberArray {
    preServiceNumberArray = _previousServiceNumberArray;
}

+(NSMutableArray *)getPrevServiceNumberArray{
    return preServiceNumberArray;
}

//HideSecondaryIdBack
+(void)setHideSecondaryIdBack:(BOOL)hide_sec_id_back {
    hideSecondaryIdBack = hide_sec_id_back;
}

+(BOOL)getHideSecondaryIDBack {
    return hideSecondaryIdBack;
}

//Clearing initilizeCallExecutionParameter
+(NSMutableDictionary *)clearCallExecutionParameter{
    NSMutableDictionary *callExeParam = [[NSMutableDictionary alloc] init];
    [callExeParam setObject:@"" forKey:@"Service_ID"];
    [callExeParam setObject:@"" forKey:@"Manual_Review_Required"];
    [callExeParam setObject:@"" forKey:@"Bypass_Age_Validation"];
    [callExeParam setObject:@"" forKey:@"Bypass_Name_Matching"];
    [callExeParam setObject:@"" forKey:@"Deduplication_Required"];
    [callExeParam setObject:@"" forKey:@"Need_Immediate_Response"];
    //[AppItSDK setCallExecutionParameter:callExeParam];
    return callExeParam;
}
@end

