//
//  SelfieCaptureController.m
//  AppItDepedency
//
//  Created by  on 10/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "SelfieCaptureController.h"
#import "ArrayObjectController.h"
#import "NSStringUtilsDemo.h"
#import "RootPageViewController.h"
#import "AppDelegate.h"
#import "LabelUtils.h"

@interface SelfieCaptureController ()

@end

@implementation SelfieCaptureController {
    UILabel *titleLabel, *captureLabel;
    UIButton *configurationButton, *cameraClickBtn;
    UIScrollView *scrollView;
    bool isVisible;
    UITextField *lightThresholdTextField, *focusThresholdTextField, *faceDetectionThresTextField, *maxImageSizeThreTextField, *faceOutlineColorTextField, *faceOutlineColorTransTextField, *detectedFaceOutlineColorTextField, *detectedFaceOutlineColorTransTextField, *outlineColorOfFaceOutlineTextField, *outlineColorOfFaceOutlineTransTextField, *outlineDetectedColorOfFaceOutlineTextField, *outlineDetectedColorOfFaceOutlineTransTextField, *selectTitleImgTextField, *backButtonTextField, *backButtonTransTextField, *retryButtonTextField, *retryButtonTransTextField, *confirmButtonTextField, *confirmButtonTransTextField, *fontStyleTextField, *textColorTextField, *textColorTransTextField, *instContinueButtonTextField, *instContinueButtonTransTextField, *instContinueButtonTextColorField, *instContinueButtonTransTextColorField, *faceTitleTextField, *faceHintMsgTextField,
    *faceHintIconTextField, *faceTitleImageTextField, *faceCaptureLabelTextField, *englishLabelTextField, *spanishLabelTextField, *faceContoursTextField, *faceImageTypeTextField, *retryButtonBorderTextField, *retryButtonBorderTransTextField, *confirmButtonStyleTextField, *confirmButtonStyleTransTextField,*headerSizeTextField, *textSizeTextField, *headerFontStyleTextField,  *headerTextColorTextField, *headerTextColorTransTextField, *eyesOpenThreTextField, *livelinessThresholdTextField;
    
    int mAlpha;
    int mFaceLowLightThreshold, mFaceFocusThresholde, mFaceMaxImageSize;
    int mFaceDetectionPercentage, mEyesOpenThresholdPercentage, mLivelinessFaceThresholdPercentage;
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,    *dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor ,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dRetryButtonBorderColor, *dConfirmButtonColor, *dConfirmButtonStyle, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor;
    
    NSArray *_selectedPickerData, *_selectedFontStylePickerData, *_selectedFaceContoursPickerData,*_selectedHeaderFontStylePickerData;
    NSArray *showTitlePickerData, *showFontStylePickerData, *showHeaderFontStylePickerData, *_faceTitlePickerData, *_faceHintMsgPickerData, *_faceHintIconPickerData, *_faceTitleImagePickerData, *_faceCaptureLabelPickerData, *_faceContoursPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    NSArray *_faceImgTypePickerData, *_selectedFaceImgTypePickerData;
    
    bool launchFrontCamera, toggleCamera, showPreviewScreen, showInstructionScreen, hideFaceTitle, hideFaceHintMessage, hideFaceHintIcon, hideFaceTitleImage,isCapture, isFaceDataUpload, isPassiveFaceDetectionEnabled, isBGREnable;
    UIButton *frontCameraTogleButton, *toggleCameraButton, *showPreviewScreenTogleButton, *showInstScreenToggleButton, *faceTitleCheckBox, *faceHintMsgCheckBox, *faceHintIconCheckBox, *faceTitleImageCheckBox, *uploadFaceDataTogleButton, *passiveFaceDetectionTogleButton, *enableBGRToggleButton;
    
    UIImageView *resultImage;
    UILabel *faceName;
    UIButton *recaptureButton;
    NSMutableArray *imageArray;
    NSMutableArray *imageNameArray;
    UIImageView *downUPArrowImage ;
    NSMutableDictionary *englishLabels;
    NSMutableDictionary *spanishLabels;
    NSString *textFieldTypeForPicker;
    UIImageView *downArrowImageFaceImage;
    UILabel *faceImageTypeLabel;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

-(void)viewDidAppear:(BOOL)animated {
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    isSnackBarVisible = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    //showTitlePickerData = @[@"None", @"Title Image 1"];
    //_selectedPickerData = @[@"None", @"Title Image 1"];
    showTitlePickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    _selectedPickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    
    //faceTitlePickerData = @[@"Bottom", @"Top"];
    //_faceHintMsgPickerData = @[@"Top", @"Bottom"];
    //_faceHintIconPickerData = @[@"Top",@"Bottom"];
    //_faceTitleImagePickerData = @[@"Top", @"Bottom"];
    //_faceContoursPickerData = @[@"Low", @"Medium", @"Zero", @"All"];
    //_selectedFaceContoursPickerData = @[@"Low", @"Medium", @"Zero", @"All"];
    
    _faceTitlePickerData = @[[LabelUtils getLabelForKey:@"Bottom"], [LabelUtils getLabelForKey:@"Top"]];
    _faceHintMsgPickerData = @[[LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Bottom"]];
    _faceHintIconPickerData = @[[LabelUtils getLabelForKey:@"Top"],[LabelUtils getLabelForKey:@"Bottom"]];
    _faceTitleImagePickerData = @[[LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Bottom"]];
    //_faceContoursPickerData = @[@"Low", @"Medium", @"Zero", @"All"];
    //_selectedFaceContoursPickerData = @[@"Low", @"Medium", @"Zero", @"All"];
    _faceContoursPickerData = @[[LabelUtils getLabelForKey:@"low"], [LabelUtils getLabelForKey:@"medium"], [LabelUtils getLabelForKey:@"zero"], [LabelUtils getLabelForKey:@"all"]];
    _selectedFaceContoursPickerData = @[[LabelUtils getLabelForKey:@"low"], [LabelUtils getLabelForKey:@    "medium"], [LabelUtils getLabelForKey:@"zero"], [LabelUtils getLabelForKey:@"all"]];
    
    _faceCaptureLabelPickerData = @[@"too_much_glare_face_capture",@"smile",@"turn_left",@"turn_right",@"move_up",@"move_down",@"look_straight",@"subject_is_too_dark_fc_detect",@"out_of_focus_fc_detect",@"light",@"focus",@"face_detected",@"page_title_face_detection",@"face_detection_instruction", @"face_capture_preview_header",@"face_capture_preview_message"];
   // _faceImgTypePickerData = @[@"FACE_IMAGE", @"PROCESSED_FACE", @"OVAL_FACE"];
   // _selectedFaceImgTypePickerData = @[@"FACE_IMAGE", @"PROCESSED_FACE", @"OVAL_FACE"];
    _faceImgTypePickerData = @[[LabelUtils getLabelForKey:@"face"], [LabelUtils getLabelForKey:@"processed_face"], [LabelUtils getLabelForKey:@"oval_face"]];
    _selectedFaceImgTypePickerData = @[[LabelUtils getLabelForKey:@"face"], [LabelUtils getLabelForKey:@"processed_face"], [LabelUtils getLabelForKey:@"oval_face"]];
    
    [selectTitleImgTextField setDelegate:(id)self];
    [faceTitleTextField setDelegate:(id)self];
    [faceHintMsgTextField setDelegate:(id)self];
    [faceHintIconTextField setDelegate:(id)self];
    [faceTitleImageTextField setDelegate:(id)self];
    [faceCaptureLabelTextField setDelegate:(id)self];
    [fontStyleTextField setDelegate:(id)self];
    [faceContoursTextField setDelegate:(id)self];
    [faceImageTypeTextField setDelegate:(id)self];
    [headerFontStyleTextField setDelegate:(id)self];
    
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setText:showTitlePickerData[0]];
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setText:showFontStylePickerData[0]];
    [faceTitleTextField setInputView:myPickerView];
    [faceHintMsgTextField setInputView:myPickerView];
    [faceHintIconTextField setInputView:myPickerView];
    [faceTitleImageTextField setInputView:myPickerView];
    [faceCaptureLabelTextField setInputView:myPickerView];
    [faceCaptureLabelTextField setText:_faceCaptureLabelPickerData[0]];
    [faceContoursTextField setInputView:myPickerView];
    [faceContoursTextField setText:_faceContoursPickerData[0]];
    [faceImageTypeTextField setInputView:myPickerView];
    [faceImageTypeTextField setText:_faceImgTypePickerData[0]];
    [recaptureButton setUserInteractionEnabled:YES];
    [headerFontStyleTextField setInputView:myPickerView];
    [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputView:myPickerView];
    
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setInputAccessoryView:toolbarForPicker];
    [headerFontStyleTextField setInputView:myPickerView];
    [headerFontStyleTextField setInputAccessoryView:toolbarForPicker];
    [faceTitleTextField setInputAccessoryView:toolbarForPicker];
    [faceHintMsgTextField setInputAccessoryView:toolbarForPicker];
    [faceHintIconTextField setInputAccessoryView:toolbarForPicker];
    [faceTitleImageTextField setInputAccessoryView:toolbarForPicker];
    [faceContoursTextField setInputAccessoryView:toolbarForPicker];
    [faceCaptureLabelTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputAccessoryView:toolbarForPicker];
    
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [selectTitleImgTextField resignFirstResponder];
    [fontStyleTextField resignFirstResponder];
    [headerFontStyleTextField resignFirstResponder];
    [faceTitleTextField resignFirstResponder];
    [faceHintMsgTextField resignFirstResponder];
    [faceHintIconTextField resignFirstResponder];
    [faceTitleImageTextField resignFirstResponder];
    [faceCaptureLabelTextField resignFirstResponder];
    [faceContoursTextField resignFirstResponder];
    [faceImageTypeTextField resignFirstResponder];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectTitleImgTextField){
        textFieldTypeForPicker = @"selectTitleImgTextField";
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    }else if (textField == fontStyleTextField){
        textFieldTypeForPicker = @"fontStyleTextField";
        _selectedPickerData=showFontStylePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == faceTitleTextField) {
        textFieldTypeForPicker = @"faceTitleTextField";
        _selectedPickerData = _faceTitlePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == faceHintMsgTextField) {
        textFieldTypeForPicker = @"faceHintMsgTextField";
        _selectedPickerData = _faceHintMsgPickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == faceHintIconTextField) {
        textFieldTypeForPicker = @"faceHintIconTextField";
        _selectedPickerData = _faceHintIconPickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == faceTitleImageTextField) {
        textFieldTypeForPicker = @"faceTitleImageTextField";
        _selectedPickerData = _faceTitleImagePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == faceCaptureLabelTextField) {
        textFieldTypeForPicker = @"faceCaptureLabelTextField";
        _selectedPickerData = _faceCaptureLabelPickerData;
        [myPickerView reloadAllComponents];
    }else if(textField == faceContoursTextField) {
        textFieldTypeForPicker = @"faceContoursTextField";
        _selectedPickerData = _faceContoursPickerData;
        [myPickerView reloadAllComponents];
    }else if(textField == faceImageTypeTextField){
        textFieldTypeForPicker = @"faceImageType";
        _selectedPickerData = _faceImgTypePickerData;
        [myPickerView reloadAllComponents];
    }else if(textField == headerFontStyleTextField) {
        textFieldTypeForPicker = @"idHeaderFontStyleTextField";
        _selectedPickerData = showHeaderFontStylePickerData;
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
    
    if([textFieldTypeForPicker isEqualToString:@"selectTitleImgTextField"]) {
        [selectTitleImgTextField setText:showTitlePickerData[row]];
        [selectTitleImgTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"fontStyleTextField"]){
        [fontStyleTextField setText:showFontStylePickerData[row]];
        [fontStyleTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceTitleTextField"]) {
        [faceTitleTextField setText:_faceTitlePickerData[row]];
        [faceTitleTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceHintMsgTextField"]) {
        [faceHintMsgTextField setText:_faceHintMsgPickerData[row]];
        [faceHintMsgTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceHintIconTextField"]) {
        [faceHintIconTextField setText:_faceHintIconPickerData[row]];
        [faceHintIconTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceTitleImageTextField"]) {
        [faceTitleImageTextField setText:_faceTitleImagePickerData[row]];
        [faceTitleImageTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceCaptureLabelTextField"]) {
        [faceCaptureLabelTextField setText:_faceCaptureLabelPickerData[row]];
        [faceCaptureLabelTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceContoursTextField"]) {
        [faceContoursTextField setText:_faceContoursPickerData[row]];
        [faceContoursTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"faceImageType"]){
        [faceImageTypeTextField setText:_faceImgTypePickerData[row]];
        [faceImageTypeTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idHeaderFontStyleTextField"]) {
        [headerFontStyleTextField setText:showHeaderFontStylePickerData[row]];
        [headerFontStyleTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];

    //showTitlePickerData = @[@"None", @"Title Image 1"];
    //_selectedPickerData = @[@"None", @"Title Image 1"];
    
    //showFontStylePickerData = @[@"Default",@"Helvetica", @"Helvetica Bold", @"Helvetica Bold Oblique",@"Helvetica Light",@"Helvetica Light Oblique",@"Helvetica Neue",@"Helvetica Neue Bold",@"Helvetica Neue Bold Italic",@"Helvetica Neue Condensed Black",@"Helvetica Neue Condensed Bold",@"Helvetica Neue Italic",@"Helvetica Neue Light",@"Helvetica Neue Light Italic",@"Helvetica Neue Medium",@"Helvetica Neue Medium Italic",@"Helvetica Neue Thin",@"Helvetica Neue Thin Italic",@"Helvetica Neue UltraLight",@"Helvetica Neue UltraLight Italic",@"Helvetica Oblique"];
    showFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"],[LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    _selectedFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    showHeaderFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    
    isVisible = false;
    mAlpha = 1;
    launchFrontCamera = true;
    toggleCamera = false;
    isFaceDataUpload = false;
    isBGREnable = false;
    isPassiveFaceDetectionEnabled = true;
    showPreviewScreen = false;
    //showInstructionScreen = false;
    showInstructionScreen = true;
    isCapture = true;
    
    mFaceLowLightThreshold=60, mFaceFocusThresholde=15, mFaceMaxImageSize=500;
    mFaceDetectionPercentage=90;
    mEyesOpenThresholdPercentage =40;
    mLivelinessFaceThresholdPercentage = 90;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36",dRetryButtonBorderColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dConfirmButtonStyle=@"FFFFFF", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95";
    
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
    [titleLabel setText:[LabelUtils getLabelForKey:@"selfie_capture_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    titleLabel.numberOfLines = 2;
   // [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
   // [self setWrapUILabel:titleLabel];
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
    [eyesOpenThreTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [livelinessThresholdTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [maxImageSizeThreTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [faceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedFaceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineDetectedColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [headerSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    NSString *facelightthreshold = [self retrieveSetting:@"facelightthreshold" defaultValue: [@(mFaceLowLightThreshold) stringValue]];
    NSString *facefocusthreshold = [self retrieveSetting:@"facefocusthreshold" defaultValue: [@(mFaceFocusThresholde) stringValue]];
    NSString *facedetectionthreshold = [self retrieveSetting:@"passivefacedetectionthreshold" defaultValue: [@(mFaceDetectionPercentage) stringValue]];
//    NSString *facedetectionthreshold = [self retrieveSetting:@"passivefacedetectionthreshold" defaultValue: [NSString stringWithFormat:@"%.02f",mFaceDetectionPercentage]];
    NSString *isPassiveFaceDetection = [self retrieveSetting:@"passivefacedetectionMethod" defaultValue: @"Y"];
    
    NSString *eyes_Open_Threshold = [self retrieveSetting:@"eyesOpenthreshold" defaultValue:[@(mEyesOpenThresholdPercentage) stringValue]];
    NSString *liveliness_Face_Threshold = [self retrieveSetting:@"livelinessFaceThreshold" defaultValue:[@(mLivelinessFaceThresholdPercentage) stringValue]];
    
    NSString *faceimagesize = [self retrieveSetting:@"faceimagesize" defaultValue: [@(mFaceMaxImageSize) stringValue]];
    NSString *faceoutlinecolor = [self retrieveSetting:@"faceoutlinecolor" defaultValue: dFaceOutlineColor];
    NSString *faceoutlinetransparency = [self retrieveSetting:@"faceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *detectedfaceoutlinecolor = [self retrieveSetting:@"detectedfaceoutlinecolor" defaultValue: dDetectedFaceOutlineColor];
    NSString *detectedfaceoutlinetransparency = [self retrieveSetting:@"detectedfaceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *outsideoutlinecolor = [self retrieveSetting:@"_outsideoutlinecolor" defaultValue: dOutsideIdOutlineColor];
    NSString *outsideoutlinetransparency = [self retrieveSetting:@"_outsideoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *detectedfaceoutsideoutlinecolor = [self retrieveSetting:@"detectedfaceoutsideoutlinecolor" defaultValue:dDetectedOutsideFaceOutlineColor];
    NSString *detectedfaceoutsideoutlinetransparency = [self retrieveSetting:@"detectedfaceoutsideoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"faceBackButton" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"faceBackButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"faceTextColor" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"faceTextColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"faceRetryButton" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"faceRetryButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"faceRetryButtonBorder" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"faceRetryButtonBorderTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"faceConfirmButton" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"faceConfirmButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"faceConfirmButtonStyle" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"faceConfirmButtonStyleTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"faceInstContinueButton" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"faceInstContinueButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"faceInstContinueButtonText" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"faceInstContinueButtonTextTransparency" defaultValue:[@(mAlpha) stringValue]];
    
    //    NSString *faceTitle = [self retrieveSetting:@"faceTitleOnTop" defaultValue:@"Bottom"];
    //    NSString *faceHintMessage = [self retrieveSetting:@"faceHintMessageOnTop" defaultValue:@"Top"];
    //    NSString *faceHintIcon = [self retrieveSetting:@"faceHintIconOnTop" defaultValue:@"Top"];
    //    NSString *faceTitleImage = [self retrieveSetting:@"faceTitleImageOnTop" defaultValue:@"Top"];
    
    NSString *faceTitle = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"faceTitleOnTop" defaultValue:@"Bottom"]];
    NSString *faceHintMessage = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"faceHintMessageOnTop" defaultValue:@"Top"]];
    NSString *faceHintIcon = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"faceHintIconOnTop" defaultValue:@"Top"]];
    NSString *faceTitleImage = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"faceTitleImageOnTop" defaultValue:@"Top"]];
    
    NSString *headerTextSize = [self retrieveSetting:@"faceHeaderTextSize" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"faceTextSize" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"faceHeaderTextColor" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"faceHeaderTextColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    
    [faceTitleTextField setText:faceTitle];
    [faceHintMsgTextField setText:faceHintMessage];
    [faceHintIconTextField setText:faceHintIcon];
    [faceTitleImageTextField setText:faceTitleImage];
    
    if([@"Y" isEqualToString:isPassiveFaceDetection]) {
        isPassiveFaceDetectionEnabled = true;
        [passiveFaceDetectionTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"]
                           forState:UIControlStateNormal];
    } else {
        isPassiveFaceDetectionEnabled = false;
        [passiveFaceDetectionTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"]
                           forState:UIControlStateNormal];
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFaceTitle" defaultValue:@"N"]]) {
        hideFaceTitle = true;
        [faceTitleCheckBox setImage:[UIImage imageNamed:@"check.png"]
                           forState:UIControlStateNormal];
    } else {
        hideFaceTitle = false;
        [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                           forState:UIControlStateNormal];
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacehintMsg" defaultValue:@"N"]]) {
        hideFaceHintMessage = true;
        [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                             forState:UIControlStateNormal];
    } else {
        hideFaceHintMessage = false;
        [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                             forState:UIControlStateNormal];
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacehintIcon" defaultValue:@"N"]]) {
        hideFaceHintIcon = true;
        [faceHintIconCheckBox setImage:[UIImage imageNamed:@"check.png"]
                              forState:UIControlStateNormal];
    } else {
        hideFaceHintIcon = false;
        [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacetitleImage" defaultValue:@"N"]]) {
        hideFaceTitleImage = true;
        [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
    } else {
        hideFaceTitleImage = false;
        [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
    
    [lightThresholdTextField setText:facelightthreshold];
    [focusThresholdTextField setText:facefocusthreshold];
    [faceDetectionThresTextField setText:facedetectionthreshold];
    [eyesOpenThreTextField setText:eyes_Open_Threshold];
    [livelinessThresholdTextField setText:liveliness_Face_Threshold];
    [maxImageSizeThreTextField setText:faceimagesize];
    [faceOutlineColorTextField setText:faceoutlinecolor];
    [faceOutlineColorTransTextField setText:faceoutlinetransparency];
    [detectedFaceOutlineColorTextField setText:detectedfaceoutlinecolor];
    [detectedFaceOutlineColorTransTextField setText:detectedfaceoutlinetransparency];
    [outlineColorOfFaceOutlineTextField setText:outsideoutlinecolor];
    [outlineColorOfFaceOutlineTransTextField setText:outsideoutlinetransparency];
    [outlineDetectedColorOfFaceOutlineTextField setText:detectedfaceoutsideoutlinecolor];
    [outlineDetectedColorOfFaceOutlineTransTextField setText:detectedfaceoutsideoutlinetransparency];
    [backButtonTextField setText:backButton];
    [backButtonTransTextField setText:backButtonTrans];
    [retryButtonTextField setText:retryButton];
    [retryButtonTransTextField setText:retryButtonTrans];
    [retryButtonBorderTextField setText:retryButtonBorder];
    [retryButtonBorderTransTextField setText:retryButtonBorderTrans];
    [confirmButtonTextField setText:confirmButton];
    [confirmButtonTransTextField setText:confirmButtonTrans];
    [confirmButtonStyleTextField setText:confirmButtonStyle];
    [confirmButtonStyleTransTextField setText:confirmButtonStyleTrans];
    [textColorTextField setText:textColor];
    [textColorTransTextField setText:textColorTrans];
    [instContinueButtonTextField setText:instContinueButton];
    [instContinueButtonTransTextField setText:instContinueButtonTrans];
    [instContinueButtonTextColorField setText:instContinueTextColor];
    [instContinueButtonTransTextColorField setText:instContinueTextColorTrans];
    [headerTextColorTextField setText:headerTextColor];
    [headerTextColorTransTextField setText:headerTextColorTrans];
    [headerSizeTextField setText:headerTextSize];
    [textSizeTextField setText:textSize];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //NSString *n=[LabelUtils getLabelForKey:@"light_threshold"];
    //Light Threshold
    UILabel *lightThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [lightThresholdLabel setText:[LabelUtils getLabelForKey:@"light_threshold"]];
    [lightThresholdLabel setAlpha:0.7];
    [lightThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    lightThresholdLabel.numberOfLines = 0;
    lightThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:lightThresholdLabel];
    [lightThresholdLabel setHidden:YES];
    
    //Focus Threshold
    UILabel *focusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    [focusThresholdLabel setText:[LabelUtils getLabelForKey:@"focus_threshold"]];
    [focusThresholdLabel setAlpha:0.7];
    focusThresholdLabel.numberOfLines = 0;
    focusThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [focusThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:focusThresholdLabel];
    [focusThresholdLabel setHidden:YES];
    
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
    [lightThresholdTextField setHidden:YES];
    
    //Focus threshold TextField
    focusThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, lightThresholdTextField.frame.origin.y, focusThresholdLabel.frame.size.width, (height/100)*4)];
    [focusThresholdTextField setFont:[UIFont systemFontOfSize:12]]; focusThresholdTextField.layer.cornerRadius = 5;
    focusThresholdTextField.layer.borderWidth = 1.0;
    focusThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [focusThresholdTextField setAlpha:0.7];
    [focusThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    focusThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:focusThresholdTextField];
    [focusThresholdTextField setHidden:YES];
    
    //Face Detection Threshold
    //Face Detection Threshold Label
//    UILabel *faceDetectionThreLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,lightThresholdTextField.frame.origin.y + lightThresholdTextField.frame.size.height +   (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
//    UILabel *faceDetectionThreLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    UILabel *faceDetectionThreLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, 0)];
    [faceDetectionThreLabel setText:[LabelUtils getLabelForKey:@"face_detection_threshold"]];
    [faceDetectionThreLabel setAlpha:0.7];
    [faceDetectionThreLabel setFont:[UIFont systemFontOfSize:11]];
    faceDetectionThreLabel.numberOfLines = 0;
    faceDetectionThreLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceDetectionThreLabel];
    
    //Max Image Size label
//    UILabel *maxImageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,focusThresholdTextField.frame.origin.y + focusThresholdTextField.frame.size.height +  (height/100)*2, focusThresholdTextField.frame.size.width, (height/100)*2)];
//    UILabel *maxImageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    UILabel *maxImageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, 0)];
    [maxImageSizeLabel setText:[LabelUtils getLabelForKey:@"max_image_size"]];
    [maxImageSizeLabel setAlpha:0.7];
    maxImageSizeLabel.numberOfLines = 0;
    maxImageSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxImageSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxImageSizeLabel];
    
    //Face Detection Threshold Text Field
//    faceDetectionThresTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceDetectionThreLabel.frame.origin.y + faceDetectionThreLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
    faceDetectionThresTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceDetectionThreLabel.frame.origin.y + faceDetectionThreLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, 0)];
    [faceDetectionThresTextField setFont:[UIFont systemFontOfSize:12]];
    faceDetectionThresTextField.layer.cornerRadius = 5;
    faceDetectionThresTextField.layer.borderWidth = 1.0;
    faceDetectionThresTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceDetectionThresTextField setAlpha:0.7];
    [faceDetectionThresTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceDetectionThresTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceDetectionThresTextField];
    
    //Max Image Size Text Field
//    maxImageSizeThreTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, maxImageSizeLabel.frame.origin.y + maxImageSizeLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
    maxImageSizeThreTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, maxImageSizeLabel.frame.origin.y + maxImageSizeLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, 0)];
    [maxImageSizeThreTextField setFont:[UIFont systemFontOfSize:12]];
    maxImageSizeThreTextField.layer.cornerRadius = 5;
    maxImageSizeThreTextField.layer.borderWidth = 1.0;
    maxImageSizeThreTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxImageSizeThreTextField setAlpha:0.7];
    [maxImageSizeThreTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    maxImageSizeThreTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:maxImageSizeThreTextField];
    
    //Start
//    UILabel *eyesThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceDetectionThresTextField.frame.origin.y + faceDetectionThresTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    UILabel *eyesThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceDetectionThresTextField.frame.origin.y + faceDetectionThresTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [eyesThresholdLabel setText:@"Eyes Open Threshold"];
    [eyesThresholdLabel setAlpha:0.7];
    [eyesThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    eyesThresholdLabel.numberOfLines = 0;
    eyesThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:eyesThresholdLabel];
    
//    eyesOpenThreTextField = [[UITextField alloc] initWithFrame:CGRectMake(eyesThresholdLabel.frame.origin.x, eyesThresholdLabel.frame.origin.y + eyesThresholdLabel.frame.size.height + (height/100)*1, eyesThresholdLabel.frame.size.width, (height/100)*4)];
    eyesOpenThreTextField = [[UITextField alloc] initWithFrame:CGRectMake(eyesThresholdLabel.frame.origin.x, eyesThresholdLabel.frame.origin.y + eyesThresholdLabel.frame.size.height + (height/100)*1, eyesThresholdLabel.frame.size.width, 0)];
    [eyesOpenThreTextField setFont:[UIFont systemFontOfSize:12]];
    eyesOpenThreTextField.layer.cornerRadius = 5;
    eyesOpenThreTextField.layer.borderWidth = 1.0;
    eyesOpenThreTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [eyesOpenThreTextField setAlpha:0.7];
    [eyesOpenThreTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    eyesOpenThreTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:eyesOpenThreTextField];
    
//    UILabel *livelinessFaceThreLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,maxImageSizeThreTextField.frame.origin.y + maxImageSizeThreTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, (height/100)*2)];
    UILabel *livelinessFaceThreLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,maxImageSizeThreTextField.frame.origin.y + maxImageSizeThreTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, 0)];
    [livelinessFaceThreLabel setText:@"Spoof Detection Threshold"];
    [livelinessFaceThreLabel setAlpha:0.7];
    livelinessFaceThreLabel.numberOfLines = 0;
    livelinessFaceThreLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [livelinessFaceThreLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:livelinessFaceThreLabel];
    
//    livelinessThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, livelinessFaceThreLabel.frame.origin.y + livelinessFaceThreLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
    livelinessThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, livelinessFaceThreLabel.frame.origin.y + livelinessFaceThreLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, 0)];
    [livelinessThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    livelinessThresholdTextField.layer.cornerRadius = 5;
    livelinessThresholdTextField.layer.borderWidth = 1.0;
    livelinessThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [livelinessThresholdTextField setAlpha:0.7];
    [livelinessThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    livelinessThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:livelinessThresholdTextField];
    //End
    
    //Launch Front Camera
    //Launch Front Camera Label
//    UILabel *launchFrontCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceDetectionThresTextField.frame.origin.y + faceDetectionThresTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
     UILabel *launchFrontCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,eyesOpenThreTextField.frame.origin.y + eyesOpenThreTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [launchFrontCameraLabel setText:[LabelUtils getLabelForKey:@"launch_front_camera"]];
    [launchFrontCameraLabel setAlpha:0.7];
    [launchFrontCameraLabel setFont:[UIFont systemFontOfSize:11]];
    launchFrontCameraLabel.numberOfLines = 0;
    launchFrontCameraLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:launchFrontCameraLabel];
    
    //Toggle Camera Label
//    UILabel *toggleCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,maxImageSizeThreTextField.frame.origin.y + maxImageSizeThreTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, (height/100)*2)];
    UILabel *toggleCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,eyesOpenThreTextField.frame.origin.y + eyesOpenThreTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, (height/100)*2)];
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
    
    UILabel *face_detection_method_type_label = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,frontCameraTogleButton.frame.origin.y + frontCameraTogleButton.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [face_detection_method_type_label setText:[LabelUtils getLabelForKey:@"face_detection_method"]];
    [face_detection_method_type_label setAlpha:0.7];
    [face_detection_method_type_label setFont:[UIFont systemFontOfSize:11]];
    face_detection_method_type_label.numberOfLines = 0;
    face_detection_method_type_label.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:face_detection_method_type_label];
    
    UILabel *passive_face_detection_no = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, face_detection_method_type_label.frame.origin.y + face_detection_method_type_label.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [passive_face_detection_no setText:[LabelUtils getLabelForKey:@"active"]];
    [passive_face_detection_no setAlpha:0.7];
    [passive_face_detection_no setFont:[UIFont systemFontOfSize:12]];
    [passive_face_detection_no setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:passive_face_detection_no];
    
    passiveFaceDetectionTogleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passiveFaceDetectionTogleButton.frame = CGRectMake(frontCameraToggleNoLabel.frame.origin.x + frontCameraToggleNoLabel.frame.size.width + (width/100)*2, passive_face_detection_no.frame.origin.y, (width/100)*10, (height/100)*5);
    [passiveFaceDetectionTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"]
                            forState:UIControlStateNormal];
    passiveFaceDetectionTogleButton.contentMode = UIViewContentModeScaleAspectFit;
    [passiveFaceDetectionTogleButton addTarget:self action:@selector(passiveFaceDetectionToggleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:passiveFaceDetectionTogleButton];
    
    UILabel *passive_face_detection_yes = [[UILabel alloc] initWithFrame:CGRectMake(passiveFaceDetectionTogleButton.frame.origin.x + passiveFaceDetectionTogleButton.frame.size.width + (width/100)*2, passive_face_detection_no.frame.origin.y, (width/100)*15, (height/100)*5)];
    [passive_face_detection_yes setText:[LabelUtils getLabelForKey:@"passive"]];
    [passive_face_detection_yes setAlpha:0.7];
    [passive_face_detection_yes setFont:[UIFont systemFontOfSize:12]];
    [passive_face_detection_yes setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:passive_face_detection_yes];
    
    UILabel *uploadFaceDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,passiveFaceDetectionTogleButton.frame.origin.y + passiveFaceDetectionTogleButton.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [uploadFaceDataLabel setText:[LabelUtils getLabelForKey:@"upload_face_data"]];
    [uploadFaceDataLabel setAlpha:0.7];
    [uploadFaceDataLabel setFont:[UIFont systemFontOfSize:11]];
    uploadFaceDataLabel.numberOfLines = 0;
    uploadFaceDataLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:uploadFaceDataLabel];
    
    UILabel *uploadFaceDataNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, uploadFaceDataLabel.frame.origin.y + uploadFaceDataLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [uploadFaceDataNoLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [uploadFaceDataNoLabel setAlpha:0.7];
    [uploadFaceDataNoLabel setFont:[UIFont systemFontOfSize:12]];
    [uploadFaceDataNoLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:uploadFaceDataNoLabel];
    
    uploadFaceDataTogleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadFaceDataTogleButton.frame = CGRectMake(frontCameraToggleNoLabel.frame.origin.x + frontCameraToggleNoLabel.frame.size.width + (width/100)*2, uploadFaceDataNoLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [uploadFaceDataTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"]
                            forState:UIControlStateNormal];
    uploadFaceDataTogleButton.contentMode = UIViewContentModeScaleAspectFit;
    //frontCameraTogleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [uploadFaceDataTogleButton addTarget:self action:@selector(uploadFaceDataToggleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:uploadFaceDataTogleButton];
    
    UILabel *uploadFaceDataYesLabel = [[UILabel alloc] initWithFrame:CGRectMake(uploadFaceDataTogleButton.frame.origin.x + uploadFaceDataTogleButton.frame.size.width + (width/100)*2, uploadFaceDataTogleButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [uploadFaceDataYesLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [uploadFaceDataYesLabel setAlpha:0.7];
    [uploadFaceDataYesLabel setFont:[UIFont systemFontOfSize:12]];
    [uploadFaceDataYesLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:uploadFaceDataYesLabel];
    
    UILabel *toggleRGB_BGRDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, passiveFaceDetectionTogleButton.frame.origin.y + passiveFaceDetectionTogleButton.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
    [toggleRGB_BGRDataLabel setText:@"RGB/BGR"];
    [toggleRGB_BGRDataLabel setAlpha:0.7];
    [toggleRGB_BGRDataLabel setFont:[UIFont systemFontOfSize:11]];
    toggleRGB_BGRDataLabel.numberOfLines = 0;
    toggleRGB_BGRDataLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:toggleRGB_BGRDataLabel];
    
    UILabel *enableRGBDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, toggleRGB_BGRDataLabel.frame.origin.y + toggleRGB_BGRDataLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [enableRGBDataLabel setText:@"RGB"];
    [enableRGBDataLabel setAlpha:0.7];
    [enableRGBDataLabel setFont:[UIFont systemFontOfSize:12]];
    [enableRGBDataLabel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:enableRGBDataLabel];
    
    enableBGRToggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enableBGRToggleButton.frame = CGRectMake(enableRGBDataLabel.frame.origin.x + enableRGBDataLabel.frame.size.width + (width/100)*2, enableRGBDataLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    [enableBGRToggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    enableBGRToggleButton.contentMode = UIViewContentModeScaleAspectFit;
    [enableBGRToggleButton addTarget:self action:@selector(enableBGRToggleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:enableBGRToggleButton];
    
    UILabel *enableBGRDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(enableBGRToggleButton.frame.origin.x + enableBGRToggleButton.frame.size.width + (width/100)*2, enableBGRToggleButton.frame.origin.y, (width/100)*10, (height/100)*5)];
    [enableBGRDataLabel setText:@"BGR"];
    [enableBGRDataLabel setAlpha:0.7];
    [enableBGRDataLabel setFont:[UIFont systemFontOfSize:12]];
    [enableBGRDataLabel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:enableBGRDataLabel];
    
    if(![AppItSDK isDebugEnable]) {
        [uploadFaceDataLabel setHidden:YES];
        [uploadFaceDataNoLabel setHidden:YES];
        [uploadFaceDataTogleButton setHidden:YES];
        [uploadFaceDataYesLabel setHidden:YES];
        
        [toggleRGB_BGRDataLabel setHidden:YES];
        [enableRGBDataLabel setHidden:YES];
        [enableBGRToggleButton setHidden:YES];
        [enableBGRDataLabel setHidden:YES];
    }
    
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
    [showPreviewScreenTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"]
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
    [showInstScreenToggleButton setImage:[UIImage imageNamed:@"toggleOn.png"]
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
    UILabel *faceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,showPreviewScreenTogleButton.frame.origin.y + showPreviewScreenTogleButton.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"face_outline_color"]];
    [faceOutlineColorLabel setAlpha:0.7];
    [faceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    faceOutlineColorLabel.numberOfLines = 0;
    faceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceOutlineColorLabel setHidden: YES];
    faceOutlineColorLabel.hidden = YES;
    [scrollView addSubview:faceOutlineColorLabel];
    
    //Face OutLine Color TransParency
    UILabel *faceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,showInstScreenToggleButton.frame.origin.y + showInstScreenToggleButton.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [faceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [faceOutLineTransLabel setAlpha:0.7];
    faceOutLineTransLabel.numberOfLines = 0;
    faceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [faceOutLineTransLabel setHidden: YES];
    faceOutLineTransLabel.hidden = YES;
    [scrollView addSubview:faceOutLineTransLabel];
    
    //Face Outline Color Text Field
    faceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceOutlineColorLabel.frame.origin.y + faceOutlineColorLabel.frame.size.height + (height/100)*0, faceOutlineColorLabel.frame.size.width, (height/100)*0)];
    [faceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTextField.layer.cornerRadius = 5;
    faceOutlineColorTextField.layer.borderWidth = 1.0;
    faceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTextField setAlpha:0.7];
    [faceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceOutlineColorTextField setHidden: YES];
    faceOutlineColorTextField.hidden = YES;
    [scrollView addSubview:faceOutlineColorTextField];
    
    //Face Outline Color Trans Text Field
    faceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, faceOutLineTransLabel.frame.origin.y + faceOutLineTransLabel.frame.size.height + (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [faceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTransTextField.layer.cornerRadius = 5;
    faceOutlineColorTransTextField.layer.borderWidth = 1.0;
    faceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTransTextField setAlpha:0.7];
    [faceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceOutlineColorTransTextField setHidden: YES];
    faceOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:faceOutlineColorTransTextField];
    
    //Detected Face Outline Color
    //Detected Face Outline Color label
    UILabel *detectedFaceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceOutlineColorTextField.frame.origin.y + faceOutlineColorTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [detectedFaceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"detect_face_outline_color"]];
    [detectedFaceOutlineColorLabel setAlpha:0.7];
    [detectedFaceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedFaceOutlineColorLabel.numberOfLines = 0;
    detectedFaceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedFaceOutlineColorLabel setHidden: YES];
    detectedFaceOutlineColorLabel.hidden = YES;
    [scrollView addSubview:detectedFaceOutlineColorLabel];
    
    //Detected Face OutLine Color TransParency label
    UILabel *detectedFaceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,faceOutlineColorTransTextField.frame.origin.y + faceOutlineColorTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [detectedFaceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedFaceOutLineTransLabel setAlpha:0.7];
    detectedFaceOutLineTransLabel.numberOfLines = 0;
    detectedFaceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedFaceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedFaceOutLineTransLabel setHidden: YES];
    detectedFaceOutLineTransLabel.hidden = YES;
    [scrollView addSubview:detectedFaceOutLineTransLabel];
    
    //Detected Face Outline Color Text Field
    detectedFaceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, detectedFaceOutlineColorLabel.frame.origin.y + detectedFaceOutlineColorLabel.frame.size.height + (height/100)*0, detectedFaceOutlineColorLabel.frame.size.width, (height/100)*0)];
    [detectedFaceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTextField setAlpha:0.7];
    [detectedFaceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedFaceOutlineColorTextField setHidden: YES];
    detectedFaceOutlineColorTextField.hidden = YES;
    [scrollView addSubview:detectedFaceOutlineColorTextField];
    
    //Detected Face Outline Color Trans Text Field
    detectedFaceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, detectedFaceOutLineTransLabel.frame.origin.y + detectedFaceOutLineTransLabel.frame.size.height + (height/100)*0, detectedFaceOutLineTransLabel.frame.size.width, (height/100)*0)];
    [detectedFaceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTransTextField setAlpha:0.7];
    [detectedFaceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedFaceOutlineColorTransTextField setHidden: YES];
    detectedFaceOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:detectedFaceOutlineColorTransTextField];
    
    //Outside Color of Face Outline
    //Outside Color of Face Outline Label
    UILabel *outsideColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,detectedFaceOutlineColorTextField.frame.origin.y + detectedFaceOutlineColorTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [outsideColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_color_of_face_outLine"]];
    [outsideColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideColorOfFaceOutlineLabel setHidden: YES];
    outsideColorOfFaceOutlineLabel.hidden = YES;
    [scrollView addSubview:outsideColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,detectedFaceOutlineColorTransTextField.frame.origin.y + detectedFaceOutlineColorTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [outsideColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [outsideColorOfFaceOutlineTransLabel setHidden: YES];
    outsideColorOfFaceOutlineTransLabel.hidden = YES;
    [scrollView addSubview:outsideColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, outsideColorOfFaceOutlineLabel.frame.origin.y + outsideColorOfFaceOutlineLabel.frame.size.height + (height/100)*0, outsideColorOfFaceOutlineLabel.frame.size.width, (height/100)*0)];
    [outlineColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineColorOfFaceOutlineTextField setHidden: YES];
    outlineColorOfFaceOutlineTextField.hidden = YES;
    [scrollView addSubview:outlineColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, outlineColorOfFaceOutlineTextField.frame.origin.y*0, detectedFaceOutLineTransLabel.frame.size.width, (height/100)*0)];
    [outlineColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineColorOfFaceOutlineTransTextField setHidden: YES];
    outlineColorOfFaceOutlineTransTextField.hidden = YES;
    [scrollView addSubview:outlineColorOfFaceOutlineTransTextField];
    
    //Outside Detected Color Of Face Outline
    //Outside Detected Color of Face Outline Label
    UILabel *outsideDetectedColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,outlineColorOfFaceOutlineTextField.frame.origin.y + outlineColorOfFaceOutlineTextField.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*5)];
    [outsideDetectedColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_detected_color_of_face_outline"]];
    [outsideDetectedColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideDetectedColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideDetectedColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideDetectedColorOfFaceOutlineLabel setHidden: YES];
    outsideDetectedColorOfFaceOutlineLabel.hidden = YES;
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideDetectedColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,outlineColorOfFaceOutlineTransTextField.frame.origin.y + outlineColorOfFaceOutlineTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [outsideDetectedColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideDetectedColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideDetectedColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideDetectedColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [outsideDetectedColorOfFaceOutlineTransLabel setHidden: YES];
    outsideDetectedColorOfFaceOutlineTransLabel.hidden = YES;
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineDetectedColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, outsideDetectedColorOfFaceOutlineLabel.frame.origin.y + outsideDetectedColorOfFaceOutlineLabel.frame.size.height + (height/100)*0, outsideDetectedColorOfFaceOutlineLabel.frame.size.width, (height/100)*0)];
    [outlineDetectedColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineDetectedColorOfFaceOutlineTextField setHidden: YES];
    outlineDetectedColorOfFaceOutlineTextField.hidden = YES;
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineDetectedColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, outlineDetectedColorOfFaceOutlineTextField.frame.origin.y*0, outsideDetectedColorOfFaceOutlineTransLabel.frame.size.width, (height/100)*0)];
    [outlineDetectedColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [outlineDetectedColorOfFaceOutlineTransTextField setHidden: YES];
    outlineDetectedColorOfFaceOutlineTransTextField.hidden = YES;
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTransTextField];
    
    //Text/Header Size
    //Header Size label
    UILabel *headerTextSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,outlineDetectedColorOfFaceOutlineTextField.frame.origin.y + outlineDetectedColorOfFaceOutlineTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [headerTextSizeLabel setText:[LabelUtils getLabelForKey:@"header_text_label_size"]];
    [headerTextSizeLabel setAlpha:0.7];
    [headerTextSizeLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextSizeLabel.numberOfLines = 0;
    headerTextSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextSizeLabel setHidden: YES];
    headerTextSizeLabel.hidden = YES;
    [scrollView addSubview:headerTextSizeLabel];
    
    //Text Size Label
    UILabel *textSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,outlineDetectedColorOfFaceOutlineTransTextField.frame.origin.y + outlineDetectedColorOfFaceOutlineTransTextField.frame.size.height +  (height/100)*0, outlineDetectedColorOfFaceOutlineTransTextField.frame.size.width, (height/100)*0)];
    [textSizeLabel setText:[LabelUtils getLabelForKey:@"text_label_size"]];
    [textSizeLabel setAlpha:0.7];
    textSizeLabel.numberOfLines = 0;
    textSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [textSizeLabel setHidden: YES];
    textSizeLabel.hidden = YES;
    [scrollView addSubview:textSizeLabel];
    
    //Header size TextField
    headerSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, headerTextSizeLabel.frame.origin.y + headerTextSizeLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [headerSizeTextField setFont:[UIFont systemFontOfSize:12]];
    headerSizeTextField.layer.cornerRadius = 5;
    headerSizeTextField.layer.borderWidth = 1.0;
    headerSizeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerSizeTextField setAlpha:0.7];
    [headerSizeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerSizeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [headerSizeTextField setHidden: YES];
    headerSizeTextField.hidden = YES;
    [scrollView addSubview:headerSizeTextField];
    
    //Text size TextField
    textSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, headerSizeTextField.frame.origin.y*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [textSizeTextField setFont:[UIFont systemFontOfSize:12]];
    textSizeTextField.layer.cornerRadius = 5;
    textSizeTextField.layer.borderWidth = 1.0;
    textSizeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textSizeTextField setAlpha:0.7];
    [textSizeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textSizeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [textSizeTextField setHidden: YES];
    textSizeTextField.hidden = YES;
    [scrollView addSubview:textSizeTextField];
    
    //Font Style
    //Font Style Label
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,headerSizeTextField.frame.origin.y + headerSizeTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textFontStyleLabel setHidden: YES];
    textFontStyleLabel.hidden = YES;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(lightThresholdLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [fontStyleTextField setFont:[UIFont systemFontOfSize:12]];
    fontStyleTextField.layer.cornerRadius = 5;
    fontStyleTextField.layer.borderWidth = 1.0;
    fontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [fontStyleTextField setAlpha:0.7];
    [fontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    fontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [fontStyleTextField setHidden: YES];
    fontStyleTextField.hidden = YES;
    [scrollView addSubview:fontStyleTextField];
    
    //Header Font Style
    //Font Style Label
    UILabel *headerFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [headerFontStyleLabel setText:[LabelUtils getLabelForKey:@"header_text_font_style"]];
    [headerFontStyleLabel setAlpha:0.7];
    [headerFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    headerFontStyleLabel.numberOfLines = 0;
    headerFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerFontStyleLabel setHidden: YES];
    headerFontStyleLabel.hidden = YES;
    [scrollView addSubview:headerFontStyleLabel];
    
    //Font Style TextField
    headerFontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(lightThresholdLabel.frame.origin.x, headerFontStyleLabel.frame.origin.y + headerFontStyleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [headerFontStyleTextField setFont:[UIFont systemFontOfSize:12]];
    headerFontStyleTextField.layer.cornerRadius = 5;
    headerFontStyleTextField.layer.borderWidth = 1.0;
    headerFontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerFontStyleTextField setAlpha:0.7];
    [headerFontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerFontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [headerFontStyleTextField setHidden: YES];
    headerFontStyleTextField.hidden = YES;
    [scrollView addSubview:headerFontStyleTextField];
    
    //Text Color/transparency
    //Text Color Label
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorLabel setHidden: YES];
    textColorLabel.hidden = YES;
    [scrollView addSubview:textColorLabel];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [textColorTransLabel setHidden: YES];
    textColorTransLabel.hidden = YES;
    [scrollView addSubview:textColorTransLabel];
    
    //Text Color TextField
    textColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [textColorTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTextField.layer.cornerRadius = 5;
    textColorTextField.layer.borderWidth = 1.0;
    textColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTextField setAlpha:0.7];
    [textColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [textColorTextField setHidden: YES];
    textColorTextField.hidden = YES;
    [scrollView addSubview:textColorTextField];
    
    //Transparency TextField
    textColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, textColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*0, textColorTransLabel.frame.size.width, (height/100)*0)];
    [textColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTransTextField.layer.cornerRadius = 5;
    textColorTransTextField.layer.borderWidth = 1.0;
    textColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTransTextField setAlpha:0.7];
    [textColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [textColorTransTextField setHidden: YES];
    textColorTransTextField.hidden = YES;
    [scrollView addSubview:textColorTransTextField];
    
    //Header Text Color/transparency
    //Header Text Color Label
    UILabel *headerTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,textColorTextField.frame.origin.y + textColorTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [headerTextColorLabel setText:[LabelUtils getLabelForKey:@"header_text_label_color"]];
    [headerTextColorLabel setAlpha:0.7];
    [headerTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextColorLabel.numberOfLines = 0;
    headerTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorLabel setHidden: YES];
    headerTextColorLabel.hidden = YES;
    [scrollView addSubview:headerTextColorLabel];
    
    //Transparency Label
    UILabel *headerTextColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,textColorTransTextField.frame.origin.y + textColorTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [headerTextColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [headerTextColorTransLabel setAlpha:0.7];
    headerTextColorTransLabel.numberOfLines = 0;
    headerTextColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [headerTextColorTransLabel setHidden: YES];
    headerTextColorTransLabel.hidden = YES;
    [scrollView addSubview:headerTextColorTransLabel];
    
    //Header Text Color TextField
    headerTextColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, headerTextColorLabel.frame.origin.y + headerTextColorLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [headerTextColorTextField setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTextField.layer.cornerRadius = 5;
    headerTextColorTextField.layer.borderWidth = 1.0;
    headerTextColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTextField setAlpha:0.7];
    [headerTextColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [headerTextColorTextField setHidden: YES];
    headerTextColorTextField.hidden = YES;
    [scrollView addSubview:headerTextColorTextField];
    
    //Transparency TextField
    headerTextColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, headerTextColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*0, headerTextColorTransLabel.frame.size.width, (height/100)*0)];
    [headerTextColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTransTextField.layer.cornerRadius = 5;
    headerTextColorTransTextField.layer.borderWidth = 1.0;
    headerTextColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTransTextField setAlpha:0.7];
    [headerTextColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    headerTextColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [headerTextColorTransTextField setHidden: YES];
    headerTextColorTransTextField.hidden = YES;
    [scrollView addSubview:headerTextColorTransTextField];
    
    //Back Button/transparency
    //Back button Label
    UILabel *backButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,headerTextColorTextField.frame.origin.y + headerTextColorTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [backButtonLabel setText:[LabelUtils getLabelForKey:@"back_button_color"]];
    [backButtonLabel setAlpha:0.7];
    [backButtonLabel setFont:[UIFont systemFontOfSize:11]];
    backButtonLabel.numberOfLines = 0;
    backButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonLabel setHidden: YES];
    backButtonLabel.hidden = YES;
    [scrollView addSubview:backButtonLabel];
    
    //Transparency Label
    UILabel *backButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,headerTextColorTransTextField.frame.origin.y + headerTextColorTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [backButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backButtonTransLabel setAlpha:0.7];
    backButtonTransLabel.numberOfLines = 0;
    backButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    //textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [backButtonTransLabel setHidden: YES];
    backButtonTransLabel.hidden = YES;
    [scrollView addSubview:backButtonTransLabel];
    
    //Back Button TextField
    backButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, backButtonLabel.frame.origin.y + backButtonLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [backButtonTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTextField.layer.cornerRadius = 5;
    backButtonTextField.layer.borderWidth = 1.0;
    backButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTextField setAlpha:0.7];
    [backButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [backButtonTextField setHidden: YES];
    backButtonTextField.hidden = YES;
    [scrollView addSubview:backButtonTextField];
    
    //Transparency TextField
    backButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, backButtonTransLabel.frame.origin.y + backButtonTransLabel.frame.size.height + (height/100)*0, backButtonTransLabel.frame.size.width, (height/100)*0)];
    [backButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTransTextField.layer.cornerRadius = 5;
    backButtonTransTextField.layer.borderWidth = 1.0;
    backButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTransTextField setAlpha:0.7];
    [backButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    backButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [backButtonTransTextField setHidden: YES];
    backButtonTransTextField.hidden = YES;
    [scrollView addSubview:backButtonTransTextField];
    
    //Retry Button/Transparency
    //Retry Button Label
    UILabel *retryButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,backButtonTextField.frame.origin.y + backButtonTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [retryButtonLabel setText:[LabelUtils getLabelForKey:@"retry_button_color"]];
    [retryButtonLabel setAlpha:0.7];
    [retryButtonLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonLabel.numberOfLines = 0;
    retryButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonLabel setHidden: YES];
    retryButtonLabel.hidden = YES;
    [scrollView addSubview:retryButtonLabel];
    
    //Transparency Label
    UILabel *retryButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,backButtonTextField.frame.origin.y + backButtonTextField.frame.size.height +  (height/100)*0, backButtonTextField.frame.size.width, (height/100)*0)];
    [retryButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonTransLabel setAlpha:0.7];
    retryButtonTransLabel.numberOfLines = 0;
    retryButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [retryButtonTransLabel setHidden: YES];
    retryButtonTransLabel.hidden = YES;
    [scrollView addSubview:retryButtonTransLabel];
    
    //Retry Button TextField
    retryButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, retryButtonLabel.frame.origin.y + retryButtonLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [retryButtonTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTextField.layer.cornerRadius = 5;
    retryButtonTextField.layer.borderWidth = 1.0;
    retryButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTextField setAlpha:0.7];
    [retryButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [retryButtonTextField setHidden: YES];
    retryButtonTextField.hidden = YES;
    [scrollView addSubview:retryButtonTextField];
    
    //Transparency TextField
    retryButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, retryButtonTransLabel.frame.origin.y + retryButtonTransLabel.frame.size.height + (height/100)*0, retryButtonTransLabel.frame.size.width, (height/100)*0)];
    [retryButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTransTextField.layer.cornerRadius = 5;
    retryButtonTransTextField.layer.borderWidth = 1.0;
    retryButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTransTextField setAlpha:0.7];
    [retryButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [retryButtonTransTextField setHidden: YES];
    retryButtonTransTextField.hidden = YES;
    [scrollView addSubview:retryButtonTransTextField];
    
    //Retry Button Border/Transparency
    //Retry Button Border Label
    UILabel *retryButtonBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [retryButtonBorderLabel setText:[LabelUtils getLabelForKey:@"retry_button_border_color"]];
    [retryButtonBorderLabel setAlpha:0.7];
    [retryButtonBorderLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonBorderLabel.numberOfLines = 0;
    retryButtonBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderLabel setHidden: YES];
    retryButtonBorderLabel.hidden = YES;
    [scrollView addSubview:retryButtonBorderLabel];
    
    //Transparency Label
    UILabel *retryButtonBorderTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +  (height/100)*0, retryButtonTransTextField.frame.size.width, (height/100)*0)];
    [retryButtonBorderTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonBorderTransLabel setAlpha:0.7];
    retryButtonBorderTransLabel.numberOfLines = 0;
    retryButtonBorderTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderTransLabel setFont:[UIFont systemFontOfSize:11]];
    [retryButtonBorderTransLabel setHidden: YES];
    retryButtonBorderTransLabel.hidden = YES;
    [scrollView addSubview:retryButtonBorderTransLabel];
    
    //Retry Button Border TextField
    retryButtonBorderTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, retryButtonBorderLabel.frame.origin.y + retryButtonBorderLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [retryButtonBorderTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTextField.layer.cornerRadius = 5;
    retryButtonBorderTextField.layer.borderWidth = 1.0;
    retryButtonBorderTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTextField setAlpha:0.7];
    [retryButtonBorderTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [retryButtonBorderTextField setHidden: YES];
    retryButtonBorderTextField.hidden = YES;
    [scrollView addSubview:retryButtonBorderTextField];
    
    //Transparency TextField
    retryButtonBorderTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, retryButtonBorderTransLabel.frame.origin.y + retryButtonBorderTransLabel.frame.size.height + (height/100)*0, retryButtonBorderTransLabel.frame.size.width, (height/100)*0)];
    [retryButtonBorderTransTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTransTextField.layer.cornerRadius = 5;
    retryButtonBorderTransTextField.layer.borderWidth = 1.0;
    retryButtonBorderTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTransTextField setAlpha:0.7];
    [retryButtonBorderTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonBorderTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [retryButtonBorderTransTextField setHidden: YES];
    retryButtonBorderTransTextField.hidden = YES;
    [scrollView addSubview:retryButtonBorderTransTextField];
    
    
    //Confirm Button/Transparency
    //Confirm Button Label
    UILabel *confirmButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [confirmButtonLabel setText:[LabelUtils getLabelForKey:@"confirm_button_color"]];
    [confirmButtonLabel setAlpha:0.7];
    [confirmButtonLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonLabel.numberOfLines = 0;
    confirmButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonLabel setHidden: YES];
    confirmButtonLabel.hidden = YES;
    [scrollView addSubview:confirmButtonLabel];
    
    //Transparency Label
    UILabel *confirmButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +  (height/100)*0, retryButtonBorderTextField.frame.size.width, (height/100)*0)];
    [confirmButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonTransLabel setAlpha:0.7];
    confirmButtonTransLabel.numberOfLines = 0;
    confirmButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [confirmButtonTransLabel setHidden: YES];
    confirmButtonTransLabel.hidden = YES;
    [scrollView addSubview:confirmButtonTransLabel];
    
    //Confirm Button TextField
    confirmButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, confirmButtonLabel.frame.origin.y + confirmButtonLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [confirmButtonTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTextField.layer.cornerRadius = 5;
    confirmButtonTextField.layer.borderWidth = 1.0;
    confirmButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTextField setAlpha:0.7];
    [confirmButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [confirmButtonTextField setHidden: YES];
    confirmButtonTextField.hidden = YES;
    [scrollView addSubview:confirmButtonTextField];
    
    //Transparency TextField
    confirmButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, confirmButtonTransLabel.frame.origin.y + confirmButtonTransLabel.frame.size.height + (height/100)*0, confirmButtonTransLabel.frame.size.width, (height/100)*0)];
    [confirmButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTransTextField.layer.cornerRadius = 5;
    confirmButtonTransTextField.layer.borderWidth = 1.0;
    confirmButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTransTextField setAlpha:0.7];
    [confirmButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [confirmButtonTransTextField setHidden: YES];
    confirmButtonTransTextField.hidden = YES;
    [scrollView addSubview:confirmButtonTransTextField];
    
    //Confirm Button/Transparency Style
    //Confirm Button Label
    UILabel *confirmButtonStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [confirmButtonStyleLabel setText:[LabelUtils getLabelForKey:@"confirm_button_style"]];
    [confirmButtonStyleLabel setAlpha:0.7];
    [confirmButtonStyleLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonStyleLabel.numberOfLines = 0;
    confirmButtonStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleLabel setHidden: YES];
    confirmButtonStyleLabel.hidden = YES;
    [scrollView addSubview:confirmButtonStyleLabel];
    
    //Transparency Label
    UILabel *confirmButtonStyleTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +  (height/100)*0, confirmButtonTextField.frame.size.width, (height/100)*0)];
    [confirmButtonStyleTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonStyleTransLabel setAlpha:0.7];
    confirmButtonStyleTransLabel.numberOfLines = 0;
    confirmButtonStyleTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleTransLabel setFont:[UIFont systemFontOfSize:11]];
    [confirmButtonStyleTransLabel setHidden: YES];
    confirmButtonStyleTransLabel.hidden = YES;
    [scrollView addSubview:confirmButtonStyleTransLabel];
    
    //Confirm Button TextField
    confirmButtonStyleTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, confirmButtonStyleLabel.frame.origin.y + confirmButtonStyleLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [confirmButtonStyleTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTextField.layer.cornerRadius = 5;
    confirmButtonStyleTextField.layer.borderWidth = 1.0;
    confirmButtonStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTextField setAlpha:0.7];
    [confirmButtonStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [confirmButtonStyleTextField setHidden: YES];
    confirmButtonStyleTextField.hidden = YES;
    [scrollView addSubview:confirmButtonStyleTextField];
    
    //Transparency TextField
    confirmButtonStyleTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, confirmButtonStyleTransLabel.frame.origin.y + confirmButtonStyleTransLabel.frame.size.height + (height/100)*0, confirmButtonStyleTransLabel.frame.size.width, (height/100)*0)];
    [confirmButtonStyleTransTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTransTextField.layer.cornerRadius = 5;
    confirmButtonStyleTransTextField.layer.borderWidth = 1.0;
    confirmButtonStyleTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTransTextField setAlpha:0.7];
    [confirmButtonStyleTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonStyleTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [confirmButtonStyleTransTextField setHidden: YES];
    confirmButtonStyleTransTextField.hidden = YES;
    [scrollView addSubview:confirmButtonStyleTransTextField];
    
    //Instruction continue Button/Transparency
    //continue Button Label
    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,confirmButtonStyleTextField.frame.origin.y + confirmButtonStyleTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
    [continueButtonLabel setAlpha:0.7];
    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonLabel.numberOfLines = 0;
    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonLabel setHidden: YES];
    continueButtonLabel.hidden = YES;
    [scrollView addSubview:continueButtonLabel];
    
    //Transparency Label
    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,confirmButtonStyleTransTextField.frame.origin.y + confirmButtonStyleTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransLabel setAlpha:0.7];
    continueButtonTransLabel.numberOfLines = 0;
    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [continueButtonTransLabel setHidden: YES];
    continueButtonTransLabel.hidden = YES;
    [scrollView addSubview:continueButtonTransLabel];
    
    //continue Button TextField
    instContinueButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [instContinueButtonTextField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextField.layer.cornerRadius = 5;
    instContinueButtonTextField.layer.borderWidth = 1.0;
    instContinueButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextField setAlpha:0.7];
    [instContinueButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [instContinueButtonTextField setHidden: YES];
    instContinueButtonTextField.hidden = YES;
    [scrollView addSubview:instContinueButtonTextField];
    
    //Transparency TextField
    instContinueButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [instContinueButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextField.layer.cornerRadius = 5;
    instContinueButtonTransTextField.layer.borderWidth = 1.0;
    instContinueButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextField setAlpha:0.7];
    [instContinueButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [instContinueButtonTransTextField setHidden: YES];
    instContinueButtonTransTextField.hidden = YES;
    [scrollView addSubview:instContinueButtonTransTextField];
    
    //Instruction continue Text color Button/Transparency
    //Continue Button Text color Label
    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,instContinueButtonTextField.frame.origin.y + instContinueButtonTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
    [continueButtonTextColorLabel setAlpha:0.7];
    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonTextColorLabel.numberOfLines = 0;
    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTextColorLabel setHidden: YES];
    continueButtonTextColorLabel.hidden = YES;
    [scrollView addSubview:continueButtonTextColorLabel];
    
    //Transparency Label
    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +  (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransTextColorLabel setAlpha:0.7];
    continueButtonTransTextColorLabel.numberOfLines = 0;
    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    [continueButtonTransTextColorLabel setHidden: YES];
    continueButtonTransTextColorLabel.hidden = YES;
    [scrollView addSubview:continueButtonTransTextColorLabel];
    
    //Continue Button text color TextField
    instContinueButtonTextColorField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [instContinueButtonTextColorField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextColorField.layer.cornerRadius = 5;
    instContinueButtonTextColorField.layer.borderWidth = 1.0;
    instContinueButtonTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextColorField setAlpha:0.7];
    [instContinueButtonTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextColorField.borderStyle = UITextBorderStyleRoundedRect;
    [instContinueButtonTextColorField setHidden: YES];
    instContinueButtonTextColorField.hidden = YES;
    [scrollView addSubview:instContinueButtonTextColorField];
    
    //Transparency TextField
    instContinueButtonTransTextColorField= [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
    [instContinueButtonTransTextColorField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextColorField.layer.cornerRadius = 5;
    instContinueButtonTransTextColorField.layer.borderWidth = 1.0;
    instContinueButtonTransTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextColorField setAlpha:0.7];
    [instContinueButtonTransTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextColorField.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextColorField.keyboardType = UIKeyboardTypeNumberPad;
    [instContinueButtonTransTextColorField setHidden: YES];
    instContinueButtonTransTextColorField.hidden = YES;
    [scrollView addSubview:instContinueButtonTransTextColorField];
    
    //Select Face Image Type
    //Select Face Image Type label
    UILabel *faceModel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,passiveFaceDetectionTogleButton.frame.origin.y + passiveFaceDetectionTogleButton.frame.size.height, self.view.frame.size.width, (height/100)*5)];
    if([AppItSDK isDebugEnable]) {
        faceModel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,uploadFaceDataTogleButton.frame.origin.y + uploadFaceDataTogleButton.frame.size.height, self.view.frame.size.width, (height/100)*5)];
    } else {
        faceModel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,passiveFaceDetectionTogleButton.frame.origin.y + frontCameraToggleYesLabel.frame.size.height, self.view.frame.size.width, (height/100)*5)];
    }
    NSString *faceModelName = [NSString stringWithFormat:@"Face model : %@", [AppItSDK getFaceModelName]];
    [faceModel setText:faceModelName];
    [faceModel setAlpha:0.7];
    [faceModel setFont:[UIFont systemFontOfSize:11]];
    faceModel.numberOfLines = 0;
    faceModel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceModel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:faceModel];

