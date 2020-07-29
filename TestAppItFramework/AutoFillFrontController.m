//
//  AutoFillFrontController.m
//  AppItDepedency
//
//  Created by Sanket Garde on 03/03/20.
//  Copyright © 2020 idmission solutions pvt ltd . All rights reserved.
//

#import "AutoFillFrontController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"
#import "NSStringUtilsDemo.h"

@interface AutoFillFrontController ()

@end

@implementation AutoFillFrontController {
   //UILabel *leftLabel;
    UILabel *titleLabel;
    UIButton *recaptureButton;
    UIButton *configurationButton, *exitConfigureViewBtn;
    UIImageView *resultImage;
    UIButton *cameraClickBtn;
    UILabel *captureLabel;
    bool isCapture;
    
    UIScrollView *scrollView, *snippetFieldScrollView;
    UIImageView *downUPArrowImage;
    UITextField *mrzRetryCountTextField, *mrzBarcodeRetryCountTextField;
    bool isVisible;
    UIView *configureView;
     
    NSString *mrzRetryCountThreshold, *mrzBarcodeRetryCountThreshold;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isCapture = true;
    mrzRetryCountThreshold = @"10";
    mrzBarcodeRetryCountThreshold = @"10";
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",titlesArray[0]]];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"auto_fill_front_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    [self initUI];
    
    configurationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [configurationButton setBackgroundColor:[UIColor grayColor]];
    configurationButton.frame = CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*8, width, (height/100)*8);
    [configurationButton setTitle:[LabelUtils getLabelForKey:@"configuration"] forState:UIControlStateNormal];
    [configurationButton addTarget:self action:@selector(configurationBtnClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
    [ArrayObjectController addLinearGradientToView:configurationButton TopColor:[ArrayObjectController colorwithHexString:@"#00A579" alpha:1.0] BottomColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:configurationButton];
    
    //    //Down Arrow Image
    downUPArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(configurationButton.frame.origin.x + configurationButton.frame.size.width/2 - (width/100)*29, configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downUPArrowImage setImage:[UIImage imageNamed:@"Up_Arrow.png"]];
    [self.view addSubview:downUPArrowImage];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*25 + (height/100)*25, width, (height/100)*25)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    [mrzRetryCountTextField setDelegate:(id)self];
    [mrzRetryCountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [mrzRetryCountTextField setText:[self retrieveSetting:@"mrz_retry_count_front" defaultValue:mrzRetryCountThreshold]];
    
    [mrzBarcodeRetryCountTextField setDelegate:(id)self];
    [mrzBarcodeRetryCountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [mrzBarcodeRetryCountTextField setText:[self retrieveSetting:@"mrz_barcode_retry_count_front" defaultValue:mrzBarcodeRetryCountThreshold]];
    
    //Adding Snippet Fields
    configureView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*10, (height/100)*10, (width/100)*80, [ArrayObjectController getPageControlY] - (height/100)*30)];
    [configureView setBackgroundColor:[UIColor whiteColor]];
    configureView.layer.borderColor = [UIColor grayColor].CGColor;
    configureView.layer.borderWidth = 0.5f;
    [self.view addSubview:configureView];
    [configureView setHidden:YES];
    
    snippetFieldScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, configureView.frame.size.width, configureView.frame.size.height)];
    snippetFieldScrollView.showsVerticalScrollIndicator=YES;
    [snippetFieldScrollView setScrollEnabled:YES];
    [snippetFieldScrollView setShowsHorizontalScrollIndicator:YES];
    [snippetFieldScrollView setShowsVerticalScrollIndicator:YES];
    [configureView addSubview:snippetFieldScrollView];
    
    exitConfigureViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitConfigureViewBtn setFrame:CGRectMake(configureView.frame.origin.x + configureView.frame.size.width - (configureView.frame.size.width/100)*9, configureView.frame.origin.y - (configureView.frame.size.width/100)*9, (configureView.frame.size.width/100)*10, (configureView.frame.size.width/100)*10)];
    //    [exitConfigureViewBtn setFrame:CGRectMake(configureView.frame.origin.x + configureView.frame.size.width - (configureView.frame.size.width/100)*11, configureView.frame.origin.y + (configureView.frame.size.width/100) * 1, (configureView.frame.size.width/100)*10, (configureView.frame.size.width/100)*10)];
    [exitConfigureViewBtn setImage:[UIImage imageNamed:@"cancelsnippet.png"] forState:UIControlStateNormal];
    [self.view addSubview:exitConfigureViewBtn];
    [exitConfigureViewBtn setHidden:YES];
    [exitConfigureViewBtn addTarget:self action:@selector(exitFromConfigureView:) forControlEvents:UIControlEventTouchUpInside];
    [exitConfigureViewBtn setContentMode:UIViewContentModeScaleAspectFill];
}

