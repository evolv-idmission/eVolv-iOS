//
//  IDCaptureBackController.m
//  AppItDepedency
//
//  Created by  on 10/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "IDCaptureBackController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "AppDelegate.h"
#import "FinalStepController.h"
#import "LabelUtils.h"

@interface IDCaptureBackController ()

@end

@implementation IDCaptureBackController {
    UILabel *titleLabel;
    UIButton *configurationButton;
    UIScrollView *scrollView, *snippetFieldScrollView;
    bool isVisible;
    
    int mAlpha;
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime, mbarcodeScanLimitValue, mMrzScanLimit, mMrzAndBarcodeScanLimit;
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dRetryButtonBorderColor, *dConfirmButtonColor, *dConfirmButtonStyle, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor;
    
    //TextField
    UITextField *idOutlineColorTextField, *idOutlineColorTransTextField, *detectedIdOutlineColorTextField, *detectedIdOutlineColorTransTextField, *colorOutsideOutlineTextField, *colorOutsideOutlineTransTextField, *detectedColorOutsideOutlineTextField, *detectedColorOutsideOutlineTransTextField, *lightThresholdTextField, *minFocusThreshold, *maxFocusThresholdTextField, *glarePercentageTextField, *enableCapBtnTimeTextField, *maxImageSize, *imageWidthTextField, *imageHeightTextField, *showTitleImgTextField,*backButtonTextField, *backButtonTransTextField, *retryButtonTextField, *retryButtonTransTextField, *confirmButtonTextField, *confirmButtonTransTextField, *fontStyleTextField, *textColorTextField, *textColorTransTextField, *instContinueButtonTextField, *instContinueButtonTransTextField, *instContinueButtonTextColorField, *instContinueButtonTransTextColorField, *idCaptureTitleTextField, *idCaptureHintMsgTextField, *idCapturetitleImageTextField,  *idCaptureLabelTextField, *englishLabelTextField, *spanishLabelTextField,
    *retryButtonBorderTextField, *retryButtonBorderTransTextField, *confirmButtonStyleTextField, *confirmButtonStyleTransTextField, *headerSizeTextField, *textSizeTextField, *headerFontStyleTextField, *headerTextColorTextField, *headerTextColorTransTextField, *idCaptureBorderLabelTextField, *barcodeScanLimitTextField, *mrzRetryCountTextField, *mrzBarcodeRetryCountTextField;
    
    //Configuration Radio Btn
    UIButton *portraitRadioBtn, *landscapeRadioBtn, *noInstRadioBtn, *yesInstRadioBtn, *idCaptureTitleCheckBox, *idCaptureHintMsgCheckBox, *idTitleImgCheckBox, *barcodeScanRadioButton,*exitConfigureViewBtn;
    
    //Bool
    bool isPortrait, showInstScreen, hideIdCaptureTitle, hideIdHintMessage, hideIdTitleImage, isCapture;
    
    NSArray *_selectedPickerData,*_selectedFontStylePickerData,*_selectedHeaderFontStylePickerData;
    NSArray *showTitlePickerData,*showFontStylePickerData,*showHeaderFontStylePickerData,*_idCaptreTitlePickerData, *_idCaptureHintMsgPickerData, *_idCaptureTitleImagePickerData, *_idCaptureLabelPickerData, *_idCaptureBorderLabelPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UIImageView *resultImage;
    UIButton *recaptureButton;
    
    UIImageView *downUPArrowImage ;
    NSMutableDictionary *englishLabels;
    NSMutableDictionary *spanishLabels;
    NSString *textFieldTypeForPicker;
    
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible, barcodeScan;
    UITextView *barcodeBoldData, *barcodeScorolledData;
    UIView *configureView;
}
//@synthesize labelLeft, labelRight;

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear call");
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    isSnackBarVisible = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    //showTitlePickerData = @[@"None", @"Title Image 1"];
    //_selectedPickerData = @[@"None", @"Title Image 1"];
    [showTitleImgTextField setDelegate:(id)self];
    [fontStyleTextField setDelegate:(id)self];
    [headerFontStyleTextField setDelegate:(id)self];
    [idCaptureTitleTextField setDelegate:(id)self];
    [idCaptureHintMsgTextField setDelegate:(id)self];
    [idCapturetitleImageTextField setDelegate:(id)self];
    [idCaptureLabelTextField setDelegate:(id)self];
    [idCaptureBorderLabelTextField setDelegate:(id)self];
    [mrzRetryCountTextField setDelegate:(id)self];
    [mrzBarcodeRetryCountTextField setDelegate:(id)self];
    
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [showTitleImgTextField setInputView:myPickerView];
    [showTitleImgTextField setText:showTitlePickerData[0]];
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setText:showFontStylePickerData[0]];
    [headerFontStyleTextField setInputView:myPickerView];
    [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
    [idCaptureTitleTextField setInputView:myPickerView];
    //[idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
    [idCaptureHintMsgTextField setInputView:myPickerView];
    //[idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
    [idCapturetitleImageTextField setInputView:myPickerView];
    //[idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
    [idCaptureLabelTextField setInputView:myPickerView];
    [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
    [idCaptureBorderLabelTextField setInputView:myPickerView];
    [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
    [recaptureButton setUserInteractionEnabled:YES];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    
    [showTitleImgTextField setInputView:myPickerView];
    [showTitleImgTextField setInputAccessoryView:toolbarForPicker];
    
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setInputAccessoryView:toolbarForPicker];
    
    [headerFontStyleTextField setInputView:myPickerView];
    [headerFontStyleTextField setInputAccessoryView:toolbarForPicker];
    
    [idCaptureTitleTextField setInputAccessoryView:toolbarForPicker];
    [idCaptureHintMsgTextField setInputAccessoryView:toolbarForPicker];
    [idCapturetitleImageTextField setInputAccessoryView:toolbarForPicker];
    [idCaptureLabelTextField setInputAccessoryView:toolbarForPicker];
    [idCaptureBorderLabelTextField setInputAccessoryView:toolbarForPicker];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [showTitleImgTextField resignFirstResponder];
    [fontStyleTextField resignFirstResponder];
    [headerFontStyleTextField resignFirstResponder];
    [idCaptureTitleTextField resignFirstResponder];
    [idCaptureHintMsgTextField resignFirstResponder];
    [idCapturetitleImageTextField resignFirstResponder];
    [idCaptureLabelTextField resignFirstResponder];
    [idCaptureBorderLabelTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    if (textField == showTitleImgTextField){
    //        _selectedPickerData = showTitlePickerData;
    //        [myPickerView reloadAllComponents];
    //    }else if (textField == fontStyleTextField){
    //        _selectedPickerData=showFontStylePickerData;
    //        [myPickerView reloadAllComponents];
    //    } else if (textField == idCaptureTitleTextField) {
    //        _selectedPickerData = _idCaptreTitlePickerData;
    //    } else if(textField == idCaptureHintMsgTextField) {
    //        _selectedPickerData = _idCaptureHintMsgPickerData;
    //    } else if(textField == idCapturetitleImageTextField) {
    //        _selectedPickerData = _idCaptureTitleImagePickerData;
    //    } else if(textField == idCaptureLabelTextField) {
    //        _selectedPickerData = _idCaptureLabelPickerData;
    //    }
    if (textField == showTitleImgTextField){
        textFieldTypeForPicker = @"selectTitleImgTextField";
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    }else if (textField == fontStyleTextField){
        textFieldTypeForPicker = @"fontStyleTextField";
        _selectedPickerData=showFontStylePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == idCaptureTitleTextField) {
        textFieldTypeForPicker = @"idTitleTextField";
        _selectedPickerData = _idCaptreTitlePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == idCaptureHintMsgTextField) {
        textFieldTypeForPicker = @"idHintMsgTextField";
        _selectedPickerData = _idCaptureHintMsgPickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == idCapturetitleImageTextField) {
        textFieldTypeForPicker = @"idTitleImageTextField";
        _selectedPickerData = _idCaptureTitleImagePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == idCaptureLabelTextField) {
        textFieldTypeForPicker = @"idLabelTextField";
        _selectedPickerData = _idCaptureLabelPickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == headerFontStyleTextField) {
        textFieldTypeForPicker = @"idHeaderFontStyleTextField";
        _selectedPickerData = showHeaderFontStylePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == idCaptureBorderLabelTextField) {
        textFieldTypeForPicker = @"idBorderLabelTextField";
        _selectedPickerData = _idCaptureBorderLabelPickerData;
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
        [showTitleImgTextField setText:showTitlePickerData[row]];
        [showTitleImgTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"fontStyleTextField"]){
        [fontStyleTextField setText:showFontStylePickerData[row]];
        [fontStyleTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idTitleTextField"]) {
        [idCaptureTitleTextField setText:_idCaptreTitlePickerData[row]];
        [idCaptureTitleTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idHintMsgTextField"]) {
        [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[row]];
        [idCaptureHintMsgTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idTitleImageTextField"]) {
        [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[row]];
        [idCapturetitleImageTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idLabelTextField"]) {
        [idCaptureLabelTextField setText:_idCaptureLabelPickerData[row]];
        [idCaptureLabelTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idHeaderFontStyleTextField"]) {
        [headerFontStyleTextField setText:showHeaderFontStylePickerData[row]];
        [headerFontStyleTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"idBorderLabelTextField"]) {
        [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[row]];
        [idCaptureBorderLabelTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    
    showTitlePickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    _selectedPickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    
    showFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"],[LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    _selectedFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    showHeaderFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    // _idCaptreTitlePickerData = @[@"Top", @"Center", @"Bottom"];
    _idCaptreTitlePickerData = @[[LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Center"], [LabelUtils getLabelForKey:@"Bottom"]];
    // _idCaptureHintMsgPickerData = @[@"Center", @"Bottom", @"Top"];
    _idCaptureHintMsgPickerData = @[[LabelUtils getLabelForKey:@"Center"], [LabelUtils getLabelForKey:@"Bottom"], [LabelUtils getLabelForKey:@"Top"]];
    // _idCaptureTitleImagePickerData = @[@"Bottom", @"Top", @"Center"];
    _idCaptureTitleImagePickerData = @[[LabelUtils getLabelForKey:@"Bottom"], [LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Center"]];
    _idCaptureLabelPickerData = @[@"align_document_img_capture", @"subject_is_too_dark_img_capture", @"out_of_focus_img_capture", @"too_much_glare_img_capture", @"light", @"focus", @"glare", @"page_title_image_capture"];
    //_idCaptureBorderLabelPickerData = @[@"Thick", @"Thin"];
    _idCaptureBorderLabelPickerData = @[[LabelUtils getLabelForKey:@"thick"], [LabelUtils getLabelForKey:@"thin"]];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    isVisible = false;
    isPortrait = true;
    //showInstScreen = false;
    showInstScreen = true;
    isCapture = true;
    
    mAlpha = 1;
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60, mbarcodeScanLimitValue=5, mMrzScanLimit = 5, mMrzAndBarcodeScanLimit = 5;
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95",
    dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dRetryButtonBorderColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dConfirmButtonStyle=@"FFFFFF", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95";
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    // [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"IDCaptureBack"]];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"capture_id_back_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    titleLabel.numberOfLines = 2;
    //[self setWrapUILabel:titleLabel];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    [self initUI];
    
    //Configuration Changes
    configurationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [configurationButton setBackgroundColor:[UIColor grayColor]];
    //    configurationButton.frame = CGRectMake(0, height - (height/100)*8 - 76, width, (height/100)*8);
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
    
    //    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height - 76 - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    //Add numeric keyboard-Start
    [idOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedIdOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [colorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedColorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [minFocusThreshold setKeyboardType:UIKeyboardTypeNumberPad];
    [glarePercentageTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [enableCapBtnTimeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [barcodeScanLimitTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [maxImageSize setKeyboardType:UIKeyboardTypeNumberPad];
    [imageWidthTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [imageHeightTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [headerSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [mrzRetryCountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [mrzBarcodeRetryCountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *lightthreshold = [self retrieveSetting:@"lightthreshold_Back" defaultValue:[@(mLightThreshold) stringValue]];
    NSString *minfocusthreshold = [self retrieveSetting:@"focusthreshold_Back" defaultValue:[@(mFocusThreshold) stringValue]];
    NSString *maxfocusthreshold = [self retrieveSetting:@"maxfocusthreshold_Back" defaultValue:[@(maxFocusThreshold) stringValue]];
    NSString *glarepercentage = [self retrieveSetting:@"glarepercentage_Back" defaultValue:[@(mGlarePercentage) stringValue]];
    NSString *capturebuttontime = [self retrieveSetting:@"capturebuttontime_Back" defaultValue:[@(mCaptureButtonTime) stringValue]];
    NSString *barcodeScanLimit_NSString = [self retrieveSetting:@"barcodeScanLimit_Back" defaultValue:[@(mbarcodeScanLimitValue) stringValue]];
    NSString *mrzScanLimit_NSString = [self retrieveSetting:@"mrzScanLimit_Back" defaultValue:[@(mMrzScanLimit) stringValue]];
    NSString *mrzAndBarcodeScanLimit_NSString = [self retrieveSetting:@"mrzAndbarcodeScanLimit_Back" defaultValue:[@(mMrzAndBarcodeScanLimit) stringValue]];
    NSString *maximagesize = [self retrieveSetting:@"maximagesize_Back" defaultValue:[@(mMaxImageSize) stringValue]];
    NSString *imageheight = [self retrieveSetting:@"imageheight_Back" defaultValue:[@(mImageHeight) stringValue]];
    NSString *imagewidth = [self retrieveSetting:@"imagewidth_Back" defaultValue:[@(mImageWidth) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    
    if([hideIdCaptureTitleString isEqualToString:@"Y"]) {
        hideIdCaptureTitle  = true;
        [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
    } else {
        hideIdCaptureTitle = false;
        [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
    
    if([hideIdCaptureHintMsgString isEqualToString:@"Y"]) {
        hideIdHintMessage = true;
        [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                  forState:UIControlStateNormal];
    } else {
        hideIdHintMessage = false;
        [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                  forState:UIControlStateNormal];
    }
    
    if([hideIdCaptureTitleImgString isEqualToString:@"Y"]) {
        hideIdTitleImage = true;
        [idTitleImgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                            forState:UIControlStateNormal];
    } else {
        hideIdTitleImage = false;
        [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    }
    
    [idCaptureTitleTextField setText:idCaptureTitleLabelString];
    [idCaptureHintMsgTextField setText:idCaptureHintMessageString];
    [idCapturetitleImageTextField setText:idCaptureTitleImageString];
    
    [idOutlineColorTextField setText:idoutlinecolor];
    [idOutlineColorTransTextField setText:idoutlinetransparency];
    [detectedIdOutlineColorTextField setText:detectedIdOutlineColor];
    [detectedIdOutlineColorTransTextField setText:detectedIdOutlineTrans];
    [colorOutsideOutlineTextField setText:colorOutsideOutline];
    [colorOutsideOutlineTransTextField setText:colorOutsideOutlineTrans];
    [detectedColorOutsideOutlineTextField setText:detectedidcolorOutsideOutline];
    [detectedColorOutsideOutlineTransTextField setText:detectedidcolorOutsideOutlineTransparency];
    [lightThresholdTextField setText:lightthreshold];
    [minFocusThreshold setText:minfocusthreshold];
    [maxFocusThresholdTextField setText:maxfocusthreshold];
    [glarePercentageTextField setText:glarepercentage];
    [enableCapBtnTimeTextField setText:capturebuttontime];
    [barcodeScanLimitTextField setText:barcodeScanLimit_NSString];
    [mrzRetryCountTextField setText:mrzScanLimit_NSString];
    [mrzBarcodeRetryCountTextField setText:mrzAndBarcodeScanLimit_NSString];
    [maxImageSize setText:maximagesize];
    [imageWidthTextField setText:imagewidth];
    [imageHeightTextField setText:imageheight];
    //[showTitleImgTextField setText:@"None"];
    [showTitleImgTextField setText:[LabelUtils getLabelForKey:@"none"]];
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
        
        if(nil != key && [key isEqualToString:@"MRZData_MRZ"]) {
            obj = [self unEsacpeXML:obj];
        }
        
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
        [barcodeDataLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [barcodeDataLabel setText:@"Extracted Data:"];
        [barcodeDataLabel setTextAlignment:NSTextAlignmentLeft];
        [scrollView addSubview:barcodeDataLabel];
        
        keyName = [[UILabel alloc] initWithFrame:CGRectMake(0, barcodeDataLabel.frame.origin.y + barcodeDataLabel.frame.size.height + (height/100)*2, (width/100)*50, (height/100)*10)];
        
    } else {
        keyName = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollY, (width/100)*50, (height/100)*10)];
    }
    
    
    
    // GroupNAme
    
    [keyName setText:fieldType];
    [keyName setFont:[UIFont systemFontOfSize:12]];
    keyName.numberOfLines = 0;
    [keyName setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:keyName];
    
    UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(keyName.frame.origin.x + keyName.frame.size.width , keyName.frame.origin.y, (width/100)*50, (height/100)*10)];
    [valueName setText:valueType];
    [valueName setFont:[UIFont systemFontOfSize:12]];
    valueName.numberOfLines = 0;
    [valueName setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:valueName];
    
    UIView *addLineView = [[UIView alloc] initWithFrame:CGRectMake(0, keyName.frame.origin.y + keyName.frame.size.height + (width/100)*5, width, (width/100)*0.2)];
    [scrollView addSubview:addLineView];
    
    return (addLineView.frame.origin.y + addLineView.frame.size.height);
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
    //Id Outline color
    UILabel *idOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*0,(width/100)*44, (height/100)*0)];
    [idOutLineColorLabel setText:[LabelUtils getLabelForKey:@"id_outline_color"]];
    [idOutLineColorLabel setAlpha:0.7];
    [idOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    idOutLineColorLabel.numberOfLines = 0;
    idOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutLineColorLabel setHidden: YES];
    idOutLineColorLabel.hidden = YES;
    [scrollView addSubview:idOutLineColorLabel];
    
    //Id Outline Color Transparency
    UILabel *idOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*0, (width/100)*44, (height/100)*0)];
    [idOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [idOutlineTransLabel setAlpha:0.7];
    idOutlineTransLabel.numberOfLines = 0;
    idOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [idOutlineTransLabel setHidden: YES];
    idOutlineTransLabel.hidden = YES;
    [scrollView addSubview:idOutlineTransLabel];
    
    //id outline color TextField
    idOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idOutLineColorLabel.frame.origin.y + idOutLineColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    idOutlineColorTextField.layer.cornerRadius = 5;
    idOutlineColorTextField.layer.borderWidth = 1.0;
    idOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTextField setAlpha:0.7];
    [idOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idOutlineColorTextField setHidden: YES];
    idOutlineColorTextField.hidden = YES;
    [scrollView addSubview:idOutlineColorTextField];
    
    //id outline color Trans TextField
    idOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, idOutlineColorTextField.frame.origin.y * 0, idOutlineTransLabel.frame.size.width, (height/100)*0)];
    [idOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]]; idOutlineColorTransTextField.layer.cornerRadius = 5;
    idOutlineColorTransTextField.layer.borderWidth = 1.0;
    idOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTransTextField setAlpha:0.7];
    [idOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idOutlineColorTransTextField setHidden: YES];
    idOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:idOutlineColorTransTextField];
    
    //Detected ID Outline Color
    //Detected Id outline Color Label
    UILabel *detectedIdOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idOutlineColorTextField.frame.origin.y + idOutlineColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutLineColorLabel setText:[LabelUtils getLabelForKey:@"detected_id_outline_color"]];
    [detectedIdOutLineColorLabel setAlpha:0.7];
    [detectedIdOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedIdOutLineColorLabel.numberOfLines = 0;
    detectedIdOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutLineColorLabel setHidden: YES];
    detectedIdOutLineColorLabel.hidden = YES;
    [scrollView addSubview:detectedIdOutLineColorLabel];
    
    //Detected Id Outline Color Transparency
    UILabel *detectedIdOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idOutlineColorTransTextField.frame.origin.y + idOutlineColorTransTextField.frame.size.height +  (height/100)*0, idOutlineColorTransTextField.frame.size.width, (height/100)*0)];
    [detectedIdOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedIdOutlineTransLabel setAlpha:0.7];
    detectedIdOutlineTransLabel.numberOfLines = 0;
    detectedIdOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedIdOutlineTransLabel setHidden: YES];
    detectedIdOutlineTransLabel.hidden = YES;
    [scrollView addSubview:detectedIdOutlineTransLabel];
    
    //Detected Id outline Color text field
    detectedIdOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedIdOutLineColorLabel.frame.origin.y + detectedIdOutLineColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTextField setAlpha:0.7];
    [detectedIdOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedIdOutlineColorTextField setHidden: YES];
    detectedIdOutlineColorTextField.hidden = YES;
    [scrollView addSubview:detectedIdOutlineColorTextField];
    
    //Detected Id outline Color Transparency
    detectedIdOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedIdOutlineTransLabel.frame.origin.y + detectedIdOutlineTransLabel.frame.size.height + (height/100)*0, detectedIdOutlineTransLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTransTextField setAlpha:0.7];
    [detectedIdOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedIdOutlineColorTransTextField setHidden: YES];
    detectedIdOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:detectedIdOutlineColorTransTextField];
    
    //Color OutsideOutline
    //Color Outside Outline Label
    UILabel *colorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedIdOutlineColorTextField.frame.origin.y + detectedIdOutlineColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"color_outside_outline"]];
    [colorOutsideOutLineLabel setAlpha:0.7];
    [colorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    colorOutsideOutLineLabel.numberOfLines = 0;
    colorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutLineLabel setHidden: YES];
    colorOutsideOutLineLabel.hidden = YES;
    [scrollView addSubview:colorOutsideOutLineLabel];
    
    //Color Outside Outline Transparency
    UILabel *colorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedIdOutlineColorTransTextField.frame.origin.y + detectedIdOutlineColorTransTextField.frame.size.height +  (height/100)*0, idOutlineColorTransTextField.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [colorOutsideOutlineTransLabel setAlpha:0.7];
    colorOutsideOutlineTransLabel.numberOfLines = 0;
    colorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [colorOutsideOutlineTransLabel setHidden: YES];
    colorOutsideOutlineTransLabel.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTransLabel];
    
    //Color Outside Outline TextField
    colorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, colorOutsideOutLineLabel.frame.origin.y + colorOutsideOutLineLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTextField setAlpha:0.7];
    [colorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [colorOutsideOutlineTextField setHidden: YES];
    colorOutsideOutlineTextField.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTextField];
    
    //Color Outside Outline Transparency TextField
    colorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, colorOutsideOutlineTransLabel.frame.origin.y + colorOutsideOutlineTransLabel.frame.size.height + (height/100)*0, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTransTextField setAlpha:0.7];
    [colorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [colorOutsideOutlineTransTextField setHidden: YES];
    colorOutsideOutlineTransTextField.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTransTextField];
    
    //Detected Color Outside OutLine
    //Detected Color OutSide OutLine Label
    UILabel *detectedColorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,colorOutsideOutlineTextField.frame.origin.y + colorOutsideOutlineTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"detected_color_outside_outline"]];
    [detectedColorOutsideOutLineLabel setAlpha:0.7];
    [detectedColorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    detectedColorOutsideOutLineLabel.numberOfLines = 0;
    detectedColorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedColorOutsideOutLineLabel setHidden: YES];
    detectedColorOutsideOutLineLabel.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutLineLabel];
    
    //Detected Color Outside Outline Transparency
    UILabel *detectedcolorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,colorOutsideOutlineTransTextField.frame.origin.y + colorOutsideOutlineTransTextField.frame.size.height +  (height/100)*0, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*0)];
    [detectedcolorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedcolorOutsideOutlineTransLabel setAlpha:0.7];
    detectedcolorOutsideOutlineTransLabel.numberOfLines = 0;
    detectedcolorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedcolorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedcolorOutsideOutlineTransLabel setHidden: YES];
    detectedcolorOutsideOutlineTransLabel.hidden = YES;
    [scrollView addSubview:detectedcolorOutsideOutlineTransLabel];
    
    //Detected Color Outside Outline TextField
    detectedColorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedColorOutsideOutLineLabel.frame.origin.y + detectedColorOutsideOutLineLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedColorOutsideOutlineTextField setHidden: YES];
    detectedColorOutsideOutlineTextField.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutlineTextField];
    
    //Detected Color Outside Outline Trans TextField
    detectedColorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedColorOutsideOutlineTextField.frame.origin.y*0, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTransTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedColorOutsideOutlineTransTextField setHidden: YES];
    detectedColorOutsideOutlineTransTextField.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutlineTransTextField];
    
    //Light Threshold
    //Light Threshold Label
    UILabel *lightThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedColorOutsideOutlineTextField.frame.origin.y + detectedColorOutsideOutlineTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [lightThresholdLabel setText:[LabelUtils getLabelForKey:@"light_threshold"]];
    [lightThresholdLabel setAlpha:0.7];
    [lightThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    lightThresholdLabel.numberOfLines = 0;
    lightThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:lightThresholdLabel];
    
    //Light Threshold Transparency
    UILabel *lightThresholdTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedColorOutsideOutlineTransTextField.frame.origin.y + detectedColorOutsideOutlineTransTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [lightThresholdTransLabel setText:[LabelUtils getLabelForKey:@"min_focus_threshold"]];
    [lightThresholdTransLabel setAlpha:0.7];
    lightThresholdTransLabel.numberOfLines = 0;
    lightThresholdTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [lightThresholdTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:lightThresholdTransLabel];
    
    //Light Threshold Text Field
    lightThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, lightThresholdLabel.frame.origin.y + lightThresholdLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [lightThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    lightThresholdTextField.layer.cornerRadius = 5;
    lightThresholdTextField.layer.borderWidth = 1.0;
    lightThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [lightThresholdTextField setAlpha:0.7];
    [lightThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    lightThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:lightThresholdTextField];
    
    //Light Threshold Trans Text Field
    minFocusThreshold = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, lightThresholdTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [minFocusThreshold setFont:[UIFont systemFontOfSize:12]];
    minFocusThreshold.layer.cornerRadius = 5;
    minFocusThreshold.layer.borderWidth = 1.0;
    minFocusThreshold.layer.borderColor = [[UIColor grayColor]CGColor];
    [minFocusThreshold setAlpha:0.7];
    [scrollView addSubview:minFocusThreshold];
    
    //Max.Focus Threshold
    //Max Focus Threshold Label
    UILabel *maxFocusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,lightThresholdTextField.frame.origin.y + lightThresholdTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [maxFocusThresholdLabel setText:[LabelUtils getLabelForKey:@"max_focus_threshold"]];
    [maxFocusThresholdLabel setAlpha:0.7];
    [maxFocusThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    maxFocusThresholdLabel.numberOfLines = 0;
    maxFocusThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:maxFocusThresholdLabel];
    
    //Max Focus Threshold Trans
    UILabel *maxFocusThresholdTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,minFocusThreshold.frame.origin.y + minFocusThreshold.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [maxFocusThresholdTransLabel setText:[LabelUtils getLabelForKey:@"glare_percentage"]];
    [maxFocusThresholdTransLabel setAlpha:0.7];
    maxFocusThresholdTransLabel.numberOfLines = 0;
    maxFocusThresholdTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxFocusThresholdTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxFocusThresholdTransLabel];
    
    //Max Focus Threshold TextField
    maxFocusThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, maxFocusThresholdLabel.frame.origin.y + maxFocusThresholdLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [maxFocusThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    maxFocusThresholdTextField.layer.cornerRadius = 5;
    maxFocusThresholdTextField.layer.borderWidth = 1.0;
    maxFocusThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxFocusThresholdTextField setAlpha:0.7];
    [maxFocusThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    maxFocusThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:maxFocusThresholdTextField];
    
    //Max Focus Threshold Trans TextField
    glarePercentageTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, maxFocusThresholdTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [glarePercentageTextField setFont:[UIFont systemFontOfSize:12]];
    glarePercentageTextField.layer.cornerRadius = 5;
    glarePercentageTextField.layer.borderWidth = 1.0;
    glarePercentageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [glarePercentageTextField setAlpha:0.7];
    [glarePercentageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    glarePercentageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:glarePercentageTextField];
    
    //Enable Capture Button
    //Enable Capture Button Label
    UILabel *enableCaptureButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,maxFocusThresholdTextField.frame.origin.y + maxFocusThresholdTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*5)];
    [enableCaptureButtonLabel setText:[LabelUtils getLabelForKey:@"enable_capture_button_time"]];
    [enableCaptureButtonLabel setAlpha:0.7];
    [enableCaptureButtonLabel setFont:[UIFont systemFontOfSize:11]];
    enableCaptureButtonLabel.numberOfLines = 0;
    enableCaptureButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:enableCaptureButtonLabel];
    
    //Max button Size label
    UILabel *maxButtonSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,glarePercentageTextField.frame.origin.y + glarePercentageTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [maxButtonSizeLabel setText:[LabelUtils getLabelForKey:@"max_image_size"]];
    [maxButtonSizeLabel setAlpha:0.7];
    maxButtonSizeLabel.numberOfLines = 0;
    maxButtonSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxButtonSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxButtonSizeLabel];
    
    //Enable Capture Button Time TextField
    enableCapBtnTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, enableCaptureButtonLabel.frame.origin.y + enableCaptureButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [enableCapBtnTimeTextField setFont:[UIFont systemFontOfSize:12]];
    enableCapBtnTimeTextField.layer.cornerRadius = 5;
    enableCapBtnTimeTextField.layer.borderWidth = 1.0;
    enableCapBtnTimeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [enableCapBtnTimeTextField setAlpha:0.7];
    [enableCapBtnTimeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    enableCapBtnTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:enableCapBtnTimeTextField];
    
    //Max Button Size TextField
    maxImageSize = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, enableCapBtnTimeTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [maxImageSize setFont:[UIFont systemFontOfSize:12]];
    maxImageSize.layer.cornerRadius = 5;
    maxImageSize.layer.borderWidth = 1.0;
    maxImageSize.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxImageSize setAlpha:0.7];
    [scrollView addSubview:maxImageSize];
    
    //Image Height/Width
    //Image Width label
    UILabel *imageWidthLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,enableCapBtnTimeTextField.frame.origin.y + enableCapBtnTimeTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [imageWidthLabel setText:[LabelUtils getLabelForKey:@"image_width"]];
    [imageWidthLabel setAlpha:0.7];
    [imageWidthLabel setFont:[UIFont systemFontOfSize:11]];
    imageWidthLabel.numberOfLines = 0;
    imageWidthLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:imageWidthLabel];
    
    //Image Height Label
    UILabel *imageHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,maxImageSize.frame.origin.y + maxImageSize.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [imageHeightLabel setText:[LabelUtils getLabelForKey:@"image_height"]];
    [imageHeightLabel setAlpha:0.7];
    imageHeightLabel.numberOfLines = 0;
    imageHeightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [imageHeightLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:imageHeightLabel];
    
    //Image Width TextField
    imageWidthTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, imageWidthLabel.frame.origin.y + imageWidthLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [imageWidthTextField setFont:[UIFont systemFontOfSize:12]];
    imageWidthTextField.layer.cornerRadius = 5;
    imageWidthTextField.layer.borderWidth = 1.0;
    imageWidthTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [imageWidthTextField setAlpha:0.7];
    [imageWidthTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    imageWidthTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:imageWidthTextField];
    
    //Image Height TextField
    imageHeightTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, imageWidthTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [imageHeightTextField setFont:[UIFont systemFontOfSize:12]];
    imageHeightTextField.layer.cornerRadius = 5;
    imageHeightTextField.layer.borderWidth = 1.0;
    imageHeightTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [imageHeightTextField setAlpha:0.7];
    [imageHeightTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    imageHeightTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:imageHeightTextField];
    
    //Text/Header Size
    //Header Size label
    UILabel *headerTextSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,imageWidthTextField.frame.origin.y + imageWidthTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [headerTextSizeLabel setText:[LabelUtils getLabelForKey:@"header_text_label_size"]];
    [headerTextSizeLabel setAlpha:0.7];
    [headerTextSizeLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextSizeLabel.numberOfLines = 0;
    headerTextSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextSizeLabel setHidden: YES];
    headerTextSizeLabel.hidden = YES;
    [scrollView addSubview:headerTextSizeLabel];
    
    //Text Size Label
    UILabel *textSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,imageHeightTextField.frame.origin.y + imageHeightTextField.frame.size.height +  (height/100)*0, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*0)];
    [textSizeLabel setText:[LabelUtils getLabelForKey:@"text_label_size"]];
    [textSizeLabel setAlpha:0.7];
    textSizeLabel.numberOfLines = 0;
    textSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [textSizeLabel setHidden: YES];
    textSizeLabel.hidden = YES;
    [scrollView addSubview:textSizeLabel];
    
    //Header size TextField
    headerSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, headerTextSizeLabel.frame.origin.y + headerTextSizeLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    textSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, headerSizeTextField.frame.origin.y*0, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerSizeTextField.frame.origin.y + headerSizeTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textFontStyleLabel setHidden: YES];
    textFontStyleLabel.hidden = YES;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(idOutLineColorLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
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
    UILabel *headerFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [headerFontStyleLabel setText:[LabelUtils getLabelForKey:@"header_text_font_style"]];
    [headerFontStyleLabel setAlpha:0.7];
    [headerFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    headerFontStyleLabel.numberOfLines = 0;
    headerFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerFontStyleLabel setHidden: YES];
    headerFontStyleLabel.hidden = YES;
    [scrollView addSubview:headerFontStyleLabel];
    
    //Font Style TextField
    headerFontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(idOutLineColorLabel.frame.origin.x, headerFontStyleLabel.frame.origin.y + headerFontStyleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
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
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorLabel setHidden: YES];
    textColorLabel.hidden = YES;
    [scrollView addSubview:textColorLabel];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [textColorLabel setHidden: YES];
    textColorLabel.hidden = YES;
    [scrollView addSubview:textColorTransLabel];
    
    //Text Color TextField
    textColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    textColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, textColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*0, textColorTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *headerTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,textColorTextField.frame.origin.y + textColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [headerTextColorLabel setText:[LabelUtils getLabelForKey:@"header_text_label_color"]];
    [headerTextColorLabel setAlpha:0.7];
    [headerTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextColorLabel.numberOfLines = 0;
    headerTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorLabel setHidden: YES];
    headerTextColorLabel.hidden = YES;
    [scrollView addSubview:headerTextColorLabel];
    
    //Transparency Label
    UILabel *headerTextColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,textColorTransTextField.frame.origin.y + textColorTransTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [headerTextColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [headerTextColorTransLabel setAlpha:0.7];
    headerTextColorTransLabel.numberOfLines = 0;
    headerTextColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [headerTextColorTransLabel setHidden: YES];
    headerTextColorTransLabel.hidden = YES;
    [scrollView addSubview:headerTextColorTransLabel];
    
    //Header Text Color TextField
    headerTextColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, headerTextColorLabel.frame.origin.y + headerTextColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    headerTextColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, headerTextColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*0, headerTextColorTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *backButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerTextColorTextField.frame.origin.y + headerTextColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [backButtonLabel setText:[LabelUtils getLabelForKey:@"back_button_color"]];
    [backButtonLabel setAlpha:0.7];
    [backButtonLabel setFont:[UIFont systemFontOfSize:11]];
    backButtonLabel.numberOfLines = 0;
    backButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonLabel setHidden: YES];
    backButtonLabel.hidden = YES;
    [scrollView addSubview:backButtonLabel];
    
    //Transparency Label
    UILabel *backButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,headerTextColorTransTextField.frame.origin.y + headerTextColorTransTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [backButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backButtonTransLabel setAlpha:0.7];
    backButtonTransLabel.numberOfLines = 0;
    backButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    //backButtonTransLabel.keyboardType = UIKeyboardTypeNumberPad;
    [backButtonTransLabel setHidden: YES];
    backButtonTransLabel.hidden = YES;
    [scrollView addSubview:backButtonTransLabel];
    
    //Back Button TextField
    backButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, backButtonLabel.frame.origin.y + backButtonLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    backButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, backButtonTransLabel.frame.origin.y + backButtonTransLabel.frame.size.height + (height/100)*0, backButtonTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *retryButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,backButtonTextField.frame.origin.y + backButtonTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [retryButtonLabel setText:[LabelUtils getLabelForKey:@"retry_button_color"]];
    [retryButtonLabel setAlpha:0.7];
    [retryButtonLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonLabel.numberOfLines = 0;
    retryButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonLabel setHidden: YES];
    retryButtonLabel.hidden = YES;
    [scrollView addSubview:retryButtonLabel];
    
    //Transparency Label
    UILabel *retryButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,backButtonTransTextField.frame.origin.y + backButtonTransTextField.frame.size.height +  (height/100)*0, backButtonTransTextField.frame.size.width, (height/100)*0)];
    [retryButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonTransLabel setAlpha:0.7];
    retryButtonTransLabel.numberOfLines = 0;
    retryButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [retryButtonTransLabel setHidden: YES];
    retryButtonTransLabel.hidden = YES;
    [scrollView addSubview:retryButtonTransLabel];
    
    //Retry Button TextField
    retryButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, retryButtonLabel.frame.origin.y + retryButtonLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    retryButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, retryButtonTransLabel.frame.origin.y + retryButtonTransLabel.frame.size.height + (height/100)*0, retryButtonTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *retryButtonBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [retryButtonBorderLabel setText:[LabelUtils getLabelForKey:@"retry_button_border_color"]];
    [retryButtonBorderLabel setAlpha:0.7];
    [retryButtonBorderLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonBorderLabel.numberOfLines = 0;
    retryButtonBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderLabel setHidden: YES];
    retryButtonBorderLabel.hidden = YES;
    [scrollView addSubview:retryButtonBorderLabel];
    
    //Transparency Label
    UILabel *retryButtonBorderTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +  (height/100)*0, retryButtonTransTextField.frame.size.width, (height/100)*0)];
    [retryButtonBorderTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonBorderTransLabel setAlpha:0.7];
    retryButtonBorderTransLabel.numberOfLines = 0;
    retryButtonBorderTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderTransLabel setFont:[UIFont systemFontOfSize:11]];
    [retryButtonBorderTransLabel setHidden: YES];
    retryButtonBorderTransLabel.hidden = YES;
    [scrollView addSubview:retryButtonBorderTransLabel];
    
    //Retry Button Border TextField
    retryButtonBorderTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, retryButtonBorderLabel.frame.origin.y + retryButtonBorderLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [retryButtonBorderTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTextField.layer.cornerRadius = 5;
    retryButtonBorderTextField.layer.borderWidth = 1.0;
    retryButtonBorderTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTextField setAlpha:0.7];
    [retryButtonBorderTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTextField.borderStyle = UITextBorderStyleRoundedRect;
    [retryButtonBorderTextField setHidden: YES];
    retryButtonBorderTextField.hidden = YES;
    [scrollView addSubview:retryButtonBorderTextField];
    
    //Transparency TextField
    retryButtonBorderTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, retryButtonBorderTransLabel.frame.origin.y + retryButtonBorderTransLabel.frame.size.height + (height/100)*0, retryButtonBorderTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *confirmButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [confirmButtonLabel setText:[LabelUtils getLabelForKey:@"confirm_button_color"]];
    [confirmButtonLabel setAlpha:0.7];
    [confirmButtonLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonLabel.numberOfLines = 0;
    confirmButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonLabel setHidden: YES];
    confirmButtonLabel.hidden = YES;
    [scrollView addSubview:confirmButtonLabel];
    
    //Transparency Label
    UILabel *confirmButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +  (height/100)*0, retryButtonBorderTextField.frame.size.width, (height/100)*0)];
    [confirmButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonTransLabel setAlpha:0.7];
    confirmButtonTransLabel.numberOfLines = 0;
    confirmButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [confirmButtonTransLabel setHidden: YES];
    confirmButtonTransLabel.hidden = YES;
    [scrollView addSubview:confirmButtonTransLabel];
    
    //Confirm Button TextField
    confirmButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, confirmButtonLabel.frame.origin.y + confirmButtonLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    confirmButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, confirmButtonTransLabel.frame.origin.y + confirmButtonTransLabel.frame.size.height + (height/100)*0, confirmButtonTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *confirmButtonStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [confirmButtonStyleLabel setText:[LabelUtils getLabelForKey:@"confirm_button_style"]];
    [confirmButtonStyleLabel setAlpha:0.7];
    [confirmButtonStyleLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonStyleLabel.numberOfLines = 0;
    confirmButtonStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleLabel setHidden: YES];
    confirmButtonStyleLabel.hidden = YES;
    [scrollView addSubview:confirmButtonStyleLabel];
    
    //Transparency Label
    UILabel *confirmButtonStyleTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +  (height/100)*0, confirmButtonTextField.frame.size.width, (height/100)*0)];
    [confirmButtonStyleTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonStyleTransLabel setAlpha:0.7];
    confirmButtonStyleTransLabel.numberOfLines = 0;
    confirmButtonStyleTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleTransLabel setFont:[UIFont systemFontOfSize:11]];
    [confirmButtonStyleTransLabel setHidden: YES];
    confirmButtonStyleTransLabel.hidden = YES;
    [scrollView addSubview:confirmButtonStyleTransLabel];
    
    //Confirm Button TextField
    confirmButtonStyleTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, confirmButtonStyleLabel.frame.origin.y + confirmButtonStyleLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    confirmButtonStyleTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, confirmButtonStyleTransLabel.frame.origin.y + confirmButtonStyleTransLabel.frame.size.height + (height/100)*0, confirmButtonStyleTransLabel.frame.size.width, (height/100)*0)];
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
    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,confirmButtonStyleTextField.frame.origin.y + confirmButtonStyleTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
    [continueButtonLabel setAlpha:0.7];
    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonLabel.numberOfLines = 0;
    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonLabel setHidden: YES];
    continueButtonLabel.hidden = YES;
    [scrollView addSubview:continueButtonLabel];
    
    //Transparency Label
    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,confirmButtonStyleTransTextField.frame.origin.y + confirmButtonStyleTransTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransLabel setAlpha:0.7];
    continueButtonTransLabel.numberOfLines = 0;
    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [continueButtonTransLabel setHidden: YES];
    continueButtonTransLabel.hidden = YES;
    [scrollView addSubview:continueButtonTransLabel];
    
    //continue Button TextField
    instContinueButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    instContinueButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,instContinueButtonTextField.frame.origin.y + instContinueButtonTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
    [continueButtonTextColorLabel setAlpha:0.7];
    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonTextColorLabel.numberOfLines = 0;
    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTextColorLabel setHidden: YES];
    continueButtonTextColorLabel.hidden = YES;
    [scrollView addSubview:continueButtonTextColorLabel];
    
    //Transparency Label
    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransTextColorLabel setAlpha:0.7];
    continueButtonTransTextColorLabel.numberOfLines = 0;
    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    [continueButtonTransTextColorLabel setHidden: YES];
    continueButtonTransTextColorLabel.hidden = YES;
    [scrollView addSubview:continueButtonTransTextColorLabel];
    
    //Continue Button text color TextField
    instContinueButtonTextColorField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    instContinueButtonTransTextColorField= [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    
    //ID Capture Border
    UILabel *idCaptureBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,instContinueButtonTextColorField.frame.origin.y + instContinueButtonTextColorField.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idCaptureBorderLabel setText:[LabelUtils getLabelForKey:@"id_capture_border"]];
    [idCaptureBorderLabel setAlpha:0.7];
    [idCaptureBorderLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureBorderLabel.numberOfLines = 0;
    idCaptureBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idCaptureBorderLabel setHidden: YES];
    idCaptureBorderLabel.hidden = YES;
    [scrollView addSubview:idCaptureBorderLabel];
    
    idCaptureBorderLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureBorderLabel.frame.origin.y + idCaptureBorderLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [idCaptureBorderLabelTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureBorderLabelTextField.layer.cornerRadius = 5;
    idCaptureBorderLabelTextField.layer.borderWidth = 1.0;
    idCaptureBorderLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureBorderLabelTextField setAlpha:0.7];
    [idCaptureBorderLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureBorderLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idCaptureBorderLabelTextField setHidden: YES];
    idCaptureBorderLabelTextField.hidden = YES;
    [scrollView addSubview:idCaptureBorderLabelTextField];
    
    UIImageView *idCaptureBorderLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureBorderLabelTextField.frame.origin.x + idCaptureBorderLabelTextField.frame.size.width - (width/100)*9 , idCaptureBorderLabelTextField.frame.origin.y + (idCaptureBorderLabelTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [idCaptureBorderLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [idCaptureBorderLabelDownArrowImage setHidden: YES];
    idCaptureBorderLabelDownArrowImage.hidden = YES;
    [scrollView addSubview:idCaptureBorderLabelDownArrowImage];
    //
    
    //Orientation
    //Default Orientation Label
    UILabel *defaultOrientationLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureBorderLabelTextField.frame.origin.y + idCaptureBorderLabelTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [defaultOrientationLabel setText:[LabelUtils getLabelForKey:@"default_orientation"]];
    [defaultOrientationLabel setAlpha:0.7];
    [defaultOrientationLabel setFont:[UIFont systemFontOfSize:11]];
    defaultOrientationLabel.numberOfLines = 0;
    defaultOrientationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:defaultOrientationLabel];
    
    //Portrait Radio Btn
    portraitRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    portraitRadioBtn.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, defaultOrientationLabel.frame.origin.y + defaultOrientationLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                      forState:UIControlStateNormal];
    [portraitRadioBtn addTarget:self action:@selector(portraitBtnChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:portraitRadioBtn];
    
    
    //Portrait Label
    UILabel *portraitLabel = [[UILabel alloc] initWithFrame:CGRectMake(portraitRadioBtn.frame.origin.x + portraitRadioBtn.frame.size.width + (width/100)*2, portraitRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [portraitLabel setText:[LabelUtils getLabelForKey:@"portrait"]];
    [portraitLabel setAlpha:0.7];
    [portraitLabel setFont:[UIFont systemFontOfSize:14]];
    portraitLabel.numberOfLines = 0;
    portraitLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:portraitLabel];
    
    //LandScape Radio Button
    landscapeRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    landscapeRadioBtn.frame = CGRectMake(portraitLabel.frame.origin.x + portraitLabel.frame.size.width + (width/100)*2, defaultOrientationLabel.frame.origin.y + defaultOrientationLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                       forState:UIControlStateNormal];
    [landscapeRadioBtn addTarget:self action:@selector(landscapeBtnChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:landscapeRadioBtn];
    
    //Landscape Label
    UILabel *landscapeLabel = [[UILabel alloc] initWithFrame:CGRectMake(landscapeRadioBtn.frame.origin.x + landscapeRadioBtn.frame.size.width + (width/100)*2, landscapeRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [landscapeLabel setText:[LabelUtils getLabelForKey:@"landscape"]];
    [landscapeLabel setAlpha:0.7];
    [landscapeLabel setFont:[UIFont systemFontOfSize:14]];
    landscapeLabel.numberOfLines = 0;
    landscapeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:landscapeLabel];
    
    //Barcode FallBack
    UILabel *barcodeScanLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, portraitRadioBtn.frame.origin.y + portraitRadioBtn.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    //    [barcodeScanLimitLabel setText:[LabelUtils getLabelForKey:@"image_width"]];
    [barcodeScanLimitLabel setText:@"Barcode Scan Limit"];
    [barcodeScanLimitLabel setAlpha:0.7];
    [barcodeScanLimitLabel setFont:[UIFont systemFontOfSize:11]];
    barcodeScanLimitLabel.numberOfLines = 0;
    barcodeScanLimitLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:barcodeScanLimitLabel];
    
    //Image Width TextField
    barcodeScanLimitTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, barcodeScanLimitLabel.frame.origin.y + barcodeScanLimitLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [barcodeScanLimitTextField setFont:[UIFont systemFontOfSize:12]];
    barcodeScanLimitTextField.layer.cornerRadius = 5;
    barcodeScanLimitTextField.layer.borderWidth = 1.0;
    barcodeScanLimitTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [barcodeScanLimitTextField setAlpha:0.7];
    [barcodeScanLimitTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    barcodeScanLimitTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:barcodeScanLimitTextField];
    
     //mrxRetryount
    UILabel *mrzRetryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, barcodeScanLimitLabel.frame.origin.y, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [mrzRetryCountLabel setText:[LabelUtils getLabelForKey:@"mrz_retry_count"]];
    [mrzRetryCountLabel setAlpha:0.7];
    [mrzRetryCountLabel setFont:[UIFont systemFontOfSize:11]];
    mrzRetryCountLabel.numberOfLines = 0;
    mrzRetryCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mrzRetryCountLabel];
    
    mrzRetryCountTextField = [[UITextField alloc] initWithFrame:CGRectMake(mrzRetryCountLabel.frame.origin.x, mrzRetryCountLabel.frame.origin.y + mrzRetryCountLabel.frame.size.height + (height/100)*1, barcodeScanLimitTextField.frame.size.width, (height/100)*4)];
    [mrzRetryCountTextField setFont:[UIFont systemFontOfSize:12]];
    mrzRetryCountTextField.layer.cornerRadius = 5;
    mrzRetryCountTextField.layer.borderWidth = 1.0;
    mrzRetryCountTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [mrzRetryCountTextField setAlpha:0.7];
    [mrzRetryCountTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    mrzRetryCountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:mrzRetryCountTextField];
    
    //MRZ and Barcode Retry Count
    UILabel *mrzBarcodeRetryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,barcodeScanLimitTextField.frame.origin.y + barcodeScanLimitTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [mrzBarcodeRetryCountLabel setText:[LabelUtils getLabelForKey:@"mrz_barcode_retry_count"]];
    [mrzBarcodeRetryCountLabel setAlpha:0.7];
    [mrzBarcodeRetryCountLabel setFont:[UIFont systemFontOfSize:11]];
    mrzBarcodeRetryCountLabel.numberOfLines = 0;
    mrzBarcodeRetryCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mrzBarcodeRetryCountLabel];
    
     mrzBarcodeRetryCountTextField = [[UITextField alloc] initWithFrame:CGRectMake(mrzBarcodeRetryCountLabel.frame.origin.x, mrzBarcodeRetryCountLabel.frame.origin.y + mrzBarcodeRetryCountLabel.frame.size.height + (height/100)*1, barcodeScanLimitTextField.frame.size.width, (height/100)*4)];
    [mrzBarcodeRetryCountTextField setFont:[UIFont systemFontOfSize:12]];
    mrzBarcodeRetryCountTextField.layer.cornerRadius = 5;
    mrzBarcodeRetryCountTextField.layer.borderWidth = 1.0;
    mrzBarcodeRetryCountTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [mrzBarcodeRetryCountTextField setAlpha:0.7];
    [mrzBarcodeRetryCountTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    mrzBarcodeRetryCountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:mrzBarcodeRetryCountTextField];
    
    //BarcodeScan Radio Button
    barcodeScanRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barcodeScanRadioButton.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, portraitRadioBtn.frame.origin.y + portraitRadioBtn.frame.size.height + (height/100)*2, (width/100)*7, (height/100)*4);
    [barcodeScanRadioButton setImage:[UIImage imageNamed:@"uncheck.png"]
                       forState:UIControlStateNormal];
    [barcodeScanRadioButton addTarget:self action:@selector(barcodeScanBtnChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:barcodeScanRadioButton];
    [barcodeScanRadioButton setHidden:YES];
    
    //Barcode Scan Label
    UILabel *barcodeScanLabel = [[UILabel alloc] initWithFrame:CGRectMake(barcodeScanRadioButton.frame.origin.x + barcodeScanRadioButton.frame.size.width + (width/100)*2, barcodeScanRadioButton.frame.origin.y, (width/100)*25, (height/100)*4)];
    [barcodeScanLabel setText:@"Barcode Scan"];
    [barcodeScanLabel setAlpha:0.7];
    [barcodeScanLabel setFont:[UIFont systemFontOfSize:14]];
    barcodeScanLabel.numberOfLines = 0;
    barcodeScanLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:barcodeScanLabel];
    [barcodeScanLabel setHidden:YES];
    
    //Show Instruction Screen
    //Show Instruction Screen Label
    UILabel *instructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,portraitRadioBtn.frame.origin.y + portraitRadioBtn.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [instructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [instructionScreenLabel setAlpha:0.7];
    [instructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
    instructionScreenLabel.numberOfLines = 0;
    instructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:instructionScreenLabel];
    [instructionScreenLabel setHidden:YES];
    
    //NoRadio Button
    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noInstRadioBtn.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, instructionScreenLabel.frame.origin.y + instructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                    forState:UIControlStateNormal];
    //    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
    //                    forState:UIControlStateNormal];
    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noInstRadioBtn];
    [noInstRadioBtn setHidden:YES];
    
    //No Label
    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [noInstLabel setAlpha:0.7];
    [noInstLabel setFont:[UIFont systemFontOfSize:14]];
    noInstLabel.numberOfLines = 0;
    noInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:noInstLabel];
    [noInstLabel setHidden:YES];
    
    //YesRadio Button
    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*7, (height/100)*4);
    //[yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
    //                 forState:UIControlStateNormal];
    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                     forState:UIControlStateNormal];
    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:yesInstRadioBtn];
    [yesInstRadioBtn setHidden:YES];
    
    //Yes Label
    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width + (width/100)*2, yesInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [yesInstLabel setAlpha:0.7];
    [yesInstLabel setFont:[UIFont systemFontOfSize:14]];
    yesInstLabel.numberOfLines = 0;
    yesInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:yesInstLabel];
    [yesInstLabel setHidden:YES];
    
    //Show Title Image
    UILabel *showTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,noInstRadioBtn.frame.origin.y + noInstRadioBtn.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [showTitleLabel setText:[LabelUtils getLabelForKey:@"show_title_image"]];
    [showTitleLabel setAlpha:0.7];
    [showTitleLabel setFont:[UIFont systemFontOfSize:11]];
    showTitleLabel.numberOfLines = 0;
    showTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showTitleLabel setHidden: YES];
    showTitleLabel.hidden = YES;
    [scrollView addSubview:showTitleLabel];
    
    //Show title Image Edit Spinner
    showTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, showTitleLabel.frame.origin.y + showTitleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [showTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    showTitleImgTextField.layer.cornerRadius = 5;
    showTitleImgTextField.layer.borderWidth = 1.0;
    showTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [showTitleImgTextField setAlpha:0.7];
    [showTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    showTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [showTitleImgTextField setHidden: YES];
    showTitleImgTextField.hidden = YES;
    [scrollView addSubview:showTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(showTitleImgTextField.frame.origin.x + showTitleImgTextField.frame.size.width - (width/100)*9 , showTitleImgTextField.frame.origin.y + (showTitleImgTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [downArrowImage setHidden: YES];
    downArrowImage.hidden = YES;
    [scrollView addSubview:downArrowImage];
    
    //IdCaptureTitleLabel
    UILabel *idCaptureTitleLAbel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,showTitleImgTextField.frame.origin.y + showTitleImgTextField.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idCaptureTitleLAbel setText:[LabelUtils getLabelForKey:@"id_capture_title_alignment"]];
    [idCaptureTitleLAbel setAlpha:0.7];
    [idCaptureTitleLAbel setFont:[UIFont systemFontOfSize:11]];
    idCaptureTitleLAbel.numberOfLines = 0;
    idCaptureTitleLAbel.lineBreakMode = NSLineBreakByWordWrapping;
    [idCaptureTitleLAbel setHidden: YES];
    idCaptureTitleLAbel.hidden = YES;
    [scrollView addSubview:idCaptureTitleLAbel];
    
    idCaptureTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureTitleLAbel.frame.origin.y + idCaptureTitleLAbel.frame.size.height + (height/100)*0, idCaptureTitleLAbel.frame.size.width, (height/100)*0)];
    [idCaptureTitleTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureTitleTextField.layer.cornerRadius = 5;
    idCaptureTitleTextField.layer.borderWidth = 1.0;
    idCaptureTitleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureTitleTextField setAlpha:0.7];
    [idCaptureTitleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCaptureTitleTextField.keyboardType = UIKeyboardTypeNumberPad;
    [idCaptureTitleTextField setHidden: YES];
    idCaptureTitleTextField.hidden = YES;
    [scrollView addSubview:idCaptureTitleTextField];
    
    UIImageView *idCaptureTitleDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureTitleTextField.frame.origin.x + idCaptureTitleTextField.frame.size.width - (width/100)*9 , idCaptureTitleTextField.frame.origin.y + (idCaptureTitleTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [idCaptureTitleDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureTitleDownArrowImage];
    
    idCaptureTitleCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idCaptureTitleCheckBox.frame = CGRectMake(idCaptureTitleTextField.frame.origin.x + idCaptureTitleTextField.frame.size.width + (width/100)*2, idCaptureTitleTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [idCaptureTitleCheckBox addTarget:self action:@selector(idCaptureTitleChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [idCaptureTitleCheckBox setHidden: YES];
    idCaptureTitleCheckBox.hidden = YES;
    [scrollView addSubview:idCaptureTitleCheckBox];
    
    UILabel *hideIdCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(idCaptureTitleCheckBox.frame.origin.x + idCaptureTitleCheckBox.frame.size.width + (width/100)*2, idCaptureTitleCheckBox.frame.origin.y*0, idCaptureTitleTextField.frame.size.width, (height/100)*0)];
    [hideIdCaptureLabel setText:[LabelUtils getLabelForKey:@"hide_id_capture_title"]];
    [hideIdCaptureLabel setAlpha:0.7];
    [hideIdCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureLabel.numberOfLines = 0;
    hideIdCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideIdCaptureLabel setHidden: YES];
    hideIdCaptureLabel.hidden = YES;
    [scrollView addSubview:hideIdCaptureLabel];
    
    //IdCaptureHintMsgAlignmentLabel
    UILabel *idCaptureHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureTitleTextField.frame.origin.y + idCaptureTitleTextField.frame.size.height + (height/100)*0, self.view.frame.size.width, (height/100)*0)];
    [idCaptureHintMsgLabel setText:[LabelUtils getLabelForKey:@"id_capture_hint_message_alignment"]];
    [idCaptureHintMsgLabel setAlpha:0.7];
    [idCaptureHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureHintMsgLabel.numberOfLines = 0;
    idCaptureHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idCaptureHintMsgLabel setHidden: YES];
    idCaptureHintMsgLabel.hidden = YES;
    [scrollView addSubview:idCaptureHintMsgLabel];
    
    idCaptureHintMsgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureHintMsgLabel.frame.origin.y + idCaptureHintMsgLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idCaptureHintMsgTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureHintMsgTextField.layer.cornerRadius = 5;
    idCaptureHintMsgTextField.layer.borderWidth = 1.0;
    idCaptureHintMsgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureHintMsgTextField setAlpha:0.7];
    [idCaptureHintMsgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureHintMsgTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCaptureHintMsgTextField.keyboardType = UIKeyboardTypeNumberPad;
    [idCaptureHintMsgTextField setHidden: YES];
    idCaptureHintMsgTextField.hidden = YES;
    [scrollView addSubview:idCaptureHintMsgTextField];
    
    UIImageView *idCaptureHintMsgDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureHintMsgTextField.frame.origin.x + idCaptureHintMsgTextField.frame.size.width - (width/100)*9 , idCaptureHintMsgTextField.frame.origin.y + (idCaptureHintMsgTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [idCaptureHintMsgDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureHintMsgDownArrowImage];
    
    idCaptureHintMsgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idCaptureHintMsgCheckBox.frame = CGRectMake(idCaptureHintMsgTextField.frame.origin.x + idCaptureHintMsgTextField.frame.size.width + (width/100)*2, idCaptureHintMsgTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    [idCaptureHintMsgCheckBox addTarget:self action:@selector(idCaptureHintMessageChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [idCaptureHintMsgCheckBox setHidden: YES];
    idCaptureHintMsgCheckBox.hidden = YES;
    [scrollView addSubview:idCaptureHintMsgCheckBox];
    
    UILabel *hideIdCaptureHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idCaptureHintMsgCheckBox.frame.origin.x + idCaptureHintMsgCheckBox.frame.size.width + (width/100)*2, idCaptureHintMsgCheckBox.frame.origin.y*0, idCaptureTitleTextField.frame.size.width, (height/100)*0)];
    [hideIdCaptureHintMsgLabel setText:[LabelUtils getLabelForKey:@"hide_id_hint_message"]];
    [hideIdCaptureHintMsgLabel setAlpha:0.7];
    [hideIdCaptureHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureHintMsgLabel.numberOfLines = 0;
    hideIdCaptureHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideIdCaptureHintMsgLabel setHidden: YES];
    hideIdCaptureHintMsgLabel.hidden = YES;
    [scrollView addSubview:hideIdCaptureHintMsgLabel];
    
    //IdCaptureTitleImageAlignment
    UILabel *idCaptureTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureHintMsgTextField.frame.origin.y + idCaptureHintMsgTextField.frame.size.height + (height/100)*0, self.view.frame.size.width, (height/100)*0)];
    [idCaptureTitleImageLabel setText:[LabelUtils getLabelForKey:@"id_capture_title_image_alignment"]];
    [idCaptureTitleImageLabel setAlpha:0.7];
    [idCaptureTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureTitleImageLabel.numberOfLines = 0;
    idCaptureTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idCaptureTitleImageLabel setHidden: YES];
    idCaptureTitleImageLabel.hidden = YES;
    [scrollView addSubview:idCaptureTitleImageLabel];
    
    idCapturetitleImageTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureTitleImageLabel.frame.origin.y + idCaptureTitleImageLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idCapturetitleImageTextField setFont:[UIFont systemFontOfSize:12]];
    idCapturetitleImageTextField.layer.cornerRadius = 5;
    idCapturetitleImageTextField.layer.borderWidth = 1.0;
    idCapturetitleImageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCapturetitleImageTextField setAlpha:0.7];
    [idCapturetitleImageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCapturetitleImageTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCapturetitleImageTextField.keyboardType = UIKeyboardTypeNumberPad;
    [idCapturetitleImageTextField setHidden: YES];
    idCapturetitleImageTextField.hidden = YES;
    [scrollView addSubview:idCapturetitleImageTextField];
    
    UIImageView *idCaptureTitleImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCapturetitleImageTextField.frame.origin.x + idCapturetitleImageTextField.frame.size.width - (width/100)*9 , idCapturetitleImageTextField.frame.origin.y + (idCapturetitleImageTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [idCaptureTitleImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [idCaptureTitleImageDownArrowImage setHidden: YES];
    idCaptureTitleImageDownArrowImage.hidden = YES;
    [scrollView addSubview:idCaptureTitleImageDownArrowImage];
    
    idTitleImgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idTitleImgCheckBox.frame = CGRectMake(idCapturetitleImageTextField.frame.origin.x + idCapturetitleImageTextField.frame.size.width + (width/100)*2, idCapturetitleImageTextField.frame.origin.y*0, (width/100)*7, (height/100)*0);
    [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                        forState:UIControlStateNormal];
    [idTitleImgCheckBox addTarget:self action:@selector(idCaptureTitleImageChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [idTitleImgCheckBox setHidden: YES];
    idTitleImgCheckBox.hidden = YES;
    [scrollView addSubview:idTitleImgCheckBox];
    
    UILabel *hideIdCaptureTitleImgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idTitleImgCheckBox.frame.origin.x + idTitleImgCheckBox.frame.size.width + (width/100)*2, idTitleImgCheckBox.frame.origin.y*0, idCapturetitleImageTextField.frame.size.width, (height/100)*0)];
    [hideIdCaptureTitleImgLabel setText:[LabelUtils getLabelForKey:@"hide_id_title_image"]];
    [hideIdCaptureTitleImgLabel setAlpha:0.7];
    [hideIdCaptureTitleImgLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureTitleImgLabel.numberOfLines = 0;
    hideIdCaptureTitleImgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [hideIdCaptureTitleImgLabel setHidden: YES];
    hideIdCaptureTitleImgLabel.hidden = YES;
    [scrollView addSubview:hideIdCaptureTitleImgLabel];
    
    //Id Capture Label Initialization
    UILabel *initIdCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCapturetitleImageTextField.frame.origin.y + idCapturetitleImageTextField.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [initIdCaptureLabel setText:[LabelUtils getLabelForKey:@"id_capture_label"]];
    [initIdCaptureLabel setAlpha:0.7];
    [initIdCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    initIdCaptureLabel.numberOfLines = 0;
    initIdCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [initIdCaptureLabel setHidden: YES];
    initIdCaptureLabel.hidden = YES;
    [scrollView addSubview:initIdCaptureLabel];
    
    idCaptureLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, initIdCaptureLabel.frame.origin.y + initIdCaptureLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [idCaptureLabelTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureLabelTextField.layer.cornerRadius = 5;
    idCaptureLabelTextField.layer.borderWidth = 1.0;
    idCaptureLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureLabelTextField setAlpha:0.7];
    [idCaptureLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idCaptureLabelTextField setHidden: YES];
    idCaptureLabelTextField.hidden = YES;
    [scrollView addSubview:idCaptureLabelTextField];
    
    UIImageView *idCaptureLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureLabelTextField.frame.origin.x + idCaptureLabelTextField.frame.size.width - (width/100)*9 , idCaptureLabelTextField.frame.origin.y + (idCaptureLabelTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [idCaptureLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [idCaptureLabelDownArrowImage setHidden: YES];
    idCaptureLabelDownArrowImage.hidden = YES;
    [scrollView addSubview:idCaptureLabelDownArrowImage];
    
    //English Label
    UILabel *englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureLabelTextField.frame.origin.y + idCaptureLabelTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [englishLabel setText:[LabelUtils getLabelForKey:@"english_label"]];
    [englishLabel setAlpha:0.7];
    [englishLabel setFont:[UIFont systemFontOfSize:11]];
    englishLabel.numberOfLines = 0;
    englishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [englishLabel setHidden: YES];
    englishLabel.hidden = YES;
    [scrollView addSubview:englishLabel];
    
    //Spanish Label
    UILabel *spanishLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idCaptureLabelTextField.frame.origin.y + idCaptureLabelTextField.frame.size.height +  (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [spanishLabel setText:[LabelUtils getLabelForKey:@"spanish_label"]];
    [spanishLabel setAlpha:0.7];
    spanishLabel.numberOfLines = 0;
    spanishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [spanishLabel setFont:[UIFont systemFontOfSize:11]];
    [spanishLabel setHidden: YES];
    spanishLabel.hidden = YES;
    [scrollView addSubview:spanishLabel];
    
    //English TextField
    englishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, englishLabel.frame.origin.y + englishLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
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
    spanishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*0, spanishLabel.frame.size.width, (height/100)*0)];
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
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(idOutLineColorLabel.frame.origin.x, mrzBarcodeRetryCountTextField.frame.origin.y + mrzBarcodeRetryCountTextField.frame.size.height + (height/100)*2, englishLabelTextField.frame.size.width, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(idOutlineTransLabel.frame.origin.x, saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    //    [scrollView setContentSize:CGSizeMake(width, resetBtn.frame.origin.y + resetBtn.frame.size.height + (height/100)*3)];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)portraitBtnChkBox:(UIButton*)button {
    if(!isPortrait) {
        [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        isPortrait = true;
    }
}

-(void)landscapeBtnChkBox:(UIButton*)button {
    
    if(isPortrait) {
        [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        isPortrait = false;
    }
}

-(void)barcodeScanBtnChkBox:(UIButton*)button {
    
    if(barcodeScan) {
        [barcodeScanRadioButton setImage:[UIImage imageNamed:@"uncheck.png"]
        forState:UIControlStateNormal];
        barcodeScan = false;
    } else {
        [barcodeScanRadioButton setImage:[UIImage imageNamed:@"check.png"]
        forState:UIControlStateNormal];
        barcodeScan = true;
    }

}

-(void)noInstChkBox:(UIButton*)button {
    if(showInstScreen) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        showInstScreen = false;
    }
}

-(void)yesInstChkBox:(UIButton*)button {
    
    if(!showInstScreen) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        showInstScreen = true;
    }
    
}

-(void)idCaptureTitleChkBox:(UIButton*)button {
    if(!hideIdCaptureTitle) {
        [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
        hideIdCaptureTitle = true;
    } else {
        hideIdCaptureTitle = false;
        [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
}

-(void)idCaptureHintMessageChkBox:(UIButton*)button {
    if(!hideIdHintMessage) {
        hideIdHintMessage = true;
        [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                                  forState:UIControlStateNormal];
    } else {
        hideIdHintMessage = false;
        [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                                  forState:UIControlStateNormal];
    }
}

-(void)idCaptureTitleImageChkBox:(UIButton*)button {
    if(!hideIdTitleImage) {
        hideIdTitleImage = true;
        [idTitleImgCheckBox setImage:[UIImage imageNamed:@"check.png"]
                            forState:UIControlStateNormal];
    } else {
        hideIdTitleImage = false;
        [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    }
}

-(void)addLabelClicked:(UIButton*)button {
    NSString *labelKey = idCaptureLabelTextField.text;
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
    
    int minimumLightThreshold=mLightThreshold, minimumFocusThreshold=mFocusThreshold,maximunFocusThreshold = maxFocusThreshold, GlarePercentage=mGlarePercentage, EnableCaptureButtonTime=mCaptureButtonTime, ImageSize=mMaxImageSize, ImageHeight=mImageHeight,ImageWidth=mImageWidth,BarcodeScanLimit=mbarcodeScanLimitValue, MrzScanLimit = mMrzScanLimit, MrzAndBarcodeScanLimit = mMrzAndBarcodeScanLimit;
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor,*backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *confirmButtonStyle=dConfirmButtonStyle, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, confirmButtonStyleTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha,  headerTextColorTrans=mAlpha;
    
    if([NSStringUtilsDemo isInteger:lightThresholdTextField.text]){
        minimumLightThreshold = [lightThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:maxFocusThresholdTextField.text]){
        minimumLightThreshold = [maxFocusThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:minFocusThreshold.text]){
        minimumFocusThreshold = [minFocusThreshold.text intValue];
    }
    if([NSStringUtilsDemo isInteger:glarePercentageTextField.text]){
        GlarePercentage = [glarePercentageTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:enableCapBtnTimeTextField.text]){
        EnableCaptureButtonTime = [enableCapBtnTimeTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:barcodeScanLimitTextField.text]){
        BarcodeScanLimit = [barcodeScanLimitTextField.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:mrzRetryCountTextField.text]){
        MrzScanLimit = [mrzRetryCountTextField.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:mrzBarcodeRetryCountTextField.text]){
        MrzAndBarcodeScanLimit = [mrzBarcodeRetryCountTextField.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:maxImageSize.text]){
        ImageSize = [maxImageSize.text intValue];
    }
    if([NSStringUtilsDemo isInteger:imageHeightTextField.text]){
        ImageHeight = [imageHeightTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:imageWidthTextField.text]){
        ImageWidth = [imageWidthTextField.text intValue];
    }
    
    idOutlineColor = idOutlineColorTextField.text;
    idOutsideOutlineColor = colorOutsideOutlineTextField.text;
    idOutlineColorAlpha = [idOutlineColorTransTextField.text intValue];
    idOutsideOutlineColorAlpha = [colorOutsideOutlineTransTextField.text intValue];
    detectedidoutlinecolor = detectedIdOutlineColorTextField.text;
    detectedidoutlinetransparency = [detectedIdOutlineColorTransTextField.text intValue];
    dDetectedIDOutsideOutlineColor = detectedColorOutsideOutlineTextField.text;
    detectedidoutlineoutsidecolortrans = [detectedColorOutsideOutlineTransTextField.text intValue];
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
    retryButtonBorderTrans=[retryButtonBorderTransTextField.text intValue];
    confirmButtonTrans =[confirmButtonTransTextField.text intValue];
    confirmButtonStyleTrans =[confirmButtonStyleTransTextField.text intValue];
    textColorTrans=[textColorTransTextField.text intValue];
    instContinueButtonTrans=[instContinueButtonTransTextField.text intValue];
    instContinueButtonTransText=[instContinueButtonTransTextColorField.text intValue];
    headerTextColorTrans=[headerTextColorTransTextField.text intValue];
    
    [self saveSetting:@"lightthreshold_Back" value:[NSString stringWithFormat:@"%d", minimumLightThreshold]];
    [self saveSetting:@"focusthreshold_Back" value:[NSString stringWithFormat:@"%d", minimumFocusThreshold]];
    [self saveSetting:@"maxfocusthreshold_Back" value:[NSString stringWithFormat:@"%d", maximunFocusThreshold]];
    [self saveSetting:@"glarepercentage_Back" value:[NSString stringWithFormat:@"%d", GlarePercentage]];
    [self saveSetting:@"capturebuttontime_Back" value:[NSString stringWithFormat:@"%d", EnableCaptureButtonTime]];
    [self saveSetting:@"capturebuttontime_Back" value:[NSString stringWithFormat:@"%d", EnableCaptureButtonTime]];
    [self saveSetting:@"barcodeScanLimit_Back" value:[NSString stringWithFormat:@"%d", BarcodeScanLimit]];
    [self saveSetting:@"mrzScanLimit_Back" value:[NSString stringWithFormat:@"%d", MrzScanLimit]];
    [self saveSetting:@"mrzAndbarcodeScanLimit_Back" value:[NSString stringWithFormat:@"%d", MrzAndBarcodeScanLimit]];
    [self saveSetting:@"maximagesize_Back" value:[NSString stringWithFormat:@"%d", ImageSize]];
    [self saveSetting:@"imageheight_Back" value:[NSString stringWithFormat:@"%d", ImageHeight]];
    [self saveSetting:@"imagewidth_Back" value:[NSString stringWithFormat:@"%d", ImageWidth]];
    
    [self saveSetting:@"idoutlinecolor" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor" value:idOutsideOutlineColor];
    [self saveSetting:@"backButton" value:backButtonColor];
    [self saveSetting:@"retryButton" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle" value:confirmButtonStyle];
    [self saveSetting:@"textColor" value:textColor];
    [self saveSetting:@"instContinueButton" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText" value:instContinueButtonTextColor];
    
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButtonTransparency" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self configBtnclickMethod];
    [self saveSetting:@"idCaptureTitleLabel" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    
    NSString *hideIdCapTitle, *hideIdCaphintMsg, *hideIdCapTitImage;
    if(hideIdCaptureTitle) {
        hideIdCapTitle = @"Y";
    } else {
        hideIdCapTitle = @"N";
    }
    
    if(hideIdHintMessage) {
        hideIdCaphintMsg = @"Y";
    } else {
        hideIdCaphintMsg = @"N";
    }
    
    if(hideIdTitleImage) {
        hideIdCapTitImage = @"Y";
    } else {
        hideIdCapTitImage = @"N";
    }
    
    [self saveSetting:@"hideIdCaptureTitle" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage" value:hideIdCapTitImage];
    
    bool hideFaceTitle, hideFacehintMsg, hideFacehintIcon, hideFacetitleImage;
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFaceTitle" defaultValue:@"N"]]) {
        hideFaceTitle = true;
    } else {
        hideFaceTitle = false;
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacehintMsg" defaultValue:@"N"]]) {
        hideFacehintMsg = true;
    } else {
        hideFacehintMsg = false;
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacehintIcon" defaultValue:@"N"]]) {
        hideFacehintIcon = true;
    } else {
        hideFacehintIcon = false;
    }
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"hideFacetitleImage" defaultValue:@"N"]]) {
        hideFacetitleImage = true;
    } else {
        hideFacetitleImage = false;
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
    
    NSString *idTitleAlignment=[self getIdCaptureAlignment:[idCaptureTitleTextField text] defaultValue:@"Top"];
    NSString *idHintMsgAlignment=[self getIdCaptureAlignment:[idCaptureHintMsgTextField text] defaultValue:@"Center"];
    NSString *idTitleImageAlignment=[self getIdCaptureAlignment:[idCapturetitleImageTextField text] defaultValue:@"Bottom"];
    
//    [AppItSDK customizeUserInterface:self faceTitleOnTop:isFaceTitleOnTop hideFaceTitle:hideFaceTitle faceHintMessageOnTop:isFaceHintMsgOnTop hideFacehintMsg:hideFacehintMsg faceHintIconOnTop:isFaceHintIconOnTop hideFacehintIcon:hideFacehintIcon faceTitleImageOnTop:isFaceTitleImageOnTop hideFacetitleImage:hideFacetitleImage idCaptureTitleAlignment:idTitleAlignment hideIDCaptureTitle:hideIdCaptureTitle idCaptureHintMsgAlignment:idHintMsgAlignment hideIDCapturehintMsg:hideIdHintMessage idCaptureTitleImgAlignment:idTitleImageAlignment hideIDCapturetitleImg:hideIdTitleImage];
    
    //Add Label Clicked
    [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
    
    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
    
    [idOutlineColorTextField setText:dIdOutlineColor];
    [idOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedIdOutlineColorTextField setText:dDetectedIdOutlineColor];
    [detectedIdOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [colorOutsideOutlineTextField setText:dOutsideIdOutlineColor];
    [colorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [detectedColorOutsideOutlineTextField setText:dDetectedIdOutsideOutlineColor];
    [detectedColorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [lightThresholdTextField setText:[@(mLightThreshold) stringValue]];
    [minFocusThreshold setText:[@(mFocusThreshold) stringValue]];
    [maxFocusThresholdTextField setText:[@(maxFocusThreshold) stringValue]];
    [glarePercentageTextField setText:[@(mGlarePercentage) stringValue]];
    [enableCapBtnTimeTextField setText:[@(mCaptureButtonTime) stringValue]];
    [barcodeScanLimitTextField setText:[@(mbarcodeScanLimitValue) stringValue]];
    [mrzRetryCountTextField setText:[@(mMrzScanLimit) stringValue]];
    [mrzBarcodeRetryCountTextField setText:[@(mMrzAndBarcodeScanLimit) stringValue]];
    [maxImageSize setText:[@(mMaxImageSize) stringValue]];
    [imageWidthTextField setText:[@(mImageWidth) stringValue]];
    [imageHeightTextField setText:[@(mImageHeight) stringValue]];
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
    //[idCaptureTitleTextField setText:@"Top"];
    //[idCaptureHintMsgTextField setText:@"Center"];
    //[idCapturetitleImageTextField setText:@"Center"];
    [idCaptureTitleTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [idCaptureHintMsgTextField setText:[LabelUtils getLabelForKey:@"Center"]];
    [idCapturetitleImageTextField setText:[LabelUtils getLabelForKey:@"Bottom"]];
    [headerTextColorTextField setText:dTextColor];
    [headerTextColorTransTextField setText:[@(mAlpha) stringValue]];
    [headerSizeTextField setText:@""];
    [textSizeTextField setText:@""];
    
    hideIdTitleImage = false;
    hideIdHintMessage = false;
    hideIdCaptureTitle = false;
    
    [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                        forState:UIControlStateNormal];
    
    [self saveSetting:@"lightthreshold_Back" value:[NSString stringWithFormat:@"%@", [lightThresholdTextField text]]];
    [self saveSetting:@"focusthreshold_Back" value:[NSString stringWithFormat:@"%@", [minFocusThreshold text]]];
    [self saveSetting:@"maxfocusthreshold_Back" value:[NSString stringWithFormat:@"%@", [maxFocusThresholdTextField text]]];
    [self saveSetting:@"glarepercentage_Back" value:[NSString stringWithFormat:@"%@", [glarePercentageTextField text]]];
    [self saveSetting:@"capturebuttontime_Back" value:[NSString stringWithFormat:@"%@", [enableCapBtnTimeTextField text]]];
    [self saveSetting:@"barcodeScanLimit_Back" value:[NSString stringWithFormat:@"%@", [barcodeScanLimitTextField text]]];
    [self saveSetting:@"mrzScanLimit_Back" value:[NSString stringWithFormat:@"%@", [mrzRetryCountTextField text]]];
    [self saveSetting:@"mrzAndbarcodeScanLimit_Back" value:[NSString stringWithFormat:@"%@", [mrzBarcodeRetryCountTextField text]]];
    [self saveSetting:@"maximagesize_Back" value:[NSString stringWithFormat:@"%@", [maxImageSize text]]];
    [self saveSetting:@"imageheight_Back" value:[NSString stringWithFormat:@"%@", [imageHeightTextField text]]];
    [self saveSetting:@"imagewidth_Back" value:[NSString stringWithFormat:@"%@", [imageWidthTextField text]]];
    
    [self saveSetting:@"idoutlinecolor" value:[NSString stringWithFormat:@"%@", [idOutlineColorTextField text]]];
    [self saveSetting:@"idoutsideoutlinecolor" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTextField text]]];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%@", [idOutlineColorTransTextField text]]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTransTextField text]]];
    [self saveSetting:@"detectedidoutlinecolor" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTextField text]]];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTransTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:[NSString stringWithFormat:@"%@", [detectedColorOutsideOutlineTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%@",[detectedColorOutsideOutlineTransTextField text]]];
    
    [self saveSetting:@"backButton" value:[NSString stringWithFormat:@"%@", [backButtonTextField text]]];
    [self saveSetting:@"retryButton" value:[NSString stringWithFormat:@"%@", [retryButtonTextField text]]];
    [self saveSetting:@"confirmButton" value:[NSString stringWithFormat:@"%@", [confirmButtonTextField text]]];
    [self saveSetting:@"textColor" value:[NSString stringWithFormat:@"%@", [textColorTextField text]]];
    [self saveSetting:@"instContinueButton" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextField text]]];
    [self saveSetting:@"instContinueButtonText" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextColorField text]]];
    
    [self saveSetting:@"backButtonTransparency" value:[NSString stringWithFormat:@"%@",[backButtonTransTextField text]]];
    [self saveSetting:@"retryButtonTransparency" value:[NSString stringWithFormat:@"%@",[retryButtonTransTextField text]]];
    [self saveSetting:@"confirmButtonTransparency" value:[NSString stringWithFormat:@"%@",[confirmButtonTransTextField text]]];
    [self saveSetting:@"textColorTransparency" value:[NSString stringWithFormat:@"%@",[textColorTransTextField text]]];
    [self saveSetting:@"instContinueButtonTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextField text]]];
    [self saveSetting:@"instContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextColorField text]]];
    
    [self saveSetting:@"idCaptureTitleLabel" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage" value:[idCapturetitleImageTextField text]];
    
    [self saveSetting:@"hideIdCaptureTitle" value:@"N"];
    [self saveSetting:@"hideIdCaptureHintMsg" value:@"N"];
    [self saveSetting:@"hideIdCaptureTitleImage" value:@"N"];
    
    [self saveSetting:@"retryButtonBorder" value:[retryButtonBorderTextField text]];
    [self saveSetting:@"confirmButtonStyle" value:[confirmButtonStyleTextField text]];
    [self saveSetting:@"retryButtonBorderTransparency" value:[NSString stringWithFormat:@"%@",[retryButtonBorderTransTextField text]]];
    [self saveSetting:@"confirmButtonStyleTransparency" value:[NSString stringWithFormat:@"%@",[confirmButtonStyleTransTextField text]]];
    [self saveSetting:@"headerTextSize" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency" value:[NSString stringWithFormat:@"%@",headerTextColorTransTextField]];
    
    //Resetting the all labels value
    [englishLabels removeAllObjects];
    [spanishLabels removeAllObjects];
    [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
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
    [cameraClickBtn setImage:[UIImage imageNamed:@"Camera.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    UILabel *captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    //    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, backGroundWhiteView.frame.origin.y + (backGroundWhiteView.frame.size.height/100)*2, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - (backGroundWhiteView.frame.size.height/100)*4)];
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (width/100)*1, backGroundWhiteView.frame.origin.y + (height/100)*1, backGroundWhiteView.frame.size.width - (width/100)*2, backGroundWhiteView.frame.size.height - (height/100)*2)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:resultImage];
    
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
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*52, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    barcodeBoldData = [[UITextView alloc] init];
    barcodeBoldData.frame = CGRectMake(backGroundWhiteView.frame.origin.x, nextBtn.frame.origin.y + nextBtn.frame.size.height + (height/100)*2, recaptureButton.frame.size.width, (height/100)*5);
    [barcodeBoldData setBackgroundColor:[UIColor clearColor]];
    [barcodeBoldData setFont:[UIFont boldSystemFontOfSize:16]];
    [barcodeBoldData setTextAlignment:NSTextAlignmentLeft];
    [barcodeBoldData setText:@"Extracted Data:"];
    [self.view addSubview:barcodeBoldData];
    
    int justToCheckHeight = configurationButton.frame.origin.y - (barcodeBoldData.frame.origin.y + barcodeBoldData.frame.size.height);
    
    barcodeScorolledData = [[UITextView alloc] init];
    barcodeScorolledData.frame = CGRectMake(backGroundWhiteView.frame.origin.x, barcodeBoldData.frame.origin.y + barcodeBoldData.frame.size.height + (height/100)*1 , recaptureButton.frame.size.width, justToCheckHeight - (height/100)*2);
    [barcodeScorolledData setFont:[UIFont fontWithName:@"Arial" size:16]];
    [barcodeScorolledData setScrollEnabled:YES];
    [barcodeScorolledData setUserInteractionEnabled:YES];
    [barcodeScorolledData setBackgroundColor:[UIColor clearColor]];
    [barcodeScorolledData setTextAlignment:NSTextAlignmentLeft];
    [barcodeScorolledData setTextColor:[UIColor blackColor]];
    [self.view addSubview:barcodeScorolledData];
    [barcodeScorolledData setHidden:YES];
    [barcodeBoldData setHidden:YES];
    
    
}

- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        // [self captureCameraAPICall];
        [self checkCameraPermission];
    }
}

-(void)captureBtn:(UIButton*)button {
    // [self captureCameraAPICall];
    [self checkCameraPermission];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    int service_id = [ArrayObjectController getServiceId];
    //    if(service_id == 20) {
    //        FinalStepController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalStepController"];
    //        [self.navigationController pushViewController:controller animated:YES];
    //    } else {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    NSString *restorationId1 = [self valueForKey:@"storyboardIdentifier"];
    [controller setNextViewController:restorationId1];
    //   }
}

-(void)captureCameraAPICall{
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *lightThreshold = [lightThresholdTextField text];
    NSString *minCapFocusThreshold = [minFocusThreshold text];
    NSString *maxCapFocusThreshold = [maxFocusThresholdTextField text];
    NSString *glarePercentage = [glarePercentageTextField text];
    NSString *enableCapBtnTime = [enableCapBtnTimeTextField text];
    NSString *barcodeScanLimit = [barcodeScanLimitTextField text];
    NSString *mrzScanLimit = [mrzRetryCountTextField text];
    NSString *mrzAndBarcodeScanLimit = [mrzBarcodeRetryCountTextField text];
    NSString *maxCapImageSize = [maxImageSize text];
    NSString *imageHeight = [imageHeightTextField text];
    NSString *imageWidth = [imageWidthTextField text];
    NSString *idOutlineColor = [idOutlineColorTextField text];
    NSString *idOutlineColorTrans = [idOutlineColorTransTextField text];
    NSString *detectedIdOutlineColor = [detectedIdOutlineColorTextField text];
    NSString *detectedIdOutlineColorTrans = [detectedIdOutlineColorTransTextField text];
    NSString *colorOutsideOutline = [colorOutsideOutlineTextField text];
    NSString *colorOutsideOutlineTrans = [colorOutsideOutlineTransTextField text];
    NSString *detectedColorOutsideOutline = [detectedColorOutsideOutlineTextField text];
    NSString *detectedColorOutsideOutlineTrans= [detectedColorOutsideOutlineTransTextField text];
    // NSString *fontStyle= [fontStyleTextField text];
    NSString *fontStyle=[self getFontStyle:[fontStyleTextField text] defaultValue:@"Default"];
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
    // NSString *headerFontStyle= [headerFontStyleTextField text];
    NSString *headerFontStyle=[self getFontStyle:[headerFontStyleTextField text] defaultValue:@"Default"];
    NSString *headerTextColor= [headerTextColorTextField text];
    NSString *headerTextColorTrans= [headerTextColorTransTextField text];
    NSString *headerSize= [headerSizeTextField text];
    NSString *textSize= [textSizeTextField text];
    NSString *idCaptureBorderLabel= [self getIdCaptureBorder:[idCaptureBorderLabelTextField text] defaultValue:@"Thick"];
    
//    NSString *isPortraitMode = (isPortrait) ? @"true" : @"false";
//    NSString *showInsScreen = (showInstScreen) ? @"true" : @"false";
    
    NSString *isPortraitMode = (isPortrait) ? @"Y" : @"N";
    NSString *showInsScreen = (showInstScreen) ? @"Y" : @"N";
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:isPortraitMode]){
        [nsDict setObject:isPortraitMode forKey:@"id_capture_portrait"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:lightThreshold]){
        [nsDict setObject:lightThreshold forKey:@"id_light_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:minCapFocusThreshold]){
        [nsDict setObject:minCapFocusThreshold forKey:@"id_min_focus_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapFocusThreshold]){
        [nsDict setObject:maxCapFocusThreshold forKey:@"id_max_focus_threshold"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:glarePercentage]){
        [nsDict setObject:glarePercentage forKey:@"id_glare_percentage"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:enableCapBtnTime]){
        [nsDict setObject:enableCapBtnTime forKey:@"id_enable_capture_button_time"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapImageSize]){
        [nsDict setObject:maxCapImageSize forKey:@"id_max_image_size"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:imageHeight]){
        [nsDict setObject:imageHeight forKey:@"id_image_height"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:imageWidth]){
        [nsDict setObject:imageWidth forKey:@"id_image_width"];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:barcodeScanLimit]){
        [nsDict setObject:barcodeScanLimit forKey:@"barcode_scan_max_limit"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:mrzScanLimit]){
        [nsDict setObject:mrzScanLimit forKey:@"mrz_scan_max_limit"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:mrzAndBarcodeScanLimit]){
        [nsDict setObject:mrzAndBarcodeScanLimit forKey:@"mrz_and_barcode_scan_max_limit"];
    }
    
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
//        [nsDict setObject:showInsScreen forKey:@"id_show_instruction"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:idOutlineColor]){
//        [nsDict setObject:idOutlineColor forKey:@"idOutlineColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:idOutlineColorTrans]){
//        [nsDict setObject:idOutlineColorTrans forKey:@"idOutlineColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedIdOutlineColor]){
//        [nsDict setObject:detectedIdOutlineColor forKey:@"detectedIdOutlineColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedIdOutlineColorTrans]){
//        [nsDict setObject:detectedIdOutlineColorTrans forKey:@"detectedIdOutlineColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:colorOutsideOutline]){
//        [nsDict setObject:colorOutsideOutline forKey:@"idOutsideOutlineColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:colorOutsideOutlineTrans]){
//        [nsDict setObject:colorOutsideOutlineTrans forKey:@"idOutsideOutlineColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedColorOutsideOutline]){
//        [nsDict setObject:detectedColorOutsideOutline forKey:@"detectedIdOutsideOutlineColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:detectedColorOutsideOutlineTrans]){
//        [nsDict setObject:detectedColorOutsideOutlineTrans forKey:@"detectedIdOutsideOutlineColorAlpha"];
//    }
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
//        [nsDict setObject:confirmButtonTrans forKey:@"confirmButtonTrans"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButtonStyle]){
//        [nsDict setObject:confirmButtonStyle forKey:@"confirmButtonStyle"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:confirmButtonStyleTrans]){
//        [nsDict setObject:confirmButtonStyleTrans forKey:@"confirmButtonStyleTrans"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:textColor]){
//        [nsDict setObject:textColor forKey:@"textColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:textColorTrans]){
//        [nsDict setObject:textColorTrans forKey:@"textColorTrans"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTrans]){
//        [nsDict setObject:instContinueButtonTrans forKey:@"instructionButtonColorAlpha"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButton]){
//        [nsDict setObject:instContinueButton forKey:@"instructionButtonColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTextColor]){
//        [nsDict setObject:instContinueButtonTextColor forKey:@"instructionButtonTXTColor"];
//    }
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTransTextColor]){
//        [nsDict setObject:instContinueButtonTransTextColor forKey:@"instructionButtonTXTColorAlpha"];
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
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:idCaptureBorderLabel]) {
//        [nsDict setObject:idCaptureBorderLabel forKey:@"idCaptureBorder"];
//    }
    //  [AppItSDK captureBackImage:[ArrayObjectController getPageDelegate] capturePortrait:isPortrait minimumLightThreshold:[lightThresholdTextField.text intValue] minimumFocusThreshold:[minFocusThreshold.text intValue] GlarePercentage:[glarePercentageTextField.text intValue] EnableCaptureButtonTime:[enableCapBtnTimeTextField.text intValue] ImageSize:[maxImageSize.text intValue] ImageHeight:[imageHeightTextField.text intValue] ImageWidth:[imageWidthTextField.text intValue] idOutlineColor:[idOutlineColorTextField text] idOutlineColorTransparency:[idOutlineColorTransTextField.text intValue] detectedIdOutlineColor:[detectedIdOutlineColorTextField text] detectedIdOutlineTransparency:[detectedIdOutlineColorTransTextField.text intValue] idOutsideOutlineColor:[colorOutsideOutlineTextField text] idOutsideOutlineColorTransparency:[colorOutsideOutlineTransTextField.text intValue] detectedColorOutsideOutline:[detectedColorOutsideOutlineTextField text] detectedColorOutsideOutnillineTransparency:[detectedColorOutsideOutlineTransTextField.text intValue] titleImage:nil showInstruction:showInstScreen instructionimage:nil];
    
    UIImage *titleImageFace;
    //if([@"None" isEqualToString:[showTitleImgTextField text]]) {
    if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[showTitleImgTextField text]]) {
        titleImageFace = nil;
    } else {
        titleImageFace = [UIImage imageNamed:@"title_image"];
    }
    
    NSString *countryCode = [ArrayObjectController getCountryType];
    NSString *stateCode = [ArrayObjectController getStateType];
    NSString *idType = [ArrayObjectController getIdType];
    
    NSString *barcodeScanString = (barcodeScan) ? @"Y" : @"N";
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:barcodeScanString]){
        [nsDict setObject:barcodeScanString forKey:@"barcode_scan"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:countryCode]){
        [nsDict setObject:countryCode forKey:@"country_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:stateCode]){
        [nsDict setObject:stateCode forKey:@"state_code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:idType]){
        [nsDict setObject:idType forKey:@"id_type"];
    }
    
//     [nsDict setObject:@"Y" forKey:@"id_capture_enable"];
    
//    [AppItSDK captureBackImage:@"BACK" instance:[ArrayObjectController getPageDelegate] titleImage:titleImageFace additionalDictionary:[AppItSDK getAdditionalDataDictionary] instructionimage:nil fieldName:nil uiConfigDictionary:nsDict];
    [AppItSDK captureBackImage:[ArrayObjectController getPageDelegate] additionalDictionary:[AppItSDK getAdditionalDataDictionary] uiConfigDictionary:nsDict];
    
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

-(void)configurationBtnClicked:(UIButton*)button {
    [self configBtnclickMethod];
}

-(void)configBtnclickMethod {
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

-(void)captureResponse : (NSMutableDictionary*) result {
    NSLog(@"");
    NSLog(@"captureImageResponse Response : %@ ", result);
    
    NSString *front = [result objectForKey:@"FRONT"];
    NSString *back = [result objectForKey:@"BACK"];
    NSMutableDictionary *barcodeDataDict = [result objectForKey:@"barcode_data"];
    
    if(nil == barcodeDataDict || [barcodeDataDict count] == 0) {
        barcodeDataDict = [result objectForKey:@"MRZData"];
    }
    
    if(nil != barcodeDataDict && [barcodeDataDict count] > 0) {
        
//        [barcodeScorolledData setHidden:NO];
//        [barcodeBoldData setHidden:NO];
//
//       NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:barcodeDataDict options:0 error:nil];
//       NSString * barcodeString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
//        barcodeString = [barcodeString stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
//        if(![NSStringUtils stringIsNilOrEmpty:barcodeString]) {
//            [barcodeScorolledData setText:barcodeString];
//        }
        [configureView setHidden:false];
        [exitConfigureViewBtn setHidden:false];
        [self reloadAllTheViews:barcodeDataDict];
        
    } else {
//        [barcodeScorolledData setHidden:YES];
//        [barcodeBoldData setHidden:YES];
        [configureView setHidden:true];
        [exitConfigureViewBtn setHidden:true];
    }
                                            
    if(nil != front){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:front options:0];
        UIImage* image = [UIImage imageWithData:data];
        
    }else if(nil != back){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:back options:0];
        UIImage* image = [UIImage imageWithData:data];
        [resultImage setImage:image];
        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
        isCapture=false;
    }
}

-(void)setResultImage:(UIImage *)resImage {
    [resultImage setImage:resImage];
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
}

//Run time Permission Asking
-(void) checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        [self captureCameraAPICall];
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
                        [self captureCameraAPICall];
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
                    [self captureCameraAPICall];
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

-(NSString* ) unEsacpeXML:(NSString*) text{
    
    text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    return text;
}


@end
