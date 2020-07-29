//
//  ArrayObjectController.h
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArrayObjectController : NSObject

+(NSArray *)getSnippetFieldDict;

+(void)setSnippetFieldDict:(NSArray*)snippetFieldDict;

+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

+(NSString*)retrieveSetting:(NSString*)key;

+(NSString *)getTitleStringForDictionary;

+(void)setTitleStringForDictionary:(NSString *)titleString;

+(id )getPageDelegate;

+(void)setPageDelegate:(id)pageSelf;

+(void)addLinearGradientToView:(UIView*)view TopColor:(UIColor*)topColor BottomColor:(UIColor*)bottomColor;

//Service Type
+(NSString *)getServiceType;

+(void)setServiceType:(NSString *)serviceType;

//PageControl Height
+(CGFloat)getPageControlHeight;

+(void)setPageControlHeight:(CGFloat)pageHieght;

//PageControl Y
+(CGFloat)getPageControlY;

+(void)setPageControlY:(CGFloat)pageY;

//ID Type
+(NSString *)getIdType;

+(void)setIdType:(NSString *)idType;

//Secondary Id Type
+(NSString *)getSecondaryIdType;

+(void)setSecondaryIdType:(NSString *)idType;

//Country type
+(NSString *)getCountryType;

+(void)setCountryType:(NSString *)countryType;

//Secondary Country Type
+(NSString *)getSecondaryCountryType;

+(void)setSecondaryCountryType:(NSString *)countryType;

//State Type
+(NSString *)getStateType;

+(void)setStateType:(NSString *)stateType;

//Secondary State Type
+(NSString *)getSecondaryStateType;

+(void)setSecondaryStateType:(NSString *)stateType;


//Face Image Type
+(NSString *)getFaceImageType;

+(void)setFaceImageType:(NSString *)faceImageType;

//Id Face Type
+(NSString *)getIdFaceType;

+(void)setIdFaceType:(NSString *)idFaceType;

//Additional Data Dict
+(NSMutableDictionary *)getAdditionalDataDictionary;

+(void)setAdditionalDataDictionary:(NSMutableDictionary*)additionalDataDictionary;

//Address Data Dict
+(NSMutableDictionary *)getAddressDataDictionary;
+(void)setAddressDataDictionary:(NSMutableDictionary*)addressDataDictionary;

//Employe Dict
+(NSMutableDictionary *)getEmployeeDataDictionary;
+(void)setEmployeeDataDictionary:(NSMutableDictionary*)employeeDataDictionary;


//Set Service ID
+(int)getServiceId;

+(void)setServiceId:(int)serviceId;

//Email Id
+(NSString *)getEmailId;

+(void)setemailId:(NSString *)emailID;

//Mobile Number
+(NSString *)getMobNum;

+(void)setMobNum:(NSString *)mobNum;

//Notification Type
+(NSString *)geNotType;

+(void)setNotType:(NSString *)notType;

//Reponse OTP Type
+(NSString *)getResponseType;

+(void)setResponseType:(NSString *)responseType;

//Employee Code
+(NSString *)getEmployeeCode;
+(void)setEmployeeCode:(NSString *)empCode;

+(NSString *)getOverrideEmpCode;
+(void)setOverrideEmpCode:(NSString *)empCode;

+(void)setEnableCaptureEmployee:(BOOL)captureEmployeeBool;
+(BOOL)getEnableCaptureEmployee;

+(void)setIsContinueProcess:(BOOL)isClearForKey;

+(BOOL)getIsContinueProcess;

+(void)setClearFormKey:(BOOL)isClearForKey;

+(BOOL)getClearFormKey;

+(void)setServiceDetails:(NSMutableDictionary*)_serviceIdDictionary;

+(NSMutableDictionary *)getServiceDetails;

+(void)setPrevServiceNumberArray:(NSMutableArray*)_previousServiceNumberArray;

+(NSMutableArray *)getPrevServiceNumberArray;

+(void)setCustomizedUIConfig:(BOOL)customizedUIConfig;
+(BOOL)getCustomizedUIConfig;
+(NSMutableDictionary *)clearCallExecutionParameter;

+(void)setIsSecondaryIdCaptureImage:(BOOL)isSecondaryIdCaptureImage;
+(BOOL)getIsSecondaryIDCaptureImage;

+(void)setHideSecondaryIdBack:(BOOL)hide_sec_id_back;
+(BOOL)getHideSecondaryIDBack;

@end