-(void)exitFromConfigureView:(UIButton*)button {
    if(![configureView isHidden]) {
        [self removeAllTheViewFromScrolView];
        [configureView setHidden:YES];
        [exitConfigureViewBtn setHidden:YES];
    }
}

-(void) removeAllTheViewFromScrolView {
    for (UIView *v in snippetFieldScrollView.subviews) {
        [v removeFromSuperview];
    }
}

-(void) reloadAllTheViews:(NSMutableDictionary *)barcodeDataDictionary {
    for (UIView *v in snippetFieldScrollView.subviews) {
        [v removeFromSuperview];
    }
    [self addViewToScrollView:barcodeDataDictionary];
}

-(void) addViewToScrollView:(NSMutableDictionary *)barcodeDataDictionary {
    __block float endViewPosition = 0;
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    
    __block bool firstLaunch = true;
    
    [barcodeDataDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        endViewPosition = [self addDataInScrollView:snippetFieldScrollView scrollY:(height/100)*2 + endViewPosition fieldType:key valueType:obj firstTimeLaunch:firstLaunch];
        if(firstLaunch) {
            firstLaunch = false;
        }
    }];
    
    [snippetFieldScrollView setContentSize:CGSizeMake(configureView.frame.size.width,  endViewPosition + (width/100)*3)];
}

-(float)addDataInScrollView:(UIScrollView *)scrollView scrollY:(float)scrollY fieldType:(NSString*)fieldType valueType:(NSString *)valueType firstTimeLaunch:(bool)firstLaunch{
    
    int width = scrollView.frame.size.width;
    int height = scrollView.frame.size.height;
    
    UILabel *keyName ;
    
    if(firstLaunch) {
        UILabel *barcodeDataLabel = [[UILabel alloc] initWithFrame:CGRectMake( (width/100)*3, scrollY, (width/100)*50, (height/100)*12)];
        [barcodeDataLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [barcodeDataLabel setText:@"Data:"];
        [barcodeDataLabel setTextAlignment:NSTextAlignmentLeft];
        [barcodeDataLabel setTextColor:[UIColor blackColor]];
        [scrollView addSubview:barcodeDataLabel];
        
        keyName = [[UILabel alloc] initWithFrame:CGRectMake(0, barcodeDataLabel.frame.origin.y + barcodeDataLabel.frame.size.height + (height/100)*2, (width/100)*50, (height/100)*10)];
        
    } else {
        keyName = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollY, (width/100)*50, (height/100)*10)];
    }
    
    
    
    // GroupNAme
    
    [keyName setText:fieldType];
    [keyName setFont:[UIFont systemFontOfSize:12]];
    [keyName setLineBreakMode:NSLineBreakByWordWrapping];
    keyName.numberOfLines = 0;
    [keyName setTextAlignment:NSTextAlignmentCenter];
//    [keyName setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:keyName];
    
    UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(keyName.frame.origin.x + keyName.frame.size.width , keyName.frame.origin.y, (width/100)*50, (height/100)*10)];
    [valueName setText:valueType];
    [valueName setFont:[UIFont systemFontOfSize:12]];
    [valueName setLineBreakMode:NSLineBreakByWordWrapping];
    valueName.numberOfLines = 0;
    [valueName setTextAlignment:NSTextAlignmentCenter];
//    [valueName setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:valueName];
    
    UIView *addLineView = [[UIView alloc] initWithFrame:CGRectMake(0, keyName.frame.origin.y + keyName.frame.size.height + (width/100)*5, width, (width/100)*0.2)];
    [scrollView addSubview:addLineView];
    
    return (addLineView.frame.origin.y + addLineView.frame.size.height);
}

