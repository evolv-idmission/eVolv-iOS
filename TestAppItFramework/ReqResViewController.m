//
//  ReqResViewController.m
//  AppItDepedency
//
//  Created by  on 30/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "ReqResViewController.h"
#import "ArrayObjectController.h"
#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"

@interface ReqResViewController () {
    UIButton *shareButton;
    bool isRequest;
    NSString *requestResponseType;
}

@end

@implementation ReqResViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    [self initializeView];
    [self navigationCode];
}

-(void)navigationCode {
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = [LabelUtils getLabelForKey:@"result"];
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
    
    UIImage* image3 = [UIImage imageNamed:@"download.png"];
    CGRect frameimg = CGRectMake(0, 0, dataImage.size.width, dataImage.size.height);
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:frameimg];
    [downloadBtn setBackgroundImage:image3 forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(share_button_pressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [downloadBtn setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *downloadBarBtn =[[UIBarButtonItem alloc] initWithCustomView:downloadBtn];
    self.navigationItem.rightBarButtonItem=downloadBarBtn;
    
}


-(void)initializeView {
    
    bool isiPhoneX = false;
    
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
        int height = (int)[[UIScreen mainScreen] nativeBounds].size.height;
        int width = (int)[[UIScreen mainScreen] nativeBounds].size.width;
        
        switch (height) {
                
            case 2436:
                //"iPhone X"
                isiPhoneX = true;
                break;
            default:
                printf("unknown");
        }
    }
    isRequest = true;
    requestResponseType = @"";
    NSBundle *frameworkBundle = [NSBundle bundleWithIdentifier:@"com.idmission.AppItFramework"];
    int viewHeight = self.view.bounds.size.height;
    int viewWidth = self.view.bounds.size.width;
    int padding = 5;
    int iPhoneXPadding = 5;
    int iconSize = 100;
    if(viewHeight < 668){
        iconSize = 50;
    }
    if(isiPhoneX) {
        iPhoneXPadding = 30;
    }
    
    // Share
    CGRect shareLabelRect = CGRectMake((viewWidth/100*25), iPhoneXPadding ,60,60);
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:shareLabelRect];
    [shareLabel setNumberOfLines:0];
    [shareLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [shareLabel setTextAlignment:NSTextAlignmentCenter];
    [shareLabel setText:[LabelUtils getLabelForKey:@"share"]];
    [shareLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:shareLabel];
    
    //Segment Control
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[[LabelUtils getLabelForKey:@"request"],[LabelUtils getLabelForKey:@"response"]]];
    [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    segmentControl.frame = CGRectMake(shareLabel.frame.origin.x + shareLabel.frame.size.width + iPhoneXPadding, shareLabel.frame.origin.y + (shareLabel.frame.size.height/2) - 15 , (viewWidth/100*50), 30);
    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    [segmentControl setTintColor:[UIColor blackColor]];
    [self.view addSubview:segmentControl];
    
    // label Request
//    CGRect requestLabelRect = CGRectMake( 0, iconSize ,viewWidth,60);
    CGRect requestLabelRect = CGRectMake( 0, segmentControl.frame.size.height + segmentControl.frame.origin.y + (viewHeight/100)*1 ,viewWidth,60);
    UILabel *requestLabel = [[UILabel alloc] initWithFrame:requestLabelRect];
    [requestLabel setNumberOfLines:0];
    [requestLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [requestLabel setTextAlignment:NSTextAlignmentCenter];
    [requestLabel setText:[LabelUtils getLabelForKey:@"request"]];
    [requestLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:requestLabel];
    
    // Request
    int totalHeightforReRes = viewHeight - segmentControl.frame.size.height - requestLabel.frame.size.height - requestLabel.frame.size.height - self.navigationController.navigationBar.frame.size.height - iPhoneXPadding - iconSize - (viewHeight/100)*6;
    CGRect requestRect = CGRectMake( 0 , requestLabel.frame.origin.y  + requestLabel.frame.size.height ,viewWidth,totalHeightforReRes/2);
    UITextView *request = [[UITextView alloc] initWithFrame:requestRect];
    [request setEditable:false];
    request.layer.borderColor = [ArrayObjectController colorwithHexString:@"4fa5d5" alpha:1].CGColor;
//    request.layer.borderWidth = 2.0f;
    request.layer.borderWidth = 0.0f;
    [self.view addSubview:request];
    
    // label Response
    CGRect responseLabelRect = CGRectMake( 0, request.frame.origin.y + request.frame.size.height ,viewWidth,60);
    UILabel *responseLabel = [[UILabel alloc] initWithFrame:responseLabelRect];
    [responseLabel setNumberOfLines:0];
    [responseLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [responseLabel setTextAlignment:NSTextAlignmentCenter];
    [responseLabel setText:[LabelUtils getLabelForKey:@"response"]];
    [responseLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:responseLabel];
    
    //Response
    int heightForResponseLabel = (viewHeight/100)*4;
//    CGRect responseRect = CGRectMake( 0 , responseLabel.frame.origin.y  + iconSize ,viewWidth,request.frame.size.height);
    CGRect responseRect = CGRectMake( 0 , responseLabel.frame.origin.y  + responseLabel.frame.size.height ,viewWidth,request.frame.size.height);
    UITextView *response = [[UITextView alloc] initWithFrame:responseRect];
    [response setEditable:false];
    response.layer.borderColor = [ArrayObjectController colorwithHexString:@"4fa5d5" alpha:1].CGColor;
    response.layer.borderWidth = 0.0f;
//    response.layer.borderWidth = 2.0f;
    [self.view addSubview:response];
    
    //Back Button
    UIButton *rawDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect saveAccountframe = CGRectMake(width/2 - (width/100)*45, languageTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*5, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (width/100)*15);
    CGRect saveAccountframe = CGRectMake((self.view.frame.size.width/100)*3, response.frame.origin.y + response.frame.size.height + (viewHeight/100)*1+15,self.view.frame.size.width/100*45, (viewHeight/100)*6);
    [rawDataButton setFrame:saveAccountframe];
    rawDataButton.layer.cornerRadius = 18;
    rawDataButton.clipsToBounds = YES;
    [rawDataButton setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    [rawDataButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rawDataButton.titleLabel.textColor = [UIColor whiteColor];
    [rawDataButton setBackgroundColor:[UIColor blackColor]];
    [rawDataButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
   // rawDataButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:rawDataButton];
    
    // Clear data Button
    UIButton *clearDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGRect frame = CGRectMake((self.view.frame.size.width/100)*5, viewHeight - (viewHeight/100)*8 - self.navigationController.navigationBar.frame.size.height, (self.view.frame.size.width/100)*90, (viewHeight/100)*6);
//    CGRect frame = CGRectMake((self.view.frame.size.width/100)*5, response.frame.origin.y + response.frame.size.height + (viewHeight/100)*1.5, (self.view.frame.size.width/100)*90, (viewHeight/100)*6);
    CGRect frame = CGRectMake((self.view.frame.size.width/100)*52, rawDataButton.frame.origin.y, rawDataButton.frame.size.width, (viewHeight/100)*6);
    [clearDataBtn setFrame:frame];
    clearDataBtn.layer.cornerRadius = 18;
    clearDataBtn.clipsToBounds = YES;
    [clearDataBtn setTitle:[LabelUtils getLabelForKey:@"clear_data_back_main_page"] forState:UIControlStateNormal];
    clearDataBtn.titleLabel.textColor = [UIColor whiteColor];
    [clearDataBtn addTarget:self action:@selector(clearDataBtn:) forControlEvents:UIControlEventTouchUpInside];
    [clearDataBtn setBackgroundColor:[UIColor blackColor]];
    clearDataBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    clearDataBtn.titleLabel.numberOfLines = 2;
    clearDataBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearDataBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:clearDataBtn];
    
    if([_requestResponseType isEqualToString:@"PROCESS_IMAGE"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"processImageRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"processImageResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"processImage";
        
    } else if ([_requestResponseType isEqualToString:@"EMPLOYEE_UPDATE"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"updateEmployeeRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"updateEmployeeResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"EMPLOYEE_UPDATE";
        
    }
    else if ([_requestResponseType isEqualToString:@"MATCH_FACE"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"matchFaceRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"matchFaceResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"matchFace";
        
    } else if ([_requestResponseType isEqualToString:@"VERIFY_CUSTOMER"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyCustomerRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyCustomerResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"verifyCustomer";
        
    } else if([_requestResponseType isEqualToString:@"PROCESS_IMAGE_AND_MATCH_FACE"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"processImageMatchFaceRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"processImageMatchFaceResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"processImageMatchFace";
        
    } else if([_requestResponseType isEqualToString:@"COMPLETE_OPERATION"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"completeOperationRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"completeOperationResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"completeOperation";
    } else if([_requestResponseType isEqualToString:@"CUSTOMER_UPDATE"]) {
        
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"customerUpdateRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"customerUpdateResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"CUSTOMER_UPDATE";
    } else if([_requestResponseType isEqualToString:@"CUSTOMER_UPDATE"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"customerUpdateRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"customerUpdateResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"CUSTOMER_UPDATE";
    } else if([_requestResponseType isEqualToString:@"VERIFY_CUSTOMER"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyCustomerRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyCustomerResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"VERIFY_CUSTOMER";
    } else if([_requestResponseType isEqualToString:@"ADDRESS_MATCHING"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"addressMatchingRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"addressMatchingResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"ADDRESS_MATCHING";
    } else if([_requestResponseType isEqualToString:@"EMPLOYEE_VERIFICATION"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"employeeVerificationRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"employeeVerificationResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"EMPLOYEE_VERIFICATION";
    } else if([_requestResponseType isEqualToString:@"GENERATE_TOKEN"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"generateTokenRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"generateTokenResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"GENERATE_TOKEN";
    } else if([_requestResponseType isEqualToString:@"GENERATE_OTP"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"generateOTPRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"generateOTPResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"GENERATE_OTP";
    } else if([_requestResponseType isEqualToString:@"VERIFY_OTP"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyOTPRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"verifyOTPResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"VERIFY_OTP";
    } else if([_requestResponseType isEqualToString:@"FINGER_ENROLLMENT"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"fingerEnrollRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"fingerEnrollResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"FINGER_ENROLLMENT";
    } else if([_requestResponseType isEqualToString:@"IDVALIDATION_WITH_VIDEO_RECORDING"]) {
        NSError *error;
        [request setText: [NSString stringWithContentsOfFile:[self getFilePath:@"idValidationWithVideoMatchRequest.txt"] encoding:NSUTF8StringEncoding error:&error]];
        [response setText: [NSString stringWithContentsOfFile:[self getFilePath:@"idValidationWithVideoMatchResponse.txt"] encoding:NSUTF8StringEncoding error:&error]];
        requestResponseType = @"IDVALIDATION_WITH_VIDEO_RECORDING";
    }
    
}

- (NSString *) getFilePath:(NSString *)fileName {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    return filePath;
}

-(void)back_button_pressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)share_button_pressed:(id)sender{
    NSLog(@"Share button pressed");
    NSURL *URL;
    if([requestResponseType isEqualToString:@"processImage"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"processImageRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"processImageResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"matchFace"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"matchFaceRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"matchFaceResponse" ofType:@"txt"];
        }
        
    } else if([requestResponseType isEqualToString:@"verifyCustomer"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"verifyCustomerRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"verifyCustomerResponse" ofType:@"txt"];
        }
    } else if ([requestResponseType isEqualToString:@"processImageMatchFace"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"processImageMatchFaceRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"processImageMatchFaceResponse" ofType:@"txt"];
        }
    } else if ([requestResponseType isEqualToString:@"completeOperation"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"completeOperationRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"completeOperationResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"CUSTOMER_UPDATE"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"customerUpdateRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"customerUpdateResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"VERIFY_CUSTOMER"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"verifyCustomerRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"verifyCustomerResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"ADDRESS_MATCHING"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"addressMatchingRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"addressMatchingResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"EMPLOYEE_VERIFICATION"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"employeeVerificationRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"employeeVerificationResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"GENERATE_TOKEN"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"generateTokenRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"generateTokenResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"GENERATE_OTP"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"generateOTPRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"generateOTPResponse" ofType:@"txt"];
        }
    } else if([requestResponseType isEqualToString:@"VERIFY_OTP"]) {
        if(isRequest) {
            URL = [self localPathForResource:@"verifyOTPRequest" ofType:@"txt"];
        } else {
            URL = [self localPathForResource:@"verifyOTPResponse" ofType:@"txt"];
        }
    }
    
    
    //    if (URL) {
    //        // Initialize Document Interaction Controller
    //        self->documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    //
    //        // Configure Document Interaction Controller
    //        [self->documentInteractionController setDelegate:self];
    //
    //        // Preview PDF
    //        [self->documentInteractionController presentPreviewAnimated:YES];
    //    }
    
    if (URL) {
        self->documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [self->documentInteractionController setDelegate:self];
        
//        [self->documentInteractionController presentOptionsMenuFromRect:[shareButton frame] inView:self.view animated:YES];
        
        UIView *targetView = (UIView *)[self.navigationItem.rightBarButtonItem performSelector:@selector(view)];
        CGRect rect = targetView.frame;
        
        [self->documentInteractionController presentOptionsMenuFromRect:[targetView frame] inView:self.view animated:YES];
    }
}

-(void)backBtnClick:(UIButton*)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clearDataBtn:(UIButton*)button {
    
    [AppItSDK deleteData];
    
    AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            isRequest = true;
            break;}
        case 1:{
            isRequest = false;
            break;}
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

- (NSURL *)localPathForResource:(NSString *)resource ofType:(NSString *)type {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *resourcePath = [[documentsDirectory stringByAppendingPathComponent:resource] stringByAppendingPathExtension:type];
    return [NSURL fileURLWithPath:resourcePath];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void)navigationDrawerBtn:(UIButton*)button {
    NSLog(@"Navigation Drawer Btn clicked");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
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
    else if([controllerType isEqualToString:@"ProcessFlow"]) {
        
        ProcessFlowController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
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

@end
