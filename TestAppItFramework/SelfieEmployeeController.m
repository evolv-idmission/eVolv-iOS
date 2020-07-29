//
//  SelfieEmployeeController.m
//  AppItDepedency
//
//  Created by  on 02/11/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "SelfieEmployeeController.h"
#import "ArrayObjectController.h"
#import "NSStringUtilsDemo.h"
#import "RootPageViewController.h"
#import "AppDelegate.h"
#import "LabelUtils.h"

@interface SelfieEmployeeController ()

@end

@implementation SelfieEmployeeController {
    
    UILabel *titleLabel;
    UIButton *configurationButton;
    UIScrollView *scrollView;
    bool isVisible;
    UITextField *lightThresholdTextField, *focusThresholdTextField, *faceDetectionThresTextField, *maxImageSizeThreTextField, *faceOutlineColorTextField, *faceOutlineColorTransTextField, *detectedFaceOutlineColorTextField, *detectedFaceOutlineColorTransTextField, *outlineColorOfFaceOutlineTextField, *outlineColorOfFaceOutlineTransTextField, *outlineDetectedColorOfFaceOutlineTextField, *outlineDetectedColorOfFaceOutlineTransTextField, *selectTitleImgTextField, *faceImageTypeTextField;
    
    int mAlpha;
    int mFaceLowLightThreshold, mFaceFocusThresholde, mFaceDetectionPercentage, mFaceMaxImageSize;
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,    *dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor ,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor;
    
    NSArray *_selectedPickerData;
    NSArray *showTitlePickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    
    bool launchFrontCamera, toggleCamera, showPreviewScreen, showInstructionScreen, isCapture;
    UIButton *frontCameraTogleButton, *toggleCameraButton, *showPreviewScreenTogleButton, *showInstScreenToggleButton;
    
    UIImageView *resultImage;
    UIButton *recaptureButton;
    UILabel *faceName;
    NSMutableArray *imageArray;
    NSMutableArray *imageNameArray;
    UIImageView *downUPArrowImage ;
    NSArray *_faceImgTypePickerData, *_selectedFaceImgTypePickerData;
    NSString *textFieldTypeForPicker;
    UITextField *employeeCodeTextField;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

-(void)viewDidAppear:(BOOL)animated {
    isSnackBarVisible = false;
    myPickerView = [[UIPickerView alloc] init];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
   // showTitlePickerData = @[@"None", @"Title Image 1"];
    //_selectedPickerData = @[@"None", @"Title Image 1"];
    showTitlePickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    _selectedPickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
   // _faceImgTypePickerData = @[@"FACE_IMAGE", @"PROCESSED_FACE", @"OVAL_FACE"];
    //_selectedFaceImgTypePickerData = @[@"FACE_IMAGE", @"PROCESSED_FACE", @"OVAL_FACE"];
    _faceImgTypePickerData = @[[LabelUtils getLabelForKey:@"face"], [LabelUtils getLabelForKey:@"processed_face"], [LabelUtils getLabelForKey:@"oval_face"]];
    _selectedFaceImgTypePickerData = @[[LabelUtils getLabelForKey:@"face"], [LabelUtils getLabelForKey:@"processed_face"], [LabelUtils getLabelForKey:@"oval_face"]];
    
    [selectTitleImgTextField setDelegate:(id)self];
    [faceImageTypeTextField setDelegate:(id)self];

    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setText:showTitlePickerData[0]];
    [faceImageTypeTextField setInputView:myPickerView];
    [faceImageTypeTextField setText:_faceImgTypePickerData[0]];
//    if([ArrayObjectController getEnableCaptureEmployee]) {
        [self setEnabledCaptureAndEmployee];
//    }
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputView:myPickerView];
    [faceImageTypeTextField setInputAccessoryView:toolbarForPicker];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [selectTitleImgTextField resignFirstResponder];
    [faceImageTypeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectTitleImgTextField){
        textFieldTypeForPicker = @"selectTitleImgTextField";
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    }else if(textField == faceImageTypeTextField){
         textFieldTypeForPicker = @"faceImageType";
        _selectedPickerData = _faceImgTypePickerData;
        [myPickerView reloadAllComponents];
    }
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_selectedPickerData count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_selectedPickerData objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    
    if([_selectedPickerData isEqualToArray:showTitlePickerData]){
        [selectTitleImgTextField setText:showTitlePickerData[row]];
        [selectTitleImgTextField setTag:row+1];
    }
    
    if([textFieldTypeForPicker isEqualToString:@"faceImageType"]){
        [faceImageTypeTextField setText:_faceImgTypePickerData[row]];
        [faceImageTypeTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    isVisible = false;
    mAlpha = 1;
    launchFrontCamera = true;
    toggleCamera = false;
    showPreviewScreen = false;
   // showInstructionScreen = false;
    showInstructionScreen = true;
    isCapture = true;

    mFaceLowLightThreshold=60, mFaceFocusThresholde=15, mFaceDetectionPercentage=20, mFaceMaxImageSize=500;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95";
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    //[titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"Selfie Capture"]];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"selfie_employee_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    titleLabel.numberOfLines = 2;
   // [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    [self initUI];
    
    //Configuration Changes
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
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    //Add numeric keypad start
    [lightThresholdTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [focusThresholdTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [faceDetectionThresTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [maxImageSizeThreTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [faceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedFaceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineDetectedColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    NSString *facelightthreshold = [self retrieveSetting:@"facelightthreshold_Emp" defaultValue: [@(mFaceLowLightThreshold) stringValue]];
    NSString *facefocusthreshold = [self retrieveSetting:@"facefocusthreshold_Emp" defaultValue: [@(mFaceFocusThresholde) stringValue]];
    NSString *facedetectionthreshold = [self retrieveSetting:@"facedetectionthreshold_Emp" defaultValue: [@(mFaceDetectionPercentage) stringValue]];
    NSString *faceimagesize = [self retrieveSetting:@"faceimagesize" defaultValue: [@(mFaceMaxImageSize) stringValue]];
    NSString *faceoutlinecolor = [self retrieveSetting:@"faceoutlinecolor" defaultValue: dFaceOutlineColor];
    NSString *faceoutlinetransparency = [self retrieveSetting:@"faceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *detectedfaceoutlinecolor = [self retrieveSetting:@"detectedfaceoutlinecolor" defaultValue: dDetectedFaceOutlineColor];
    NSString *detectedfaceoutlinetransparency = [self retrieveSetting:@"detectedfaceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *outsideoutlinecolor = [self retrieveSetting:@"_outsideoutlinecolor" defaultValue: dOutsideIdOutlineColor];
    NSString *outsideoutlinetransparency = [self retrieveSetting:@"_outsideoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *detectedfaceoutsideoutlinecolor = [self retrieveSetting:@"detectedfaceoutsideoutlinecolor" defaultValue:dDetectedOutsideFaceOutlineColor];
    NSString *detectedfaceoutsideoutlinetransparency = [self retrieveSetting:@"detectedfaceoutsideoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    
    [lightThresholdTextField setText:facelightthreshold];
    [focusThresholdTextField setText:facefocusthreshold];
    [faceDetectionThresTextField setText:facedetectionthreshold];
    [maxImageSizeThreTextField setText:faceimagesize];
    [faceOutlineColorTextField setText:faceoutlinecolor];
    [faceOutlineColorTransTextField setText:faceoutlinetransparency];
    [detectedFaceOutlineColorTextField setText:detectedfaceoutlinecolor];
    [detectedFaceOutlineColorTransTextField setText:detectedfaceoutlinetransparency];
    [outlineColorOfFaceOutlineTextField setText:outsideoutlinecolor];
    [outlineColorOfFaceOutlineTransTextField setText:outsideoutlinetransparency];
    [outlineDetectedColorOfFaceOutlineTextField setText:detectedfaceoutsideoutlinecolor];
    [outlineDetectedColorOfFaceOutlineTransTextField setText:detectedfaceoutsideoutlinetransparency];
    
    [ArrayObjectController setEnableCaptureEmployee:NO];
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Light Threshold
    UILabel *lightThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [lightThresholdLabel setText:[LabelUtils getLabelForKey:@"light_threshold"]];
    [lightThresholdLabel setAlpha:0.7];
    [lightThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    lightThresholdLabel.numberOfLines = 0;
    lightThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:lightThresholdLabel];
    
    //Focus Threshold
    UILabel *focusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    [focusThresholdLabel setText:[LabelUtils getLabelForKey:@"focus_threshold"]];
    [focusThresholdLabel setAlpha:0.7];
    focusThresholdLabel.numberOfLines = 0;
    focusThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [focusThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:focusThresholdLabel];
    
    //Light threshold TextField
    lightThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, lightThresholdLabel.frame.origin.y + lightThresholdLabel.frame.size.height + (height/100)*1, lightThresholdLabel.frame.size.width, (height/100)*4)];
    [lightThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    lightThresholdTextField.layer.cornerRadius = 5;
    lightThresholdTextField.layer.borderWidth = 1.0;
    lightThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [lightThresholdTextField setAlpha:0.7];
    [lightThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    lightThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:lightThresholdTextField];
    
    //Focus threshold TextField
    focusThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, lightThresholdTextField.frame.origin.y, focusThresholdLabel.frame.size.width, (height/100)*4)];
    [focusThresholdTextField setFont:[UIFont systemFontOfSize:12]]; focusThresholdTextField.layer.cornerRadius = 5;
    focusThresholdTextField.layer.borderWidth = 1.0;
    focusThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [focusThresholdTextField setAlpha:0.7];
    [focusThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    focusThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:focusThresholdTextField];
    
    //Face Detection Threshold
    //Face Detection Threshold Label
    UILabel *faceDetectionThreLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,lightThresholdTextField.frame.origin.y + lightThresholdTextField.frame.size.height +   (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [faceDetectionThreLabel setText:[LabelUtils getLabelForKey:@"face_detection_threshold"]];
    [faceDetectionThreLabel setAlpha:0.7];
    [faceDetectionThreLabel setFont:[UIFont systemFontOfSize:11]];
    faceDetectionThreLabel.numberOfLines = 0;
    faceDetectionThreLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceDetectionThreLabel];
    
    //Max Image Size label
    UILabel *maxImageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,focusThresholdTextField.frame.origin.y + focusThresholdTextField.frame.size.height +  (height/100)*2, focusThresholdTextField.frame.size.width, (height/100)*2)];
    [maxImageSizeLabel setText:[LabelUtils getLabelForKey:@"max_image_size"]];
    [maxImageSizeLabel setAlpha:0.7];
    maxImageSizeLabel.numberOfLines = 0;
    maxImageSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxImageSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxImageSizeLabel];
    
    //Face Detection Threshold Text Field
    faceDetectionThresTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceDetectionThreLabel.frame.origin.y + faceDetectionThreLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
    [faceDetectionThresTextField setFont:[UIFont systemFontOfSize:12]];
    faceDetectionThresTextField.layer.cornerRadius = 5;
    faceDetectionThresTextField.layer.borderWidth = 1.0;
    faceDetectionThresTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceDetectionThresTextField setAlpha:0.7];
    [faceDetectionThresTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceDetectionThresTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceDetectionThresTextField];
    
    //Max Image Size Text Field
    maxImageSizeThreTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, maxImageSizeLabel.frame.origin.y + maxImageSizeLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
    [maxImageSizeThreTextField setFont:[UIFont systemFontOfSize:12]];
    maxImageSizeThreTextField.layer.cornerRadius = 5;
    maxImageSizeThreTextField.layer.borderWidth = 1.0;
    maxImageSizeThreTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxImageSizeThreTextField setAlpha:0.7];
    [maxImageSizeThreTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    maxImageSizeThreTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:maxImageSizeThreTextField];
    
    //Launch Front Camera
    //Launch Front Camera Label
    UILabel *launchFrontCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceDetectionThresTextField.frame.origin.y + faceDetectionThresTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [launchFrontCameraLabel setText:[LabelUtils getLabelForKey:@"launch_front_camera"]];
    [launchFrontCameraLabel setAlpha:0.7];
    [launchFrontCameraLabel setFont:[UIFont systemFontOfSize:11]];
    launchFrontCameraLabel.numberOfLines = 0;
    launchFrontCameraLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:launchFrontCameraLabel];
    
    //Toggle Camera Label
    UILabel *toggleCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,maxImageSizeThreTextField.frame.origin.y + maxImageSizeThreTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, (height/100)*2)];
    [toggleCameraLabel setText:[LabelUtils getLabelForKey:@"toggle_camera"]];
    [toggleCameraLabel setAlpha:0.7];
    toggleCameraLabel.numberOfLines = 0;
    toggleCameraLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [toggleCameraLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:toggleCameraLabel];
    
    //Launch Front camera NO label
    UILabel *frontCameraToggleNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, launchFrontCameraLabel.frame.origin.y + launchFrontCameraLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [frontCameraToggleNoLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [frontCameraToggleNoLabel setAlpha:0.7];
    [frontCameraToggleNoLabel setFont:[UIFont systemFontOfSize:12]];
    [frontCameraToggleNoLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:frontCameraToggleNoLabel];
    
    //toggleButton
    frontCameraTogleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    frontCameraTogleButton.frame = CGRectMake(frontCameraToggleNoLabel.frame.origin.x + frontCameraToggleNoLabel.frame.size.width + (width/100)*2, frontCameraToggleNoLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [frontCameraTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"]
                            forState:UIControlStateNormal];
    frontCameraTogleButton.contentMode = UIViewContentModeScaleAspectFit;
    //frontCameraTogleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [frontCameraTogleButton addTarget:self action:@selector(frontCameraToggleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:frontCameraTogleButton];
    
    //YES Label
    UILabel *frontCameraToggleYesLabel = [[UILabel alloc] initWithFrame:CGRectMake(frontCameraTogleButton.frame.origin.x + frontCameraTogleButton.frame.size.width + (width/100)*2, frontCameraTogleButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [frontCameraToggleYesLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [frontCameraToggleYesLabel setAlpha:0.7];
    [frontCameraToggleYesLabel setFont:[UIFont systemFontOfSize:12]];
    [frontCameraToggleYesLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:frontCameraToggleYesLabel];
    
    //toggle camera YES label
    UILabel *toggleCameraNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleCameraLabel.frame.origin.x, toggleCameraLabel.frame.origin.y + toggleCameraLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [toggleCameraNoLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [toggleCameraNoLabel setAlpha:0.7];
    [toggleCameraNoLabel setFont:[UIFont systemFontOfSize:12]];
    [toggleCameraNoLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:toggleCameraNoLabel];
    
    //toggleButton
    toggleCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toggleCameraButton.frame = CGRectMake(toggleCameraNoLabel.frame.origin.x + toggleCameraNoLabel.frame.size.width + (width/100)*2, toggleCameraNoLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [toggleCameraButton setImage:[UIImage imageNamed:@"toggleOf.png"]
                        forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    toggleCameraButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [toggleCameraButton addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:toggleCameraButton];
    
    //No Label
    UILabel *toggleCameraYesLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleCameraButton.frame.origin.x + toggleCameraButton.frame.size.width + (width/100)*2, toggleCameraButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [toggleCameraYesLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [toggleCameraYesLabel setAlpha:0.7];
    [toggleCameraYesLabel setFont:[UIFont systemFontOfSize:12]];
    [toggleCameraYesLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:toggleCameraYesLabel];
    
    //Show Preview Screen
    //show Preview Screen Label
    UILabel *showPreviewScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, frontCameraToggleYesLabel.frame.origin.y + frontCameraToggleYesLabel.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    showPreviewScreenLabel.numberOfLines = 0;
    showPreviewScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showPreviewScreenLabel setText:[LabelUtils getLabelForKey:@"show_preview_screen"]];
    [showPreviewScreenLabel setAlpha:0.7];
    [showPreviewScreenLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:showPreviewScreenLabel];
    [showPreviewScreenLabel setHidden:YES];
    
    //Launch Front camera No label
    UILabel *showPreviewScreenYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, showPreviewScreenLabel.frame.origin.y + showPreviewScreenLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [showPreviewScreenYESLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [showPreviewScreenYESLabel setAlpha:0.7];
    [showPreviewScreenYESLabel setFont:[UIFont systemFontOfSize:12]];
    [showPreviewScreenYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showPreviewScreenYESLabel];
    [showPreviewScreenYESLabel setHidden:YES];
    
    //toggleButton
    showPreviewScreenTogleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showPreviewScreenTogleButton.frame = CGRectMake(showPreviewScreenYESLabel.frame.origin.x + showPreviewScreenYESLabel.frame.size.width + (width/100)*2, showPreviewScreenYESLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [showPreviewScreenTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"]
                                  forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    showPreviewScreenTogleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [showPreviewScreenTogleButton addTarget:self action:@selector(showPreviewScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:showPreviewScreenTogleButton];
    [showPreviewScreenTogleButton setHidden:YES];
    
    //Yes Label
    UILabel *showPreviewScreenNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(showPreviewScreenTogleButton.frame.origin.x + showPreviewScreenTogleButton.frame.size.width + (width/100)*2, showPreviewScreenTogleButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [showPreviewScreenNOLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [showPreviewScreenNOLabel setAlpha:0.7];
    [showPreviewScreenNOLabel setFont:[UIFont systemFontOfSize:12]];
    [showPreviewScreenNOLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showPreviewScreenNOLabel];
    [showPreviewScreenNOLabel setHidden:YES];
    
    //Show Instruction Screen
    UILabel *showInstructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, toggleCameraButton.frame.origin.y + toggleCameraButton.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    showInstructionScreenLabel.numberOfLines = 0;
    showInstructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showInstructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [showInstructionScreenLabel setAlpha:0.7];
    [showInstructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:showInstructionScreenLabel];
    [showInstructionScreenLabel setHidden:YES];
    
    //Show Instruction Screen No label
    UILabel *showInstructionYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(showInstructionScreenLabel.frame.origin.x, showInstructionScreenLabel.frame.origin.y + showInstructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [showInstructionYESLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [showInstructionYESLabel setAlpha:0.7];
    [showInstructionYESLabel setFont:[UIFont systemFontOfSize:12]];
    [showInstructionYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showInstructionYESLabel];
    [showInstructionYESLabel setHidden:YES];
    
    //toggleButton
    showInstScreenToggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showInstScreenToggleButton.frame = CGRectMake(showInstructionYESLabel.frame.origin.x + showInstructionYESLabel.frame.size.width + (width/100)*2, showInstructionYESLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [showInstScreenToggleButton setImage:[UIImage imageNamed:@"toggleOf.png"]
                                forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    showInstScreenToggleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [showInstScreenToggleButton addTarget:self action:@selector(showInstScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:showInstScreenToggleButton];
    [showInstScreenToggleButton setHidden:YES];
    
    //Show Instruction Screen No Label
    UILabel *showInstScreenNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(showInstScreenToggleButton.frame.origin.x + showInstScreenToggleButton.frame.size.width + (width/100)*2, showInstScreenToggleButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [showInstScreenNOLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [showInstScreenNOLabel setAlpha:0.7];
    [showInstScreenNOLabel setFont:[UIFont systemFontOfSize:12]];
    [showInstScreenNOLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showInstScreenNOLabel];
    [showInstScreenNOLabel setHidden:YES];
    
    //Face OutLine Color
    //Face Outline Color Label
    UILabel *faceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,showPreviewScreenTogleButton.frame.origin.y + showPreviewScreenTogleButton.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [faceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"face_outline_color"]];
    [faceOutlineColorLabel setAlpha:0.7];
    [faceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    faceOutlineColorLabel.numberOfLines = 0;
    faceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceOutlineColorLabel setHidden:YES];
    [scrollView addSubview:faceOutlineColorLabel];
    
    //Face OutLine Color TransParency
    UILabel *faceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,showInstScreenToggleButton.frame.origin.y + showInstScreenToggleButton.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, 0)];
    [faceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [faceOutLineTransLabel setAlpha:0.7];
    faceOutLineTransLabel.numberOfLines = 0;
    faceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [faceOutLineTransLabel setHidden:YES];
    [scrollView addSubview:faceOutLineTransLabel];
    
    //Face Outline Color Text Field
    faceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceOutlineColorLabel.frame.origin.y + faceOutlineColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, 0)];
    [faceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTextField.layer.cornerRadius = 5;
    faceOutlineColorTextField.layer.borderWidth = 1.0;
    faceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTextField setAlpha:0.7];
    [faceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceOutlineColorTextField setHidden:YES];
    [scrollView addSubview:faceOutlineColorTextField];
    
    //Face Outline Color Trans Text Field
    faceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, faceOutLineTransLabel.frame.origin.y + faceOutLineTransLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, 0)];
    [faceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTransTextField.layer.cornerRadius = 5;
    faceOutlineColorTransTextField.layer.borderWidth = 1.0;
    faceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTransTextField setAlpha:0.7];
    [faceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceOutlineColorTransTextField setHidden:YES];
    [scrollView addSubview:faceOutlineColorTransTextField];
    
    //Detected Face Outline Color
    //Detected Face Outline Color label
    UILabel *detectedFaceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceOutlineColorTextField.frame.origin.y + faceOutlineColorTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [detectedFaceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"detect_face_outline_color"]];
    [detectedFaceOutlineColorLabel setAlpha:0.7];
    [detectedFaceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedFaceOutlineColorLabel.numberOfLines = 0;
    detectedFaceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedFaceOutlineColorLabel setHidden:YES];
    [scrollView addSubview:detectedFaceOutlineColorLabel];
    
    //Detected Face OutLine Color TransParency label
    UILabel *detectedFaceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,faceOutlineColorTransTextField.frame.origin.y + faceOutlineColorTransTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, 0)];
    [detectedFaceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedFaceOutLineTransLabel setAlpha:0.7];
    detectedFaceOutLineTransLabel.numberOfLines = 0;
    detectedFaceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedFaceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedFaceOutLineTransLabel setHidden:YES];
    [scrollView addSubview:detectedFaceOutLineTransLabel];
    
    //Detected Face Outline Color Text Field
    detectedFaceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, detectedFaceOutlineColorLabel.frame.origin.y + detectedFaceOutlineColorLabel.frame.size.height + (height/100)*1, detectedFaceOutlineColorLabel.frame.size.width, 0)];
    [detectedFaceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTextField setAlpha:0.7];
    [detectedFaceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedFaceOutlineColorTextField setHidden:YES];
    [scrollView addSubview:detectedFaceOutlineColorTextField];
    
    //Detected Face Outline Color Trans Text Field
    detectedFaceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, detectedFaceOutLineTransLabel.frame.origin.y + detectedFaceOutLineTransLabel.frame.size.height + (height/100)*1, detectedFaceOutLineTransLabel.frame.size.width, 0)];
    [detectedFaceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTransTextField setAlpha:0.7];
    [detectedFaceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedFaceOutlineColorTransTextField setHidden:YES];
    [scrollView addSubview:detectedFaceOutlineColorTransTextField];
    
    //Outside Color of Face Outline
    //Outside Color of Face Outline Label
    UILabel *outsideColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,detectedFaceOutlineColorTextField.frame.origin.y + detectedFaceOutlineColorTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [outsideColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_color_of_face_outLine"]];
    [outsideColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideColorOfFaceOutlineLabel setHidden:YES];
    [scrollView addSubview:outsideColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,detectedFaceOutlineColorTransTextField.frame.origin.y + detectedFaceOutlineColorTransTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, 0)];
    [outsideColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [outsideColorOfFaceOutlineTransLabel setHidden:YES];
    [scrollView addSubview:outsideColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, outsideColorOfFaceOutlineLabel.frame.origin.y + outsideColorOfFaceOutlineLabel.frame.size.height + (height/100)*1, outsideColorOfFaceOutlineLabel.frame.size.width, 0)];
    [outlineColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineColorOfFaceOutlineTextField setHidden:YES];
    [scrollView addSubview:outlineColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, outlineColorOfFaceOutlineTextField.frame.origin.y, detectedFaceOutLineTransLabel.frame.size.width, 0)];
    [outlineColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineColorOfFaceOutlineTransTextField setHidden:YES];
    [scrollView addSubview:outlineColorOfFaceOutlineTransTextField];
    
    //Outside Detected Color Of Face Outline
    //Outside Detected Color of Face Outline Label
    UILabel *outsideDetectedColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,outlineColorOfFaceOutlineTextField.frame.origin.y + outlineColorOfFaceOutlineTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [outsideDetectedColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_detected_color_of_face_outline"]];
    [outsideDetectedColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideDetectedColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideDetectedColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideDetectedColorOfFaceOutlineLabel setHidden:YES];
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideDetectedColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,outlineColorOfFaceOutlineTransTextField.frame.origin.y + outlineColorOfFaceOutlineTransTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, 0)];
    [outsideDetectedColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideDetectedColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideDetectedColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideDetectedColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [outsideDetectedColorOfFaceOutlineTransLabel setHidden:YES];
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineDetectedColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, outsideDetectedColorOfFaceOutlineLabel.frame.origin.y + outsideDetectedColorOfFaceOutlineLabel.frame.size.height + (height/100)*1, outsideDetectedColorOfFaceOutlineLabel.frame.size.width, 0)];
    [outlineDetectedColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineDetectedColorOfFaceOutlineTextField setHidden:YES];
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineDetectedColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, outlineDetectedColorOfFaceOutlineTextField.frame.origin.y, outsideDetectedColorOfFaceOutlineTransLabel.frame.size.width, 0)];
    [outlineDetectedColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineDetectedColorOfFaceOutlineTransTextField setHidden:YES];
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTransTextField];
    
    //Select Face Image Type
    //Select Face Image Type label
    UILabel *selectFaceImageTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,frontCameraToggleYesLabel.frame.origin.y + frontCameraToggleYesLabel.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*5)];
    [selectFaceImageTypeLabel setText:[LabelUtils getLabelForKey:@"face_image_type"]];
    [selectFaceImageTypeLabel setAlpha:0.7];
    [selectFaceImageTypeLabel setFont:[UIFont systemFontOfSize:11]];
    selectFaceImageTypeLabel.numberOfLines = 0;
    selectFaceImageTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:selectFaceImageTypeLabel];
    
    //Select Face Image type Edit Spinner
    faceImageTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, selectFaceImageTypeLabel.frame.origin.y + selectFaceImageTypeLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [faceImageTypeTextField setFont:[UIFont systemFontOfSize:12]];
    faceImageTypeTextField.layer.cornerRadius = 5;
    faceImageTypeTextField.layer.borderWidth = 1.0;
    faceImageTypeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceImageTypeTextField setAlpha:0.7];
    [faceImageTypeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceImageTypeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceImageTypeTextField setText:_faceImgTypePickerData[0]];
    [scrollView addSubview:faceImageTypeTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImageFace = [[UIImageView alloc] initWithFrame:CGRectMake(faceImageTypeTextField.frame.origin.x + faceImageTypeTextField.frame.size.width - (width/100)*9 , faceImageTypeTextField.frame.origin.y + (faceImageTypeTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImageFace setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImageFace];
    
    //Select Title Image
    //Select Title Image label
    UILabel *selectTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceImageTypeTextField.frame.origin.y + faceImageTypeTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [selectTitleImageLabel setText:[LabelUtils getLabelForKey:@"title_image"]];
    [selectTitleImageLabel setAlpha:0.7];
    [selectTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    selectTitleImageLabel.numberOfLines = 0;
    selectTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [selectTitleImageLabel setHidden:YES];
    [scrollView addSubview:selectTitleImageLabel];
    
    //Select Title Image Edit Spinner
    selectTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, selectTitleImageLabel.frame.origin.y + selectTitleImageLabel.frame.size.height + (height/100)*1, (width/100)*92, 0)];
    [selectTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    selectTitleImgTextField.layer.cornerRadius = 5;
    selectTitleImgTextField.layer.borderWidth = 1.0;
    selectTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [selectTitleImgTextField setAlpha:0.7];
    [selectTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    selectTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [selectTitleImgTextField setHidden:YES];
    [scrollView addSubview:selectTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectTitleImgTextField.frame.origin.x + selectTitleImgTextField.frame.size.width - (width/100)*9 , selectTitleImgTextField.frame.origin.y + (selectTitleImgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [downArrowImage setHidden:YES];
    [self.view addSubview:downArrowImage];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(lightThresholdLabel.frame.origin.x, selectTitleImgTextField.frame.origin.y + selectTitleImgTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(focusThresholdLabel.frame.origin.x, saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)frontCameraToggleBtnClick:(UIButton*)button {
    
    if(!launchFrontCamera) {
        [frontCameraTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        launchFrontCamera = true;
    } else {
        [frontCameraTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        launchFrontCamera = false;
    }
}

-(void)toggleCameraBtnClick:(UIButton*)button {
    if(!toggleCamera) {
        [toggleCameraButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        toggleCamera = true;
    } else {
        [toggleCameraButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        toggleCamera = false;
    }
}

-(void)showPreviewScreenBtnClick:(UIButton*)button {
    if(!showPreviewScreen) {
        [showPreviewScreenTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        showPreviewScreen = true;
    } else {
        [showPreviewScreenTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        showPreviewScreen = false;
    }
}

-(void)showInstScreenBtnClick:(UIButton*)button {
    if(!showInstructionScreen) {
        [showInstScreenToggleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        showInstructionScreen = true;
    }else {
        [showInstScreenToggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        showInstructionScreen = false;
    }
}

-(void)saveButton:(UIButton*)button {
    
    //UITextField, *selectTitleImgTextField;
    
    int lowLightThreshold=mFaceLowLightThreshold, focusPercentage=mFaceFocusThresholde, faceDetectionPercentage=mFaceDetectionPercentage, faceImageSize=mFaceMaxImageSize;
    NSString *faceoutlinecolor = dFaceOutlineColor, *detectedfaceoutlinecolor = dDetectedFaceOutlineColor, *outsideoutlinecolor = dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutLineColor = dDetectedOutsideFaceOutlineColor;
    int faceoutlinetransparency = mAlpha, detectedfaceoutlinetransparency = mAlpha, outsideoutlinetransparency = mAlpha, dDetectedOutsideFaceOutLineColorAlpha = mAlpha;
    
    if([NSStringUtilsDemo isInteger:lightThresholdTextField.text]){
        lowLightThreshold = [lightThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:focusThresholdTextField.text]){
        focusPercentage = [focusThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:faceDetectionThresTextField.text]){
        faceDetectionPercentage = [faceDetectionThresTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:maxImageSizeThreTextField.text]){
        faceImageSize = [maxImageSizeThreTextField.text intValue];
    }
    faceoutlinecolor = faceOutlineColorTextField.text;
    detectedfaceoutlinecolor = detectedFaceOutlineColorTextField.text;
    outsideoutlinecolor = outlineColorOfFaceOutlineTextField.text;
    faceoutlinetransparency = [faceOutlineColorTransTextField.text intValue];
    detectedfaceoutlinetransparency = [detectedFaceOutlineColorTransTextField.text intValue];
    outsideoutlinetransparency = [outlineColorOfFaceOutlineTransTextField.text intValue];
    dDetectedOutsideFaceOutLineColor = outlineDetectedColorOfFaceOutlineTextField.text;
    dDetectedOutsideFaceOutLineColorAlpha = [outlineDetectedColorOfFaceOutlineTransTextField.text intValue];
    
    [self saveSetting:@"facelightthreshold_Emp" value:[NSString stringWithFormat:@"%d", lowLightThreshold]];
    [self saveSetting:@"facefocusthreshold_Emp" value:[NSString stringWithFormat:@"%d", focusPercentage]];
    [self saveSetting:@"facedetectionthreshold_Emp" value:[NSString stringWithFormat:@"%d", faceDetectionPercentage]];
    [self saveSetting:@"faceimagesize_Emp" value:[NSString stringWithFormat:@"%d", faceImageSize]];
    [self saveSetting:@"faceoutlinecolor" value:faceoutlinecolor];
    [self saveSetting:@"detectedfaceoutlinecolor" value:detectedfaceoutlinecolor];
    [self saveSetting:@"_outsideoutlinecolor" value:outsideoutlinecolor];
    [self saveSetting:@"detectedfaceoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedfaceoutlinetransparency]];
    [self saveSetting:@"faceoutlinetransparency" value:[NSString stringWithFormat:@"%d", faceoutlinetransparency]];
    [self saveSetting:@"_outsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", outsideoutlinetransparency]];
    [self saveSetting:@"detectedfaceoutsideoutlinecolor" value:dDetectedOutsideFaceOutLineColor];
    [self saveSetting:@"detectedfaceoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d",dDetectedOutsideFaceOutLineColorAlpha]];
    
    [self configBtnClickMethod];
    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
    
    [lightThresholdTextField setText:[@(mFaceLowLightThreshold) stringValue]];
    [focusThresholdTextField setText:[@(mFaceFocusThresholde) stringValue]];
    [faceDetectionThresTextField setText:[@(mFaceDetectionPercentage) stringValue]];
    [maxImageSizeThreTextField setText:[@(mFaceMaxImageSize) stringValue]];
    [faceOutlineColorTextField setText:dFaceOutlineColor];
    [faceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedFaceOutlineColorTextField setText:dDetectedFaceOutlineColor];
    [detectedFaceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [outlineColorOfFaceOutlineTextField setText:dOutsideIdOutlineColor];
    [outlineColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [outlineDetectedColorOfFaceOutlineTextField setText:dDetectedOutsideFaceOutlineColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    
    [self saveSetting:@"facelightthreshold_Emp" value:[NSString stringWithFormat:@"%@", [@(mFaceLowLightThreshold) stringValue]]];
    [self saveSetting:@"facefocusthreshold_Emp" value:[NSString stringWithFormat:@"%@", [@(mFaceFocusThresholde) stringValue]]];
    [self saveSetting:@"facedetectionthreshold_Emp" value:[NSString stringWithFormat:@"%@", [@(mFaceDetectionPercentage) stringValue]]];
    [self saveSetting:@"faceimagesize" value:[NSString stringWithFormat:@"%@", [@(mFaceMaxImageSize) stringValue]]];
    [self saveSetting:@"faceoutlinecolor" value:dFaceOutlineColor];
    [self saveSetting:@"detectedfaceoutlinecolor" value:dDetectedFaceOutlineColor];
    [self saveSetting:@"_outsideoutlinecolor" value:dOutsideIdOutlineColor];
    [self saveSetting:@"detectedfaceoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"faceoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"_outsideoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"detectedfaceoutsideoutlinecolor" value:dDetectedOutsideFaceOutlineColor];
    [self saveSetting:@"detectedfaceoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%@",[@(mAlpha) stringValue]]];
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
    
    UIButton *cameraClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraClickBtn.frame = CGRectMake(cameraClickX, cameraClickY, (width/100)*10, (width/100)*10);
    cameraClickBtn.center = backGroundWhiteView.center;
    [cameraClickBtn setImage:[UIImage imageNamed:@"Selfy_Capture.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    UILabel *captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    faceName = [[UILabel alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*50 - (width/100)*15, backGroundWhiteView.frame.origin.y, (width/100)*30, (height/100)*5)];
    [faceName setTextAlignment:NSTextAlignmentCenter];
    [faceName setAlpha:0.7];
    [faceName setFont:[UIFont boldSystemFontOfSize:11]];
    [self.view addSubview:faceName];
    
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, faceName.frame.origin.y + faceName.frame.size.height, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - faceName.frame.size.height)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:resultImage];
    
    [resultImage setTag:-1];
    
    imageArray = [[NSMutableArray alloc] initWithCapacity:5];//It will expand automatically when needed
    imageNameArray = [[NSMutableArray alloc] initWithCapacity:5];//It will expand automatically when needed
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resultImageViewTapped:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [resultImage addGestureRecognizer:tapGestureRecognizer];
    [resultImage setUserInteractionEnabled:YES];
    [resultImage setContentMode:UIViewContentModeScaleAspectFit];
    
    //Generic Document TextField
    employeeCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*8)];
    employeeCodeTextField.layer.cornerRadius = 5;
    employeeCodeTextField.layer.borderWidth = 1.0;
    employeeCodeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [employeeCodeTextField setFont:[UIFont systemFontOfSize:14]];
    [employeeCodeTextField setAlpha:0.7];
    [employeeCodeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    employeeCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:employeeCodeTextField];
    
    UILabel *genericDocLabel = [[UILabel alloc] initWithFrame:CGRectMake(employeeCodeTextField.frame.origin.x + 15, employeeCodeTextField.frame.origin.y - ((height/100)*2), ((employeeCodeTextField.frame.size.width)/100)*35, ((height/100)*4))];
    [genericDocLabel setText:[LabelUtils getLabelForKey:@"employee_code"]];
    [genericDocLabel setFont:[UIFont systemFontOfSize:14]];
    [genericDocLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [genericDocLabel setTextAlignment:NSTextAlignmentCenter];
    [genericDocLabel setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:genericDocLabel];
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (width/100)*12);
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, employeeCodeTextField.frame.origin.y + employeeCodeTextField.frame.size.height + (height/100)*2, backGroundWhiteView.frame.size.width, (height/100)*6);
    [recaptureButton setFrame:frame];
    recaptureButton.layer.cornerRadius = 20;
    recaptureButton.clipsToBounds = YES;
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
    recaptureButton.titleLabel.textColor = [UIColor whiteColor];
    [recaptureButton addTarget:self action:@selector(captureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [recaptureButton setBackgroundColor:[UIColor blackColor]];
    [recaptureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
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
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (recaptureButton.frame.size.width/100)*5, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (width/100)*12);
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*52, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    [recaptureButton setUserInteractionEnabled:NO];
    [employeeCodeTextField setUserInteractionEnabled:NO];
}

-(void)setEnabledCaptureAndEmployee {
    [recaptureButton setUserInteractionEnabled:YES];
    [employeeCodeTextField setUserInteractionEnabled:YES];
}

- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
     [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        UIImage *titleImageFace;
        if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[selectTitleImgTextField text]]) {
            titleImageFace = nil;
        } else {
            titleImageFace = [UIImage imageNamed:@"title_image"];
        }
        [ArrayObjectController setEnableCaptureEmployee:true];
        
        NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
        
        NSString *lightThreshold = [lightThresholdTextField text];
        NSString *maxCapImageSize = [maxImageSizeThreTextField text];
        NSString *showInsScreen = (showInstructionScreen) ? @"Y" : @"N";
    
        NSString *focusThreshold= [focusThresholdTextField text];
        NSString *faceDetectionThreshold= [faceDetectionThresTextField text];
        NSString *faceOutlineColor= [faceOutlineColorTextField text];
        NSString *faceOutlineColorTrans= [faceOutlineColorTransTextField text];
        NSString *detectedFaceOutlineColor= [detectedFaceOutlineColorTextField text];
        NSString *detectedFaceOutlineColorTrans= [detectedFaceOutlineColorTransTextField text];
        NSString *outlineColorOfFaceOutline= [outlineColorOfFaceOutlineTextField text];
        NSString *outlineColorOfFaceOutlineTrans= [outlineColorOfFaceOutlineTransTextField text];
        NSString *outlineDetectedColorOfFaceOutline= [outlineDetectedColorOfFaceOutlineTextField text];
        NSString *outlineDetectedColorOfFaceOutlineTrans= [outlineDetectedColorOfFaceOutlineTransTextField text];
        //    NSString *launchCamera= launchFrontCamera ? @"true": @"false";
        //    NSString *toggleCameraButton= toggleCamera ? @"true": @"false";
        //    NSString *showFacePreviewScreen = (showPreviewScreen) ? @"true" : @"false";
        NSString *launchCamera= launchFrontCamera ? @"Y": @"N";
        NSString *toggleCameraButton= toggleCamera ? @"Y": @"N";
        NSString *showFacePreviewScreen = (showPreviewScreen) ? @"Y" : @"N";
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:lightThreshold]){
            [nsDict setObject:lightThreshold forKey:@"fd_light_threshold"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapImageSize]){
            [nsDict setObject:maxCapImageSize forKey:@"fd_max_image_size"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:toggleCameraButton]){
            [nsDict setObject:toggleCameraButton forKey:@"fd_toggle_camera"];
        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
//            [nsDict setObject:showInsScreen forKey:@"fd_show_instruction_screen"];
//        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:launchCamera]){
            [nsDict setObject:launchCamera forKey:@"fd_launch_front_camera"];
        }
//        if(![NSStringUtils stringIsNilOrEmpty:showFacePreviewScreen]){
//            [nsDict setObject:showFacePreviewScreen forKey:@"fd_show_preview_screen"];
//        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:focusThreshold]){
            [nsDict setObject:focusThreshold forKey:@"fd_focus_threshold"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:faceDetectionThreshold]){
            [nsDict setObject:faceDetectionThreshold forKey:@"fd_detection_threshold"];
        }
        //NSString *faceContours= [faceContoursTextField text];
        
//        [AppItSDK detectFace:[ArrayObjectController getPageDelegate] lowLightThreshold:[lightThresholdTextField.text intValue] focusPercentage:[focusThresholdTextField.text intValue] faceDetectionPercentage:[faceDetectionThresTextField.text intValue] ImageSize:[maxImageSizeThreTextField.text intValue] setFrontCameraDefault:launchFrontCamera showPreviewScreen:showPreviewScreen faceOutlineColor:[faceOutlineColorTextField text] faceOutlineTransparency:[faceOutlineColorTransTextField.text intValue] detectedFaceOutlineColor:[detectedFaceOutlineColorTextField text] detectedFaceOutlineTransparency:[detectedFaceOutlineColorTransTextField.text intValue] outsideFaceOutlineColor:[outlineColorOfFaceOutlineTextField text] outsideFaceOutlineTransparency:[outlineColorOfFaceOutlineTransTextField.text intValue] detectedOutsideFaceOutlineColor:[outlineDetectedColorOfFaceOutlineTextField text] detectedOutsideFaceOutlineColorTrans:[outlineDetectedColorOfFaceOutlineTransTextField.text intValue] titleImageFace:nil showInstruction:showInstructionScreen instructionimage:nil toggleCamera:toggleCamera];

//        [AppItSDK detectFace:[ArrayObjectController getPageDelegate] lowLightThreshold:[lightThresholdTextField.text intValue] focusPercentage:[focusThresholdTextField.text intValue] faceDetectionPercentage:[faceDetectionThresTextField.text intValue] ImageSize:[maxImageSizeThreTextField.text intValue] setFrontCameraDefault:launchFrontCamera showPreviewScreen:showPreviewScreen faceOutlineColor:[faceOutlineColorTextField text] faceOutlineTransparency:[faceOutlineColorTransTextField.text intValue] detectedFaceOutlineColor:[detectedFaceOutlineColorTextField text] detectedFaceOutlineTransparency:[detectedFaceOutlineColorTransTextField.text intValue] outsideFaceOutlineColor:[outlineColorOfFaceOutlineTextField text] outsideFaceOutlineTransparency:[outlineColorOfFaceOutlineTransTextField.text intValue] detectedOutsideFaceOutlineColor:[outlineDetectedColorOfFaceOutlineTextField text] detectedOutsideFaceOutlineColorTrans:[outlineDetectedColorOfFaceOutlineTransTextField.text intValue] titleImageFace:titleImageFace showInstruction:showInstructionScreen instructionimage:nil toggleCamera:toggleCamera];
        
    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] faceCaptureConfig:nsDict];
    }
}

-(void)captureBtn:(UIButton*)button {
    UIImage *titleImageFace;
    if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[selectTitleImgTextField text]]) {
        titleImageFace = nil;
    } else {
        titleImageFace = [UIImage imageNamed:@"title_image"];
    }
    [ArrayObjectController setEnableCaptureEmployee:true];
//    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] lowLightThreshold:[lightThresholdTextField.text intValue] focusPercentage:[focusThresholdTextField.text intValue] faceDetectionPercentage:[faceDetectionThresTextField.text intValue] ImageSize:[maxImageSizeThreTextField.text intValue] setFrontCameraDefault:launchFrontCamera showPreviewScreen:showPreviewScreen faceOutlineColor:[faceOutlineColorTextField text] faceOutlineTransparency:[faceOutlineColorTransTextField.text intValue] detectedFaceOutlineColor:[detectedFaceOutlineColorTextField text] detectedFaceOutlineTransparency:[detectedFaceOutlineColorTransTextField.text intValue] outsideFaceOutlineColor:[outlineColorOfFaceOutlineTextField text] outsideFaceOutlineTransparency:[outlineColorOfFaceOutlineTransTextField.text intValue] detectedOutsideFaceOutlineColor:[outlineDetectedColorOfFaceOutlineTextField text] detectedOutsideFaceOutlineColorTrans:[outlineDetectedColorOfFaceOutlineTransTextField.text intValue] titleImageFace:nil showInstruction:showInstructionScreen instructionimage:nil toggleCamera:toggleCamera];
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *lightThreshold = [lightThresholdTextField text];
    NSString *maxCapImageSize = [maxImageSizeThreTextField text];
    NSString *showInsScreen = (showInstructionScreen) ? @"Y" : @"N";
    
    NSString *focusThreshold= [focusThresholdTextField text];
    NSString *faceDetectionThreshold= [faceDetectionThresTextField text];
    NSString *faceOutlineColor= [faceOutlineColorTextField text];
    NSString *faceOutlineColorTrans= [faceOutlineColorTransTextField text];
    NSString *detectedFaceOutlineColor= [detectedFaceOutlineColorTextField text];
    NSString *detectedFaceOutlineColorTrans= [detectedFaceOutlineColorTransTextField text];
    NSString *outlineColorOfFaceOutline= [outlineColorOfFaceOutlineTextField text];
    NSString *outlineColorOfFaceOutlineTrans= [outlineColorOfFaceOutlineTransTextField text];
    NSString *outlineDetectedColorOfFaceOutline= [outlineDetectedColorOfFaceOutlineTextField text];
    NSString *outlineDetectedColorOfFaceOutlineTrans= [outlineDetectedColorOfFaceOutlineTransTextField text];
    //    NSString *launchCamera= launchFrontCamera ? @"true": @"false";
    //    NSString *toggleCameraButton= toggleCamera ? @"true": @"false";
    //    NSString *showFacePreviewScreen = (showPreviewScreen) ? @"true" : @"false";
    NSString *launchCamera= launchFrontCamera ? @"Y": @"N";
    NSString *toggleCameraButton= toggleCamera ? @"Y": @"N";
    NSString *showFacePreviewScreen = (showPreviewScreen) ? @"Y" : @"N";
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:lightThreshold]){
        [nsDict setObject:lightThreshold forKey:@"fd_light_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapImageSize]){
        [nsDict setObject:maxCapImageSize forKey:@"fd_max_image_size"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:toggleCameraButton]){
        [nsDict setObject:toggleCameraButton forKey:@"fd_toggle_camera"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
        [nsDict setObject:showInsScreen forKey:@"fd_show_instruction_screen"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:launchCamera]){
        [nsDict setObject:launchCamera forKey:@"fd_launch_front_camera"];
    }
    if(![NSStringUtils stringIsNilOrEmpty:showFacePreviewScreen]){
        [nsDict setObject:showFacePreviewScreen forKey:@"fd_show_preview_screen"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:focusThreshold]){
        [nsDict setObject:focusThreshold forKey:@"fd_focus_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:faceDetectionThreshold]){
        [nsDict setObject:faceDetectionThreshold forKey:@"fd_detection_threshold"];
    }
    
    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] faceCaptureConfig:nsDict];

}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:[faceImageTypeTextField text]]) {
//        [ArrayObjectController setFaceImageType:[faceImageTypeTextField text]];
//    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:[self getFaceType:[faceImageTypeTextField text] defaultValue:@"FACE_IMAGE"]]) {
        [ArrayObjectController setFaceImageType:[self getFaceType:[faceImageTypeTextField text] defaultValue:@"FACE_IMAGE"]];
    }
//    [ArrayObjectController setEmployeeCode:[[employeeCodeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

    [ArrayObjectController setOverrideEmpCode:[[employeeCodeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
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

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)setResultImage:(NSMutableDictionary*) result {
   // [resultImage setImage:resImage];
    [self clearResultImages];
    NSString *face = [result objectForKey:@"FACE"];
    NSString *processedFace = [result objectForKey:@"PROCESSED_FACE"];
    NSString *ovalFace = [result objectForKey:@"OVAL_FACE"];
    [self add_face_image_in_result:@"FACE" faceValue:face];
    [self add_face_image_in_result:@"PROCESSED_FACE" faceValue:processedFace];
    [self add_face_image_in_result:@"OVAL_FACE" faceValue:ovalFace];
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"]  forState:UIControlStateNormal];
    [self refreshResultImageView];
    isCapture=false;
}

-(void)clearResultImages{
    [imageArray removeAllObjects];
    [imageNameArray removeAllObjects];
    [faceName setText:@""];
    [self refreshResultImageView];
}

- (void)resultImageViewTapped:(UIGestureRecognizer *)gestureRecognizer {
    [self refreshResultImageView];
}

-(void)refreshResultImageView {
    NSInteger tag = [resultImage tag];
    tag = tag+1;
    
    if([imageArray count] > 0){
        if(tag < [imageArray count]){
            [resultImage setTag:tag];
            [resultImage setImage:imageArray[tag]];
           // [faceName setText:imageNameArray[tag]];
            [faceName setText:[self getFaceTypeAccordingLanguage:imageNameArray[tag]]];
        }else{
            [resultImage setTag:0];
            [resultImage setImage:imageArray[0]];
            //[resultImageLabel setText:imageNameArray[0]];
            [faceName setText:[self getFaceTypeAccordingLanguage:imageNameArray[0]]];
        }
    }else{
        [resultImage setImage:nil];
    }
}

-(void)add_face_image_in_result:(NSString*)faceName faceValue:(NSString*)faceValue{
    if(nil != faceValue){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:faceValue options:0];
        UIImage* image = [UIImage imageWithData:data];
        
        if([imageNameArray containsObject:faceName]){
            NSInteger index = [imageNameArray indexOfObject:faceName];
            [imageArray replaceObjectAtIndex:index withObject:image];
        }else{
            [imageNameArray addObject:faceName];
            [imageArray addObject:image];
        }
    }
}

-(void)snackBarView:(NSString*)snackMessage {
    
    int width = self.navigationController.view.frame.size.width;
    int height = self.navigationController.view.frame.size.height;
    
    if(!isSnackBarVisible) {
        showMSGLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - (height/100)*8 + (height/100)*8, width, (height/100)*8)];
        [showMSGLabel setText:snackMessage];
        [showMSGLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#5D5A59" alpha:1.0]];
        [showMSGLabel setTextAlignment:NSTextAlignmentCenter];
        [showMSGLabel setTextColor:[UIColor whiteColor]];
        
        //if(![showMSGLabel isDescendantOfView:self.navigationController.view]) {
        isSnackBarVisible = true;
        [self.navigationController.view addSubview:showMSGLabel];
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


-(NSString*)getFaceType:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *faceType=defaultValue;
    if ([label isEqualToString:@"FACE"]){
        faceType=@"FACE_IMAGE";
    }else if([label isEqualToString:@"CARA"]){
        faceType=@"FACE_IMAGE";
    }else if([label isEqualToString:@"မျက်နှာ"]){
        faceType=@"FACE_IMAGE";
    }
    
    if ([label isEqualToString:@"PROCESSED_FACE"]){
        faceType=@"PROCESSED_FACE";
    }else if([label isEqualToString:@"CARA_PROCESADA"]){
        faceType=@"PROCESSED_FACE";
    }else if([label isEqualToString:@"လုပ်ငန်းများ၌မျက်နှာ"]){
        faceType=@"PROCESSED_FACE";
    }
    
    if ([label isEqualToString:@"OVAL_FACE"]){
        faceType=@"OVAL_FACE";
    }else if([label isEqualToString:@"CARA_OVALADA"]){
        faceType=@"OVAL_FACE";
    }else if([label isEqualToString:@"ဘဲဥပုံမျက်နှာ"]){
        faceType=@"OVAL_FACE";
    }
    
    return faceType;
}


-(NSString*)getFaceTypeAccordingLanguage:(NSString*)label{
    NSString *faceType;
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    if ([language isEqualToString:@"en"]){
        if ([label isEqualToString:@"FACE"] || [label isEqualToString:@"FACE_IMAGE"]){
            faceType=@"FACE";
        }else if([label isEqualToString:@"CARA"]){
            faceType=@"FACE";
        }else if([label isEqualToString:@"မျက်နှာ"]){
            faceType=@"FACE";
        }
        
        if ([label isEqualToString:@"PROCESSED_FACE"]){
            faceType=@"PROCESSED_FACE";
        }else if([label isEqualToString:@"CARA_PROCESADA"]){
            faceType=@"PROCESSED_FACE";
        }else if([label isEqualToString:@"လုပ်ငန်းများ၌မျက်နှာ"]){
            faceType=@"PROCESSED_FACE";
        }
        
        if ([label isEqualToString:@"OVAL_FACE"]){
            faceType=@"OVAL_FACE";
        }else if([label isEqualToString:@"CARA_OVALADA"]){
            faceType=@"OVAL_FACE";
        }else if([label isEqualToString:@"ဘဲဥပုံမျက်နှာ"]){
            faceType=@"OVAL_FACE";
        }
        
    }else if ([language isEqualToString:@"es"]){
        if ([label isEqualToString:@"FACE"] || [label isEqualToString:@"FACE_IMAGE"]){
            faceType=@"CARA";
        }else if([label isEqualToString:@"CARA"]){
            faceType=@"CARA";
        }else if([label isEqualToString:@"မျက်နှာ"]){
            faceType=@"CARA";
        }
        
        if ([label isEqualToString:@"PROCESSED_FACE"]){
            faceType=@"CARA_PROCESADA";
        }else if([label isEqualToString:@"CARA_PROCESADA"]){
            faceType=@"CARA_PROCESADA";
        }else if([label isEqualToString:@"လုပ်ငန်းများ၌မျက်နှာ"]){
            faceType=@"CARA_PROCESADA";
        }
        
        if ([label isEqualToString:@"OVAL_FACE"]){
            faceType=@"CARA_OVALADA";
        }else if([label isEqualToString:@"CARA_OVALADA"]){
            faceType=@"CARA_OVALADA";
        }else if([label isEqualToString:@"ဘဲဥပုံမျက်နှာ"]){
            faceType=@"CARA_OVALADA";
        }
    }else {
        if ([label isEqualToString:@"FACE"] || [label isEqualToString:@"FACE_IMAGE"]){
            faceType=@"မျက်နှာ";
        }else if([label isEqualToString:@"CARA"]){
            faceType=@"မျက်နှာ";
        }else if([label isEqualToString:@"မျက်နှာ"]){
            faceType=@"မျက်နှာ";
        }
        
        if ([label isEqualToString:@"PROCESSED_FACE"]){
            faceType=@"လုပ်ငန်းများ၌မျက်နှာ";
        }else if([label isEqualToString:@"CARA_PROCESADA"]){
            faceType=@"လုပ်ငန်းများ၌မျက်နှာ";
        }else if([label isEqualToString:@"လုပ်ငန်းများ၌မျက်နှာ"]){
            faceType=@"လုပ်ငန်းများ၌မျက်နှာ";
        }
        
        if ([label isEqualToString:@"OVAL_FACE"]){
            faceType=@"ဘဲဥပုံမျက်နှာ";
        }else if([label isEqualToString:@"CARA_OVALADA"]){
            faceType=@"ဘဲဥပုံမျက်နှာ";
        }else if([label isEqualToString:@"ဘဲဥပုံမျက်နှာ"]){
            faceType=@"ဘဲဥပုံမျက်နှာ";
        }
    }
    
    return faceType;
}

@end
