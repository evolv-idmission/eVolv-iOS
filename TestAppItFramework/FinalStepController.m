//
//  FinalStepController.m
//  AppItDepedency
//
//  Created by  on 17/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "FinalStepController.h"
#import "ArrayObjectController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "ResultViewController.h"
#import "NSStringUtilsDemo.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"

@interface FinalStepController () {
    UIAlertView *uiAlertView;
    UIActivityIndicatorView *activityIndicator;
    NSString *reqResData;
    UIButton *verifyEmployeeCustBtn, *backBtn;
    
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

@end

@implementation FinalStepController {
    bool clearFormKey, isFinalSubmit, doVerifyButton;
   
    UIButton *finalSubmitCheckBox, *clearFormKeyCheckBox, *doVerifyCheckBox;
    UIImageView *infoImage;
    UIButton *formKeyQuestionMarkBtn;
    UILabel *clearFormKeyLabel, *doVerifyLabel;
    UIButton *questionMarkBtn, *questionDoVerify;
    UILabel *finalSubmitLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    clearFormKey = true;
    isFinalSubmit = true;
    doVerifyButton = true;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    
    //Adding progress bar -Start
    uiAlertView = [[UIAlertView alloc] initWithTitle:[LabelUtils getLabelForKey:@"please_wait_msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [uiAlertView setValue:activityIndicator forKey:@"accessoryView"];
    //Adding progress bar -End
    
    //Almost Done Label
    UILabel *almostDoneLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*10, (height/100)*15, (width/100)*80, (height/100)*10)];
    [almostDoneLabel setText:[LabelUtils getLabelForKey:@"final_step"]];
    [almostDoneLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [almostDoneLabel setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:almostDoneLabel];
   
    doVerifyCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    doVerifyCheckBox.frame = CGRectMake(almostDoneLabel.frame.origin.x, almostDoneLabel.frame.origin.y + almostDoneLabel.frame.size.height + (height/100)*5, (width/100)*8, (height/100)*6);
    [doVerifyCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [doVerifyCheckBox addTarget:self action:@selector(doVerifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doVerifyCheckBox];
    
    //Do Verify Label
    doVerifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(doVerifyCheckBox.frame.origin.x + doVerifyCheckBox.frame.size.width + (width/100)*5, doVerifyCheckBox.frame.origin.y, (width/100)*30, (height/100)*6)];
    [doVerifyLabel setText:[LabelUtils getLabelForKey:@"verify"]];
    [self wrapUILabel:doVerifyLabel];
   // [doVerifyLabel setFont:[UIFont systemFontOfSize:18]];
    [doVerifyLabel setTextColor:[ArrayObjectController colorwithHexString:@"#616161" alpha:1.0]];
    [self.view addSubview:doVerifyLabel];
    
    //Do Verify Question Mark
    questionDoVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    questionDoVerify.frame = CGRectMake(doVerifyLabel.frame.origin.x + doVerifyLabel.frame.size.width + (width/100)*5, almostDoneLabel.frame.origin.y + almostDoneLabel.frame.size.height + (height/100)*5, (width/100)*7, (height/100)*6);
    [questionDoVerify setImage:[UIImage imageNamed:@"questionmark.png"] forState:UIControlStateNormal];
    [self.view addSubview:questionDoVerify];
    
    //Final Submit CheckBox
    finalSubmitCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    finalSubmitCheckBox.frame = CGRectMake(almostDoneLabel.frame.origin.x, doVerifyCheckBox.frame.origin.y + doVerifyCheckBox.frame.size.height, (width/100)*8, (height/100)*6);
    [finalSubmitCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [finalSubmitCheckBox addTarget:self action:@selector(finalSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finalSubmitCheckBox];
    
    //Final Submit Label
    finalSubmitLabel = [[UILabel alloc] initWithFrame:CGRectMake(finalSubmitCheckBox.frame.origin.x + finalSubmitCheckBox.frame.size.width + (width/100)*5, finalSubmitCheckBox.frame.origin.y, (width/100)*40, (height/100)*6)];
    [finalSubmitLabel setText:[LabelUtils getLabelForKey:@"final_submit"]];
    //[finalSubmitLabel setFont:[UIFont systemFontOfSize:18]];
    [finalSubmitLabel setTextColor:[ArrayObjectController colorwithHexString:@"#616161" alpha:1.0]];
    [self wrapUILabel:finalSubmitLabel];
    [self.view addSubview:finalSubmitLabel];
    
    //Final Submit question mark label
    questionMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    questionMarkBtn.frame = CGRectMake(finalSubmitLabel.frame.origin.x + finalSubmitLabel.frame.size.width + (width/100)*5, finalSubmitCheckBox.frame.origin.y, (width/100)*7, (height/100)*6);
    [questionMarkBtn setImage:[UIImage imageNamed:@"questionmark.png"] forState:UIControlStateNormal];
    [self.view addSubview:questionMarkBtn];
    
    //Clear Form key checkBox
    clearFormKeyCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    clearFormKeyCheckBox.frame = CGRectMake(almostDoneLabel.frame.origin.x, finalSubmitCheckBox.frame.origin.y + finalSubmitCheckBox.frame.size.height, (width/100)*8, (height/100)*6);
    [clearFormKeyCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [clearFormKeyCheckBox addTarget:self action:@selector(clearFormKeyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearFormKeyCheckBox];
    
    //Clear Form Key Label
    clearFormKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(clearFormKeyCheckBox.frame.origin.x + clearFormKeyCheckBox.frame.size.width + (width/100)*5, clearFormKeyCheckBox.frame.origin.y, (width/100)*40, (height/100)*6)];
    [clearFormKeyLabel setText:[LabelUtils getLabelForKey:@"clear_form_key"]];
    [self wrapUILabel:clearFormKeyLabel];
   // [clearFormKeyLabel setFont:[UIFont systemFontOfSize:18]];
    [clearFormKeyLabel setTextColor:[ArrayObjectController colorwithHexString:@"#616161" alpha:1.0]];
    [self.view addSubview:clearFormKeyLabel];
    
    //clear form key question mark label
    formKeyQuestionMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    formKeyQuestionMarkBtn.frame = CGRectMake(clearFormKeyLabel.frame.origin.x + clearFormKeyLabel.frame.size.width + (width/100)*5, clearFormKeyCheckBox.frame.origin.y, (width/100)*7, (height/100)*6);
    [formKeyQuestionMarkBtn setImage:[UIImage imageNamed:@"questionmark.png"] forState:UIControlStateNormal];
    [self.view addSubview:formKeyQuestionMarkBtn];
    
    //Process Image Only
    UIButton *processImageOnlyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(almostDoneLabel.frame.origin.x, formKeyQuestionMarkBtn.frame.origin.y + formKeyQuestionMarkBtn.frame.size.height + (height/100)*7, almostDoneLabel.frame.size.width, (height/100)*6);
    [processImageOnlyBtn setFrame:frame];
    processImageOnlyBtn.layer.cornerRadius = 20;
    processImageOnlyBtn.clipsToBounds = YES;
    processImageOnlyBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    processImageOnlyBtn.titleLabel.numberOfLines = 2;
    processImageOnlyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //Hiding doverify
    [doVerifyCheckBox setHidden:YES];
    [doVerifyLabel setHidden:YES];
    [questionDoVerify setHidden:YES];
    
    int service_id = [ArrayObjectController getServiceId];
    
    if(service_id == 20 || service_id == 25 || service_id == 30 ) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"process_image"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
    } else if(service_id == 60 || service_id == 65) {
         [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"match_face"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
    } else if(service_id == 70){
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"customer_update"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:YES];
        [formKeyQuestionMarkBtn setHidden:YES];
        [clearFormKeyLabel setHidden:YES];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
    } else if(service_id == 100) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"customer_verification_label"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
    } else if(service_id == 105) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"customer_verification_label"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
    } else if(service_id == 155 || service_id == 160 || service_id == 165) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"id_validation_video_match"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
    } else if(service_id == 400) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"generate_otp"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:YES];
        [formKeyQuestionMarkBtn setHidden:YES];
        [clearFormKeyLabel setHidden:YES];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
    } else if(service_id == 410) {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"verify_otp"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:YES];
        [formKeyQuestionMarkBtn setHidden:YES];
        [clearFormKeyLabel setHidden:YES];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
    } else if(service_id == 200) {
        [finalSubmitLabel setText:[LabelUtils getLabelForKey:@"extract"]];
        [clearFormKeyLabel setText:[LabelUtils getLabelForKey:@"final_submit"]];
        [doVerifyCheckBox setHidden:NO];
        [doVerifyLabel setHidden:NO];
        [questionDoVerify setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"address_matching"] forState:UIControlStateNormal];
    } else if(service_id == 300) {
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"emp_verification"] forState:UIControlStateNormal];
    } else if(service_id == 305) {
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"emp_verification"] forState:UIControlStateNormal];
    } else if(service_id == 310) {
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"emp_enrollment"] forState:UIControlStateNormal];
    } else if(service_id == 401) {
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:YES];
        [formKeyQuestionMarkBtn setHidden:YES];
        [clearFormKeyLabel setHidden:YES];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"generate_token"] forState:UIControlStateNormal];
    } else if(service_id == 330) {
        
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"create_emp_override"] forState:UIControlStateNormal];
        