//    UILabel *selectFaceImageTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,frontCameraToggleYesLabel.frame.origin.y + frontCameraToggleYesLabel.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*5)];
    UILabel *selectFaceImageTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,frontCameraToggleYesLabel.frame.origin.y + frontCameraToggleYesLabel.frame.size.height + (height/100)*2, lightThresholdLabel.frame.size.width, 0)];
    [selectFaceImageTypeLabel setText:[LabelUtils getLabelForKey:@"face_image_type"]];
    [selectFaceImageTypeLabel setAlpha:0.7];
    [selectFaceImageTypeLabel setFont:[UIFont systemFontOfSize:11]];
    selectFaceImageTypeLabel.numberOfLines = 0;
    selectFaceImageTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:selectFaceImageTypeLabel];
    
    //Select Title Image Edit Spinner
//   faceImageTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, selectFaceImageTypeLabel.frame.origin.y + selectFaceImageTypeLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    faceImageTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, selectFaceImageTypeLabel.frame.origin.y + selectFaceImageTypeLabel.frame.size.height + (height/100)*1, (width/100)*92, 0)];
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
    UIImageView *downArrowImageFace = [[UIImageView alloc] initWithFrame:CGRectMake(faceImageTypeTextField.frame.origin.x + faceImageTypeTextField.frame.size.width - (width/100)*9 , faceImageTypeTextField.frame.origin.y + (faceImageTypeTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [downArrowImageFace setImage:[UIImage imageNamed:@"drop_down.png"]];

    [scrollView addSubview:downArrowImageFace];
    
    //Select Title Image
    //Select Title Image label
    UILabel *selectTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceImageTypeTextField.frame.origin.y + faceImageTypeTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [selectTitleImageLabel setText:[LabelUtils getLabelForKey:@"title_image"]];
    [selectTitleImageLabel setAlpha:0.7];
    [selectTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    selectTitleImageLabel.numberOfLines = 0;
    selectTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [selectTitleImageLabel setHidden: YES];
    selectTitleImageLabel.hidden = YES;
    [scrollView addSubview:selectTitleImageLabel];
    
    //Select Title Image Edit Spinner
    selectTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, selectTitleImageLabel.frame.origin.y + selectTitleImageLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [selectTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    selectTitleImgTextField.layer.cornerRadius = 5;
    selectTitleImgTextField.layer.borderWidth = 1.0;
    selectTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [selectTitleImgTextField setAlpha:0.7];
    [selectTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    selectTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [selectTitleImgTextField setHidden: YES];
    selectTitleImgTextField.hidden = YES;
    [scrollView addSubview:selectTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectTitleImgTextField.frame.origin.x + selectTitleImgTextField.frame.size.width - (width/100)*9 , selectTitleImgTextField.frame.origin.y + (selectTitleImgTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [downArrowImage setHidden: YES];
    downArrowImage.hidden = YES;
    [scrollView addSubview:downArrowImage];
    
    //FaceTitleAlignment
    UILabel *faceTitleAlignmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,selectTitleImgTextField.frame.origin.y + selectTitleImgTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceTitleAlignmentLabel setText:[LabelUtils getLabelForKey:@"face_title_alignment"]];
    [faceTitleAlignmentLabel setAlpha:0.7];
    [faceTitleAlignmentLabel setFont:[UIFont systemFontOfSize:11]];
    faceTitleAlignmentLabel.numberOfLines = 0;
    faceTitleAlignmentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceTitleAlignmentLabel setHidden: YES];
    faceTitleAlignmentLabel.hidden = YES;
    [scrollView addSubview:faceTitleAlignmentLabel];
    
    faceTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceTitleAlignmentLabel.frame.origin.y + faceTitleAlignmentLabel.frame.size.height + (height/100)*0, faceTitleAlignmentLabel.frame.size.width, (height/100)*0)];
    [faceTitleTextField setFont:[UIFont systemFontOfSize:12]];
    faceTitleTextField.layer.cornerRadius = 5;
    faceTitleTextField.layer.borderWidth = 1.0;
    faceTitleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceTitleTextField setAlpha:0.7];
    [faceTitleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceTitleTextField.keyboardType = UIKeyboardTypeNumberPad;
    [faceTitleTextField setHidden: YES];
    faceTitleTextField.hidden = YES;
    [scrollView addSubview:faceTitleTextField];
    
    UIImageView *faceTitleImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceTitleTextField.frame.origin.x + faceTitleTextField.frame.size.width - (width/100)*9 , faceTitleTextField.frame.origin.y + (faceTitleTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceTitleImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceTitleImageDownArrowImage setHidden: YES];
    faceTitleImageDownArrowImage.hidden = YES;
    [scrollView addSubview:faceTitleImageDownArrowImage];
    
    faceTitleCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceTitleCheckBox.frame = CGRectMake(faceTitleTextField.frame.origin.x + faceTitleTextField.frame.size.width + (width/100)*2, faceTitleTextField.frame.origin.y*0, (width/100)*7, (height/100)*0);
    [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                       forState:UIControlStateNormal];
    [faceTitleCheckBox addTarget:self action:@selector(faceTitleCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [faceTitleCheckBox setHidden: YES];
    faceTitleCheckBox.hidden = YES;
    [scrollView addSubview:faceTitleCheckBox];
    
    UILabel *hideFaceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceTitleCheckBox.frame.origin.x + faceTitleCheckBox.frame.size.width + (width/100)*2, faceTitleCheckBox.frame.origin.y*0, faceTitleTextField.frame.size.width, (height/100)*0)];
    [hideFaceTitleLabel setText:[LabelUtils getLabelForKey:@"hide_face_title"]];
    [hideFaceTitleLabel setAlpha:0.7];
    [hideFaceTitleLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceTitleLabel.numberOfLines = 0;
    hideFaceTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideFaceTitleLabel setHidden: YES];
    hideFaceTitleLabel.hidden = YES;
    [scrollView addSubview:hideFaceTitleLabel];
    
    //FaceHintMessageAlignment
    UILabel *faceHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceTitleTextField.frame.origin.y + faceTitleTextField.frame.size.height + (height/100)*0, self.view.frame.size.width, (height/100)*0)];
    [faceHintMsgLabel setText:[LabelUtils getLabelForKey:@"face_hint_message_alignment"]];
    [faceHintMsgLabel setAlpha:0.7];
    [faceHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    faceHintMsgLabel.numberOfLines = 0;
    faceHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceHintMsgLabel setHidden: YES];
    faceHintMsgLabel.hidden = YES;
    [scrollView addSubview:faceHintMsgLabel];
    
    faceHintMsgTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceHintMsgLabel.frame.origin.y + faceHintMsgLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceHintMsgTextField setFont:[UIFont systemFontOfSize:12]];
    faceHintMsgTextField.layer.cornerRadius = 5;
    faceHintMsgTextField.layer.borderWidth = 1.0;
    faceHintMsgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceHintMsgTextField setAlpha:0.7];
    [faceHintMsgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceHintMsgTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceHintMsgTextField.keyboardType = UIKeyboardTypeNumberPad;
    [faceHintMsgTextField setHidden: YES];
    faceHintMsgTextField.hidden = YES;
    [scrollView addSubview:faceHintMsgTextField];
    
    UIImageView *faceHintMsgImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceHintMsgTextField.frame.origin.x + faceHintMsgTextField.frame.size.width - (width/100)*9 , faceHintMsgTextField.frame.origin.y + (faceHintMsgTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceHintMsgImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceHintMsgImageDownArrowImage setHidden: YES];
    faceHintMsgImageDownArrowImage.hidden = YES;
    [scrollView addSubview:faceHintMsgImageDownArrowImage];
    
    faceHintMsgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceHintMsgCheckBox.frame = CGRectMake(faceHintMsgTextField.frame.origin.x + faceHintMsgTextField.frame.size.width + (width/100)*0, faceHintMsgTextField.frame.origin.y, (width/100)*7, (height/100)*0);
    [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                         forState:UIControlStateNormal];
    [faceHintMsgCheckBox addTarget:self action:@selector(faceHintMsgCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [faceHintMsgCheckBox setHidden: YES];
    faceHintMsgCheckBox.hidden = YES;
    [scrollView addSubview:faceHintMsgCheckBox];
    
    UILabel *hideFaceHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceHintMsgCheckBox.frame.origin.x + faceHintMsgCheckBox.frame.size.width + (width/100)*0, faceHintMsgCheckBox.frame.origin.y, faceHintMsgTextField.frame.size.width, (height/100)*0)];
    [hideFaceHintMsgLabel setText:[LabelUtils getLabelForKey:@"hide_face_hint_message"]];
    [hideFaceHintMsgLabel setAlpha:0.7];
    [hideFaceHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceHintMsgLabel.numberOfLines = 0;
    hideFaceHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideFaceHintMsgLabel setHidden: YES];
    hideFaceHintMsgLabel.hidden = YES;
    [scrollView addSubview:hideFaceHintMsgLabel];
    
    //FaceHintIcon
    UILabel *faceHintIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceHintMsgTextField.frame.origin.y + faceHintMsgTextField.frame.size.height + (height/100)*0, self.view.frame.size.width, (height/100)*0)];
    [faceHintIconLabel setText:[LabelUtils getLabelForKey:@"face_hint_icon_alignment"]];
    [faceHintIconLabel setAlpha:0.7];
    [faceHintIconLabel setFont:[UIFont systemFontOfSize:11]];
    faceHintIconLabel.numberOfLines = 0;
    faceHintIconLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceHintIconLabel setHidden: YES];
    faceHintIconLabel.hidden = YES;
    [scrollView addSubview:faceHintIconLabel];
    
    faceHintIconTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceHintIconLabel.frame.origin.y + faceHintIconLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceHintIconTextField setFont:[UIFont systemFontOfSize:12]];
    faceHintIconTextField.layer.cornerRadius = 5;
    faceHintIconTextField.layer.borderWidth = 1.0;
    faceHintIconTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceHintIconTextField setAlpha:0.7];
    [faceHintIconTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceHintIconTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceHintIconTextField.keyboardType = UIKeyboardTypeNumberPad;
    [faceHintIconTextField setHidden: YES];
    faceHintIconTextField.hidden = YES;
    [scrollView addSubview:faceHintIconTextField];
    
    UIImageView *faceHintIconImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceHintIconTextField.frame.origin.x + faceHintIconTextField.frame.size.width - (width/100)*9 , faceHintIconTextField.frame.origin.y + (faceHintIconTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceHintIconImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceHintIconImageDownArrowImage setHidden: YES];
    faceHintIconImageDownArrowImage.hidden = YES;
    [scrollView addSubview:faceHintIconImageDownArrowImage];
    
    faceHintIconCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceHintIconCheckBox.frame = CGRectMake(faceHintIconTextField.frame.origin.x + faceHintIconTextField.frame.size.width + (width/100)*2, faceHintIconTextField.frame.origin.y*0, (width/100)*7, (height/100)*0);
    [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                          forState:UIControlStateNormal];
    [faceHintIconCheckBox addTarget:self action:@selector(faceHintIconCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [faceHintIconCheckBox setHidden: YES];
    faceHintIconCheckBox.hidden = YES;
    [scrollView addSubview:faceHintIconCheckBox];
    
    UILabel *hideFaceHintIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceHintIconCheckBox.frame.origin.x + faceHintIconCheckBox.frame.size.width + (width/100)*0, faceHintIconCheckBox.frame.origin.y, faceHintIconTextField.frame.size.width, (height/100)*0)];
    [hideFaceHintIconLabel setText:[LabelUtils getLabelForKey:@"hide_face_hint_icon"]];
    [hideFaceHintIconLabel setAlpha:0.7];
    [hideFaceHintIconLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceHintIconLabel.numberOfLines = 0;
    hideFaceHintIconLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideFaceHintIconLabel setHidden: YES];
    hideFaceHintIconLabel.hidden = YES;
    [scrollView addSubview:hideFaceHintIconLabel];
    
    //FaceTitleImageAlignment
    UILabel *faceTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceHintIconTextField.frame.origin.y + faceHintIconTextField.frame.size.height + (height/100)*0, self.view.frame.size.width, (height/100)*0)];
    [faceTitleImageLabel setText:[LabelUtils getLabelForKey:@"face_title_image_alignment"]];
    [faceTitleImageLabel setAlpha:0.7];
    [faceTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    faceTitleImageLabel.numberOfLines = 0;
    faceTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceTitleImageLabel setHidden: YES];
    faceTitleImageLabel.hidden = YES;
    [scrollView addSubview:faceTitleImageLabel];
    
    faceTitleImageTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceTitleImageLabel.frame.origin.y + faceTitleImageLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceTitleImageTextField setFont:[UIFont systemFontOfSize:12]];
    faceTitleImageTextField.layer.cornerRadius = 5;
    faceTitleImageTextField.layer.borderWidth = 1.0;
    faceTitleImageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceTitleImageTextField setAlpha:0.7];
    [faceTitleImageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceTitleImageTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceTitleImageTextField.keyboardType = UIKeyboardTypeNumberPad;
    [faceTitleImageTextField setHidden: YES];
    faceTitleImageTextField.hidden = YES;
    [scrollView addSubview:faceTitleImageTextField];
    
    UIImageView *faceTiImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceTitleImageTextField.frame.origin.x + faceTitleImageTextField.frame.size.width - (width/100)*9 , faceTitleImageTextField.frame.origin.y + (faceTitleImageTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceTiImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceTiImageDownArrowImage setHidden: YES];
    faceTiImageDownArrowImage.hidden = YES;
    [scrollView addSubview:faceTiImageDownArrowImage];
    
    faceTitleImageCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceTitleImageCheckBox.frame = CGRectMake(faceTitleImageTextField.frame.origin.x + faceTitleImageTextField.frame.size.width + (width/100)*0, faceTitleImageTextField.frame.origin.y, (width/100)*7, (height/100)*0);
    [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [faceTitleImageCheckBox addTarget:self action:@selector(faceTitleImageCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [faceTitleImageCheckBox setHidden: YES];
    faceTitleImageCheckBox.hidden = YES;
    [scrollView addSubview:faceTitleImageCheckBox];
    
    UILabel *hideFaceTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceTitleImageCheckBox.frame.origin.x + faceTitleImageCheckBox.frame.size.width + (width/100)*2, faceTitleImageCheckBox.frame.origin.y*0, faceTitleImageTextField.frame.size.width, (height/100)*0)];
    [hideFaceTitleImageLabel setText:[LabelUtils getLabelForKey:@"hide_face_title_image"]];
    [hideFaceTitleImageLabel setAlpha:0.7];
    [hideFaceTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceTitleImageLabel.numberOfLines = 0;
    hideFaceTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideFaceTitleImageLabel setHidden: YES];
    hideFaceTitleImageLabel.hidden = YES;
    [scrollView addSubview:hideFaceTitleImageLabel];
    
    //Id Capture Label Initialization
    UILabel *initFaceCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceTitleImageTextField.frame.origin.y + faceTitleImageTextField.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [initFaceCaptureLabel setText:[LabelUtils getLabelForKey:@"id_capture_label"]];
    [initFaceCaptureLabel setAlpha:0.7];
    [initFaceCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    initFaceCaptureLabel.numberOfLines = 0;
    initFaceCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [initFaceCaptureLabel setHidden: YES];
    initFaceCaptureLabel.hidden = YES;
    [scrollView addSubview:initFaceCaptureLabel];
    
    faceCaptureLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, initFaceCaptureLabel.frame.origin.y + initFaceCaptureLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [faceCaptureLabelTextField setFont:[UIFont systemFontOfSize:12]];
    faceCaptureLabelTextField.layer.cornerRadius = 5;
    faceCaptureLabelTextField.layer.borderWidth = 1.0;
    faceCaptureLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceCaptureLabelTextField setAlpha:0.7];
    [faceCaptureLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceCaptureLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceCaptureLabelTextField setHidden: YES];
    faceCaptureLabelTextField.hidden = YES;
    [scrollView addSubview:faceCaptureLabelTextField];
    
    UIImageView *faceCaptureLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceCaptureLabelTextField.frame.origin.x + faceCaptureLabelTextField.frame.size.width - (width/100)*9 , faceCaptureLabelTextField.frame.origin.y + (faceCaptureLabelTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceCaptureLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceCaptureLabelDownArrowImage setHidden: YES];
    faceCaptureLabelDownArrowImage.hidden = YES;
    [scrollView addSubview:faceCaptureLabelDownArrowImage];
    
    //English Label
    UILabel *englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,faceCaptureLabelTextField.frame.origin.y + faceCaptureLabelTextField.frame.size.height +   (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [englishLabel setText:[LabelUtils getLabelForKey:@"english_label"]];
    [englishLabel setAlpha:0.7];
    [englishLabel setFont:[UIFont systemFontOfSize:11]];
    englishLabel.numberOfLines = 0;
    englishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [englishLabel setHidden: YES];
    englishLabel.hidden = YES;
    [scrollView addSubview:englishLabel];
    
    //Spanish Label
    UILabel *spanishLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,faceCaptureLabelTextField.frame.origin.y + faceCaptureLabelTextField.frame.size.height +  (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [spanishLabel setText:[LabelUtils getLabelForKey:@"spanish_label"]];
    [spanishLabel setAlpha:0.7];
    spanishLabel.numberOfLines = 0;
    spanishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [spanishLabel setFont:[UIFont systemFontOfSize:11]];
    [spanishLabel setHidden: YES];
    spanishLabel.hidden = YES;
    [scrollView addSubview:spanishLabel];
    
    //English TextField
    englishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, englishLabel.frame.origin.y + englishLabel.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [englishLabelTextField setFont:[UIFont systemFontOfSize:12]];
    englishLabelTextField.layer.cornerRadius = 5;
    englishLabelTextField.layer.borderWidth = 1.0;
    englishLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [englishLabelTextField setAlpha:0.7];
    [englishLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    englishLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [englishLabelTextField setHidden: YES];
    englishLabelTextField.hidden = YES;
    [scrollView addSubview:englishLabelTextField];
    
    //Spanish TextField
    spanishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*0, spanishLabel.frame.size.width, (height/100)*0)];
    [spanishLabelTextField setFont:[UIFont systemFontOfSize:12]];
    spanishLabelTextField.layer.cornerRadius = 5;
    spanishLabelTextField.layer.borderWidth = 1.0;
    spanishLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [spanishLabelTextField setAlpha:0.7];
    [spanishLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    spanishLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    spanishLabelTextField.keyboardType = UIKeyboardTypeNumberPad;
    [spanishLabelTextField setHidden: YES];
    spanishLabelTextField.hidden = YES;
    [scrollView addSubview:spanishLabelTextField];
    
    UIButton *addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frameAddLabel = CGRectMake((width/2) - (spanishLabelTextField.frame.size.width/2), englishLabelTextField.frame.origin.y + englishLabelTextField.frame.size.height + (height/100)*0, spanishLabelTextField.frame.size.width, (height/100)*0);
    [addLabelButton setFrame:frameAddLabel];
    addLabelButton.layer.cornerRadius = 20;
    addLabelButton.clipsToBounds = YES;
    [addLabelButton setTitle:[LabelUtils getLabelForKey:@"add_label"] forState:UIControlStateNormal];
    addLabelButton.titleLabel.textColor = [UIColor whiteColor];
    [addLabelButton setBackgroundColor:[UIColor blackColor]];
    [addLabelButton addTarget:self action:@selector(addLabelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addLabelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [addLabelButton setHidden: YES];
    addLabelButton.hidden = YES;
    [scrollView addSubview:addLabelButton];
    
    //Face Contours
    UILabel *faceContoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,addLabelButton.frame.origin.y + addLabelButton.frame.size.height + (height/100)*0, lightThresholdLabel.frame.size.width, (height/100)*0)];
    [faceContoursLabel setText:[LabelUtils getLabelForKey:@"face_contours"]];
    [faceContoursLabel setAlpha:0.7];
    [faceContoursLabel setFont:[UIFont systemFontOfSize:11]];
    faceContoursLabel.numberOfLines = 0;
    faceContoursLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceContoursLabel setHidden: YES];
    faceContoursLabel.hidden = YES;
    [scrollView addSubview:faceContoursLabel];
    
    faceContoursTextField = [[UITextField alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x, faceContoursLabel.frame.origin.y + faceContoursLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [faceContoursTextField setFont:[UIFont systemFontOfSize:12]];
    faceContoursTextField.layer.cornerRadius = 5;
    faceContoursTextField.layer.borderWidth = 1.0;
    faceContoursTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceContoursTextField setAlpha:0.7];
    [faceContoursTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceContoursTextField.borderStyle = UITextBorderStyleRoundedRect;
    [faceContoursTextField setHidden: YES];
    faceContoursTextField.hidden = YES;
    [scrollView addSubview:faceContoursTextField];
    
    UIImageView *faceContoursLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceContoursTextField.frame.origin.x + faceContoursTextField.frame.size.width - (width/100)*9 , faceContoursTextField.frame.origin.y + (faceContoursTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [faceContoursLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [faceContoursLabelDownArrowImage setHidden: YES];
    faceContoursLabelDownArrowImage.hidden = YES;
    [scrollView addSubview:faceContoursLabelDownArrowImage];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(lightThresholdLabel.frame.origin.x, faceModel.frame.origin.y + faceModel.frame.size.height + (height/100)*2, faceTitleImageTextField.frame.size.width, (height/100)*6);
    [saveBtn setFrame:saveAccountframe];
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:[LabelUtils getLabelForKey:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
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

-(void)faceTitleCheckBoxBtnClick:(UIButton*)button {
    if(!hideFaceTitle) {
        [faceTitleCheckBox setImage:[UIImage imageNamed:@"check.png"]
                           forState:UIControlStateNormal];
        hideFaceTitle = true;
    } else {
        hideFaceTitle = false;
        [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                           forState:UIControlStateNormal];
    }
}

-(void)faceHintMsgCheckBoxBtnClick:(UIButton*)button {
    if(!hideFaceHintMessage) {
        [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                             forState:UIControlStateNormal];
        hideFaceHintMessage = true;
    } else {
        hideFaceHintMessage = false;
        [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                             forState:UIControlStateNormal];
    }
}

-(void)faceHintIconCheckBoxBtnClick:(UIButton*)button {
    if(!hideFaceHintIcon) {
        [faceHintIconCheckBox setImage:[UIImage imageNamed:@"check.png"]
                              forState:UIControlStateNormal];
        hideFaceHintIcon = true;
    } else {
        hideFaceHintIcon = false;
        [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    }
}

-(void)faceTitleImageCheckBoxBtnClick:(UIButton*)button {
    if(!hideFaceTitleImage) {
        [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
        hideFaceTitleImage = true;
    } else {
        hideFaceTitleImage = false;
        [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
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

-(void)uploadFaceDataToggleBtnClick:(UIButton*)button {
    if(!isFaceDataUpload) {
        [uploadFaceDataTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isFaceDataUpload = true;
    } else {
        [uploadFaceDataTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isFaceDataUpload = false;
    }
}

-(void)enableBGRToggleBtnClick:(UIButton*)button {
    if(!isBGREnable) {
        [enableBGRToggleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isBGREnable = true;
    } else {
        [enableBGRToggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isBGREnable = false;
    }
}

-(void)passiveFaceDetectionToggleBtnClick:(UIButton*)button {
    if(isPassiveFaceDetectionEnabled) {
        [passiveFaceDetectionTogleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isPassiveFaceDetectionEnabled = false;
    } else {
        [passiveFaceDetectionTogleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isPassiveFaceDetectionEnabled = true;
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

-(void)addLabelClicked:(UIButton*)button {
    NSString *labelKey = faceCaptureLabelTextField.text;
    if(![NSStringUtils stringIsNilOrEmpty:labelKey]){
        
        NSString *englabel = englishLabelTextField.text;
        if(![NSStringUtils stringIsNilOrEmpty:englabel]){
            [englishLabels setObject:englabel forKey:labelKey];
        }
        
        NSString *spalabel = spanishLabelTextField.text;
        if(![NSStringUtils stringIsNilOrEmpty:spalabel]){
            [spanishLabels setObject:spalabel forKey:labelKey];
        }
    }
    [englishLabelTextField setText:@""];
    [spanishLabelTextField setText:@""];
}

-(void)saveButton:(UIButton*)button {
    
    int lowLightThreshold=mFaceLowLightThreshold, focusPercentage=mFaceFocusThresholde, faceImageSize=mFaceMaxImageSize;
    int faceDetectionPercentage=mFaceDetectionPercentage, eyesOpenThreshold = mEyesOpenThresholdPercentage,
        livelinessFaceThreshold=mLivelinessFaceThresholdPercentage;
    NSString *faceoutlinecolor = dFaceOutlineColor, *detectedfaceoutlinecolor = dDetectedFaceOutlineColor, *outsideoutlinecolor = dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutLineColor = dDetectedOutsideFaceOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor,*confirmButtonStyle=dConfirmButtonStyle, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor;
    int faceoutlinetransparency = mAlpha, detectedfaceoutlinetransparency = mAlpha, outsideoutlinetransparency = mAlpha, dDetectedOutsideFaceOutLineColorAlpha = mAlpha,backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, confirmButtonStyleTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, headerTextColorTrans=mAlpha;
    
    if([NSStringUtilsDemo isInteger:lightThresholdTextField.text]){
        lowLightThreshold = [lightThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:focusThresholdTextField.text]){
        focusPercentage = [focusThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:faceDetectionThresTextField.text]){
        faceDetectionPercentage = [faceDetectionThresTextField.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:eyesOpenThreTextField.text]){
        eyesOpenThreshold = [eyesOpenThreTextField.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:livelinessThresholdTextField.text]){
        livelinessFaceThreshold = [livelinessThresholdTextField.text intValue];
    }
    
//    if(![NSStringUtils stringIsNilOrEmpty:faceDetectionThresTextField.text]){
//           faceDetectionPercentage = [faceDetectionThresTextField.text floatValue];
//       }
    
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
    backButtonColor = backButtonTextField.text;
    retryButtonColor = retryButtonTextField.text;
    confirmButtonColor = confirmButtonTextField.text;
    retryButtonBorderColor = retryButtonBorderTextField.text;
    confirmButtonStyle = confirmButtonStyleTextField.text;
    fontStyle = fontStyleTextField.text;
    textColor = textColorTextField.text;
    instContinueButtonColor = instContinueButtonTextField.text;
    instContinueButtonTextColor = instContinueButtonTextColorField.text;
    backButtonTrans=[backButtonTransTextField.text intValue];
    retryButtonTrans=[retryButtonTransTextField.text intValue];
    confirmButtonTrans =[confirmButtonTransTextField.text intValue];
    textColorTrans=[textColorTransTextField.text intValue];
    instContinueButtonTrans=[instContinueButtonTransTextField.text intValue];
    instContinueButtonTransText=[instContinueButtonTransTextColorField.text intValue];
    headerTextColorTrans=[headerTextColorTransTextField.text intValue];
    
    [self saveSetting:@"facelightthreshold" value:[NSString stringWithFormat:@"%d", lowLightThreshold]];
    [self saveSetting:@"facefocusthreshold" value:[NSString stringWithFormat:@"%d", focusPercentage]];
    [self saveSetting:@"passivefacedetectionthreshold" value:[NSString stringWithFormat:@"%d", faceDetectionPercentage]];
    [self saveSetting:@"passivefacedetectionthreshold" value:[NSString stringWithFormat:@"%d", faceDetectionPercentage]];
    [self saveSetting:@"eyesOpenthreshold" value:[NSString stringWithFormat:@"%d", eyesOpenThreshold]];
    [self saveSetting:@"livelinessFaceThreshold" value:[NSString stringWithFormat:@"%d", livelinessFaceThreshold]];
    [self saveSetting:@"faceimagesize" value:[NSString stringWithFormat:@"%d", faceImageSize]];
    [self saveSetting:@"faceoutlinecolor" value:faceoutlinecolor];
    [self saveSetting:@"detectedfaceoutlinecolor" value:detectedfaceoutlinecolor];
    [self saveSetting:@"_outsideoutlinecolor" value:outsideoutlinecolor];
    [self saveSetting:@"detectedfaceoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedfaceoutlinetransparency]];
    [self saveSetting:@"faceoutlinetransparency" value:[NSString stringWithFormat:@"%d", faceoutlinetransparency]];
    [self saveSetting:@"_outsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", outsideoutlinetransparency]];
    [self saveSetting:@"detectedfaceoutsideoutlinecolor" value:dDetectedOutsideFaceOutLineColor];
    [self saveSetting:@"detectedfaceoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d",dDetectedOutsideFaceOutLineColorAlpha]];
    
    [self saveSetting:@"faceBackButton" value:backButtonColor];
    [self saveSetting:@"faceRetryButton" value:retryButtonColor];
    [self saveSetting:@"faceRetryButtonBorder" value:retryButtonBorderColor];
    [self saveSetting:@"faceConfirmButton" value:confirmButtonColor];
    [self saveSetting:@"faceConfirmButtonStyle" value:confirmButtonStyle];
    [self saveSetting:@"faceTextColor" value:textColor];
    [self saveSetting:@"faceInstContinueButton" value:instContinueButtonColor];
    [self saveSetting:@"faceInstContinueButtonText" value:instContinueButtonTextColor];
    
    [self saveSetting:@"faceBackButtonTransparency" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"faceRetryButtonTransparency" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"faceRetryButtonBorderTransparency" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"faceConfirmButtonTransparency" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"faceConfirmButtonStyleTransparency" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"faceTextColorTransparency" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"faceInstContinueButtonTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"faceInstContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    
    //    [self saveSetting:@"faceTitleOnTop" value:[faceTitleTextField text]];
    //    [self saveSetting:@"faceHintMessageOnTop" value:[faceHintMsgTextField text]];
    //    [self saveSetting:@"faceHintIconOnTop" value:[faceHintIconTextField text]];
    //    [self saveSetting:@"faceTitleImageOnTop" value:[faceTitleImageTextField text]];
    [self saveSetting:@"faceTitleOnTop" value:[self getIdCaptureAlignment:[faceTitleTextField text] defaultValue:@"Bottom"]];
    [self saveSetting:@"faceHintMessageOnTop" value:[self getIdCaptureAlignment:[faceHintMsgTextField text] defaultValue:@"Top"]];
    [self saveSetting:@"faceHintIconOnTop" value:[self getIdCaptureAlignment:[faceHintIconTextField text] defaultValue:@"Top"]];
    [self saveSetting:@"faceTitleImageOnTop" value:[self getIdCaptureAlignment:[faceTitleImageTextField text] defaultValue:@"Top"]];
    
    [self saveSetting:@"faceHeaderTextSize" value:[headerSizeTextField text]];
    [self saveSetting:@"faceTextSize" value:[textSizeTextField text]];
    [self saveSetting:@"faceHeaderTextColor" value:[headerTextColorTextField text]];
    [self saveSetting:@"faceHeaderTextColorTransparency" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    
    NSString *hideFaceCapTitle, *hideFaceCaphintMsg, *hideFaceCaphintIcon,*hideFaceCapTitImage,*isPassiveFaceDetection;
    if(hideFaceTitle) {
        hideFaceCapTitle = @"Y";
    } else {
        hideFaceCapTitle = @"N";
    }
    
    if(hideFaceHintMessage) {
        hideFaceCaphintMsg = @"Y";
    } else {
        hideFaceCaphintMsg = @"N";
    }
    
    if(hideFaceCaphintIcon) {
        hideFaceCaphintIcon = @"Y";
    } else {
        hideFaceCaphintIcon = @"N";
    }
    
    if(hideFaceTitleImage) {
        hideFaceCapTitImage = @"Y";
    } else {
        hideFaceCapTitImage = @"N";
    }
    
    if(isPassiveFaceDetectionEnabled) {
        isPassiveFaceDetection = @"Y";
    } else {
        isPassiveFaceDetection = @"N";
    }
    
    [self saveSetting:@"passivefacedetectionMethod" value:isPassiveFaceDetection];
    
    [self saveSetting:@"hideFaceTitle" value:hideFaceCapTitle];
    [self saveSetting:@"hideFacehintMsg" value:hideFaceCaphintMsg];
    [self saveSetting:@"hideFacehintIcon" value:hideFaceCaphintIcon];
    [self saveSetting:@"hideFacetitleImage" value:hideFaceCapTitImage];
    
    bool hideIdTitle, hideIdHintMessage, hideIdTitleImage;
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideIdCaptureTitle" defaultValue:@"N"]]) {
        hideIdTitle = true;
    } else {
        hideIdTitle = false;
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideIdCaptureHintMsg" defaultValue:@"N"]]) {
        hideIdHintMessage = true;
    } else {
        hideIdHintMessage = false;
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideIdCaptureTitleImage" defaultValue:@"N"]]) {
        hideIdTitleImage = true;
    } else {
        hideIdTitleImage = false;
    }
    
    bool isFaceTitleOnTop, isFaceHintMsgOnTop, isFaceHintIconOnTop, isFaceTitleImageOnTop;
    
    if([@"Top" isEqualToString:[self retrieveSetting:@"faceTitleOnTop" defaultValue:@"Bottom"]]) {
        isFaceTitleOnTop = true;
    } else {
        isFaceTitleOnTop = false;
    }
    
    if([@"Top" isEqualToString:[self retrieveSetting:@"faceHintMessageOnTop" defaultValue:@"Top"]]) {
        isFaceHintMsgOnTop = true;
    } else {
        isFaceHintMsgOnTop = false;
    }
    
    if([@"Top" isEqualToString:[self retrieveSetting:@"faceHintIconOnTop" defaultValue:@"Top"]]) {
        isFaceHintIconOnTop = true;
    } else {
        isFaceHintIconOnTop = false;
    }
    
    if([@"Top" isEqualToString:[self retrieveSetting:@"faceTitleImageOnTop" defaultValue:@"Top"]]) {
        isFaceTitleImageOnTop = true;
    } else {
        isFaceTitleImageOnTop = false;
    }
    
//    [AppItSDK customizeUserInterface:self faceTitleOnTop:isFaceTitleOnTop hideFaceTitle:hideFaceTitle faceHintMessageOnTop:isFaceHintMsgOnTop hideFacehintMsg:hideFaceHintMessage faceHintIconOnTop:isFaceHintIconOnTop hideFacehintIcon:hideFaceHintIcon faceTitleImageOnTop:isFaceTitleImageOnTop hideFacetitleImage:hideFaceTitleImage idCaptureTitleAlignment:[self retrieveSetting:@"idCaptureTitleLabel" defaultValue:@"Top"] hideIDCaptureTitle:hideIdTitle idCaptureHintMsgAlignment:[self retrieveSetting:@"idCaptureHintMessage" defaultValue:@"Center"] hideIDCapturehintMsg:hideIdHintMessage idCaptureTitleImgAlignment:[self retrieveSetting:@"idCaptureTitleImage" defaultValue:@"Bottom"] hideIDCapturetitleImg:hideIdTitleImage];
    
    //Add Label Clicked
    [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
    
    [self configBtnClickMethod];
    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
    
    [lightThresholdTextField setText:[@(mFaceLowLightThreshold) stringValue]];
    [focusThresholdTextField setText:[@(mFaceFocusThresholde) stringValue]];
    [faceDetectionThresTextField setText:[@(mFaceDetectionPercentage) stringValue]];
    [faceDetectionThresTextField setText:[@(mFaceDetectionPercentage) stringValue]];
    [eyesOpenThreTextField setText:[@(mEyesOpenThresholdPercentage) stringValue]];
    [livelinessThresholdTextField setText:[@(mLivelinessFaceThresholdPercentage) stringValue]];
//    [faceDetectionThresTextField setText:[NSString stringWithFormat:@"%.02f",mFaceDetectionPercentage]];
    [maxImageSizeThreTextField setText:[@(mFaceMaxImageSize) stringValue]];
    [faceOutlineColorTextField setText:dFaceOutlineColor];
    [faceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedFaceOutlineColorTextField setText:dDetectedFaceOutlineColor];
    [detectedFaceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [outlineColorOfFaceOutlineTextField setText:dOutsideIdOutlineColor];
    [outlineColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [outlineDetectedColorOfFaceOutlineTextField setText:dDetectedOutsideFaceOutlineColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [backButtonTextField setText:dBackButtonColor];
    [backButtonTransTextField setText:[@(mAlpha) stringValue]];
    [textColorTextField setText:dTextColor];
    [textColorTransTextField setText:[@(mAlpha) stringValue]];
    [retryButtonTextField setText:dRetryButtonColor];
    [retryButtonTransTextField setText:[@(mAlpha) stringValue]];
    [retryButtonBorderTextField setText:dRetryButtonBorderColor];
    [retryButtonBorderTransTextField setText:[@(mAlpha) stringValue]];
    [confirmButtonTextField setText:dConfirmButtonColor];
    [confirmButtonTransTextField setText:[@(mAlpha) stringValue]];
    [confirmButtonStyleTextField setText:dConfirmButtonStyle];
    [confirmButtonStyleTransTextField setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextField setText:dInstContinueButtonColor];
    [instContinueButtonTransTextField setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextColorField setText:dInstContinueButtonTextColor];
    [instContinueButtonTransTextColorField setText:[@(mAlpha) stringValue]];
    [headerTextColorTextField setText:dTextColor];
    [headerTextColorTransTextField setText:[@(mAlpha) stringValue]];
    [headerSizeTextField setText:@""];
    [textSizeTextField setText:@""];
    
    [faceTitleTextField setText:[LabelUtils getLabelForKey:@"Bottom"]];
    [faceHintMsgTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [faceHintIconTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [faceTitleImageTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    hideFaceTitle = false;
    hideFaceHintMessage = false;
    hideFaceHintIcon = false;
    hideFaceTitleImage = false;
    [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                       forState:UIControlStateNormal];
    [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                         forState:UIControlStateNormal];
    [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                          forState:UIControlStateNormal];
    [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    
    [self saveSetting:@"facelightthreshold" value:[NSString stringWithFormat:@"%@", [@(mFaceLowLightThreshold) stringValue]]];
    [self saveSetting:@"facefocusthreshold" value:[NSString stringWithFormat:@"%@", [@(mFaceFocusThresholde) stringValue]]];
//    [self saveSetting:@"facedetectionthreshold" value:[NSString stringWithFormat:@"%@", [@(mFaceDetectionPercentage) stringValue]]];
    [self saveSetting:@"passivefacedetectionthreshold" value:[NSString stringWithFormat:@"%@",[@(mFaceDetectionPercentage) stringValue]]];
    [self saveSetting:@"eyesOpenthreshold" value:[NSString stringWithFormat:@"%@",[@(mEyesOpenThresholdPercentage) stringValue]]];
    [self saveSetting:@"livelinessFaceThreshold" value:[NSString stringWithFormat:@"%@",[@(mLivelinessFaceThresholdPercentage) stringValue]]];
   //  [self saveSetting:@"facedetectionthreshold" value:[NSString stringWithFormat:@"%@", [@(mFaceDetectionPercentage) stringValue]]];
    [self saveSetting:@"faceimagesize" value:[NSString stringWithFormat:@"%@", [@(mFaceMaxImageSize) stringValue]]];
    [self saveSetting:@"faceoutlinecolor" value:dFaceOutlineColor];
    [self saveSetting:@"detectedfaceoutlinecolor" value:dDetectedFaceOutlineColor];
    [self saveSetting:@"_outsideoutlinecolor" value:dOutsideIdOutlineColor];
    [self saveSetting:@"detectedfaceoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"faceoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"_outsideoutlinetransparency" value:[NSString stringWithFormat:@"%@", [@(mAlpha) stringValue]]];
    [self saveSetting:@"detectedfaceoutsideoutlinecolor" value:dDetectedOutsideFaceOutlineColor];
    [self saveSetting:@"detectedfaceoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%@",[@(mAlpha) stringValue]]];
    
    [self saveSetting:@"faceBackButton" value:[NSString stringWithFormat:@"%@", [backButtonTextField text]]];
    [self saveSetting:@"faceRetryButton" value:[NSString stringWithFormat:@"%@", [retryButtonTextField text]]];
    [self saveSetting:@"faceConfirmButton" value:[NSString stringWithFormat:@"%@", [confirmButtonTextField text]]];
    [self saveSetting:@"faceTextColor" value:[NSString stringWithFormat:@"%@", [textColorTextField text]]];
    [self saveSetting:@"faceInstContinueButton" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextField text]]];
    [self saveSetting:@"faceInstContinueButtonText" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextColorField text]]];
    
    [self saveSetting:@"faceBackButtonTransparency" value:[NSString stringWithFormat:@"%@",[backButtonTransTextField text]]];
    [self saveSetting:@"faceRetryButtonTransparency" value:[NSString stringWithFormat:@"%@",[retryButtonTransTextField text]]];
    [self saveSetting:@"faceConfirmButtonTransparency" value:[NSString stringWithFormat:@"%@",[confirmButtonTransTextField text]]];
    [self saveSetting:@"faceTextColorTransparency" value:[NSString stringWithFormat:@"%@",[textColorTransTextField text]]];
    [self saveSetting:@"faceInstContinueButtonTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextField text]]];
    [self saveSetting:@"faceInstContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextColorField text]]];
    
    [self saveSetting:@"faceTitleOnTop" value:[faceTitleTextField text]];
    [self saveSetting:@"faceHintMessageOnTop" value:[faceHintMsgTextField text]];
    [self saveSetting:@"faceHintIconOnTop" value:[faceHintIconTextField text]];
    [self saveSetting:@"faceTitleImageOnTop" value:[faceTitleImageTextField text]];
    
    [self saveSetting:@"passivefacedetectionMethod" value:@"Y"];
    [self saveSetting:@"hideFaceTitle" value:@"N"];
    [self saveSetting:@"hideFacehintMsg" value:@"N"];
    [self saveSetting:@"hideFacehintIcon" value:@"N"];
    [self saveSetting:@"hideFacetitleImage" value:@"N"];
    
    [self saveSetting:@"faceRetryButtonBorder" value:[retryButtonBorderTextField text]];
    [self saveSetting:@"faceConfirmButtonStyle" value:[confirmButtonStyleTextField text]];
    [self saveSetting:@"faceRetryButtonBorderTransparency" value:[NSString stringWithFormat:@"%@",[retryButtonBorderTransTextField text]]];
    [self saveSetting:@"faceConfirmButtonStyleTransparency" value:[NSString stringWithFormat:@"%@",[confirmButtonStyleTransTextField text]]];
    [self saveSetting:@"faceHeaderTextSize" value:[headerSizeTextField text]];
    [self saveSetting:@"faceTextSize" value:[textSizeTextField text]];
    [self saveSetting:@"faceHeaderTextColor" value:[headerTextColorTextField text]];
    [self saveSetting:@"faceHeaderTextColorTransparency" value:[NSString stringWithFormat:@"%@",headerTextColorTransTextField]];
    
    //Resetting the all labels value
    [englishLabels removeAllObjects];
    [spanishLabels removeAllObjects];
    [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
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
    [cameraClickBtn setImage:[UIImage imageNamed:@"Selfy_Capture.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*25, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*50, (width/100)*5)];
    
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
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*6);
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
    
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        // [self selfieCaptureAPICall];
        [self checkCameraPermission];
    }
}

-(void)captureBtn:(UIButton*)button {
    //[self selfieCaptureAPICall];
    [self checkCameraPermission];
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
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}
-(void)selfieCaptureAPICall{
    [ArrayObjectController setEnableCaptureEmployee:false];
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *lightThreshold = [lightThresholdTextField text];
    NSString *maxCapImageSize = [maxImageSizeThreTextField text];
    NSString *showInsScreen = (showInstructionScreen) ? @"Y" : @"N";
    NSString *fontStyle= [fontStyleTextField text];
    NSString *backButton= [backButtonTextField text];
    NSString *backButtonTrans= [backButtonTransTextField text];
    NSString *retryButton= [retryButtonTextField text];
    NSString *retryButtonTrans= [retryButtonTransTextField text];
    NSString *retryButtonBorder= [retryButtonBorderTextField text];
    NSString *retryButtonBorderTrans= [retryButtonBorderTransTextField text];
    NSString *confirmButton= [confirmButtonTextField text];
    NSString *confirmButtonTrans= [confirmButtonTransTextField text];
    NSString *confirmButtonStyle= [confirmButtonStyleTextField text];
    NSString *confirmButtonStyleTrans= [confirmButtonStyleTransTextField text];
    NSString *textColor= [textColorTextField text];
    NSString *textColorTrans= [textColorTransTextField text];
    NSString *instContinueButton= [instContinueButtonTextField text];
    NSString *instContinueButtonTrans= [instContinueButtonTransTextField text];
    NSString *instContinueButtonTextColor= [instContinueButtonTextColorField text];
    NSString *instContinueButtonTransTextColor= [instContinueButtonTransTextColorField text];
    NSString *focusThreshold= [focusThresholdTextField text];
    NSString *faceDetectionThreshold= [faceDetectionThresTextField text];
    NSString *eyesOpenThreshold = [eyesOpenThreTextField text];
    NSString *livelinessThreshold = [livelinessThresholdTextField text];
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
    NSString *isFaceDataUploadButton= isFaceDataUpload ? @"Y": @"N";
    NSString *isEnableBGRButton= isBGREnable ? @"Y": @"N";
    NSString *_isPassiveFaceDetectionEnabled= isPassiveFaceDetectionEnabled ? @"Y": @"N";
    NSString *showFacePreviewScreen = (showPreviewScreen) ? @"Y" : @"N";
    //NSString *faceContours= [faceContoursTextField text];
    NSString *faceContours=  [self getFaceContours:[faceContoursTextField text] defaultValue:@"Low"];
    NSString *headerFontStyle= [headerFontStyleTextField text];
    NSString *headerTextColor= [headerTextColorTextField text];
    NSString *headerTextColorTrans= [headerTextColorTransTextField text];
    NSString *headerSize= [headerSizeTextField text];
    NSString *textSize= [textSizeTextField text];
    // NSString *faceTitle = [faceTitleTextField text];
    NSString *faceTitle = [self getIdCaptureAlignment: [faceTitleTextField text] defaultValue:@"Bottom"];
    // NSString *faceMsg = [faceHintMsgTextField text];
    NSString *faceMsg = [self getIdCaptureAlignment: [faceHintMsgTextField text] defaultValue:@"Top"];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:lightThreshold]){
        [nsDict setObject:lightThreshold forKey:@"fd_light_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapImageSize]){
        [nsDict setObject:maxCapImageSize forKey:@"fd_max_image_size"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:toggleCameraButton]){
        [nsDict setObject:toggleCameraButton forKey:@"fd_toggle_camera"];
    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
//        [nsDict setObject:showInsScreen forKey:@"fd_show_instruction_screen"];
//    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:launchCamera]){
        [nsDict setObject:launchCamera forKey:@"fd_launch_front_camera"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:isFaceDataUploadButton]){
        [nsDict setObject:isFaceDataUploadButton forKey:@"fd_upload_facedata"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:isEnableBGRButton]){
        [nsDict setObject:isEnableBGRButton forKey:@"fd_enable_bgr"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:_isPassiveFaceDetectionEnabled]){
        [nsDict setObject:_isPassiveFaceDetectionEnabled forKey:@"fd_enable_passive_face_detection"];
    }
//    if(![NSStringUtils stringIsNilOrEmpty:showFacePreviewScreen]){
//        [nsDict setObject:showFacePreviewScreen forKey:@"fd_show_preview_screen"];
//    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:focusThreshold]){
        [nsDict setObject:focusThreshold forKey:@"fd_focus_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:faceDetectionThreshold]){
        [nsDict setObject:faceDetectionThreshold forKey:@"fd_detection_threshold"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:eyesOpenThreshold]){
        [nsDict setObject:eyesOpenThreshold forKey:@"fd_eye_open_threshold"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:livelinessThreshold]){
        [nsDict setObject:livelinessThreshold forKey:@"fd_Spoof_Detection_threshold"];
    }
    
    
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:fontStyle]){
//        [nsDict setObject:fontStyle forKey:@"style"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:backButton]){
//        [nsDict setObject:backButton forKey:@"backButtonColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:backButtonTrans]){
//        [nsDict setObject:backButtonTrans forKey:@"backButtonColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:retryButton]){
//        [nsDict setObject:retryButton forKey:@"retryButtonColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:retryButtonTrans]){
//        [nsDict setObject:retryButtonTrans forKey:@"retryButtonColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:retryButtonBorder]){
//        [nsDict setObject:retryButtonBorder forKey:@"retryButtonBorder"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:retryButtonBorderTrans]){
//        [nsDict setObject:retryButtonBorderTrans forKey:@"retryButtonBorderColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButton]){
//        [nsDict setObject:confirmButton forKey:@"confirmButtonColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButtonTrans]){
//        [nsDict setObject:confirmButtonTrans forKey:@"confirmButtonColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButtonStyle]){
//        [nsDict setObject:confirmButtonStyle forKey:@"confirmButtonStyle"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButtonStyleTrans]){
//        [nsDict setObject:confirmButtonStyleTrans forKey:@"confirmButtonStyleTrans"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:textColor]){
//        [nsDict setObject:textColor forKey:@"textLabelColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:textColorTrans]){
//        [nsDict setObject:textColorTrans forKey:@"textLabelAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButton]){
//        [nsDict setObject:instContinueButton forKey:@"instructionButtonColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTrans]){
//        [nsDict setObject:instContinueButtonTrans forKey:@"instructionButtonColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTextColor]){
//        [nsDict setObject:instContinueButtonTextColor forKey:@"instructionButtonTXTColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTransTextColor]){
//        [nsDict setObject:instContinueButtonTransTextColor forKey:@"instructionButtonTXTColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:faceOutlineColor]){
//        [nsDict setObject:faceOutlineColor forKey:@"faceOutlineHexColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:faceOutlineColorTrans]){
//        [nsDict setObject:faceOutlineColorTrans forKey:@"faceOutlineHexColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedFaceOutlineColor]){
//        [nsDict setObject:detectedFaceOutlineColor forKey:@"detectedFaceOutlineHexColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedFaceOutlineColorTrans]){
//        [nsDict setObject:detectedFaceOutlineColorTrans forKey:@"detectedFaceOutlineHexColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:outlineColorOfFaceOutline]){
//        [nsDict setObject:outlineColorOfFaceOutline forKey:@"outsideFaceOutlineColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:outlineColorOfFaceOutlineTrans]){
//        [nsDict setObject:outlineColorOfFaceOutlineTrans forKey:@"outsideFaceOutlineColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:outlineDetectedColorOfFaceOutline]){
//        [nsDict setObject:outlineDetectedColorOfFaceOutline forKey:@"detectedFaceOutsideColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:outlineDetectedColorOfFaceOutlineTrans]){
//        [nsDict setObject:outlineDetectedColorOfFaceOutlineTrans forKey:@"detectedFaceOutsideColorAlpha"];
//    }
//    if(![NSStringUtils stringIsNilOrEmpty:faceContours]){
//        [nsDict setObject:faceContours forKey:@"faceContours"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:headerFontStyle]){
//        [nsDict setObject:headerFontStyle forKey:@"headerFontStyle"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:headerTextColor]){
//        [nsDict setObject:headerTextColor forKey:@"headerTextColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:headerTextColorTrans]){
//        [nsDict setObject:headerTextColorTrans forKey:@"headerTextColorTransparency"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:headerSize]){
//        [nsDict setObject:headerSize forKey:@"headerTextSize"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:textSize]){
//        [nsDict setObject:textSize forKey:@"textSize"];
//    }
//
//    UIImage *titleImageFace;
//    //if([@"None" isEqualToString:[selectTitleImgTextField text]]) {
//    if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[selectTitleImgTextField text]]) {
//        titleImageFace = nil;
//    } else {
//        titleImageFace = [UIImage imageNamed:@"title_image"];
//    }
//    if([@"Top" isEqualToString:faceTitle]) {
//        [nsDict setObject:@"true" forKey:@"faceTitleOnTop"];
//    } else {
//        [nsDict setObject:@"false" forKey:@"faceTitleOnTop"];
//    }
//
//    if([@"Top" isEqualToString:faceMsg]) {
//        [nsDict setObject:@"true" forKey:@"faceHintMessageOnTop"];
//    } else {
//        [nsDict setObject:@"false" forKey:@"faceHintMessageOnTop"];
//    }
    
//    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] titleImageFace:titleImageFace instructionimage:nil uiConfigDictionary:nsDict];
    
//    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] faceCaptureConfig:nsDict];
    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] faceCaptureConfig:nsDict uiConfigDictionary:[ArrayObjectController getAdditionalDataDictionary]];
    
    //    [AppItSDK detectFace:[ArrayObjectController getPageDelegate] lowLightThreshold:[lightThresholdTextField.text intValue] focusPercentage:[focusThresholdTextField.text intValue] faceDetectionPercentage:[faceDetectionThresTextField.text intValue] ImageSize:[maxImageSizeThreTextField.text intValue] setFrontCameraDefault:launchFrontCamera showPreviewScreen:showPreviewScreen faceOutlineColor:[faceOutlineColorTextField text] faceOutlineTransparency:[faceOutlineColorTransTextField.text intValue] detectedFaceOutlineColor:[detectedFaceOutlineColorTextField text] detectedFaceOutlineTransparency:[detectedFaceOutlineColorTransTextField.text intValue] outsideFaceOutlineColor:[outlineColorOfFaceOutlineTextField text] outsideFaceOutlineTransparency:[outlineColorOfFaceOutlineTransTextField.text intValue] detectedOutsideFaceOutlineColor:[outlineDetectedColorOfFaceOutlineTextField text] detectedOutsideFaceOutlineColorTrans:[outlineDetectedColorOfFaceOutlineTransTextField.text intValue] titleImageFace:nil showInstruction:showInstructionScreen instructionimage:nil toggleCamera:toggleCamera];
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
    //[resultImage setImage:resImage];
    [self clearResultImages];
    if([@"5" isEqualToString:[result objectForKey:@"statusCode"]]) {
        [captureLabel setText:@"Live Face Not Detected"];
        [cameraClickBtn setHidden:YES];
    } else {
        [cameraClickBtn setHidden:NO];
        [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
        [self clearResultImages];
        NSString *face = [result objectForKey:@"FACE"];
        NSString *processedFace = [result objectForKey:@"PROCESSED_FACE"];
        NSString *ovalFace = [result objectForKey:@"OVAL_FACE"];
        [self add_face_image_in_result:@"FACE" faceValue:face];
        [self add_face_image_in_result:@"PROCESSED_FACE" faceValue:processedFace];
//        [self add_face_image_in_result:@"OVAL_FACE" faceValue:ovalFace];
        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
        [self refreshResultImageView];
        isCapture=false;
    }
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
            //[faceName setText:imageNameArray[tag]];
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

//Run time Permission Asking
-(void) checkCameraPermission {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        [self selfieCaptureAPICall];
    }
    else if(status == AVAuthorizationStatusDenied){ // denied
        if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                // Will get here on both iOS 7 & 8 even though camera permissions weren't required
                // until iOS 8. So for iOS 7 permission will always be granted.
                
                NSLog(@"DENIED");
                
                if (granted) {
                    // Permission has been granted. Use dispatch_async for any UI updating
                    // code because this block may be executed in a thread.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self selfieCaptureAPICall];
                    });
                } else {
                    NSLog(@"Not Authorized");
                    // Permission has been denied.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self snackBarView:@"Need to enable CAMERA permission."];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
                            if (canOpenSettings)
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        });
                    });
                }
            }];
        }
    }
    else if(status == AVAuthorizationStatusRestricted){ // restricted
        [self snackBarView:@"Need to enable CAMERA permission."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
            if (canOpenSettings)
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }
    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"camera authorized");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self selfieCaptureAPICall];
                });
            }
        }];
    }
}

//SnackBar
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

-(NSString*)getFontStyle:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *titleAlignment=defaultValue;
    if ([label isEqualToString:@"Default"]){
        titleAlignment=@"Default";
    }else if([label isEqualToString:@"Defecto"]){
        titleAlignment=@"Default";
    }else if([label isEqualToString:@"ပျက်ကွက်"]){
        titleAlignment=@"Default";
    }
    if ([label isEqualToString:@"Helvetica"]){
        titleAlignment=@"Helvetica";
    }else if([label isEqualToString:@"Helvética"]){
        titleAlignment=@"Helvetica";
    }
    if ([label isEqualToString:@"Helvetica Bold"]){
        titleAlignment=@"Helvetica Bold";
    }
    if ([label isEqualToString:@"Helvetica Bold Oblique"]){
        titleAlignment=@"Helvetica Bold Oblique";
    }
    if ([label isEqualToString:@"Helvetica Light"]){
        titleAlignment=@"Helvetica Light";
    }else if([label isEqualToString:@"Helvetica အလင်း"]){
        titleAlignment=@"Helvetica Light";
    }
    if ([label isEqualToString:@"Helvetica Light Oblique"]){
        titleAlignment=@"Helvetica Light Oblique";
    }else if([label isEqualToString:@"Helvetica Light Oblicua"]){
        titleAlignment=@"Helvetica Light Oblique";
    }else if([label isEqualToString:@"Helvetica အလင်း Oblique"]){
        titleAlignment=@"Helvetica Light Oblique";
    }
    if ([label isEqualToString:@"Helvetica Neue"]){
        titleAlignment=@"Helvetica Neue";
    }
    if ([label isEqualToString:@"Helvetica Neue Bold"]){
        titleAlignment=@"Helvetica Neue Bold";
    }
    if ([label isEqualToString:@"Helvetica Neue Bold Italic"]){
        titleAlignment=@"Helvetica Neue Bold Italic";
    }else if([label isEqualToString:@"Helvetica Neue Bold စာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue Bold Italic";
    }
    if ([label isEqualToString:@"Helvetica Neue Condensed Black"]){
        titleAlignment=@"Helvetica Neue Condensed Black";
    }else if([label isEqualToString:@"Helvetica Neue ဖိချုံ့က Black"]){
        titleAlignment=@"Helvetica Neue Condensed Black";
    }
    if ([label isEqualToString:@"Helvetica Neue Condensed Bold"]){
        titleAlignment=@"Helvetica Neue Condensed Bold";
    }else if([label isEqualToString:@"Helvetica Neue ဖိချုံ့ Bold"]){
        titleAlignment=@"Helvetica Neue Condensed Bold";
    }
    if ([label isEqualToString:@"Helvetica Neue Italic"]){
        titleAlignment=@"Helvetica Neue Italic";
    }else if([label isEqualToString:@"Helvetica Neue စာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue Italic";
    }
    if ([label isEqualToString:@"Helvetica Neue Light"]){
        titleAlignment=@"Helvetica Neue Light";
    }else if([label isEqualToString:@"Helvetica Neue အလင်း"]){
        titleAlignment=@"Helvetica Neue Light";
    }
    if ([label isEqualToString:@"Helvetica Neue Light Italic"]){
        titleAlignment=@"Helvetica Neue Light Italic";
    }else if([label isEqualToString:@"Helvetica Neue အလင်းစာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue Light Italic";
    }
    if ([label isEqualToString:@"Helvetica Neue Medium"]){
        titleAlignment=@"Helvetica Neue Medium";
    }else if([label isEqualToString:@"Helvetica Neue အလတ်စား"]){
        titleAlignment=@"Helvetica Neue Medium";
    }
    if ([label isEqualToString:@"Helvetica Neue Medium Italic"]){
        titleAlignment=@"Helvetica Neue Medium Italic";
    }else if([label isEqualToString:@"Helvetica Neue အလတ်စားစာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue Medium Italic";
    }
    if ([label isEqualToString:@"Helvetica Neue Thin"]){
        titleAlignment=@"Helvetica Neue Thin";
    }else if([label isEqualToString:@"Helvetica Neue ထူးအိမ်သင်"]){
        titleAlignment=@"Helvetica Neue Thin";
    }
    if ([label isEqualToString:@"Helvetica Neue Thin Italic"]){
        titleAlignment=@"Helvetica Neue Thin Italic";
    }else if([label isEqualToString:@"Helvetica Neue ထူးအိမ်သင်စာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue Thin Italic";
    }
    if ([label isEqualToString:@"Helvetica Neue UltraLight"]){
        titleAlignment=@"Helvetica Neue UltraLight";
    }
    if ([label isEqualToString:@"Helvetica Neue UltraLight Italic"]){
        titleAlignment=@"Helvetica Neue UltraLight Italic";
    }else if([label isEqualToString:@"Helvetica Neue UltraLight စာလုံးစောင်း"]){
        titleAlignment=@"Helvetica Neue UltraLight Italic";
    }
    if ([label isEqualToString:@"Helvetica Oblique"]){
        titleAlignment=@"Helvetica Oblique";
    }else if([label isEqualToString:@"Helvetica oblicua"]){
        titleAlignment=@"Helvetica oblicua";
    }
    return titleAlignment;
}

-(NSString*)getIdCaptureAlignment:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *titleAlignment=defaultValue;
    if ([label isEqualToString:@"Top"]){
        titleAlignment=@"Top";
    }else if([label isEqualToString:@"Parte superior"]){
        titleAlignment=@"Top";
    }else if([label isEqualToString:@"ထိပ်တန်း"]){
        titleAlignment=@"Top";
    }
    
    if ([label isEqualToString:@"Center"]){
        titleAlignment=@"Center";
    }else if([label isEqualToString:@"Centrar"]){
        titleAlignment=@"Center";
    }else if([label isEqualToString:@"အလယ်ဗဟို"]){
        titleAlignment=@"Center";
    }
    
    if ([label isEqualToString:@"Bottom"]){
        titleAlignment=@"Bottom";
    }else if([label isEqualToString:@"Fondo"]){
        titleAlignment=@"Bottom";
    }else if([label isEqualToString:@"အောကျခွေ"]){
        titleAlignment=@"Bottom";
    }
    
    return titleAlignment;
}

-(NSString*)getIdCaptureAlignmentAccordingLanguage:(NSString*)label{
    NSString *idAlignment;
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    if ([language isEqualToString:@"en"]){
        if ([label isEqualToString:@"Top"]){
            idAlignment=@"Top";
        }else if([label isEqualToString:@"Parte superior"]){
            idAlignment=@"Top";
        }else if([label isEqualToString:@"ထိပ်တန်း"]){
            idAlignment=@"Top";
        }
        
        if ([label isEqualToString:@"Center"]){
            idAlignment=@"Center";
        }else if([label isEqualToString:@"Centrar"]){
            idAlignment=@"Center";
        }else if([label isEqualToString:@"အလယ်ဗဟို"]){
            idAlignment=@"Center";
        }
        
        if ([label isEqualToString:@"Bottom"]){
            idAlignment=@"Bottom";
        }else if([label isEqualToString:@"Fondo"]){
            idAlignment=@"Bottom";
        }else if([label isEqualToString:@"အောကျခွေ"]){
            idAlignment=@"Bottom";
        }
    }else if ([language isEqualToString:@"es"]){
        if ([label isEqualToString:@"Top"]){
            idAlignment=@"Parte superior";
        }else if([label isEqualToString:@"Parte superior"]){
            idAlignment=@"Parte superior";
        }else if([label isEqualToString:@"ထိပ်တန်း"]){
            idAlignment=@"Parte superior";
        }
        
        if ([label isEqualToString:@"Center"]){
            idAlignment=@"Centrar";
        }else if([label isEqualToString:@"Centrar"]){
            idAlignment=@"Centrar";
        }else if([label isEqualToString:@"အလယ်ဗဟို"]){
            idAlignment=@"Centrar";
        }
        
        if ([label isEqualToString:@"Bottom"]){
            idAlignment=@"Fondo";
        }else if([label isEqualToString:@"Fondo"]){
            idAlignment=@"Fondo";
        }else if([label isEqualToString:@"အောကျခွေ"]){
            idAlignment=@"Fondo";
        }
    }else {
        if ([label isEqualToString:@"Top"]){
            idAlignment=@"ထိပ်တန်း";
        }else if([label isEqualToString:@"Parte superior"]){
            idAlignment=@"ထိပ်တန်း";
        }else if([label isEqualToString:@"ထိပ်တန်း"]){
            idAlignment=@"ထိပ်တန်း";
        }
        
        if ([label isEqualToString:@"Center"]){
            idAlignment=@"အလယ်ဗဟို";
        }else if([label isEqualToString:@"Centrar"]){
            idAlignment=@"အလယ်ဗဟို";
        }else if([label isEqualToString:@"အလယ်ဗဟို"]){
            idAlignment=@"အလယ်ဗဟို";
        }
        
        if ([label isEqualToString:@"Bottom"]){
            idAlignment=@"အောကျခွေ";
        }else if([label isEqualToString:@"Fondo"]){
            idAlignment=@"အောကျခွေ";
        }else if([label isEqualToString:@"အောကျခွေ"]){
            idAlignment=@"အောကျခွေ";
        }
    }
    
    return idAlignment;
}

-(NSString*)getIdCaptureBorder:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *idCaptureBorder=defaultValue;
    if ([label isEqualToString:@"Thick"]){
        idCaptureBorder=@"Thick";
    }else if([label isEqualToString:@"Gruesa"]){
        idCaptureBorder=@"Thick";
    }else if([label isEqualToString:@"ထူသော"]){
        idCaptureBorder=@"Thick";
    }
    
    if ([label isEqualToString:@"Thin"]){
        idCaptureBorder=@"Thin";
    }else if([label isEqualToString:@"delgada"]){
        idCaptureBorder=@"Thin";
    }else if([label isEqualToString:@"ပါးသော"]){
        idCaptureBorder=@"Thin";
    }
    
    return idCaptureBorder;
}

-(NSString*)getFaceContours:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *faceCountors=defaultValue;
    if ([label isEqualToString:@"Low"]){
        faceCountors=@"Low";
    }else if([label isEqualToString:@"Baja"]){
        faceCountors=@"Low";
    }else if([label isEqualToString:@"အနိမ့်"]){
        faceCountors=@"Low";
    }
    
    if ([label isEqualToString:@"Medium"]){
        faceCountors=@"Medium";
    }else if([label isEqualToString:@"Medio"]){
        faceCountors=@"Medium";
    }else if([label isEqualToString:@"အလယ်အလတ်"]){
        faceCountors=@"Center";
    }
    
    if ([label isEqualToString:@"Zero"]){
        faceCountors=@"Zero";
    }else if([label isEqualToString:@"Cero"]){
        faceCountors=@"Zero";
    }else if([label isEqualToString:@"သုည"]){
        faceCountors=@"Zero";
    }
    
    if ([label isEqualToString:@"All"]){
        faceCountors=@"All";
    }else if([label isEqualToString:@"Todas"]){
        faceCountors=@"All";
    }else if([label isEqualToString:@"အားလုံး"]){
        faceCountors=@"All";
    }
    
    return faceCountors;
}

-(NSString*)getFaceContoursAccordingLanguage:(NSString*)label{
    NSString *faceContours;
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    if ([language isEqualToString:@"en"]){
        if ([label isEqualToString:@"Low"]){
            faceContours=@"Low";
        }else if([label isEqualToString:@"Baja"]){
            faceContours=@"Low";
        }else if([label isEqualToString:@"အနိမ့်"]){
            faceContours=@"Low";
        }
        
        if ([label isEqualToString:@"Medium"]){
            faceContours=@"Medium";
        }else if([label isEqualToString:@"Medio"]){
            faceContours=@"Medium";
        }else if([label isEqualToString:@"အလယ်အလတ်"]){
            faceContours=@"Medium";
        }
        
        if ([label isEqualToString:@"Zero"]){
            faceContours=@"Bottom";
        }else if([label isEqualToString:@"Cero"]){
            faceContours=@"Bottom";
        }else if([label isEqualToString:@"သုည"]){
            faceContours=@"Bottom";
        }
        
        if ([label isEqualToString:@"All"]){
            faceContours=@"All";
        }else if([label isEqualToString:@"Todas"]){
            faceContours=@"All";
        }else if([label isEqualToString:@"အားလုံး"]){
            faceContours=@"All";
        }
    }else if ([language isEqualToString:@"es"]){
        if ([label isEqualToString:@"Low"]){
            faceContours=@"Baja";
        }else if([label isEqualToString:@"Baja"]){
            faceContours=@"Baja";
        }else if([label isEqualToString:@"အနိမ့်"]){
            faceContours=@"Baja";
        }
        
        if ([label isEqualToString:@"Medium"]){
            faceContours=@"Medio";
        }else if([label isEqualToString:@"Medio"]){
            faceContours=@"Medio";
        }else if([label isEqualToString:@"အလယ်အလတ်"]){
            faceContours=@"Medio";
        }
        
        if ([label isEqualToString:@"Zero"]){
            faceContours=@"Cero";
        }else if([label isEqualToString:@"Cero"]){
            faceContours=@"Cero";
        }else if([label isEqualToString:@"သုည"]){
            faceContours=@"Cero";
        }
        
        if ([label isEqualToString:@"All"]){
            faceContours=@"Todas";
        }else if([label isEqualToString:@"Todas"]){
            faceContours=@"Todas";
        }else if([label isEqualToString:@"အားလုံး"]){
            faceContours=@"Todas";
        }
    }else {
        if ([label isEqualToString:@"Low"]){
            faceContours=@"အနိမ့်";
        }else if([label isEqualToString:@"Baja"]){
            faceContours=@"အနိမ့်";
        }else if([label isEqualToString:@"အနိမ့်"]){
            faceContours=@"အနိမ့်";
        }
        
        if ([label isEqualToString:@"Medium"]){
            faceContours=@"အလယ်အလတ်";
        }else if([label isEqualToString:@"Medio"]){
            faceContours=@"အလယ်အလတ်";
        }else if([label isEqualToString:@"အလယ်အလတ်"]){
            faceContours=@"အလယ်အလတ်";
        }
        
        if ([label isEqualToString:@"Zero"]){
            faceContours=@"သုည";
        }else if([label isEqualToString:@"Cero"]){
            faceContours=@"သုည";
        }else if([label isEqualToString:@"သုည"]){
            faceContours=@"သုည";
        }
        
        if ([label isEqualToString:@"All"]){
            faceContours=@"အားလုံး";
        }else if([label isEqualToString:@"Todas"]){
            faceContours=@"အားလုံး";
        }else if([label isEqualToString:@"အားလုံး"]){
            faceContours=@"အားလုံး";
        }
    }
    
    return faceContours;
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
