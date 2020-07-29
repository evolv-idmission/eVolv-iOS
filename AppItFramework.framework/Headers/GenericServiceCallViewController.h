//
//  GenericServiceCallViewController.h
//  AppItFramework
//
//  Created by Sanket Garde on 15/07/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonImporter.h"

@interface GenericServiceCallViewController : UIViewController<NSXMLParserDelegate> {
    
    IBOutlet UIActivityIndicatorView *uiActivityIndicator;
    
}

@property(nonatomic,assign)id delegate;
@property(nonatomic) NSString* countryCode;
@property(nonatomic) NSString* stateCode;
@property(nonatomic) NSString* idType;
@property(nonatomic) NSString* matchDocumentType;

@property(nonatomic) NSMutableDictionary *resultDictionary;
@property (nonatomic) NSMutableDictionary *employeeDictionary;
@property (nonatomic) NSMutableDictionary *genericDataDictionary;

//@property (nonatomic) NSMutableDictionary *additionalAddressDict;
//@property (nonatomic) NSString *employeeCode;
//@property (nonatomic) NSString *uuID;
//@property (nonatomic) NSString *emailId;
//@property (nonatomic) NSString *mobileNumber;
//@property (nonatomic) NSString *notificationType;
//@property (nonatomic) NSString *receivedOTP;
//@property (nonatomic) NSString *videoBase64String;

@end