//        if([ArrayObjectController getEnableCaptureEmployee]) {
//            [processImageOnlyBtn setTitle:@"Verify Employee(Override)" forState:UIControlStateNormal];
//            [finalSubmitCheckBox setHidden:NO];
//            [finalSubmitLabel setHidden:NO];
//            [questionMarkBtn setHidden:NO];
//        }
        
    } else if(service_id == 320) {
        
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"create_customer_override"] forState:UIControlStateNormal];
//        if(![ArrayObjectController getEnableCaptureEmployee]) {
//            [processImageOnlyBtn setTitle:@"Create Customer" forState:UIControlStateNormal];
//        } else {
//            [processImageOnlyBtn setTitle:@"Verify Employee" forState:UIControlStateNormal];
//        }
        
    } else if(service_id == 175) {
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"customer_fp_enrollment"] forState:UIControlStateNormal];
    } else if(service_id == 180) {
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"employee_fp_enrollment"] forState:UIControlStateNormal];
    } else if(service_id == 75){
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"employee_update"] forState:UIControlStateNormal];
    }else if(service_id == 186){
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"customer_search_label"] forState:UIControlStateNormal];
    }else if(service_id == 191){
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"employee_search_label"] forState:UIControlStateNormal];
    }else if(service_id == 500 || service_id == 505 || service_id == 510 || service_id == 515 || service_id == 185 || service_id == 190){
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setHidden:YES];
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"employee_search_label"] forState:UIControlStateNormal];
    } else if(service_id == 660 || service_id == 620) {
        [finalSubmitCheckBox setHidden:YES];
        [clearFormKeyCheckBox setHidden:YES];
        [formKeyQuestionMarkBtn setHidden:YES];
        [clearFormKeyLabel setHidden:YES];
        [questionMarkBtn setHidden:YES];
        [finalSubmitLabel setHidden:YES];
        [processImageOnlyBtn setHidden:YES];
    } else {
        [processImageOnlyBtn setTitle:[LabelUtils getLabelForKey:@"process_image_and_match_face"] forState:UIControlStateNormal];
        [finalSubmitCheckBox setHidden:NO];
        [clearFormKeyCheckBox setHidden:NO];
        [formKeyQuestionMarkBtn setHidden:NO];
        [clearFormKeyLabel setHidden:NO];
        [questionMarkBtn setHidden:NO];
        [finalSubmitLabel setHidden:NO];
    }
    processImageOnlyBtn.titleLabel.textColor = [UIColor whiteColor];
    [processImageOnlyBtn setBackgroundColor:[UIColor blackColor]];
    [processImageOnlyBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [processImageOnlyBtn addTarget:self action:@selector(processingCall:) forControlEvents:UIControlEventTouchUpInside];
    [processImageOnlyBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:processImageOnlyBtn];
    
    //Generic ApI call Button
    UIButton *genericApiCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect genericBtnframe = CGRectMake(almostDoneLabel.frame.origin.x, processImageOnlyBtn.frame.origin.y + processImageOnlyBtn.frame.size.height + (height/100)*2, almostDoneLabel.frame.size.width, (height/100)*6);
    [genericApiCallBtn setFrame:genericBtnframe];
    genericApiCallBtn.layer.cornerRadius = 20;
    genericApiCallBtn.clipsToBounds = YES;
    genericApiCallBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    genericApiCallBtn.titleLabel.numberOfLines = 2;
    genericApiCallBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    genericApiCallBtn.titleLabel.textColor = [UIColor whiteColor];
    [genericApiCallBtn setBackgroundColor:[UIColor blackColor]];
    [genericApiCallBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [genericApiCallBtn addTarget:self action:@selector(genericApiCallClick:) forControlEvents:UIControlEventTouchUpInside];
    [genericApiCallBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    if(service_id == 660 || service_id == 620) {
        [genericApiCallBtn setTitle:[LabelUtils getLabelForKey:@"done"] forState:UIControlStateNormal];
    } else {
        [genericApiCallBtn setTitle:@"Final Submit" forState:UIControlStateNormal];
    }

    [self.view addSubview:genericApiCallBtn];
    
    //Info Image
//    infoImage = [[UIImageView alloc] initWithFrame:CGRectMake(processImageOnlyBtn.frame.origin.x + processImageOnlyBtn.frame.size.width - (width/100)*9 , processImageOnlyBtn.frame.origin.y + (processImageOnlyBtn.frame.size.height/2) - (height/100)*1.5, (width/100)*5, (height/100)*3)];
//    [infoImage setImage:[UIImage imageNamed:@"info_white.png"]];
//    [self.view addSubview:infoImage];
    
    //Back
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frameBack = CGRectMake(almostDoneLabel.frame.origin.x, genericApiCallBtn.frame.origin.y + genericApiCallBtn.frame.size.height + (height/100)*2, almostDoneLabel.frame.size.width, (height/100)*6);
    [backBtn setFrame:frameBack];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    verifyEmployeeCustBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frameBack1 = CGRectMake(almostDoneLabel.frame.origin.x, processImageOnlyBtn.frame.origin.y + processImageOnlyBtn.frame.size.height + (height/100)*2, almostDoneLabel.frame.size.width, (height/100)*6);
    [verifyEmployeeCustBtn setFrame:frameBack1];
    verifyEmployeeCustBtn.layer.cornerRadius = 20;
    verifyEmployeeCustBtn.clipsToBounds = YES;
    [verifyEmployeeCustBtn setTitle:@"Verify Employee(Overridde)" forState:UIControlStateNormal];
    verifyEmployeeCustBtn.titleLabel.textColor = [UIColor whiteColor];
    [verifyEmployeeCustBtn setBackgroundColor:[UIColor blackColor]];
    [verifyEmployeeCustBtn addTarget:self action:@selector(verifyEmpCust:) forControlEvents:UIControlEventTouchUpInside];
    [verifyEmployeeCustBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:verifyEmployeeCustBtn];
    [verifyEmployeeCustBtn setHidden:YES];
}

-(void)startProgress{
    [activityIndicator startAnimating];
    [uiAlertView show];
}
-(void)stopProgress{
    [activityIndicator stopAnimating];
    [uiAlertView dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)showAlertDialogBox {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Request and Response not found"
                                                      message:@""
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    
    [message show];
}


-(void)verifyEmpCust:(UIButton*)button {

//    [ArrayObjectController setEnableCaptureEmployee:YES];
    [self snackBarView:@"Capture Selfie Employee Data"];
//    RootPageViewController *ctrl = [ArrayObjectController getPageDelegate];
//    [ctrl settingSelfieEmployeeIndex];
//    [self.navigationController popViewControllerAnimated:YES];
    
//    [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getEmployeeCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
}


-(void)backBtn:(UIButton*)button {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doVerifyBtn:(UIButton*)button {
    
    if(doVerifyButton) {
        [doVerifyCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        doVerifyButton = false;
    } else {
        [doVerifyCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        doVerifyButton = true;
    }
}

-(void)finalSubmitBtn:(UIButton*)button {
    if(isFinalSubmit) {
        [finalSubmitCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        isFinalSubmit = false;
    } else {
        [finalSubmitCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        isFinalSubmit = true;
    }
}

-(void)clearFormKeyBtn:(UIButton*)button {
    if(clearFormKey) {
        [clearFormKeyCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        clearFormKey = false;
    } else {
        [clearFormKeyCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        clearFormKey = true;
    }
}

-(void)genericApiCallClick:(UIButton*)button {
    
    if(620 == [ArrayObjectController getServiceId] || 660 == [ArrayObjectController getServiceId]) {
        AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        
        NSString *countryCode = [ArrayObjectController getCountryType];
        NSString *stateCode = [ArrayObjectController getStateType];
        NSString *idType = [ArrayObjectController getIdType];
        
        NSString *secondaryCountryCode = [ArrayObjectController getSecondaryCountryType];
        NSString *secondaryStateCode = [ArrayObjectController getSecondaryStateType];
        NSString *secondaryIdType = [ArrayObjectController getSecondaryIdType];
        
        if([NSStringUtils stringIsNilOrEmpty:countryCode]) {
            countryCode = @"";
        }
        if([NSStringUtils stringIsNilOrEmpty:stateCode]) {
            stateCode = @"";
        }
        if([NSStringUtils stringIsNilOrEmpty:idType]) {
            idType = @"";
        }
        
        if([NSStringUtils stringIsNilOrEmpty:secondaryCountryCode]) {
            secondaryCountryCode = @"";
        }
        if([NSStringUtils stringIsNilOrEmpty:secondaryStateCode]) {
            secondaryStateCode = @"";
        }
        if([NSStringUtils stringIsNilOrEmpty:secondaryIdType]) {
            secondaryIdType = @"";
        }
        
        NSMutableDictionary *additionalDictionary;
        if(nil != [ArrayObjectController getAdditionalDataDictionary]) {
            additionalDictionary = [ArrayObjectController getAdditionalDataDictionary];
        } else {
            additionalDictionary = [[NSMutableDictionary alloc] init];
        }
        
        NSMutableDictionary *employeeDictionary;
        if(nil != [ArrayObjectController getEmployeeDataDictionary]) {
            employeeDictionary = [ArrayObjectController getEmployeeDataDictionary];
        } else {
            employeeDictionary = [[NSMutableDictionary alloc] init];
        }
        
        NSString *clearFormKeyString = (clearFormKey) ? @"Y" : @"N";
        
        NSString *faceImageTypeString = @"";
        if(nil != [ArrayObjectController getFaceImageType]) {
            faceImageTypeString = [ArrayObjectController getFaceImageType];
        }
        
        NSString *idImageFaceTypeString = @"";
        if(nil != [ArrayObjectController getIdFaceType]) {
            idImageFaceTypeString = [ArrayObjectController getIdFaceType];
        }
        
        [ArrayObjectController setClearFormKey:clearFormKey];
        [self startProgress];
        
        if([NSStringUtils stringIsNilOrEmpty:[ArrayObjectController getFaceImageType]]){
            [ArrayObjectController setFaceImageType:@"FACE_IMAGE"];
        }
        
        int service_id = [ArrayObjectController getServiceId];
        
        NSMutableDictionary *genericDataDict = [[NSMutableDictionary alloc] init];
        
        [genericDataDict setObject:secondaryCountryCode forKey:@"country_id_secondary"];
        [genericDataDict setObject:secondaryStateCode forKey:@"state_id_secondary"];
        [genericDataDict setObject:secondaryIdType forKey:@"id_type_secondary"];
        
        if(service_id == 20 || service_id == 25 || service_id == 30) {
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            if(service_id == 30) {
                
                [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
                
                [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
                
            } else {
                //           [AppItSDK processImage:self countryCode:countryCode stateCode:stateCode idType:idType additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
                
                [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
                
            }
            
        } else if(service_id == 60 || service_id == 65) {
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            
            [genericDataDict setObject:idImageFaceTypeString forKey:@"IdImageType"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK matchFaceImage:self faceImageType:[ArrayObjectController getFaceImageType] idImageType:[ArrayObjectController getIdFaceType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
            
        } else if(service_id == 70) {
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //if(addDict != nil){
            
            //        [AppItSDK updateCustomer:self faceImageType:[ArrayObjectController getIdFaceType] additionalDictionary:addDict];
            //}
            
        } else if(service_id == 100 || service_id == 105) {
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //        if(addDict != nil){
            //            [AppItSDK verifyCustomer:self biometricType:@"FACE" additionalDictionary:addDict clearFormKey:clearFormKey];
            //        }else{
            //            [AppItSDK verifyCustomer:self biometricType:@"FACE" additionalDictionary:nil clearFormKey:clearFormKey];
            //        }
        } else if(service_id == 155 || service_id == 160 || service_id == 165) {
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //        [AppItSDK idValidationAndMatchVideo:self countryCode:countryCode stateCode:stateCode idType:idType additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
            
        } else if(service_id == 400) {
            [ArrayObjectController setClearFormKey:false];
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            if(nil != [ArrayObjectController getEmailId]) {
                [genericDataDict setObject:[ArrayObjectController getEmailId] forKey:@"emailId"];
            } else {
                [genericDataDict setObject:@"" forKey:@"emailId"];
            }
            
            if(nil != [ArrayObjectController getMobNum]) {
                [genericDataDict setObject:[ArrayObjectController getMobNum] forKey:@"mobileNumber"];
            } else {
                [genericDataDict setObject:@"" forKey:@"mobileNumber"];
            }
            
            if(nil != [ArrayObjectController geNotType]) {
                [genericDataDict setObject:[ArrayObjectController geNotType] forKey:@"notificationType"];
            } else {
                [genericDataDict setObject:@"" forKey:@"notificationType"];
            }
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //        [AppItSDK generateOTP:self additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] emailId:[ArrayObjectController getEmailId] mobileNumber:[ArrayObjectController getMobNum] notificationType:[ArrayObjectController geNotType]];
        } else if(service_id == 410) {
            [ArrayObjectController setClearFormKey:false];
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            if(nil != [ArrayObjectController geNotType]) {
                [genericDataDict setObject:[ArrayObjectController geNotType] forKey:@"receivedOTP"];
            } else {
                [genericDataDict setObject:@"" forKey:@"receivedOTP"];
            }
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK verifyOTP:self additionalDictionary:addDict receivedOTP:[ArrayObjectController getResponseType]];
        } else if(service_id == 200) {
            //        [AppItSDK verifyAddress:self addressJSONDictionary:[ArrayObjectController getAddressDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] doExtract:isFinalSubmit doVerify:doVerifyButton finalSubmit:clearFormKey];
        } else if(service_id == 300 || service_id == 305) {
            
            if(nil != [ArrayObjectController getEmployeeCode]) {
                [genericDataDict setObject:[ArrayObjectController getEmployeeCode] forKey:@"employeeCode"];
            } else {
                [genericDataDict setObject:@"" forKey:@"employeeCode"];
            }
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getEmployeeCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
            
        } else if(service_id == 310) {
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:idImageFaceTypeString forKey:@"IdImageType"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK matchFaceImage:self faceImageType:[ArrayObjectController getFaceImageType] idImageType:[ArrayObjectController getIdFaceType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
        } else if(service_id == 401) {
            
            if(nil != [AppItSDK getUUID]) {
                [genericDataDict setObject:[AppItSDK getUUID] forKey:@"uuID"];
            } else {
                [genericDataDict setObject:@"" forKey:@"uuID"];
            }
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //[AppItSDK generateToken:self];
            
        } else if(service_id == 330) {
            
            if(nil != [ArrayObjectController getEmployeeCode]) {
                [genericDataDict setObject:[ArrayObjectController getEmployeeCode] forKey:@"employeeCode"];
            } else {
                [genericDataDict setObject:@"" forKey:@"employeeCode"];
            }
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getOverrideEmpCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
            
        } else if(service_id == 320) {
            
            if(nil != [ArrayObjectController getEmployeeCode]) {
                [genericDataDict setObject:[ArrayObjectController getEmployeeCode] forKey:@"employeeCode"];
            } else {
                [genericDataDict setObject:@"" forKey:@"employeeCode"];
            }
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getOverrideEmpCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
            
        } else if(service_id == 175) {
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            
            //        [AppItSDK enrollFingerprint:self  additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] clearFormKey:clearFormKey];
        } else if(service_id == 180) {
            //[self stopProgress];
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //        [AppItSDK createEmployee:self employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit];
        } else if(service_id == 360 || service_id == 361) {
            NSMutableDictionary *customProductDict = _customProductDefinationDict;
            //        [AppItSDK executeGenericRequest:self customProductDefination:_customProductDefinationDict additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        }else if(service_id == 75){
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
            //        [AppItSDK updateEmployee:self faceImageType:[AppItSDK getFaceImageType] employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        }else if(service_id == 186){
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        }else if(service_id == 191){
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        }else if(service_id == 500){
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        } else if(service_id == 505){
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        } else if(service_id == 510){
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        } else if(service_id == 515){
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        } else if(service_id == 185){
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        } else if(service_id == 190){
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        }else {
            
            [genericDataDict setObject:countryCode forKey:@"countryCode"];
            [genericDataDict setObject:stateCode forKey:@"stateCode"];
            [genericDataDict setObject:idType forKey:@"imageType"];
            
            [genericDataDict setObject:faceImageTypeString forKey:@"faceImageType"];
            
            [genericDataDict setObject:additionalDictionary forKey:@"additionalDictionary"];
            
            [genericDataDict setObject:clearFormKeyString forKey:@"clearFormKey"];
            
            if(service_id == 55) {
                
                [genericDataDict setObject:employeeDictionary forKey:@"employeeDictionary"];
                
                //            [AppItSDK processImageAndMatchFace:self countryCode:countryCode stateCode:stateCode idType:idType faceImageType:[ArrayObjectController getFaceImageType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
            } else {
                //            [AppItSDK processImageAndMatchFace:self countryCode:countryCode stateCode:stateCode idType:idType faceImageType:[ArrayObjectController getFaceImageType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
            }
            [AppItSDK genericApiCall:self genericDataDictionary:genericDataDict];
        }
    }
}

-(void)processingCall:(UIButton*)button {
    
    NSString *countryCode = [ArrayObjectController getCountryType];
    NSString *stateCode = [ArrayObjectController getStateType];
    NSString *idType = [ArrayObjectController getIdType];
    [ArrayObjectController setClearFormKey:clearFormKey];
    [self startProgress];
   
    if([NSStringUtils stringIsNilOrEmpty:[ArrayObjectController getFaceImageType]]){
        [ArrayObjectController setFaceImageType:@"FACE_IMAGE"];
    }

    int service_id = [ArrayObjectController getServiceId];
    
    if(service_id == 20 || service_id == 25 || service_id == 30) {
            
        if(service_id == 30) {
            [AppItSDK processImage:self countryCode:countryCode stateCode:stateCode idType:idType additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
        } else {
            [AppItSDK processImage:self countryCode:countryCode stateCode:stateCode idType:idType additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        }
        
    } else if(service_id == 60 || service_id == 65) {
        
        [AppItSDK matchFaceImage:self faceImageType:[ArrayObjectController getFaceImageType] idImageType:[ArrayObjectController getIdFaceType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];

    } else if(service_id == 70) {
        NSMutableDictionary *addDict = [ArrayObjectController getAdditionalDataDictionary];
        //if(addDict != nil){
            [AppItSDK updateCustomer:self faceImageType:[ArrayObjectController getIdFaceType] additionalDictionary:addDict];
        //}
    
    } else if(service_id == 100 || service_id == 105) {
        NSMutableDictionary *addDict = [ArrayObjectController getAdditionalDataDictionary];
        if(addDict != nil){
            [AppItSDK verifyCustomer:self biometricType:@"FACE" additionalDictionary:addDict clearFormKey:clearFormKey];
        }else{
            [AppItSDK verifyCustomer:self biometricType:@"FACE" additionalDictionary:nil clearFormKey:clearFormKey];
        }
    } else if(service_id == 155 || service_id == 160 || service_id == 165) {
        
        [AppItSDK idValidationAndMatchVideo:self countryCode:countryCode stateCode:stateCode idType:idType additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
        
    } else if(service_id == 400) {
        [ArrayObjectController setClearFormKey:false];
        [AppItSDK generateOTP:self additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] emailId:[ArrayObjectController getEmailId] mobileNumber:[ArrayObjectController getMobNum] notificationType:[ArrayObjectController geNotType]];
    } else if(service_id == 410) {
        [ArrayObjectController setClearFormKey:false];
        NSMutableDictionary *addDict = [ArrayObjectController getAdditionalDataDictionary];
        
        [AppItSDK verifyOTP:self additionalDictionary:addDict receivedOTP:[ArrayObjectController getResponseType]];
    } else if(service_id == 200) {
        [AppItSDK verifyAddress:self addressJSONDictionary:[ArrayObjectController getAddressDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] doExtract:isFinalSubmit doVerify:doVerifyButton finalSubmit:clearFormKey];
    } else if(service_id == 300 || service_id == 305) {
        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getEmployeeCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
    } else if(service_id == 310) {
        
        NSMutableDictionary *empDict = [ArrayObjectController getEmployeeDataDictionary];
        NSMutableDictionary *addDict = [ArrayObjectController getAdditionalDataDictionary];
        
        [AppItSDK matchFaceImage:self faceImageType:[ArrayObjectController getFaceImageType] idImageType:[ArrayObjectController getIdFaceType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
    } else if(service_id == 401) {
        [AppItSDK generateToken:self];
    } else if(service_id == 330) {
        
        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getOverrideEmpCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        
    } else if(service_id == 320) {
        
        [AppItSDK verifyEmployee:self employeeCode:[ArrayObjectController getOverrideEmpCode] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        
    } else if(service_id == 175) {
        [AppItSDK enrollFingerprint:self  additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] clearFormKey:clearFormKey];
    } else if(service_id == 180) {
        //[self stopProgress];
        [AppItSDK createEmployee:self employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit];
    } else if(service_id == 360 || service_id == 361) {
        NSMutableDictionary *customProductDict = _customProductDefinationDict;
        [AppItSDK executeGenericRequest:self customProductDefination:_customProductDefinationDict additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
    }else if(service_id==75){
        [AppItSDK updateEmployee:self faceImageType:[AppItSDK getFaceImageType] employeeDictionary:[ArrayObjectController getEmployeeDataDictionary] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
    } else {
       
        if(service_id == 55) {
            [AppItSDK processImageAndMatchFace:self countryCode:countryCode stateCode:stateCode idType:idType faceImageType:[ArrayObjectController getFaceImageType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey employeeDictionary:[ArrayObjectController getEmployeeDataDictionary]];
        } else {
            [AppItSDK processImageAndMatchFace:self countryCode:countryCode stateCode:stateCode idType:idType faceImageType:[ArrayObjectController getFaceImageType] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] finalSubmit:isFinalSubmit clearFormKey:clearFormKey];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [self navigationCode];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    isSnackBarVisible = false;
}

//ProcessImage Response
-(void)processImageResponse : (NSMutableDictionary*) result {
    NSLog(@"processImageResponse Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

//Match Face Response
-(void)faceMatchingResponse : (NSMutableDictionary*) result{
    NSLog(@"faceMauptchingResponse Response : %@ ", result);
    [self stopProgress];
    
    int height = self.view.frame.size.height;
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    bool showeresult = true;
//    if([@"Create Employee" isEqualToString:[ArrayObjectController getServiceType]] || [@"Create Customer" isEqualToString:[ArrayObjectController getServiceType]]) {
//        NSLog(@"Data");
//
//        [verifyEmployeeCustBtn setHidden:NO];
//       //Facial Biometric Match Failed
//        if([@"Facial Biometric Match Failed" isEqualToString:[retriedDict objectForKey:@"State"]]) {
//
//            backBtn.frame = CGRectMake(backBtn.frame.origin.x, backBtn.frame.origin.y + backBtn.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height);
//            showeresult = false;
//            [ArrayObjectController setEnableCaptureEmployee:YES];
//        } else {
//
//            showeresult = true;
//        }
//    }
    
    if(showeresult) {
        ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
        
        NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
        
        if(nil == retriedDict) {
            NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
            [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
            controller.resultDictionary = statusDict;
            controller.linearKeyArray = [[statusDict allKeys] mutableCopy];;
        } else {
            controller.resultDictionary = retriedDict;
            controller.linearKeyArray = [keyArray mutableCopy];
        }
        controller.reqResponseRawData = @"MATCH_FACE";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

//ProcessImageAndMatchFace Response
-(void)processImageAndFaceMatchingResponse : (NSMutableDictionary*) result {
    NSLog(@"processImageAndFaceMatchingResponse Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
    
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"PROCESS_IMAGE_AND_MATCH_FACE";
    controller.isClearFormKey = clearFormKey;
    [self.navigationController pushViewController:controller animated:YES];
}

//Generic Call Response

-(void)genericApiCallResponse : (NSMutableDictionary *)result {
    
    NSLog(@"GenericApiCall Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    //controller.reqResponseRawData = @"PROCESS_IMAGE_AND_MATCH_FACE";
    controller.reqResponseRawData = @"";
    controller.isClearFormKey = clearFormKey;
    [self.navigationController pushViewController:controller animated:YES];
    
}

//IDValidationAndVideoMatchingResponse
-(void)idValidationAndVideoMatchingResponse : (NSMutableDictionary*) result {
    NSLog(@"idValidationAndVideoMatchingResponse Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"IDVALIDATION_WITH_VIDEO_RECORDING";
    controller.isClearFormKey = clearFormKey;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)executeGenericResponse : (NSMutableDictionary*) result {
    NSLog(@"executeGenericResponse Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"GENERIC_CALL";
    controller.isClearFormKey = clearFormKey;
    [self.navigationController pushViewController:controller animated:YES];
}

//Create Employee
-(void)createEmployeeResponse : (NSMutableDictionary *)result {
    NSLog(@"Create Employee response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"";
    [self.navigationController pushViewController:controller animated:YES];
}


//Customer Update
- (void)updateCustomerResponse:(NSMutableDictionary *)result{
    [self stopProgress];
    NSLog(@"updateCustomer Response : %@ ", result);
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"CUSTOMER_UPDATE";
    [self.navigationController pushViewController:controller animated:YES];
}

//Employee Update
-(void)updateEmployeeResponse:(NSMutableDictionary *)result{
    [self stopProgress];
    NSLog(@"updateCustomer Response : %@ ", result);
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"EMPLOYEE_UPDATE";
    [self.navigationController pushViewController:controller animated:YES];
}

//Customer Verify
-(void)verifyCustomerResponse:(NSMutableDictionary *)result{
    NSLog(@"verifyCustomerResponse Response : %@ ", result);
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"VERIFY_CUSTOMER";
    [self.navigationController pushViewController:controller animated:YES];
}

//Generate OTP response
-(void)generateOTPResponse : (NSMutableDictionary *)result {
    [self stopProgress];
    NSLog(@"generateTokenResponse Response : %@ ", result);
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"GENERATE_OTP";
    [self.navigationController pushViewController:controller animated:YES];
}

//Verify OTP
-(void)verifyOTPResponse : (NSMutableDictionary *)result {
    [self stopProgress];
    NSLog(@"verifyOTPResponse Response : %@ ", result);
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

//Address Matching
-(void)verifyPOAResponse : (NSMutableDictionary *)result {
    NSLog(@"VerifyPOAResponse");
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
     NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"ADDRESS_MATCHING";
    [self.navigationController pushViewController:controller animated:YES];
}

//Verify Employee
-(void)verifyEmployeeResponse : (NSMutableDictionary *)result {
    NSLog(@"verifyEmployeeResponse");
    [self stopProgress];
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"EMPLOYEE_VERIFICATION";
    [self.navigationController pushViewController:controller animated:YES];
}

//Generate Token Response
-(void)generateTokenResponse : (NSMutableDictionary *)result {
    [self stopProgress];
    NSLog(@"generateTokenResponse Response : %@ ", result);
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"GENERATE_TOKEN";
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)fingerprintEnrolmentResponse : (NSMutableDictionary*) result {
    [self stopProgress];
    NSLog(@"Finger Print Enrolment Response");
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    NSMutableDictionary *keyArray = [result objectForKey:@"keyArray"];
    if(nil == retriedDict) {
        NSMutableDictionary *statusDict = [[NSMutableDictionary alloc] init];
        [statusDict setObject:[result objectForKey:@"statusMessage"] forKey:[result objectForKey:@"statusCode"]];
        controller.resultDictionary = statusDict;
        controller.linearKeyArray = [[statusDict allKeys] mutableCopy];
    } else {
        controller.resultDictionary = retriedDict;
        controller.linearKeyArray = [keyArray mutableCopy];
    }
    controller.reqResponseRawData = @"FINGER_ENROLLMENT";
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)navigationCode {
    
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UINavigationItem* navItem = [[UINavigationItem alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = [ArrayObjectController getServiceType];
    [label sizeToFit];
    
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,(width/100)*8,(width/100)*8);
    [button1 setBackgroundImage:[UIImage imageNamed: @"navdrawer.png"]
                       forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(navigationDrawerBtn:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIImage *dataImage = [UIImage imageNamed:@"navdrawer.png"];
    [cancelBtn setBackgroundImage:dataImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = cancelBtn;
}

-(void)navigationDrawerBtn:(UIButton*)button {
    NSLog(@"Navigation Drawer Btn clicked");
    SidePanelController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SidePanelController"];
    controller.view.backgroundColor = [UIColor clearColor];
    
    UIViewController *childViewController = [self.navigationController.childViewControllers lastObject];
    if(![childViewController isKindOfClass:controller.class]) {
        controller.delegate = self;
        [self.navigationController addChildViewController:controller];
        [self.navigationController.view addSubview:controller.view];
        [controller.view layoutIfNeeded];
        [controller didMoveToParentViewController:self];
    }
    
}

-(void)sidePanelBtnClicked : (NSString*) controllerType{
    NSLog(@"Side Panel Button Clicked");
    
    if([controllerType isEqualToString:@"AccountSetUP"]) {
        AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if([controllerType isEqualToString:@"ProcessFlow"]) {
        ProcessFlowController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)snackBarView:(NSString*)snackMessage {
    
    //    int width = self.navigationController.view.frame.size.width;
    //    int height = self.navigationController.view.frame.size.height;
    
    //    int height = self.view.frame.size.height;
    //    int width = self.view.frame.size.width;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
     if(!isSnackBarVisible) {
    showMSGLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - (height/100)*8 + (height/100)*8, width, (height/100)*8)];
    [showMSGLabel setText:snackMessage];
    [showMSGLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#5D5A59" alpha:1.0]];
    [showMSGLabel setTextAlignment:NSTextAlignmentCenter];
    [showMSGLabel setTextColor:[UIColor whiteColor]];
    //    [self.navigationController.view addSubview:showMSGLabel];
    [self.navigationController.view addSubview:showMSGLabel];
    [self.navigationController.view bringSubviewToFront:showMSGLabel];
    isSnackBarVisible = true;
    [UIView transitionWithView:showMSGLabel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = showMSGLabel.frame;
        frame.origin.y = showMSGLabel.frame.origin.y - (height/100)*8;
        showMSGLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        [self startTimedTask];
    }];
    }
}

- (void)startTimedTask
{
    fiveSecondTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:NO];
}

- (void)performBackgroundTask
{
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        //Do background work
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //Update UI
    int width = self.navigationController.view.frame.size.width;
    int height = self.navigationController.view.frame.size.height;
    [UIView transitionWithView:showMSGLabel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = showMSGLabel.frame;
        frame.origin.y = showMSGLabel.frame.origin.y + (height/100)*8;
        showMSGLabel.frame = frame;
        [self startTimedTask];
        
    } completion:^(BOOL finished) {
        [showMSGLabel removeFromSuperview];
        [fiveSecondTimer invalidate];
         isSnackBarVisible = false;
    }];
    
    //       });
    //    });
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(NSString*)retrieveSetting:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

-(NSString*)retrieveSetting:(NSString*)key defaultValue:(NSString*)defaultValue{
    NSString *val = [self retrieveSetting:key];
    if(val != nil){
        return val;
    }else{
        return defaultValue;
    }
}

-(void)wrapUILabel:(UILabel*)title {
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    if ([language isEqualToString:@"my"] || [language isEqualToString:@"es"]){
    title.lineBreakMode = UILineBreakModeWordWrap;
    [title setFont:[UIFont boldSystemFontOfSize:13]];
    title.numberOfLines = 2;
  }else {
    [title setFont:[UIFont boldSystemFontOfSize:18]];
  }
}

@end