-(void)initUI {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    UIView *backGroundWhiteView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*5, titleLabel.frame.origin.y + titleLabel.frame.size.height + (height/100)*2, (width/100)*90, (height/100)*35)];
    [backGroundWhiteView setBackgroundColor:[UIColor whiteColor]];
    backGroundWhiteView.layer.borderWidth = 0.2;
    backGroundWhiteView.layer.cornerRadius = 5.0;
    backGroundWhiteView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:backGroundWhiteView];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(viewOnTouch:)];
    [backGroundWhiteView addGestureRecognizer:singleFingerTap];
    
    float cameraClickX = (backGroundWhiteView.frame.origin.x + backGroundWhiteView.frame.size.width)/2 - (width/100)*1;
    float cameraClickY = (backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height)/2 - (width/100)*1;
    
    cameraClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraClickBtn.frame = CGRectMake(cameraClickX, cameraClickY, (width/100)*10, (width/100)*10);
    cameraClickBtn.center = backGroundWhiteView.center;
    [cameraClickBtn setImage:[UIImage imageNamed:@"Camera.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    //[captureLabel setText:titlesArray[0]];
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, backGroundWhiteView.frame.origin.y + (backGroundWhiteView.frame.size.height/100)*2, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - (backGroundWhiteView.frame.size.height/100)*4)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    //[resultImage setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:resultImage];
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*6);
    [recaptureButton setFrame:frame];
    recaptureButton.layer.cornerRadius = 20;
    recaptureButton.clipsToBounds = YES;
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
    recaptureButton.titleLabel.textColor = [UIColor whiteColor];
    [recaptureButton setBackgroundColor:[UIColor blackColor]];
    [recaptureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [recaptureButton addTarget:self action:@selector(captureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recaptureButton];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y + recaptureButton.frame.size.height + (height/100)*2, (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [backBtn setFrame:saveAccountframe];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (recaptureButton.frame.size.width/100)*5, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (width/100)*12);
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*55, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    NSString *countryCode = [ArrayObjectController getCountryType];
    NSString *stateCode = [ArrayObjectController getStateType];
    NSString *idType = [ArrayObjectController getIdType];
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:countryCode]){
        [nsDict setObject:countryCode forKey:@"country_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:stateCode]){
        [nsDict setObject:stateCode forKey:@"state_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:idType]){
        [nsDict setObject:idType forKey:@"id_type"];
    }
    
    NSString *mrzRetryCount = [[mrzRetryCountTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *mrzBarcodeRetryCount = [[mrzBarcodeRetryCountTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [nsDict setObject:mrzRetryCount forKey:@"id_mrz_retry_count"];
    [nsDict setObject:mrzBarcodeRetryCount forKey:@"id_mrz_barcode_retry_count"];
    
    [nsDict setObject:@"FRONT" forKey:@"id_side"];
    
    [AppItSDK autoFill:[ArrayObjectController getPageDelegate] idCaptureConfig:nsDict additionalDictionary:[ArrayObjectController getAdditionalDataDictionary]];
}

-(void)captureBtn:(UIButton*)button {
    NSString *countryCode = [ArrayObjectController getCountryType];
    NSString *stateCode = [ArrayObjectController getStateType];
    NSString *idType = [ArrayObjectController getIdType];
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:countryCode]){
        [nsDict setObject:countryCode forKey:@"country_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:stateCode]){
        [nsDict setObject:stateCode forKey:@"state_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:idType]){
        [nsDict setObject:idType forKey:@"id_type"];
    }
    
    NSString *mrzRetryCount = [[mrzRetryCountTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *mrzBarcodeRetryCount = [[mrzBarcodeRetryCountTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [nsDict setObject:mrzRetryCount forKey:@"id_mrz_retry_count"];
    [nsDict setObject:mrzBarcodeRetryCount forKey:@"id_mrz_barcode_retry_count"];
    
    [nsDict setObject:@"FRONT" forKey:@"id_side"];
    
    [AppItSDK autoFill:[ArrayObjectController getPageDelegate] idCaptureConfig:nsDict additionalDictionary:[ArrayObjectController getAdditionalDataDictionary]];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)setResultImage:(UIImage *)resImage {
    isCapture=false;
    [cameraClickBtn setHidden:YES];
    [captureLabel setHidden:YES];
    [resultImage setImage:resImage];
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //mrxRetryount
    UILabel *mrzRetryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2, (width/100)*88, (height/100)*4)];
    [mrzRetryCountLabel setText:[LabelUtils getLabelForKey:@"mrz_retry_count"]];
    [mrzRetryCountLabel setAlpha:0.7];
    [mrzRetryCountLabel setFont:[UIFont systemFontOfSize:14]];
    mrzRetryCountLabel.numberOfLines = 0;
    mrzRetryCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mrzRetryCountLabel];
    
    mrzRetryCountTextField = [[UITextField alloc] initWithFrame:CGRectMake(mrzRetryCountLabel.frame.origin.x, mrzRetryCountLabel.frame.origin.y + mrzRetryCountLabel.frame.size.height + (height/100)*1, (width/100)*88, (height/100)*4)];
    [mrzRetryCountTextField setFont:[UIFont systemFontOfSize:12]];
    mrzRetryCountTextField.layer.cornerRadius = 5;
    mrzRetryCountTextField.layer.borderWidth = 1.0;
    mrzRetryCountTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [mrzRetryCountTextField setAlpha:0.7];
    [mrzRetryCountTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    mrzRetryCountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:mrzRetryCountTextField];
    
    //MRZ and Barcode Retry Count
    UILabel *mrzBarcodeRetryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,mrzRetryCountTextField.frame.origin.y + mrzRetryCountTextField.frame.size.height + (height/100)*2, (width/100)*88, (height/100)*4)];
    [mrzBarcodeRetryCountLabel setText:[LabelUtils getLabelForKey:@"mrz_barcode_retry_count"]];
    [mrzBarcodeRetryCountLabel setAlpha:0.7];
    [mrzBarcodeRetryCountLabel setFont:[UIFont systemFontOfSize:14]];
    mrzBarcodeRetryCountLabel.numberOfLines = 0;
    mrzBarcodeRetryCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mrzBarcodeRetryCountLabel];
    
    mrzBarcodeRetryCountTextField = [[UITextField alloc] initWithFrame:CGRectMake(mrzBarcodeRetryCountLabel.frame.origin.x, mrzBarcodeRetryCountLabel.frame.origin.y + mrzBarcodeRetryCountLabel.frame.size.height + (height/100)*1, (width/100)*88, (height/100)*4)];
    [mrzBarcodeRetryCountTextField setFont:[UIFont systemFontOfSize:12]];
    mrzBarcodeRetryCountTextField.layer.cornerRadius = 5;
    mrzBarcodeRetryCountTextField.layer.borderWidth = 1.0;
    mrzBarcodeRetryCountTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [mrzBarcodeRetryCountTextField setAlpha:0.7];
    [mrzBarcodeRetryCountTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    mrzBarcodeRetryCountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:mrzBarcodeRetryCountTextField];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(mrzRetryCountLabel.frame.origin.x, mrzBarcodeRetryCountTextField.frame.origin.y + mrzBarcodeRetryCountTextField.frame.size.height + (height/100)*2, (width/100)*44, (height/100)*6);
    [saveBtn setFrame:saveAccountframe];
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:[LabelUtils getLabelForKey:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:saveBtn];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake((width/100)*52 , saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)configurationBtnClicked:(UIButton*)button {
    [self configBtnClickMethod];
}

-(void)configBtnClickMethod {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(!isVisible) {
        [UIView transitionWithView:scrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = scrollView.frame.origin.y - scrollView.frame.size.height- buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = scrollView.frame;
            frame.origin.y = frame.origin.y - frame.size.height;
            scrollView.frame = frame;
            isVisible = true;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Down_Arrow.png"]];
        }];
    } else {
        [UIView transitionWithView:scrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = scrollView.frame.origin.y + scrollView.frame.size.height - buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = scrollView.frame;
            frame.origin.y =frame.origin.y +scrollView.frame.size.height;
            scrollView.frame = frame;
            isVisible = false;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Up_Arrow.png"]];
        }];
    }
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)saveButton:(UIButton*)button {
    [self saveSetting:@"mrz_retry_count_front" value:[mrzRetryCountTextField text]];
    [self saveSetting:@"mrz_barcode_retry_count_front" value:[mrzRetryCountTextField text]];
    [self configBtnClickMethod];

}

-(void)resetButton:(UIButton*)button {

    [mrzRetryCountTextField setText:mrzRetryCountThreshold];
    [mrzBarcodeRetryCountTextField setText:mrzBarcodeRetryCountThreshold];
    [self saveSetting:@"mrz_retry_count_front" value:[mrzRetryCountTextField text]];
    [self saveSetting:@"mrz_barcode_retry_count_front" value:[mrzRetryCountTextField text]];
}

-(void)captureResponse : (NSMutableDictionary*) result {
    NSLog(@"");
    NSLog(@"captureImageResponse Response : %@ ", result);
    
//    NSString *front = [result objectForKey:@"FRONT"];
//    NSString *back = [result objectForKey:@"BACK"];
    NSMutableDictionary *resultDataDict = [result objectForKey:@"Result"];
    
    NSMutableDictionary *dataDict = [resultDataDict objectForKey:@"IDData"];
    
    if(nil !=dataDict && [dataDict count] > 0 && [dataDict objectForKey:@"MRZData_MRZ"]) {
        NSString *unescapeMRZData = [dataDict objectForKey:@"MRZData_MRZ"];
        unescapeMRZData = [self unEsacpeXML:unescapeMRZData];
        [dataDict setObject:unescapeMRZData forKey:@"MRZData_MRZ"];
    }
    
    if(nil != dataDict && [dataDict count] > 0) {
        
        [configureView setHidden:false];
        [exitConfigureViewBtn setHidden:false];
        [self reloadAllTheViews:dataDict];
        
    } else {
        [configureView setHidden:true];
        [exitConfigureViewBtn setHidden:true];
    }
    
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
    
//    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
    
//    if(nil != front){
//        NSData* data = [[NSData alloc] initWithBase64EncodedString:front options:0];
//        UIImage* image = [UIImage imageWithData:data];
//
//    }else if(nil != back){
//        NSData* data = [[NSData alloc] initWithBase64EncodedString:back options:0];
//        UIImage* image = [UIImage imageWithData:data];
//        [resultImage setImage:image];
//        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
//        isCapture=false;
//    }
}

-(void)saveSetting:(NSString*)key value:(NSString*)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
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

-(NSString* ) unEsacpeXML:(NSString*) text{
    
    text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    return text;
}



@end

