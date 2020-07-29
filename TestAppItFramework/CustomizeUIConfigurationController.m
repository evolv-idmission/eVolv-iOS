//
//  CustomizeUIConfigurationController.m
//  AppItDepedency
//
//  Created by Sanket Garde on 30/05/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import "CustomizeUIConfigurationController.h"

@interface CustomizeUIConfigurationController ()

@end

@implementation CustomizeUIConfigurationController {
    
    //For IDCapture
    UITextField *idOutlineColorTextField, *idOutlineColorTransTextField, *detectedIdOutlineColorTextField, *detectedIdOutlineColorTransTextField, *colorOutsideOutlineTextField, *colorOutsideOutlineTransTextField, *detectedColorOutsideOutlineTextField, *detectedColorOutsideOutlineTransTextField, *showTitleImgTextField, *backButtonTextField, *backButtonTransTextField, *retryButtonTextField, *retryButtonTransTextField, *confirmButtonTextField, *confirmButtonTransTextField, *fontStyleTextField, *textColorTextField, *textColorTransTextField, *instContinueButtonTextField, *instContinueButtonTransTextField, *instContinueButtonTextColorField, *instContinueButtonTransTextColorField, *idCaptureTitleTextField, *idCaptureHintMsgTextField, *idCapturetitleImageTextField, *idCaptureLabelTextField, *englishLabelTextField, *spanishLabelTextField, *retryButtonBorderTransTextField, *confirmButtonStyleTransTextField, *retryButtonBorderTextField, *confirmButtonStyleTextField, *headerSizeTextField, *textSizeTextField, *headerFontStyleTextField,  *headerTextColorTextField, *headerTextColorTransTextField, *idCaptureBorderLabelTextField, *idCaptureButtonColorTextField, *idCaptureButtonColorTransTextField;
    
    UIButton *idCaptureTitleCheckBox, *idCaptureHintMsgCheckBox, *idTitleImgCheckBox, *yesInstRadioBtn, *noInstRadioBtn, *enableShadow_Id;
    
    UIScrollView *scrollView_IdCaptureFront, *scrollView_selfieCapture, *scrollView_4F, *scrollView_voiceCapture;
    
    int mAlpha;
    NSMutableDictionary *englishLabels;
    NSMutableDictionary *spanishLabels;
    
    NSArray *_selectedPickerData, *_selectedFontStylePickerData, *_selectedHeaderFontStylePickerData;
    
    NSArray *showTitlePickerData, *showFontStylePickerData, *showHeaderFontStylePickerData, *_idCaptreTitlePickerData, *_idCaptureHintMsgPickerData, *_idCaptureTitleImagePickerData, *_idCaptureLabelPickerData, *_idCaptureBorderLabelPickerData, *_selectConfigurationPickerData;
    
    //
    
    bool isPortrait, showInstScreen_IdFront, showInstScreen_IdFront_sec, showInstScreen_IdBack, showInstScreen_IdBack_sec, showInstScreen_Doc, showInstScreen_Snippet, hideIdCaptureTitle, hideIdHintMessage, hideIdTitleImage, isCapture, isEnableShadow_IdFront, isEnableShadow_IdFront_sec, isEnableShadow_IdBack,isEnableShadow_IdBack_sec,isEnableShadow_IdBack_Doc,isEnableShadow_IdBack_Snippet;
    
    
    //SelfieCapture
    UITextField *faceOutlineColorTextField, *faceOutlineColorTransTextField, *detectedFaceOutlineColorTextField, *detectedFaceOutlineColorTransTextField, *outlineColorOfFaceOutlineTextField, *outlineColorOfFaceOutlineTransTextField, *outlineDetectedColorOfFaceOutlineTextField, *outlineDetectedColorOfFaceOutlineTransTextField, *selectTitleImgTextField, *backButtonTextField_Face, *backButtonTransTextField_Face, *retryButtonTextField_Face, *retryButtonTransTextField_Face, *confirmButtonTextField_Face, *confirmButtonTransTextField_Face, *fontStyleTextField_Face, *textColorTextField_Face, *textColorTransTextField_Face, *instContinueButtonTextField_Face, *instContinueButtonTransTextField_Face, *instContinueButtonTextColorField_Face, *instContinueButtonTransTextColorField_Face, *faceTitleTextField, *faceHintMsgTextField,
    *faceHintIconTextField, *faceTitleImageTextField, *faceCaptureLabelTextField, *englishLabelTextField_Face, *spanishLabelTextField_Face, *faceContoursTextField, *faceImageTypeTextField, *retryButtonBorderTextField_Face, *retryButtonBorderTransTextField_Face, *confirmButtonStyleTextField_Face, *confirmButtonStyleTransTextField_Face,*headerSizeTextField_Face, *textSizeTextField_Face, *headerFontStyleTextField_Face,  *headerTextColorTextField_Face, *headerTextColorTransTextField_Face,*instPreviewColorField_Face, *instPreviewTransColorField_Face;
    
    UIButton *faceTitleCheckBox, *faceHintMsgCheckBox, *faceHintIconCheckBox, *faceTitleImageCheckBox, *faceCustomizeUI, *showPreviewScreenTogleButton_Face, *showInstScreenToggleButton_Face, *enableShadow_Face;
    
    bool hideFaceTitle, hideFaceHintMessage, hideFaceHintIcon, hideFaceTitleImage, showFaceCustomizeUI, showPreviewScreen_Face, showInstructionScreen_Face, isEnableShadow_Face;
    
    NSArray *_faceTitlePickerData, *_faceHintMsgPickerData, *_faceHintIconPickerData, *_faceTitleImagePickerData, *_faceCaptureLabelPickerData, *_faceContoursPickerData;
    
    NSArray *_selectedFaceContoursPickerData;
    NSArray *_faceImgTypePickerData, *_selectedFaceImgTypePickerData;
    //
    
    //Four Finger Capture
    UITextField *selectFingerTextField,*showTitleImgTextField_4F, *fontStyleTextField_4F, *textColorTextField_4F, *textColorTransTextField_4F, *instContinueButtonTextField_4F, *instContinueButtonTransTextField_4F, *instContinueButtonTextColorField_4F, *instContinueButtonTransTextColorField_4F;
    
    UITextField *selectConfigurationTextField;
    
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    NSString *textFieldTypeForPicker;
    
    int selectConfig_row;
    bool isFirstTime;
    
    //Voice Capture
    UITextField *btnColorTextField_voiceCapture, *btnColorTransTextField_voiceCapture, *backgroundBtnTextField_voiceCapture, *backGroundBtnTransColorTextField_voiceCapture,*viewPositionTextField_voiceCapture, *textColortTextField_voiceCapture, *textColorAlphaTextField_voiceCapture, *titleTextColortTextField_voiceCapture, *titleTextColorAlphaTextField_voiceCapture,*titleLabelSizeTextField_voiceCapture,*textSizeTextField_voiceCapture,*counterLabelSizeTextField_voiceCapture,*labelsTextField_voiceCapture, *labelValueTextField_voiceCapture;
    
    UIButton *titleLabelOnTopBtn_voiceCapture, *autoPlayBtn_voiceCapture;
    
    NSArray *_voiceCaptureLabelPickerData;
    
    bool isTitleLabelOnTop_voiceCapture, isAutoPlay_voiceCapture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    bool isFirstTime = true;
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    mAlpha = 1;
    selectConfig_row = 0;
    
    showInstScreen_IdFront = true;
    showInstScreen_IdFront_sec = true;
    showInstScreen_IdBack = true;
    showInstScreen_IdBack_sec = true;
    showInstScreen_Doc = true;
    showInstScreen_Snippet = true;
    
    showPreviewScreen_Face = false;
    showInstructionScreen_Face = true;
    isEnableShadow_Face = true;
    
    isEnableShadow_IdFront = true;
    isEnableShadow_IdFront_sec = true;
    isEnableShadow_IdBack = true;
    isEnableShadow_IdBack_sec = true;
    isEnableShadow_IdBack_Doc = true;
    isEnableShadow_IdBack_Snippet = true;
    
    isTitleLabelOnTop_voiceCapture = true;
    isAutoPlay_voiceCapture = true;
    
    [self navigationCode];
    
    [self idCaptureFrontPicketDataArray];
    [self selfieCapturePickerDataArray];
    [self voiceCapturePickerDataArray];
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];

    [self initScrollViews];
    [self onResumeCode];
}

-(UIScrollView *)initializeScrollView:(UITextField *)selectConfigurationTextField {
    
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    
    int isiPhoneX_padding = 0;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
        int height = (int)[[UIScreen mainScreen] nativeBounds].size.height;
        int width = (int)[[UIScreen mainScreen] nativeBounds].size.width;
        
        switch (height) {
                
            case 2436:
                //"iPhone X"
                
                isiPhoneX_padding = 20;
                break;
            case 1792:
                
                isiPhoneX_padding = 20;
                break;
            default:
                printf("unknown");
        }
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, selectConfigurationTextField.frame.origin.y + selectConfigurationTextField.frame.size.height + (height/100)*1, width, height - selectConfigurationTextField.frame.origin.y - selectConfigurationTextField.frame.size.height - (height/100)*1 - (height/100)*9 - self.navigationController.navigationBar.frame.size.height)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    
    return scrollView;
    
}

-(void)initScrollViews {
    
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    int isiPhoneX_padding = 0;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
        int height = (int)[[UIScreen mainScreen] nativeBounds].size.height;
        int width = (int)[[UIScreen mainScreen] nativeBounds].size.width;
        
        switch (height) {
                
            case 2436:
                //"iPhone X"
                
                isiPhoneX_padding = 20;
                break;
            case 1792:
                
                isiPhoneX_padding = 20;
                break;
            default:
                printf("unknown");
        }
    }
    
    //Select Configuration
    UILabel *selectConfigurationLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,width - (width/100)*8, (height/100)*2)];
    [selectConfigurationLabel setText:[LabelUtils getLabelForKey:@"select_config"]];
    [selectConfigurationLabel setAlpha:0.7];
    [selectConfigurationLabel setFont:[UIFont systemFontOfSize:14]];
    selectConfigurationLabel.numberOfLines = 0;
    selectConfigurationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:selectConfigurationLabel];
    
    //Select Configuration TextField
    selectConfigurationTextField = [[UITextField alloc] initWithFrame:CGRectMake(selectConfigurationLabel.frame.origin.x, selectConfigurationLabel.frame.origin.y + selectConfigurationLabel.frame.size.height + (height/100)*0.5, selectConfigurationLabel.frame.size.width, (height/100)*6)];
    [selectConfigurationTextField setFont:[UIFont systemFontOfSize:12]];
    selectConfigurationTextField.layer.cornerRadius = 5;
    selectConfigurationTextField.layer.borderWidth = 1.0;
    selectConfigurationTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [selectConfigurationTextField setAlpha:0.7];
    [selectConfigurationTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    selectConfigurationTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:selectConfigurationTextField];
    
    UIImageView *selectConfigurationDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectConfigurationTextField.frame.origin.x + selectConfigurationTextField.frame.size.width - (width/100)*9 , selectConfigurationTextField.frame.origin.y + (selectConfigurationTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [selectConfigurationDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:selectConfigurationDownArrowImage];
    
    scrollView_IdCaptureFront = [[UIScrollView alloc] initWithFrame:CGRectMake(0, selectConfigurationTextField.frame.origin.y + selectConfigurationTextField.frame.size.height + (height/100)*1, width, height - selectConfigurationTextField.frame.origin.y - selectConfigurationTextField.frame.size.height - (height/100)*1 - (height/100)*9 - self.navigationController.navigationBar.frame.size.height - isiPhoneX_padding)];
    [scrollView_IdCaptureFront setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [scrollView_IdCaptureFront setScrollEnabled:YES];
    [scrollView_IdCaptureFront setShowsHorizontalScrollIndicator:YES];
    [scrollView_IdCaptureFront setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView_IdCaptureFront];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(selectConfigurationTextField.frame.origin.x, scrollView_IdCaptureFront.frame.origin.y + scrollView_IdCaptureFront.frame.size.height + (height/100)*2 - isiPhoneX_padding, (selectConfigurationTextField.frame.size.width/100)*45, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (selectConfigurationTextField.frame.size.width/100)*5, backBtn.frame.origin.y , backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    float scrollViewContentSizeHt =  [self scrollViewUI_IDFront:scrollView_IdCaptureFront];
    
    [scrollView_IdCaptureFront setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    [scrollView_IdCaptureFront setHidden:NO];
    [self isCaptureFrontSaveSetting];
    
    //Add numeric keyboard-Start
    [idOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedIdOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [colorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedColorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [headerSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textSizeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    // Selfie Capture
    
    scrollView_selfieCapture = [self initializeScrollView:selectConfigurationTextField];
    
    float scrollViewContentSizeHt_Selfie =  [self scrollViewUI_SelfieCapture:scrollView_selfieCapture];
    
    [scrollView_selfieCapture setContentSize:CGSizeMake(width, scrollViewContentSizeHt_Selfie + (height/100)*3)];
    
//    [self sefieCaptureRetrieveSetting];
    [scrollView_selfieCapture setHidden:YES];
    
    //Add numeric keypad start
    [faceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [instPreviewTransColorField_Face setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedFaceOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [outlineDetectedColorOfFaceOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [headerSizeTextField_Face setKeyboardType:UIKeyboardTypeNumberPad];
    [textSizeTextField_Face setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Four Finger Capture
    
    scrollView_4F = [self initializeScrollView:selectConfigurationTextField];
    
    float scrollViewContentSizeHt_4F = [self scrollViewUI_FourFinger:scrollView_4F];
    
    [scrollView_4F setContentSize:CGSizeMake(width, scrollViewContentSizeHt_4F + (height/100)*3)];
    //[self FourFCaptureRetrieveSetting];
    [scrollView_4F setHidden:YES];
    
    // Voice Capture
    scrollView_voiceCapture = [self initializeScrollView:selectConfigurationTextField];
    
    float scrollViewContentSizeht_voiceCapture = [self scrollViewUI_VoiceCapture:scrollView_voiceCapture];
    [scrollView_voiceCapture setContentSize:CGSizeMake(width, scrollViewContentSizeht_voiceCapture + (height/100)*3)];
    [scrollView_voiceCapture setHidden:YES];
    
    [self.view bringSubviewToFront:backBtn];
    [self.view bringSubviewToFront:nextBtn];
    
}

-(void)nextButton:(UIButton*)button {
    
    if(4 == selectConfig_row) {
        [self updateSelfieConfig];
        [self saveSetting_Selfie];
    } else if(5 == selectConfig_row) {
        [self updateFingerPrintConfig];
        [self saveSetting_4F];
    } else if(8 == selectConfig_row) {
        [self saveSetting_voiceCapture];
        [self updateVoiceConfig];
    } else {
        [self updateIDConfig:selectConfig_row];
    }
    
    RootPageViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RootPageViewController"];
    controller.pageControlFields = _pageControlFields;
    controller.serviceType = _serviceType;
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *justToCheck = [CustomizeUIConfigManager getCompleteUIConfigDictionary];
    [AppItSDK customizeUserInterface:[CustomizeUIConfigManager getCompleteUIConfigDictionary]];
}

-(void)backButton:(UIButton*)button {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)idCaptureFrontPicketDataArray {
    
    showTitlePickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    _selectedPickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    
    showFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"],[LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    _selectedFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    showHeaderFontStylePickerData = @[[LabelUtils getLabelForKey:@"default"],[LabelUtils getLabelForKey:@"helvetica"],[LabelUtils getLabelForKey:@"helvetica_bold"], [LabelUtils getLabelForKey:@"helvetica_bold_oblique"],[LabelUtils getLabelForKey:@"helvetica_light"],[LabelUtils getLabelForKey:@"helvetica_light_oblique"],[LabelUtils getLabelForKey:@"helvetica_neue"],[LabelUtils getLabelForKey:@"helvetica_neue_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_bold_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_black"],[LabelUtils getLabelForKey:@"helvetica_neue_condensed_bold"],[LabelUtils getLabelForKey:@"helvetica_neue_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_light"],[LabelUtils getLabelForKey:@"helvetica_neue_light_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_medium"],[LabelUtils getLabelForKey:@"helvetica_neue_medium_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_thin"],[LabelUtils getLabelForKey:@"helvetica_neue_thin_italic"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight"],[LabelUtils getLabelForKey:@"helvetica_neue_ultraLight_italic"],[LabelUtils getLabelForKey:@"helvetica_oblique"]];
    _idCaptreTitlePickerData = @[[LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Center"], [LabelUtils getLabelForKey:@"Bottom"]];
    _idCaptureHintMsgPickerData = @[[LabelUtils getLabelForKey:@"Center"], [LabelUtils getLabelForKey:@"Bottom"], [LabelUtils getLabelForKey:@"Top"]];
    _idCaptureTitleImagePickerData = @[[LabelUtils getLabelForKey:@"Bottom"], [LabelUtils getLabelForKey:@"Top"], [LabelUtils getLabelForKey:@"Center"]];
    _idCaptureLabelPickerData = @[@"align_document_img_capture", @"subject_is_too_dark_img_capture", @"out_of_focus_img_capture", @"too_much_glare_img_capture", @"light", @"focus", @"glare", @"page_title_image_capture", @"id_capture_instruction", @"id_capture_preview_header", @"id_capture_preview_message"];
    _idCaptureBorderLabelPickerData = @[[LabelUtils getLabelForKey:@"thick"], [LabelUtils getLabelForKey:@"thin"]];
    _selectConfigurationPickerData = @[[LabelUtils getLabelForKey:@"id_front_capture"],[LabelUtils getLabelForKey:@"id_back_capture"], [LabelUtils getLabelForKey:@"document_capture_tab"], [LabelUtils getLabelForKey:@"snippet_capture"], [LabelUtils getLabelForKey:@"selfie_capture"], [LabelUtils getLabelForKey:@"fingerprint_capture_4F"], [LabelUtils getLabelForKey:@"secondary_id_capture_front"], [LabelUtils getLabelForKey:@"secondary_id_capture_back"], [LabelUtils getLabelForKey:@"voice_recording"]];
    
}

-(void)onResumeCode {
    
    isFirstTime = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    
    //For IDCaptureFront
    
    [showTitleImgTextField setDelegate:(id)self];
    [fontStyleTextField setDelegate:(id)self];
    [headerFontStyleTextField setDelegate:(id)self];
    [idCaptureTitleTextField setDelegate:(id)self];
    [idCaptureHintMsgTextField setDelegate:(id)self];
    [idCapturetitleImageTextField setDelegate:(id)self];
    [idCaptureLabelTextField setDelegate:(id)self];
    [idCaptureBorderLabelTextField setDelegate:(id)self];
    [selectConfigurationTextField setDelegate:(id)self];
    
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
    [selectConfigurationTextField setInputView:myPickerView];
    [selectConfigurationTextField setText:_selectConfigurationPickerData[0]];
    
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
    [selectConfigurationTextField setInputAccessoryView:toolbarForPicker];
    
    //
    
    //Selfie Capture
    [selectTitleImgTextField setDelegate:(id)self];
    [faceTitleTextField setDelegate:(id)self];
    [faceHintMsgTextField setDelegate:(id)self];
    [faceHintIconTextField setDelegate:(id)self];
    [faceTitleImageTextField setDelegate:(id)self];
    [faceCaptureLabelTextField setDelegate:(id)self];
    [fontStyleTextField_Face setDelegate:(id)self];
    [faceContoursTextField setDelegate:(id)self];
    [faceImageTypeTextField setDelegate:(id)self];
    [headerFontStyleTextField_Face setDelegate:(id)self];
    
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setText:showTitlePickerData[0]];
    [fontStyleTextField_Face setInputView:myPickerView];
    [fontStyleTextField_Face setText:showFontStylePickerData[0]];
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
    [headerFontStyleTextField_Face setInputView:myPickerView];
    [headerFontStyleTextField_Face setText:showHeaderFontStylePickerData[0]];
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputView:myPickerView];
    
    [fontStyleTextField_Face setInputView:myPickerView];
    [fontStyleTextField_Face setInputAccessoryView:toolbarForPicker];
    [headerFontStyleTextField_Face setInputView:myPickerView];
    [headerFontStyleTextField_Face setInputAccessoryView:toolbarForPicker];
    [faceTitleTextField setInputAccessoryView:toolbarForPicker];
    [faceHintMsgTextField setInputAccessoryView:toolbarForPicker];
    [faceHintIconTextField setInputAccessoryView:toolbarForPicker];
    [faceTitleImageTextField setInputAccessoryView:toolbarForPicker];
    [faceContoursTextField setInputAccessoryView:toolbarForPicker];
    [faceCaptureLabelTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputAccessoryView:toolbarForPicker];
    //
    
    //Four Finger Capture
    [fontStyleTextField_4F setDelegate:(id)self];
    [fontStyleTextField_4F setInputView:myPickerView];
    [fontStyleTextField_4F setText:showFontStylePickerData[0]];
    [fontStyleTextField_4F setInputAccessoryView:toolbarForPicker];
    
    //Voice Capture
    [btnColorTextField_voiceCapture setDelegate:(id)self];
    [btnColorTransTextField_voiceCapture setDelegate:(id)self];
    [backgroundBtnTextField_voiceCapture setDelegate:(id)self];
    [backGroundBtnTransColorTextField_voiceCapture setDelegate:(id)self];
    [viewPositionTextField_voiceCapture setDelegate:(id)self];
    [textColortTextField_voiceCapture setDelegate:(id)self];
    [textColorAlphaTextField_voiceCapture setDelegate:(id)self];
    [titleTextColortTextField_voiceCapture setDelegate:(id)self];
    [titleTextColorAlphaTextField_voiceCapture setDelegate:(id)self];
    [titleLabelSizeTextField_voiceCapture setDelegate:(id)self];
    [textSizeTextField_voiceCapture setDelegate:(id)self];
    [counterLabelSizeTextField_voiceCapture setDelegate:(id)self];
    [labelsTextField_voiceCapture setDelegate:(id)self];
    [labelValueTextField_voiceCapture setDelegate:(id)self];
    
    [viewPositionTextField_voiceCapture setInputView:myPickerView];
    [labelsTextField_voiceCapture setInputView:myPickerView];
    [labelsTextField_voiceCapture setText:_voiceCaptureLabelPickerData[0]];
    [labelsTextField_voiceCapture setInputAccessoryView:toolbarForPicker];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if(false) {
        isFirstTime = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    
    //For IDCaptureFront
    
    [showTitleImgTextField setDelegate:(id)self];
    [fontStyleTextField setDelegate:(id)self];
    [headerFontStyleTextField setDelegate:(id)self];
    [idCaptureTitleTextField setDelegate:(id)self];
    [idCaptureHintMsgTextField setDelegate:(id)self];
    [idCapturetitleImageTextField setDelegate:(id)self];
    [idCaptureLabelTextField setDelegate:(id)self];
    [idCaptureBorderLabelTextField setDelegate:(id)self];
    [selectConfigurationTextField setDelegate:(id)self];
        
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
    [selectConfigurationTextField setInputView:myPickerView];
    [selectConfigurationTextField setText:_selectConfigurationPickerData[0]];
    
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
    [selectConfigurationTextField setInputAccessoryView:toolbarForPicker];
    
    //
    
    //Selfie Capture
    [selectTitleImgTextField setDelegate:(id)self];
    [faceTitleTextField setDelegate:(id)self];
    [faceHintMsgTextField setDelegate:(id)self];
    [faceHintIconTextField setDelegate:(id)self];
    [faceTitleImageTextField setDelegate:(id)self];
    [faceCaptureLabelTextField setDelegate:(id)self];
    [fontStyleTextField_Face setDelegate:(id)self];
    [faceContoursTextField setDelegate:(id)self];
    [faceImageTypeTextField setDelegate:(id)self];
    [headerFontStyleTextField_Face setDelegate:(id)self];
    
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setText:showTitlePickerData[0]];
    [fontStyleTextField_Face setInputView:myPickerView];
    [fontStyleTextField_Face setText:showFontStylePickerData[0]];
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
    [headerFontStyleTextField_Face setInputView:myPickerView];
    [headerFontStyleTextField_Face setText:showHeaderFontStylePickerData[0]];
    [selectTitleImgTextField setInputView:myPickerView];
    [selectTitleImgTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputView:myPickerView];
    
    [fontStyleTextField_Face setInputView:myPickerView];
    [fontStyleTextField_Face setInputAccessoryView:toolbarForPicker];
    [headerFontStyleTextField_Face setInputView:myPickerView];
    [headerFontStyleTextField_Face setInputAccessoryView:toolbarForPicker];
    [faceTitleTextField setInputAccessoryView:toolbarForPicker];
    [faceHintMsgTextField setInputAccessoryView:toolbarForPicker];
    [faceHintIconTextField setInputAccessoryView:toolbarForPicker];
    [faceTitleImageTextField setInputAccessoryView:toolbarForPicker];
    [faceContoursTextField setInputAccessoryView:toolbarForPicker];
    [faceCaptureLabelTextField setInputAccessoryView:toolbarForPicker];
    [faceImageTypeTextField setInputAccessoryView:toolbarForPicker];
    //
    
    //Four Finger Capture
    [fontStyleTextField_4F setDelegate:(id)self];
    [fontStyleTextField_4F setInputView:myPickerView];
    [fontStyleTextField_4F setText:showFontStylePickerData[0]];
    [fontStyleTextField_4F setInputAccessoryView:toolbarForPicker];
    }
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [selectConfigurationTextField resignFirstResponder];
    
    //IDFront
    [showTitleImgTextField resignFirstResponder];
    [fontStyleTextField resignFirstResponder];
    [headerFontStyleTextField resignFirstResponder];
    [idCaptureTitleTextField resignFirstResponder];
    [idCaptureHintMsgTextField resignFirstResponder];
    [idCapturetitleImageTextField resignFirstResponder];
    [idCaptureLabelTextField resignFirstResponder];
    [idCaptureBorderLabelTextField resignFirstResponder];
    
    //Selfie Capture
    [selectTitleImgTextField resignFirstResponder];
    [fontStyleTextField_Face resignFirstResponder];
    [headerFontStyleTextField_Face resignFirstResponder];
    [faceTitleTextField resignFirstResponder];
    [faceHintMsgTextField resignFirstResponder];
    [faceHintIconTextField resignFirstResponder];
    [faceTitleImageTextField resignFirstResponder];
    [faceCaptureLabelTextField resignFirstResponder];
    [faceContoursTextField resignFirstResponder];
    [faceImageTypeTextField resignFirstResponder];
    
    //Four FingerCapture
    [fontStyleTextField_4F resignFirstResponder];
    
    //VoiceCapture
    [viewPositionTextField_voiceCapture resignFirstResponder];
    [labelsTextField_voiceCapture resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //IDFront
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
    } else if(textField == selectConfigurationTextField) {
        textFieldTypeForPicker = @"selectConfigurationTextField";
        _selectedPickerData = _selectConfigurationPickerData;
        [myPickerView reloadAllComponents];
    }
    
    //
    
    //Selfie
    if (textField == selectTitleImgTextField){
        textFieldTypeForPicker = @"selectTitleImgTextField_Face";
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    }else if (textField == fontStyleTextField_Face){
        textFieldTypeForPicker = @"fontStyleTextField_Face";
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
    }else if(textField == headerFontStyleTextField_Face) {
        textFieldTypeForPicker = @"FaceHeaderFontStyleTextField";
        _selectedPickerData = showHeaderFontStylePickerData;
        [myPickerView reloadAllComponents];
    }
    //
    
    //Four Finger Capture
    if(textField == fontStyleTextField_4F) {
        textFieldTypeForPicker = @"fontStyleTextField_4F";
        _selectedPickerData = showFontStylePickerData;
        [myPickerView reloadAllComponents];
    }
    
    //VoiceCapture
    if(textField == viewPositionTextField_voiceCapture) {
        textFieldTypeForPicker = @"viewPositionTextField_voiceCapture";
        _selectedPickerData = _idCaptureHintMsgPickerData;
//        _selectedPickerData = _idCaptureTitleImagePickerData;
        [myPickerView reloadAllComponents];
    }
    if(textField == labelsTextField_voiceCapture) {
        textFieldTypeForPicker = @"labelsTextField_voiceCapture";
        _selectedPickerData = _voiceCaptureLabelPickerData;
        [myPickerView reloadAllComponents];
    }
    
    //
    
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
    
    // IDFront
    
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
    if([textFieldTypeForPicker isEqualToString:@"selectConfigurationTextField"]) {
        
        if(row != selectConfig_row) {
        if(0 == selectConfig_row) {
            
            [self saveSetting_IdFront];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(1 == selectConfig_row) {
            
            [self saveSetting_IdBack];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(2 == selectConfig_row) {
            
            [self saveSetting_Document];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(3 == selectConfig_row) {
            
            [self saveSetting_Snippet];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(4 == selectConfig_row) {
            
            [self saveSetting_Selfie];
            [self updateSelfieConfig];
            
        } else if(5 == selectConfig_row) {
            
            [self saveSetting_Snippet];
            [self updateFingerPrintConfig];
        } else if(6 == selectConfig_row) {
            
            [self saveSetting_SecondaryIdFront];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(7 == selectConfig_row) {
            
            [self saveSetting_SecondaryIdBack];
            [self updateIDConfig:selectConfig_row];
            
            [showTitleImgTextField setText:showTitlePickerData[0]];
            [fontStyleTextField setText:showFontStylePickerData[0]];
            [headerFontStyleTextField setText:showHeaderFontStylePickerData[0]];
            [idCaptureLabelTextField setText:_idCaptureLabelPickerData[0]];
            [idCaptureBorderLabelTextField setText:_idCaptureBorderLabelPickerData[0]];
            [idCaptureTitleTextField setText:_idCaptreTitlePickerData[0]];
            [idCaptureHintMsgTextField setText:_idCaptureHintMsgPickerData[0]];
            [idCapturetitleImageTextField setText:_idCaptureTitleImagePickerData[0]];
            
        } else if(8 == selectConfig_row) {
            [self saveSetting_voiceCapture];
            [self updateVoiceConfig];
        }
        
        selectConfig_row = (int) row;
        switch (row) {
            case 0:
                //if([scrollView_IdCaptureFront isHidden]) {
                    [scrollView_IdCaptureFront setHidden:NO];
                    [scrollView_4F setHidden:YES];
                    [scrollView_voiceCapture setHidden:YES];
                    [scrollView_selfieCapture setHidden:YES];
                    [self isCaptureFrontSaveSetting];
                //}
                break;
            case 1 :
                [scrollView_IdCaptureFront setHidden:NO];
                [scrollView_4F setHidden:YES];
                [scrollView_voiceCapture setHidden:YES];
                [scrollView_selfieCapture setHidden:YES];
                [self idCaptureBackRetrieveSetting];
                break;
            case 2 :
                [scrollView_IdCaptureFront setHidden:NO];
                [scrollView_4F setHidden:YES];
                [scrollView_voiceCapture setHidden:YES];
                [scrollView_selfieCapture setHidden:YES];
                [self documentRetrieveSetting];
                break;
            case 3 :
                [scrollView_IdCaptureFront setHidden:NO];
                [scrollView_4F setHidden:YES];
                [scrollView_voiceCapture setHidden:YES];
                [scrollView_selfieCapture setHidden:YES];
                [self snippetRetrieveSetting];
                break;
            case 4 :
                if([scrollView_selfieCapture isHidden]) {
                    [scrollView_selfieCapture setHidden:NO];
                    [scrollView_4F setHidden:YES];
                    [scrollView_voiceCapture setHidden:YES];
                    [scrollView_IdCaptureFront setHidden:YES];
                    [self sefieCaptureRetrieveSetting];
                }
                break;
            case 5 :
                if([scrollView_4F isHidden]) {
                    [scrollView_4F setHidden:NO];
                    [scrollView_voiceCapture setHidden:YES];
                    [scrollView_IdCaptureFront setHidden:YES];
                    [scrollView_selfieCapture setHidden:YES];
                    [self FourFCaptureRetrieveSetting];
                }
                break;
            case 6 :
                [scrollView_IdCaptureFront setHidden:NO];
                [scrollView_4F setHidden:YES];
                [scrollView_voiceCapture setHidden:YES];
                [scrollView_selfieCapture setHidden:YES];
                [self secondaryIdCaptureFrontRetrieveSetting];
                break;
            case 7 :
                [scrollView_IdCaptureFront setHidden:NO];
                [scrollView_4F setHidden:YES];
                [scrollView_voiceCapture setHidden:YES];
                [scrollView_selfieCapture setHidden:YES];
                [self secondaryIdCaptureBackRetrieveSetting];
                break;
            case 8 :
                if([scrollView_voiceCapture isHidden]) {
                    [scrollView_voiceCapture setHidden:NO];
                    [scrollView_4F setHidden:YES];
                    [scrollView_IdCaptureFront setHidden:YES];
                    [scrollView_selfieCapture setHidden:YES];
                    [self retrieveSettingVoiceCapture];
                }
                break;
            default:
                break;
        }
        
        [selectConfigurationTextField setText:_selectConfigurationPickerData[row]];
        [selectConfigurationTextField setTag:row+1];
        }
    }
    
    //
    
    //SelfieCapture
    if([textFieldTypeForPicker isEqualToString:@"selectTitleImgTextField_Face"]) {
        [selectTitleImgTextField setText:showTitlePickerData[row]];
        [selectTitleImgTextField setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"fontStyleTextField_Face"]){
        [fontStyleTextField_Face setText:showFontStylePickerData[row]];
        [fontStyleTextField_Face setTag:row+1];
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
    if([textFieldTypeForPicker isEqualToString:@"FaceHeaderFontStyleTextField"]) {
        [headerFontStyleTextField_Face setText:showHeaderFontStylePickerData[row]];
        [headerFontStyleTextField_Face setTag:row+1];
    }
    //
    
    //Four Fing Capture
    if([textFieldTypeForPicker isEqualToString:@"fontStyleTextField_4F"]) {
        [fontStyleTextField_4F setText:showFontStylePickerData[row]];
        [fontStyleTextField_4F setTag:row+1];
    }
    
    //Voice Capture
    if([textFieldTypeForPicker isEqualToString:@"viewPositionTextField_voiceCapture"]) {
        [viewPositionTextField_voiceCapture setText:_idCaptureHintMsgPickerData[row]];
        [viewPositionTextField_voiceCapture setTag:row+1];
    }
    if([textFieldTypeForPicker isEqualToString:@"labelsTextField_voiceCapture"]) {
        [labelsTextField_voiceCapture setText:_voiceCaptureLabelPickerData[row]];
        [labelsTextField_voiceCapture setTag:row+1];
    }
    
}
//Picker Changes End

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
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
    label.text = @"Customize UI Configuration";
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

- (float)scrollViewUI_IDFront:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
    //Id Outline color
    UILabel *idOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [idOutLineColorLabel setText:[LabelUtils getLabelForKey:@"id_outline_color"]];
    [idOutLineColorLabel setAlpha:0.7];
    [idOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    idOutLineColorLabel.numberOfLines = 0;
    idOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idOutLineColorLabel];
    
    //Id Outline Color Transparency
    UILabel *idOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    [idOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [idOutlineTransLabel setAlpha:0.7];
    idOutlineTransLabel.numberOfLines = 0;
    idOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:idOutlineTransLabel];
    
    //id outline color TextField
    idOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idOutLineColorLabel.frame.origin.y + idOutLineColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [idOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    idOutlineColorTextField.layer.cornerRadius = 5;
    idOutlineColorTextField.layer.borderWidth = 1.0;
    idOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTextField setAlpha:0.7];
    [idOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idOutlineColorTextField];
    
    //id outline color Trans TextField
    idOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, idOutlineColorTextField.frame.origin.y, idOutlineTransLabel.frame.size.width, (height/100)*4)];
    [idOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]]; idOutlineColorTransTextField.layer.cornerRadius = 5;
    idOutlineColorTransTextField.layer.borderWidth = 1.0;
    idOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTransTextField setAlpha:0.7];
    [idOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idOutlineColorTransTextField];
    
    //Detected ID Outline Color
    //Detected Id outline Color Label
    UILabel *detectedIdOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idOutlineColorTextField.frame.origin.y + idOutlineColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [detectedIdOutLineColorLabel setText:[LabelUtils getLabelForKey:@"detected_id_outline_color"]];
    [detectedIdOutLineColorLabel setAlpha:0.7];
    [detectedIdOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedIdOutLineColorLabel.numberOfLines = 0;
    detectedIdOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:detectedIdOutLineColorLabel];
    
    //Detected Id Outline Color Transparency
    UILabel *detectedIdOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idOutlineColorTransTextField.frame.origin.y + idOutlineColorTransTextField.frame.size.height +  (height/100)*2, idOutlineColorTransTextField.frame.size.width, (height/100)*2)];
    [detectedIdOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedIdOutlineTransLabel setAlpha:0.7];
    detectedIdOutlineTransLabel.numberOfLines = 0;
    detectedIdOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:detectedIdOutlineTransLabel];
    
    //Detected Id outline Color text field
    detectedIdOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedIdOutLineColorLabel.frame.origin.y + detectedIdOutLineColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [detectedIdOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTextField setAlpha:0.7];
    [detectedIdOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedIdOutlineColorTextField];
    
    //Detected Id outline Color Transparency
    detectedIdOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedIdOutlineTransLabel.frame.origin.y + detectedIdOutlineTransLabel.frame.size.height + (height/100)*1, detectedIdOutlineTransLabel.frame.size.width, (height/100)*4)];
    [detectedIdOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTransTextField setAlpha:0.7];
    [detectedIdOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedIdOutlineColorTransTextField];
    
    //Color OutsideOutline
    //Color Outside Outline Label
    UILabel *colorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedIdOutlineColorTextField.frame.origin.y + detectedIdOutlineColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [colorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"color_outside_outline"]];
    [colorOutsideOutLineLabel setAlpha:0.7];
    [colorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    colorOutsideOutLineLabel.numberOfLines = 0;
    colorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:colorOutsideOutLineLabel];
    
    //Color Outside Outline Transparency
    UILabel *colorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedIdOutlineColorTransTextField.frame.origin.y + detectedIdOutlineColorTransTextField.frame.size.height +  (height/100)*2, idOutlineColorTransTextField.frame.size.width, (height/100)*2)];
    [colorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [colorOutsideOutlineTransLabel setAlpha:0.7];
    colorOutsideOutlineTransLabel.numberOfLines = 0;
    colorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:colorOutsideOutlineTransLabel];
    
    //Color Outside Outline TextField
    colorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, colorOutsideOutLineLabel.frame.origin.y + colorOutsideOutLineLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [colorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTextField setAlpha:0.7];
    [colorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:colorOutsideOutlineTextField];
    
    //Color Outside Outline Transparency TextField
    colorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, colorOutsideOutlineTransLabel.frame.origin.y + colorOutsideOutlineTransLabel.frame.size.height + (height/100)*1, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [colorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTransTextField setAlpha:0.7];
    [colorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:colorOutsideOutlineTransTextField];
    
    //Detected Color Outside OutLine
    //Detected Color OutSide OutLine Label
    UILabel *detectedColorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,colorOutsideOutlineTextField.frame.origin.y + colorOutsideOutlineTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*5)];
    [detectedColorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"detected_color_outside_outline"]];
    [detectedColorOutsideOutLineLabel setAlpha:0.7];
    [detectedColorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    detectedColorOutsideOutLineLabel.numberOfLines = 0;
    detectedColorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:detectedColorOutsideOutLineLabel];
    
    //Detected Color Outside Outline Transparency
    UILabel *detectedcolorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,colorOutsideOutlineTransTextField.frame.origin.y + colorOutsideOutlineTransTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [detectedcolorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedcolorOutsideOutlineTransLabel setAlpha:0.7];
    detectedcolorOutsideOutlineTransLabel.numberOfLines = 0;
    detectedcolorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedcolorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:detectedcolorOutsideOutlineTransLabel];
    
    //Detected Color Outside Outline TextField
    detectedColorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedColorOutsideOutLineLabel.frame.origin.y + detectedColorOutsideOutLineLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [detectedColorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedColorOutsideOutlineTextField];
    
    //Detected Color Outside Outline Trans TextField
    detectedColorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedColorOutsideOutlineTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [detectedColorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTransTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedColorOutsideOutlineTransTextField];
    
    //Text/Header Size
    //Header Size label
    UILabel *headerTextSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedColorOutsideOutlineTextField.frame.origin.y + detectedColorOutsideOutlineTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [headerTextSizeLabel setText:[LabelUtils getLabelForKey:@"header_text_label_size"]];
    [headerTextSizeLabel setAlpha:0.7];
    [headerTextSizeLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextSizeLabel.numberOfLines = 0;
    headerTextSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerTextSizeLabel];
    
    //Text Size Label
    UILabel *textSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedColorOutsideOutlineTextField.frame.origin.y + detectedColorOutsideOutlineTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [textSizeLabel setText:[LabelUtils getLabelForKey:@"text_label_size"]];
    [textSizeLabel setAlpha:0.7];
    textSizeLabel.numberOfLines = 0;
    textSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textSizeLabel];
    
    //Header size TextField
    headerSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, headerTextSizeLabel.frame.origin.y + headerTextSizeLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [headerSizeTextField setFont:[UIFont systemFontOfSize:12]];
    headerSizeTextField.layer.cornerRadius = 5;
    headerSizeTextField.layer.borderWidth = 1.0;
    headerSizeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerSizeTextField setAlpha:0.7];
    [headerSizeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerSizeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerSizeTextField];
    
    //Text size TextField
    textSizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, headerSizeTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [textSizeTextField setFont:[UIFont systemFontOfSize:12]];
    textSizeTextField.layer.cornerRadius = 5;
    textSizeTextField.layer.borderWidth = 1.0;
    textSizeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textSizeTextField setAlpha:0.7];
    [textSizeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textSizeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textSizeTextField];
    
    //Font Style
    //Font Style Label
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerSizeTextField.frame.origin.y + headerSizeTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(idOutLineColorLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [fontStyleTextField setFont:[UIFont systemFontOfSize:12]];
    fontStyleTextField.layer.cornerRadius = 5;
    fontStyleTextField.layer.borderWidth = 1.0;
    fontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [fontStyleTextField setAlpha:0.7];
    [fontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    fontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:fontStyleTextField];
    
    //Header Font Style
    //Font Style Label
    UILabel *headerFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [headerFontStyleLabel setText:[LabelUtils getLabelForKey:@"header_text_font_style"]];
    [headerFontStyleLabel setAlpha:0.7];
    [headerFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    headerFontStyleLabel.numberOfLines = 0;
    headerFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerFontStyleLabel];
    
    //Font Style TextField
    headerFontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(idOutLineColorLabel.frame.origin.x, headerFontStyleLabel.frame.origin.y + headerFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [headerFontStyleTextField setFont:[UIFont systemFontOfSize:12]];
    headerFontStyleTextField.layer.cornerRadius = 5;
    headerFontStyleTextField.layer.borderWidth = 1.0;
    headerFontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerFontStyleTextField setAlpha:0.7];
    [headerFontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerFontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerFontStyleTextField];
    
    //Text Color/transparency
    //Text Color Label
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textColorLabel];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,headerFontStyleTextField.frame.origin.y + headerFontStyleTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textColorTransLabel];
    
    //Text Color TextField
    textColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [textColorTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTextField.layer.cornerRadius = 5;
    textColorTextField.layer.borderWidth = 1.0;
    textColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTextField setAlpha:0.7];
    [textColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textColorTextField];
    
    //Transparency TextField
    textColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, textColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*1, textColorTransLabel.frame.size.width, (height/100)*4)];
    [textColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTransTextField.layer.cornerRadius = 5;
    textColorTransTextField.layer.borderWidth = 1.0;
    textColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTransTextField setAlpha:0.7];
    [textColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textColorTransTextField];
    
    //Header Text Color/transparency
    //Header Text Color Label
    UILabel *headerTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,textColorTextField.frame.origin.y + textColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [headerTextColorLabel setText:[LabelUtils getLabelForKey:@"header_text_label_color"]];
    [headerTextColorLabel setAlpha:0.7];
    [headerTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextColorLabel.numberOfLines = 0;
    headerTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerTextColorLabel];
    
    //Transparency Label
    UILabel *headerTextColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,textColorTransTextField.frame.origin.y + textColorTransTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [headerTextColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [headerTextColorTransLabel setAlpha:0.7];
    headerTextColorTransLabel.numberOfLines = 0;
    headerTextColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:headerTextColorTransLabel];
    
    //Header Text Color TextField
    headerTextColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, headerTextColorLabel.frame.origin.y + headerTextColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [headerTextColorTextField setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTextField.layer.cornerRadius = 5;
    headerTextColorTextField.layer.borderWidth = 1.0;
    headerTextColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTextField setAlpha:0.7];
    [headerTextColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerTextColorTextField];
    
    //Transparency TextField
    headerTextColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, headerTextColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*1, headerTextColorTransLabel.frame.size.width, (height/100)*4)];
    [headerTextColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTransTextField.layer.cornerRadius = 5;
    headerTextColorTransTextField.layer.borderWidth = 1.0;
    headerTextColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTransTextField setAlpha:0.7];
    [headerTextColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    headerTextColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:headerTextColorTransTextField];
    
    //Back Button/transparency
    //Back button Label
    UILabel *backButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,headerTextColorTextField.frame.origin.y + headerTextColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [backButtonLabel setText:[LabelUtils getLabelForKey:@"back_button_color"]];
    [backButtonLabel setAlpha:0.7];
    [backButtonLabel setFont:[UIFont systemFontOfSize:11]];
    backButtonLabel.numberOfLines = 0;
    backButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:backButtonLabel];
    
    //Transparency Label
    UILabel *backButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,headerTextColorTransTextField.frame.origin.y + headerTextColorTransTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [backButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backButtonTransLabel setAlpha:0.7];
    backButtonTransLabel.numberOfLines = 0;
    backButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [scrollView addSubview:backButtonTransLabel];
    
    //Back Button TextField
    backButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, backButtonLabel.frame.origin.y + backButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [backButtonTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTextField.layer.cornerRadius = 5;
    backButtonTextField.layer.borderWidth = 1.0;
    backButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTextField setAlpha:0.7];
    [backButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:backButtonTextField];
    
    //Transparency TextField
    backButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, backButtonTransLabel.frame.origin.y + backButtonTransLabel.frame.size.height + (height/100)*1, backButtonTransLabel.frame.size.width, (height/100)*4)];
    [backButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTransTextField.layer.cornerRadius = 5;
    backButtonTransTextField.layer.borderWidth = 1.0;
    backButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTransTextField setAlpha:0.7];
    [backButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    backButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:backButtonTransTextField];
    
    //Retry Button/Transparency
    //Retry Button Label
    UILabel *retryButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,backButtonTextField.frame.origin.y + backButtonTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [retryButtonLabel setText:[LabelUtils getLabelForKey:@"retry_button_color"]];
    [retryButtonLabel setAlpha:0.7];
    [retryButtonLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonLabel.numberOfLines = 0;
    retryButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:retryButtonLabel];
    
    //Transparency Label
    UILabel *retryButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,backButtonTransTextField.frame.origin.y + backButtonTransTextField.frame.size.height +  (height/100)*2, backButtonTransTextField.frame.size.width, (height/100)*2)];
    [retryButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonTransLabel setAlpha:0.7];
    retryButtonTransLabel.numberOfLines = 0;
    retryButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:retryButtonTransLabel];
    
    //Retry Button TextField
    retryButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, retryButtonLabel.frame.origin.y + retryButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [retryButtonTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTextField.layer.cornerRadius = 5;
    retryButtonTextField.layer.borderWidth = 1.0;
    retryButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTextField setAlpha:0.7];
    [retryButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:retryButtonTextField];
    
    //Transparency TextField
    retryButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, retryButtonTransLabel.frame.origin.y + retryButtonTransLabel.frame.size.height + (height/100)*1, retryButtonTransLabel.frame.size.width, (height/100)*4)];
    [retryButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTransTextField.layer.cornerRadius = 5;
    retryButtonTransTextField.layer.borderWidth = 1.0;
    retryButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTransTextField setAlpha:0.7];
    [retryButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:retryButtonTransTextField];
    
    //Retry Button Border/Transparency
    //Retry Button Border Label
    UILabel *retryButtonBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [retryButtonBorderLabel setText:[LabelUtils getLabelForKey:@"retry_button_border_color"]];
    [retryButtonBorderLabel setAlpha:0.7];
    [retryButtonBorderLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonBorderLabel.numberOfLines = 0;
    retryButtonBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:retryButtonBorderLabel];
    
    //Transparency Label
    UILabel *retryButtonBorderTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,retryButtonTransTextField.frame.origin.y + retryButtonTransTextField.frame.size.height +  (height/100)*2, retryButtonTransTextField.frame.size.width, (height/100)*2)];
    [retryButtonBorderTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonBorderTransLabel setAlpha:0.7];
    retryButtonBorderTransLabel.numberOfLines = 0;
    retryButtonBorderTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:retryButtonBorderTransLabel];
    
    //Retry Button Border TextField
    retryButtonBorderTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, retryButtonBorderLabel.frame.origin.y + retryButtonBorderLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [retryButtonBorderTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTextField.layer.cornerRadius = 5;
    retryButtonBorderTextField.layer.borderWidth = 1.0;
    retryButtonBorderTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTextField setAlpha:0.7];
    [retryButtonBorderTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:retryButtonBorderTextField];
    
    //Transparency TextField
    retryButtonBorderTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, retryButtonBorderTransLabel.frame.origin.y + retryButtonBorderTransLabel.frame.size.height + (height/100)*1, retryButtonBorderTransLabel.frame.size.width, (height/100)*4)];
    [retryButtonBorderTransTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTransTextField.layer.cornerRadius = 5;
    retryButtonBorderTransTextField.layer.borderWidth = 1.0;
    retryButtonBorderTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTransTextField setAlpha:0.7];
    [retryButtonBorderTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonBorderTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:retryButtonBorderTransTextField];
    
    //Confirm Button/Transparency
    //Confirm Button Label
    UILabel *confirmButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [confirmButtonLabel setText:[LabelUtils getLabelForKey:@"confirm_button_color"]];
    [confirmButtonLabel setAlpha:0.7];
    [confirmButtonLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonLabel.numberOfLines = 0;
    confirmButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:confirmButtonLabel];
    
    //Transparency Label
    UILabel *confirmButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,retryButtonBorderTextField.frame.origin.y + retryButtonBorderTextField.frame.size.height +  (height/100)*2, retryButtonBorderTextField.frame.size.width, (height/100)*2)];
    [confirmButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonTransLabel setAlpha:0.7];
    confirmButtonTransLabel.numberOfLines = 0;
    confirmButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:confirmButtonTransLabel];
    
    //Confirm Button TextField
    confirmButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, confirmButtonLabel.frame.origin.y + confirmButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTextField.layer.cornerRadius = 5;
    confirmButtonTextField.layer.borderWidth = 1.0;
    confirmButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTextField setAlpha:0.7];
    [confirmButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:confirmButtonTextField];
    
    //Transparency TextField
    confirmButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, confirmButtonTransLabel.frame.origin.y + confirmButtonTransLabel.frame.size.height + (height/100)*1, confirmButtonTransLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTransTextField.layer.cornerRadius = 5;
    confirmButtonTransTextField.layer.borderWidth = 1.0;
    confirmButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTransTextField setAlpha:0.7];
    [confirmButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:confirmButtonTransTextField];
    
    
    //Confirm Button/Transparency Style
    //Confirm Button Label
    UILabel *confirmButtonStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [confirmButtonStyleLabel setText:[LabelUtils getLabelForKey:@"confirm_button_style"]];
    [confirmButtonStyleLabel setAlpha:0.7];
    [confirmButtonStyleLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonStyleLabel.numberOfLines = 0;
    confirmButtonStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:confirmButtonStyleLabel];
    
    //Transparency Label
    UILabel *confirmButtonStyleTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height +  (height/100)*2, confirmButtonTextField.frame.size.width, (height/100)*2)];
    [confirmButtonStyleTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonStyleTransLabel setAlpha:0.7];
    confirmButtonStyleTransLabel.numberOfLines = 0;
    confirmButtonStyleTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:confirmButtonStyleTransLabel];
    
    //Confirm Button TextField
    confirmButtonStyleTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, confirmButtonStyleLabel.frame.origin.y + confirmButtonStyleLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [confirmButtonStyleTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTextField.layer.cornerRadius = 5;
    confirmButtonStyleTextField.layer.borderWidth = 1.0;
    confirmButtonStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTextField setAlpha:0.7];
    [confirmButtonStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:confirmButtonStyleTextField];
    
    //Transparency TextField
    confirmButtonStyleTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, confirmButtonStyleTransLabel.frame.origin.y + confirmButtonStyleTransLabel.frame.size.height + (height/100)*1, confirmButtonStyleTransLabel.frame.size.width, (height/100)*4)];
    [confirmButtonStyleTransTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTransTextField.layer.cornerRadius = 5;
    confirmButtonStyleTransTextField.layer.borderWidth = 1.0;
    confirmButtonStyleTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTransTextField setAlpha:0.7];
    [confirmButtonStyleTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonStyleTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:confirmButtonStyleTransTextField];
    
    //Instruction continue Button/Transparency
    //continue Button Label
    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,confirmButtonStyleTextField.frame.origin.y + confirmButtonStyleTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
    [continueButtonLabel setAlpha:0.7];
    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonLabel.numberOfLines = 0;
    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonLabel];
    
    //Transparency Label
    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,confirmButtonStyleTransTextField.frame.origin.y + confirmButtonStyleTransTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransLabel setAlpha:0.7];
    continueButtonTransLabel.numberOfLines = 0;
    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransLabel];
    
    //continue Button TextField
    instContinueButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextField.layer.cornerRadius = 5;
    instContinueButtonTextField.layer.borderWidth = 1.0;
    instContinueButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextField setAlpha:0.7];
    [instContinueButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextField];
    
    //Transparency TextField
    instContinueButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextField.layer.cornerRadius = 5;
    instContinueButtonTransTextField.layer.borderWidth = 1.0;
    instContinueButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextField setAlpha:0.7];
    [instContinueButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextField];
    
    //Instruction continue Text color Button/Transparency
    //Continue Button Text color Label
    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,instContinueButtonTextField.frame.origin.y + instContinueButtonTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
    [continueButtonTextColorLabel setAlpha:0.7];
    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonTextColorLabel.numberOfLines = 0;
    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonTextColorLabel];
    
    //Transparency Label
    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransTextColorLabel setAlpha:0.7];
    continueButtonTransTextColorLabel.numberOfLines = 0;
    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransTextColorLabel];
    
    //Continue Button text color TextField
    instContinueButtonTextColorField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextColorField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextColorField.layer.cornerRadius = 5;
    instContinueButtonTextColorField.layer.borderWidth = 1.0;
    instContinueButtonTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextColorField setAlpha:0.7];
    [instContinueButtonTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextColorField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextColorField];
    
    //Transparency TextField
    instContinueButtonTransTextColorField= [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextColorField setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextColorField.layer.cornerRadius = 5;
    instContinueButtonTransTextColorField.layer.borderWidth = 1.0;
    instContinueButtonTransTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextColorField setAlpha:0.7];
    [instContinueButtonTransTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextColorField.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextColorField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextColorField];
    
    //Capture Button Color Label
    UILabel *captureButtonColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,instContinueButtonTransTextColorField.frame.origin.y + instContinueButtonTransTextColorField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
   // [captureButtonColorLabel setText:[LabelUtils getLabelForKey:@"detected_id_outline_color"]];
    [captureButtonColorLabel setText:@"Capture Button Color"];
    [captureButtonColorLabel setAlpha:0.7];
    [captureButtonColorLabel setFont:[UIFont systemFontOfSize:11]];
    captureButtonColorLabel.numberOfLines = 0;
    captureButtonColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:captureButtonColorLabel];
    
    //Capture Button Label Transparency
    UILabel *captureButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,instContinueButtonTransTextColorField.frame.origin.y + instContinueButtonTransTextColorField.frame.size.height +  (height/100)*2, instContinueButtonTransTextColorField.frame.size.width, (height/100)*2)];
    [captureButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [captureButtonTransLabel setAlpha:0.7];
    captureButtonTransLabel.numberOfLines = 0;
    captureButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [captureButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:captureButtonTransLabel];
    
    //Capture Button Color Label text field
    idCaptureButtonColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, captureButtonColorLabel.frame.origin.y + captureButtonColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [idCaptureButtonColorTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureButtonColorTextField.layer.cornerRadius = 5;
    idCaptureButtonColorTextField.layer.borderWidth = 1.0;
    idCaptureButtonColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureButtonColorTextField setAlpha:0.7];
    [idCaptureButtonColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureButtonColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idCaptureButtonColorTextField];
    
    //Capture Button Color Label Transparency
    idCaptureButtonColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, captureButtonTransLabel.frame.origin.y + captureButtonTransLabel.frame.size.height + (height/100)*1, captureButtonTransLabel.frame.size.width, (height/100)*4)];
    [idCaptureButtonColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureButtonColorTransTextField.layer.cornerRadius = 5;
    idCaptureButtonColorTransTextField.layer.borderWidth = 1.0;
    idCaptureButtonColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureButtonColorTransTextField setAlpha:0.7];
    [idCaptureButtonColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureButtonColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idCaptureButtonColorTransTextField];
    
    //ID Capture Border
    UILabel *idCaptureBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureButtonColorTextField.frame.origin.y + idCaptureButtonColorTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [idCaptureBorderLabel setText:[LabelUtils getLabelForKey:@"id_capture_border"]];
    [idCaptureBorderLabel setAlpha:0.7];
    [idCaptureBorderLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureBorderLabel.numberOfLines = 0;
    idCaptureBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idCaptureBorderLabel];
    
    idCaptureBorderLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureBorderLabel.frame.origin.y + idCaptureBorderLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [idCaptureBorderLabelTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureBorderLabelTextField.layer.cornerRadius = 5;
    idCaptureBorderLabelTextField.layer.borderWidth = 1.0;
    idCaptureBorderLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureBorderLabelTextField setAlpha:0.7];
    [idCaptureBorderLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureBorderLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idCaptureBorderLabelTextField];
    
    UIImageView *idCaptureBorderLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureBorderLabelTextField.frame.origin.x + idCaptureBorderLabelTextField.frame.size.width - (width/100)*9 , idCaptureBorderLabelTextField.frame.origin.y + (idCaptureBorderLabelTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [idCaptureBorderLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureBorderLabelDownArrowImage];
    
    //Show Title Image
    UILabel *showTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureBorderLabelTextField.frame.origin.y + idCaptureBorderLabelTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [showTitleLabel setText:[LabelUtils getLabelForKey:@"show_title_image"]];
    [showTitleLabel setAlpha:0.7];
    [showTitleLabel setFont:[UIFont systemFontOfSize:11]];
    showTitleLabel.numberOfLines = 0;
    showTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:showTitleLabel];
    
    //Show title Image Edit Spinner
    showTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, showTitleLabel.frame.origin.y + showTitleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [showTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    showTitleImgTextField.layer.cornerRadius = 5;
    showTitleImgTextField.layer.borderWidth = 1.0;
    showTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [showTitleImgTextField setAlpha:0.7];
    [showTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    showTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:showTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(showTitleImgTextField.frame.origin.x + showTitleImgTextField.frame.size.width - (width/100)*9 , showTitleImgTextField.frame.origin.y + (showTitleImgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImage];
    
    //IdCaptureTitleLabel
    UILabel *idCaptureTitleLAbel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,showTitleImgTextField.frame.origin.y + showTitleImgTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [idCaptureTitleLAbel setText:[LabelUtils getLabelForKey:@"id_capture_title_alignment"]];
    [idCaptureTitleLAbel setAlpha:0.7];
    [idCaptureTitleLAbel setFont:[UIFont systemFontOfSize:11]];
    idCaptureTitleLAbel.numberOfLines = 0;
    idCaptureTitleLAbel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idCaptureTitleLAbel];
    
    idCaptureTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureTitleLAbel.frame.origin.y + idCaptureTitleLAbel.frame.size.height + (height/100)*1, idCaptureTitleLAbel.frame.size.width, (height/100)*4)];
    [idCaptureTitleTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureTitleTextField.layer.cornerRadius = 5;
    idCaptureTitleTextField.layer.borderWidth = 1.0;
    idCaptureTitleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureTitleTextField setAlpha:0.7];
    [idCaptureTitleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCaptureTitleTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:idCaptureTitleTextField];
    
    UIImageView *idCaptureTitleDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureTitleTextField.frame.origin.x + idCaptureTitleTextField.frame.size.width - (width/100)*9 , idCaptureTitleTextField.frame.origin.y + (idCaptureTitleTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [idCaptureTitleDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureTitleDownArrowImage];
    
    idCaptureTitleCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idCaptureTitleCheckBox.frame = CGRectMake(idCaptureTitleTextField.frame.origin.x + idCaptureTitleTextField.frame.size.width + (width/100)*2, idCaptureTitleTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [idCaptureTitleCheckBox addTarget:self action:@selector(idCaptureTitleChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:idCaptureTitleCheckBox];
    
    UILabel *hideIdCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(idCaptureTitleCheckBox.frame.origin.x + idCaptureTitleCheckBox.frame.size.width + (width/100)*2, idCaptureTitleCheckBox.frame.origin.y, idCaptureTitleTextField.frame.size.width, (height/100)*4)];
    [hideIdCaptureLabel setText:[LabelUtils getLabelForKey:@"hide_id_capture_title"]];
    [hideIdCaptureLabel setAlpha:0.7];
    [hideIdCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureLabel.numberOfLines = 0;
    hideIdCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideIdCaptureLabel];
    
    //IdCaptureHintMsgAlignmentLabel
    UILabel *idCaptureHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureTitleTextField.frame.origin.y + idCaptureTitleTextField.frame.size.height + (height/100)*2, self.view.frame.size.width, (height/100)*2)];
    [idCaptureHintMsgLabel setText:[LabelUtils getLabelForKey:@"id_capture_hint_message_alignment"]];
    [idCaptureHintMsgLabel setAlpha:0.7];
    [idCaptureHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureHintMsgLabel.numberOfLines = 0;
    idCaptureHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idCaptureHintMsgLabel];
    
    idCaptureHintMsgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureHintMsgLabel.frame.origin.y + idCaptureHintMsgLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [idCaptureHintMsgTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureHintMsgTextField.layer.cornerRadius = 5;
    idCaptureHintMsgTextField.layer.borderWidth = 1.0;
    idCaptureHintMsgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureHintMsgTextField setAlpha:0.7];
    [idCaptureHintMsgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureHintMsgTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCaptureHintMsgTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:idCaptureHintMsgTextField];
    
    UIImageView *idCaptureHintMsgDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureHintMsgTextField.frame.origin.x + idCaptureHintMsgTextField.frame.size.width - (width/100)*9 , idCaptureHintMsgTextField.frame.origin.y + (idCaptureHintMsgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [idCaptureHintMsgDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureHintMsgDownArrowImage];
    
    idCaptureHintMsgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idCaptureHintMsgCheckBox.frame = CGRectMake(idCaptureHintMsgTextField.frame.origin.x + idCaptureHintMsgTextField.frame.size.width + (width/100)*2, idCaptureHintMsgTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    [idCaptureHintMsgCheckBox addTarget:self action:@selector(idCaptureHintMessageChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:idCaptureHintMsgCheckBox];
    
    UILabel *hideIdCaptureHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idCaptureHintMsgCheckBox.frame.origin.x + idCaptureHintMsgCheckBox.frame.size.width + (width/100)*2, idCaptureHintMsgCheckBox.frame.origin.y, idCaptureTitleTextField.frame.size.width, (height/100)*4)];
    [hideIdCaptureHintMsgLabel setText:[LabelUtils getLabelForKey:@"hide_id_hint_message"]];
    [hideIdCaptureHintMsgLabel setAlpha:0.7];
    [hideIdCaptureHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureHintMsgLabel.numberOfLines = 0;
    hideIdCaptureHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideIdCaptureHintMsgLabel];
    
    //IdCaptureTitleImageAlignment
    UILabel *idCaptureTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureHintMsgTextField.frame.origin.y + idCaptureHintMsgTextField.frame.size.height + (height/100)*2, self.view.frame.size.width, (height/100)*2)];
    [idCaptureTitleImageLabel setText:[LabelUtils getLabelForKey:@"id_capture_title_image_alignment"]];
    [idCaptureTitleImageLabel setAlpha:0.7];
    [idCaptureTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    idCaptureTitleImageLabel.numberOfLines = 0;
    idCaptureTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idCaptureTitleImageLabel];
    
    idCapturetitleImageTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idCaptureTitleImageLabel.frame.origin.y + idCaptureTitleImageLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [idCapturetitleImageTextField setFont:[UIFont systemFontOfSize:12]];
    idCapturetitleImageTextField.layer.cornerRadius = 5;
    idCapturetitleImageTextField.layer.borderWidth = 1.0;
    idCapturetitleImageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCapturetitleImageTextField setAlpha:0.7];
    [idCapturetitleImageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCapturetitleImageTextField.borderStyle = UITextBorderStyleRoundedRect;
    idCapturetitleImageTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:idCapturetitleImageTextField];
    
    UIImageView *idCaptureTitleImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCapturetitleImageTextField.frame.origin.x + idCapturetitleImageTextField.frame.size.width - (width/100)*9 , idCapturetitleImageTextField.frame.origin.y + (idCapturetitleImageTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [idCaptureTitleImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureTitleImageDownArrowImage];
    
    idTitleImgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    idTitleImgCheckBox.frame = CGRectMake(idCapturetitleImageTextField.frame.origin.x + idCapturetitleImageTextField.frame.size.width + (width/100)*2, idCapturetitleImageTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                        forState:UIControlStateNormal];
    [idTitleImgCheckBox addTarget:self action:@selector(idCaptureTitleImageChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:idTitleImgCheckBox];
    
    UILabel *hideIdCaptureTitleImgLabel = [[UILabel alloc] initWithFrame:CGRectMake(idTitleImgCheckBox.frame.origin.x + idTitleImgCheckBox.frame.size.width + (width/100)*2, idTitleImgCheckBox.frame.origin.y, idCapturetitleImageTextField.frame.size.width, (height/100)*4)];
    [hideIdCaptureTitleImgLabel setText:[LabelUtils getLabelForKey:@"hide_id_title_image"]];
    [hideIdCaptureTitleImgLabel setAlpha:0.7];
    [hideIdCaptureTitleImgLabel setFont:[UIFont systemFontOfSize:11]];
    hideIdCaptureTitleImgLabel.numberOfLines = 0;
    hideIdCaptureTitleImgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideIdCaptureTitleImgLabel];
    
    //Start
    //Show Instruction Screen
    UILabel *instructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idTitleImgCheckBox.frame.origin.y + idTitleImgCheckBox.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [instructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [instructionScreenLabel setAlpha:0.7];
    [instructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
    instructionScreenLabel.numberOfLines = 0;
    instructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:instructionScreenLabel];
    
    //NoRadio Button
    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noInstRadioBtn.frame = CGRectMake(idCapturetitleImageTextField.frame.origin.x, instructionScreenLabel.frame.origin.y + instructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                    forState:UIControlStateNormal];
    //    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
    //                    forState:UIControlStateNormal];
    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox_IdCapture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noInstRadioBtn];
    
    //No Label
    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [noInstLabel setAlpha:0.7];
    [noInstLabel setFont:[UIFont systemFontOfSize:14]];
    noInstLabel.numberOfLines = 0;
    noInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:noInstLabel];
    
    //YesRadio Button
    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*7, (height/100)*4);
    //[yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
    //                 forState:UIControlStateNormal];
    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                     forState:UIControlStateNormal];
    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox_IdCapture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:yesInstRadioBtn];
    
    //Yes Label
    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width + (width/100)*2, yesInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [yesInstLabel setAlpha:0.7];
    [yesInstLabel setFont:[UIFont systemFontOfSize:14]];
    yesInstLabel.numberOfLines = 0;
    yesInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:yesInstLabel];
    
    //End
    
    //Start
    //Enable Shadow
    //Enable Shadow Label
    UILabel *enableShadowLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, noInstRadioBtn.frame.origin.y + noInstRadioBtn.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    enableShadowLabel.numberOfLines = 0;
    enableShadowLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //[enableShadowLabel setText:[LabelUtils getLabelForKey:@"show_preview_screen"]];
    [enableShadowLabel setText:@"Enable Shadow"];
    [enableShadowLabel setAlpha:0.7];
    [enableShadowLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:enableShadowLabel];
    
    //Launch Front camera No label
    UILabel *enableShadowNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, enableShadowLabel.frame.origin.y + enableShadowLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [enableShadowNoLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [enableShadowNoLabel setAlpha:0.7];
    [enableShadowNoLabel setFont:[UIFont systemFontOfSize:12]];
    [enableShadowNoLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:enableShadowNoLabel];
    
    //toggleButton
    enableShadow_Id = [UIButton buttonWithType:UIButtonTypeCustom];
    enableShadow_Id.frame = CGRectMake(enableShadowNoLabel.frame.origin.x + enableShadowNoLabel.frame.size.width + (width/100)*2, enableShadowNoLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"]
                       forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    enableShadow_Id.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [enableShadow_Id addTarget:self action:@selector(enableShadowBtnClick_Id:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:enableShadow_Id];
    
    //Yes Label
    UILabel *enableShadowYesLabel = [[UILabel alloc] initWithFrame:CGRectMake(enableShadow_Id.frame.origin.x + enableShadow_Id.frame.size.width + (width/100)*2, enableShadow_Id.frame.origin.y, (width/100)*10, (height/100)*5)];
    [enableShadowYesLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [enableShadowYesLabel setAlpha:0.7];
    [enableShadowYesLabel setFont:[UIFont systemFontOfSize:12]];
    [enableShadowYesLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:enableShadowYesLabel];
    
    //Id Capture Label Initialization
    UILabel *initIdCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,enableShadow_Id.frame.origin.y + enableShadow_Id.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [initIdCaptureLabel setText:[LabelUtils getLabelForKey:@"id_capture_label"]];
    [initIdCaptureLabel setAlpha:0.7];
    [initIdCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    initIdCaptureLabel.numberOfLines = 0;
    initIdCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:initIdCaptureLabel];
    
    idCaptureLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, initIdCaptureLabel.frame.origin.y + initIdCaptureLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [idCaptureLabelTextField setFont:[UIFont systemFontOfSize:12]];
    idCaptureLabelTextField.layer.cornerRadius = 5;
    idCaptureLabelTextField.layer.borderWidth = 1.0;
    idCaptureLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idCaptureLabelTextField setAlpha:0.7];
    [idCaptureLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idCaptureLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idCaptureLabelTextField];
    
    UIImageView *idCaptureLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(idCaptureLabelTextField.frame.origin.x + idCaptureLabelTextField.frame.size.width - (width/100)*9 , idCaptureLabelTextField.frame.origin.y + (idCaptureLabelTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [idCaptureLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:idCaptureLabelDownArrowImage];
    
    //English Label
    UILabel *englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idCaptureLabelTextField.frame.origin.y + idCaptureLabelTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [englishLabel setText:[LabelUtils getLabelForKey:@"label_value"]];
    [englishLabel setAlpha:0.7];
    [englishLabel setFont:[UIFont systemFontOfSize:11]];
    englishLabel.numberOfLines = 0;
    englishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:englishLabel];
    
    //Spanish Label
    UILabel *spanishLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idCaptureLabelTextField.frame.origin.y + idCaptureLabelTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [spanishLabel setText:[LabelUtils getLabelForKey:@"spanish_label"]];
    [spanishLabel setAlpha:0.7];
    spanishLabel.numberOfLines = 0;
    spanishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [spanishLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:spanishLabel];
    [spanishLabel setHidden:YES];
    
    //English TextField
    englishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, englishLabel.frame.origin.y + englishLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [englishLabelTextField setFont:[UIFont systemFontOfSize:12]];
    englishLabelTextField.layer.cornerRadius = 5;
    englishLabelTextField.layer.borderWidth = 1.0;
    englishLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [englishLabelTextField setAlpha:0.7];
    [englishLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    englishLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:englishLabelTextField];
    
    //Spanish TextField
    spanishLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*1, spanishLabel.frame.size.width, (height/100)*4)];
    [spanishLabelTextField setFont:[UIFont systemFontOfSize:12]];
    spanishLabelTextField.layer.cornerRadius = 5;
    spanishLabelTextField.layer.borderWidth = 1.0;
    spanishLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [spanishLabelTextField setAlpha:0.7];
    [spanishLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    spanishLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    spanishLabelTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:spanishLabelTextField];
    [spanishLabelTextField setHidden:YES];
    
    UIButton *addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGRect frameAddLabel = CGRectMake((width/2) - (spanishLabelTextField.frame.size.width/2), englishLabelTextField.frame.origin.y + englishLabelTextField.frame.size.height + (height/100)*2, spanishLabelTextField.frame.size.width, (height/100)*6);
    CGRect frameAddLabel = CGRectMake(idOutlineTransLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*1, spanishLabel.frame.size.width, (height/100)*6);
    [addLabelButton setFrame:frameAddLabel];
    addLabelButton.layer.cornerRadius = 20;
    addLabelButton.clipsToBounds = YES;
    [addLabelButton setTitle:[LabelUtils getLabelForKey:@"add_label"] forState:UIControlStateNormal];
    addLabelButton.titleLabel.textColor = [UIColor whiteColor];
    [addLabelButton setBackgroundColor:[UIColor blackColor]];
    [addLabelButton addTarget:self action:@selector(addLabelClickedIDCaptureFront:) forControlEvents:UIControlEventTouchUpInside];
    [addLabelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:addLabelButton];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(idOutLineColorLabel.frame.origin.x, addLabelButton.frame.origin.y + addLabelButton.frame.size.height + (height/100)*2, englishLabelTextField.frame.size.width, (height/100)*6);
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
    [saveBtn setHidden:YES];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(width/2 - (saveBtn.frame.size.width/2), saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButtonIdFront:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    //    [scrollView setContentSize:CGSizeMake(width, resetBtn.frame.origin.y + resetBtn.frame.size.height + (height/100)*3)];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)addLabelClickedIDCaptureFront:(UIButton*)button {
//    NSString *labelKey = idCaptureLabelTextField.text;
//    if(![NSStringUtils stringIsNilOrEmpty:labelKey]){
//
//        NSString *englabel = englishLabelTextField.text;
//        if(![NSStringUtils stringIsNilOrEmpty:englabel]){
//            [englishLabels setObject:englabel forKey:labelKey];
//        }
//
//        NSString *spalabel = spanishLabelTextField.text;
//        if(![NSStringUtils stringIsNilOrEmpty:spalabel]){
//            [spanishLabels setObject:spalabel forKey:labelKey];
//        }
//    }
//    [englishLabelTextField setText:@""];
//    [spanishLabelTextField setText:@""];
    
    NSString *labelKey = idCaptureLabelTextField.text;
    NSString *englabel = englishLabelTextField.text;
    
    if(0 == selectConfig_row) {
        
        NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultIDCaptureFrontConfig] getLabelConfiguration];
        
        if(nil != labelConfig) {
            [labelConfig setObject:[[englishLabelTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
            
        }
        
    } else if(1 == selectConfig_row) {
        
        NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultIDCaptureBackConfig] getLabelConfiguration];
        
        if(nil != labelConfig) {
            [labelConfig setObject:[[englishLabelTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
            
        }
        
    } else if(2 == selectConfig_row) {
        
        NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultDocCaptureConfig] getLabelConfiguration];
        
        if(nil != labelConfig) {
            [labelConfig setObject:[[englishLabelTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
            
        }
        
    } else if(3 == selectConfig_row) {
        
        NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultSnippetCaptureConfig] getLabelConfiguration];
        
        if(nil != labelConfig) {
            [labelConfig setObject:[[englishLabelTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
            
        }
        
    }
    [englishLabelTextField setText:@""];
    
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

-(void)noInstChkBox_IdCapture:(UIButton*)button {
    
    switch (selectConfig_row) {
        case 0:
            if(showInstScreen_IdFront) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdFront = false;
            }
            break;
        case 1:
            if(showInstScreen_IdBack) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdBack = false;
            }
            break;
        case 2:
            if(showInstScreen_Doc) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_Doc = false;
            }
            break;
        case 3:
            if(showInstScreen_Snippet) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_Snippet = false;
            }
            break;
        case 6:
            if(showInstScreen_IdFront_sec) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdFront_sec = false;
            }
            break;
        case 7:
            if(showInstScreen_IdBack_sec) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdBack_sec = false;
            }
            break;
            
        default:
            break;
    }
}

-(void)yesInstChkBox_IdCapture:(UIButton*)button {
    
    switch (selectConfig_row) {
        case 0:
            if(!showInstScreen_IdFront) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdFront = true;
            }
            break;
        
        case 1:
            if(!showInstScreen_IdBack) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdBack = true;
            }
            break;
        
        case 2:
            if(!showInstScreen_Doc) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_Doc = true;
            }
            break;
        
        case 3:
            if(!showInstScreen_Snippet) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_Snippet = true;
            }
            break;
        case 6:
            if(!showInstScreen_IdFront_sec) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdFront_sec = true;
            }
            break;
        case 7:
            if(!showInstScreen_IdBack_sec) {
                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
                showInstScreen_IdBack_sec = true;
            }
            break;
            
        default:
            break;
    }
    
}

-(void)resetButtonIdFront:(UIButton*)button {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
    [idOutlineColorTextField setText:dIdOutlineColor];
    [idOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedIdOutlineColorTextField setText:dDetectedIdOutlineColor];
    [detectedIdOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [colorOutsideOutlineTextField setText:dOutsideIdOutlineColor];
    [colorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [detectedColorOutsideOutlineTextField setText:dDetectedIdOutsideOutlineColor];
    [detectedColorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
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
    [idCaptureButtonColorTextField setText:dCaptureButtonColor];
    [idCaptureButtonColorTransTextField setText:[@(mAlpha) stringValue]];
    
    [idCaptureTitleTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [idCaptureHintMsgTextField setText:[LabelUtils getLabelForKey:@"Center"]];
    [idCapturetitleImageTextField setText:[LabelUtils getLabelForKey:@"Bottom"]];
    hideIdTitleImage = false;
    hideIdHintMessage = false;
    hideIdCaptureTitle = false;
    
    [idCaptureTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [idCaptureHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                              forState:UIControlStateNormal];
    [idTitleImgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                        forState:UIControlStateNormal];
    
    //Resetting the all labels value
    [englishLabels removeAllObjects];
    [spanishLabels removeAllObjects];
    //[AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
}

-(void)saveSetting_IdFront {
    
     NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
     NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle, *captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, *captureButtonColorTrans=mAlpha;
    
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
    
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];
    
    [self saveSetting:@"idoutlinecolor" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton" value:backButtonColor];
    [self saveSetting:@"retryButton" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle" value:confirmButtonStyle];
    [self saveSetting:@"textColor" value:textColor];
    [self saveSetting:@"instContinueButton" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];
    
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
}

-(void)isCaptureFrontSaveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency" defaultValue:[@(mAlpha) stringValue]];
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
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    
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
    
    [idCaptureTitleTextField setText:idCaptureTitleLabelString]; //
    [idCaptureHintMsgTextField setText:idCaptureHintMessageString];
    [idCapturetitleImageTextField setText:idCaptureTitleImageString];
    
    [idOutlineColorTextField setText:idoutlinecolor]; //
    [idOutlineColorTransTextField setText:idoutlinetransparency];//
    [detectedIdOutlineColorTextField setText:detectedIdOutlineColor];//
    [detectedIdOutlineColorTransTextField setText:detectedIdOutlineTrans]; //
    
    [colorOutsideOutlineTextField setText:colorOutsideOutline]; //
    
    [colorOutsideOutlineTransTextField setText:colorOutsideOutlineTrans]; //
    [detectedColorOutsideOutlineTextField setText:detectedidcolorOutsideOutline]; //
    [detectedColorOutsideOutlineTransTextField setText:detectedidcolorOutsideOutlineTransparency]; //
    
    //[showTitleImgTextField setText:@"None"];
    [showTitleImgTextField setText:[LabelUtils getLabelForKey:@"none"]];
    [backButtonTextField setText:backButton]; //
    [backButtonTransTextField setText:backButtonTrans]; //
    [retryButtonTextField setText:retryButton]; //
    [retryButtonTransTextField setText:retryButtonTrans]; //
    [retryButtonBorderTextField setText:retryButtonBorder]; //
    [retryButtonBorderTransTextField setText:retryButtonBorderTrans]; //
    [confirmButtonTextField setText:confirmButton]; //
    [confirmButtonTransTextField setText:confirmButtonTrans]; //
    [confirmButtonStyleTextField setText:confirmButtonStyle]; //
    [confirmButtonStyleTransTextField setText:confirmButtonStyleTrans]; //
    [textColorTextField setText:textColor]; //
    [textColorTransTextField setText:textColorTrans]; //
    [instContinueButtonTextField setText:instContinueButton]; //
    [instContinueButtonTransTextField setText:instContinueButtonTrans]; //
    [instContinueButtonTextColorField setText:instContinueTextColor]; //
    [instContinueButtonTransTextColorField setText:instContinueTextColorTrans]; //
    [headerTextColorTextField setText:headerTextColor]; //
    [headerTextColorTransTextField setText:headerTextColorTrans]; //
    [headerSizeTextField setText:headerTextSize]; //
    [textSizeTextField setText:textSize]; //
    [idCaptureButtonColorTextField setText:captureButtonColor]; //
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans]; //
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_IdFront) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdFront) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
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

-(void)saveSetting:(NSString*)key value:(NSString*)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
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

//SelfieCapture
- (float)scrollViewUI_SelfieCapture:(UIScrollView *)scrollView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Face OutLine Color
    //Face Outline Color Label
    UILabel *faceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [faceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"face_outline_color"]];
    [faceOutlineColorLabel setAlpha:0.7];
    [faceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    faceOutlineColorLabel.numberOfLines = 0;
    faceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceOutlineColorLabel];
    
    //Face OutLine Color TransParency
    UILabel *faceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    [faceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [faceOutLineTransLabel setAlpha:0.7];
    faceOutLineTransLabel.numberOfLines = 0;
    faceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [faceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:faceOutLineTransLabel];
    
    //Face Outline Color Text Field
    faceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceOutlineColorLabel.frame.origin.y + faceOutlineColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [faceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTextField.layer.cornerRadius = 5;
    faceOutlineColorTextField.layer.borderWidth = 1.0;
    faceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTextField setAlpha:0.7];
    [faceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceOutlineColorTextField];
    
    //Face Outline Color Trans Text Field
    faceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, faceOutLineTransLabel.frame.origin.y + faceOutLineTransLabel.frame.size.height + (height/100)*1, faceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [faceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    faceOutlineColorTransTextField.layer.cornerRadius = 5;
    faceOutlineColorTransTextField.layer.borderWidth = 1.0;
    faceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceOutlineColorTransTextField setAlpha:0.7];
    [faceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceOutlineColorTransTextField];
    
    //Detected Face Outline Color
    //Detected Face Outline Color label
    UILabel *detectedFaceOutlineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceOutlineColorTextField.frame.origin.y + faceOutlineColorTextField.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [detectedFaceOutlineColorLabel setText:[LabelUtils getLabelForKey:@"detect_face_outline_color"]];
    [detectedFaceOutlineColorLabel setAlpha:0.7];
    [detectedFaceOutlineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedFaceOutlineColorLabel.numberOfLines = 0;
    detectedFaceOutlineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:detectedFaceOutlineColorLabel];
    
    //Detected Face OutLine Color TransParency label
    UILabel *detectedFaceOutLineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,faceOutlineColorTransTextField.frame.origin.y + faceOutlineColorTransTextField.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [detectedFaceOutLineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedFaceOutLineTransLabel setAlpha:0.7];
    detectedFaceOutLineTransLabel.numberOfLines = 0;
    detectedFaceOutLineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedFaceOutLineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:detectedFaceOutLineTransLabel];
    
    //Detected Face Outline Color Text Field
    detectedFaceOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, detectedFaceOutlineColorLabel.frame.origin.y + detectedFaceOutlineColorLabel.frame.size.height + (height/100)*1, detectedFaceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [detectedFaceOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTextField setAlpha:0.7];
    [detectedFaceOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedFaceOutlineColorTextField];
    
    //Detected Face Outline Color Trans Text Field
    detectedFaceOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, detectedFaceOutLineTransLabel.frame.origin.y + detectedFaceOutLineTransLabel.frame.size.height + (height/100)*1, detectedFaceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [detectedFaceOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedFaceOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedFaceOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedFaceOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedFaceOutlineColorTransTextField setAlpha:0.7];
    [detectedFaceOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedFaceOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedFaceOutlineColorTransTextField];
    
    //Outside Color of Face Outline
    //Outside Color of Face Outline Label
    UILabel *outsideColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,detectedFaceOutlineColorTextField.frame.origin.y + detectedFaceOutlineColorTextField.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*5)];
    [outsideColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_color_of_face_outLine"]];
    [outsideColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:outsideColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,detectedFaceOutlineColorTransTextField.frame.origin.y + detectedFaceOutlineColorTransTextField.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [outsideColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:outsideColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, outsideColorOfFaceOutlineLabel.frame.origin.y + outsideColorOfFaceOutlineLabel.frame.size.height + (height/100)*1, outsideColorOfFaceOutlineLabel.frame.size.width, (height/100)*4)];
    [outlineColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:outlineColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, outlineColorOfFaceOutlineTextField.frame.origin.y, detectedFaceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [outlineColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:outlineColorOfFaceOutlineTransTextField];
    
    //Outside Detected Color Of Face Outline
    //Outside Detected Color of Face Outline Label
    UILabel *outsideDetectedColorOfFaceOutlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,outlineColorOfFaceOutlineTextField.frame.origin.y + outlineColorOfFaceOutlineTextField.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*5)];
    [outsideDetectedColorOfFaceOutlineLabel setText:[LabelUtils getLabelForKey:@"outside_detected_color_of_face_outline"]];
    [outsideDetectedColorOfFaceOutlineLabel setAlpha:0.7];
    [outsideDetectedColorOfFaceOutlineLabel setFont:[UIFont systemFontOfSize:11]];
    outsideDetectedColorOfFaceOutlineLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineLabel];
    
    //Outside Color Of Face Outline TransParency label
    UILabel *outsideDetectedColorOfFaceOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,outlineColorOfFaceOutlineTransTextField.frame.origin.y + outlineColorOfFaceOutlineTransTextField.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [outsideDetectedColorOfFaceOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [outsideDetectedColorOfFaceOutlineTransLabel setAlpha:0.7];
    outsideDetectedColorOfFaceOutlineTransLabel.numberOfLines = 0;
    outsideDetectedColorOfFaceOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [outsideDetectedColorOfFaceOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:outsideDetectedColorOfFaceOutlineTransLabel];
    
    //Outline Color of Face Outline Text Field
    outlineDetectedColorOfFaceOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, outsideDetectedColorOfFaceOutlineLabel.frame.origin.y + outsideDetectedColorOfFaceOutlineLabel.frame.size.height + (height/100)*1, outsideDetectedColorOfFaceOutlineLabel.frame.size.width, (height/100)*4)];
    [outlineDetectedColorOfFaceOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTextField];
    
    //Detected Face Outline Color Trans Text Field
    outlineDetectedColorOfFaceOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, outlineDetectedColorOfFaceOutlineTextField.frame.origin.y, outsideDetectedColorOfFaceOutlineTransLabel.frame.size.width, (height/100)*4)];
    [outlineDetectedColorOfFaceOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    outlineDetectedColorOfFaceOutlineTransTextField.layer.cornerRadius = 5;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderWidth = 1.0;
    outlineDetectedColorOfFaceOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setAlpha:0.7];
    [outlineDetectedColorOfFaceOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    outlineDetectedColorOfFaceOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:outlineDetectedColorOfFaceOutlineTransTextField];
    
    //Text/Header Size
    //Header Size label
    UILabel *headerTextSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,outlineDetectedColorOfFaceOutlineTextField.frame.origin.y + outlineDetectedColorOfFaceOutlineTextField.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [headerTextSizeLabel setText:[LabelUtils getLabelForKey:@"header_text_label_size"]];
    [headerTextSizeLabel setAlpha:0.7];
    [headerTextSizeLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextSizeLabel.numberOfLines = 0;
    headerTextSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerTextSizeLabel];
    
    //Text Size Label
    UILabel *textSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,outlineDetectedColorOfFaceOutlineTransTextField.frame.origin.y + outlineDetectedColorOfFaceOutlineTransTextField.frame.size.height +  (height/100)*2, outlineDetectedColorOfFaceOutlineTransTextField.frame.size.width, (height/100)*2)];
    [textSizeLabel setText:[LabelUtils getLabelForKey:@"text_label_size"]];
    [textSizeLabel setAlpha:0.7];
    textSizeLabel.numberOfLines = 0;
    textSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textSizeLabel];
    
    //Header size TextField
    headerSizeTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, headerTextSizeLabel.frame.origin.y + headerTextSizeLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [headerSizeTextField_Face setFont:[UIFont systemFontOfSize:12]];
    headerSizeTextField_Face.layer.cornerRadius = 5;
    headerSizeTextField_Face.layer.borderWidth = 1.0;
    headerSizeTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerSizeTextField_Face setAlpha:0.7];
    [headerSizeTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerSizeTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerSizeTextField_Face];
    
    //Text size TextField
    textSizeTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, headerSizeTextField_Face.frame.origin.y, faceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [textSizeTextField_Face setFont:[UIFont systemFontOfSize:12]];
    textSizeTextField_Face.layer.cornerRadius = 5;
    textSizeTextField_Face.layer.borderWidth = 1.0;
    textSizeTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [textSizeTextField_Face setAlpha:0.7];
    [textSizeTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textSizeTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textSizeTextField_Face];
    
    //Font Style
    //Font Style Label
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,headerSizeTextField_Face.frame.origin.y + headerSizeTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField_Face = [[UITextField alloc] initWithFrame: CGRectMake(faceOutlineColorLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [fontStyleTextField_Face setFont:[UIFont systemFontOfSize:12]];
    fontStyleTextField_Face.layer.cornerRadius = 5;
    fontStyleTextField_Face.layer.borderWidth = 1.0;
    fontStyleTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [fontStyleTextField_Face setAlpha:0.7];
    [fontStyleTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    fontStyleTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:fontStyleTextField_Face];
    
    //Header Font Style
    //Font Style Label
    UILabel *headerFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,fontStyleTextField_Face.frame.origin.y + fontStyleTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [headerFontStyleLabel setText:[LabelUtils getLabelForKey:@"header_text_font_style"]];
    [headerFontStyleLabel setAlpha:0.7];
    [headerFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    headerFontStyleLabel.numberOfLines = 0;
    headerFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerFontStyleLabel];
    
    //Font Style TextField
    headerFontStyleTextField_Face = [[UITextField alloc] initWithFrame: CGRectMake(faceOutlineColorLabel.frame.origin.x, headerFontStyleLabel.frame.origin.y + headerFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [headerFontStyleTextField_Face setFont:[UIFont systemFontOfSize:12]];
    headerFontStyleTextField_Face.layer.cornerRadius = 5;
    headerFontStyleTextField_Face.layer.borderWidth = 1.0;
    headerFontStyleTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerFontStyleTextField_Face setAlpha:0.7];
    [headerFontStyleTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerFontStyleTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerFontStyleTextField_Face];
    
    //Text Color/transparency
    //Text Color Label
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,headerFontStyleTextField_Face.frame.origin.y + headerFontStyleTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textColorLabel];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,headerFontStyleTextField_Face.frame.origin.y + headerFontStyleTextField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textColorTransLabel];
    
    //Text Color TextField
    textColorTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [textColorTextField_Face setFont:[UIFont systemFontOfSize:12]];
    textColorTextField_Face.layer.cornerRadius = 5;
    textColorTextField_Face.layer.borderWidth = 1.0;
    textColorTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTextField_Face setAlpha:0.7];
    [textColorTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textColorTextField_Face];
    
    //Transparency TextField
    textColorTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, textColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*1, textColorTransLabel.frame.size.width, (height/100)*4)];
    [textColorTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    textColorTransTextField_Face.layer.cornerRadius = 5;
    textColorTransTextField_Face.layer.borderWidth = 1.0;
    textColorTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTransTextField_Face setAlpha:0.7];
    [textColorTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    textColorTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textColorTransTextField_Face];
    
    //Header Text Color/transparency
    //Header Text Color Label
    UILabel *headerTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,textColorTextField_Face.frame.origin.y + textColorTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [headerTextColorLabel setText:[LabelUtils getLabelForKey:@"header_text_label_color"]];
    [headerTextColorLabel setAlpha:0.7];
    [headerTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    headerTextColorLabel.numberOfLines = 0;
    headerTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:headerTextColorLabel];
    
    //Transparency Label
    UILabel *headerTextColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,textColorTransTextField_Face.frame.origin.y + textColorTransTextField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [headerTextColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [headerTextColorTransLabel setAlpha:0.7];
    headerTextColorTransLabel.numberOfLines = 0;
    headerTextColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headerTextColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:headerTextColorTransLabel];
    
    //Header Text Color TextField
    headerTextColorTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, headerTextColorLabel.frame.origin.y + headerTextColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [headerTextColorTextField_Face setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTextField_Face.layer.cornerRadius = 5;
    headerTextColorTextField_Face.layer.borderWidth = 1.0;
    headerTextColorTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTextField_Face setAlpha:0.7];
    [headerTextColorTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headerTextColorTextField_Face];
    
    //Transparency TextField
    headerTextColorTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, headerTextColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*1, headerTextColorTransLabel.frame.size.width, (height/100)*4)];
    [headerTextColorTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    headerTextColorTransTextField_Face.layer.cornerRadius = 5;
    headerTextColorTransTextField_Face.layer.borderWidth = 1.0;
    headerTextColorTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [headerTextColorTransTextField_Face setAlpha:0.7];
    [headerTextColorTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    headerTextColorTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    headerTextColorTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:headerTextColorTransTextField_Face];
    
    //Back Button/transparency
    //Back button Label
    UILabel *backButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,headerTextColorTextField_Face.frame.origin.y + headerTextColorTextField_Face.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [backButtonLabel setText:[LabelUtils getLabelForKey:@"back_button_color"]];
    [backButtonLabel setAlpha:0.7];
    [backButtonLabel setFont:[UIFont systemFontOfSize:11]];
    backButtonLabel.numberOfLines = 0;
    backButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:backButtonLabel];
    
    //Transparency Label
    UILabel *backButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,headerTextColorTransTextField_Face.frame.origin.y + headerTextColorTransTextField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [backButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backButtonTransLabel setAlpha:0.7];
    backButtonTransLabel.numberOfLines = 0;
    backButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    textColorTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    
    [scrollView addSubview:backButtonTransLabel];
    
    //Back Button TextField
    backButtonTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, backButtonLabel.frame.origin.y + backButtonLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [backButtonTextField_Face setFont:[UIFont systemFontOfSize:12]];
    backButtonTextField_Face.layer.cornerRadius = 5;
    backButtonTextField_Face.layer.borderWidth = 1.0;
    backButtonTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTextField_Face setAlpha:0.7];
    [backButtonTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:backButtonTextField_Face];
    
    //Transparency TextField
    backButtonTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, backButtonTransLabel.frame.origin.y + backButtonTransLabel.frame.size.height + (height/100)*1, backButtonTransLabel.frame.size.width, (height/100)*4)];
    [backButtonTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    backButtonTransTextField_Face.layer.cornerRadius = 5;
    backButtonTransTextField_Face.layer.borderWidth = 1.0;
    backButtonTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTransTextField_Face setAlpha:0.7];
    [backButtonTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    backButtonTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:backButtonTransTextField_Face];
    
    //Retry Button/Transparency
    //Retry Button Label
    UILabel *retryButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,backButtonTextField_Face.frame.origin.y + backButtonTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [retryButtonLabel setText:[LabelUtils getLabelForKey:@"retry_button_color"]];
    [retryButtonLabel setAlpha:0.7];
    [retryButtonLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonLabel.numberOfLines = 0;
    retryButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:retryButtonLabel];
    
    //Transparency Label
    UILabel *retryButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,backButtonTextField_Face.frame.origin.y + backButtonTextField_Face.frame.size.height +  (height/100)*2, backButtonTextField_Face.frame.size.width, (height/100)*2)];
    [retryButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonTransLabel setAlpha:0.7];
    retryButtonTransLabel.numberOfLines = 0;
    retryButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:retryButtonTransLabel];
    
    //Retry Button TextField
    retryButtonTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, retryButtonLabel.frame.origin.y + retryButtonLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [retryButtonTextField_Face setFont:[UIFont systemFontOfSize:12]];
    retryButtonTextField_Face.layer.cornerRadius = 5;
    retryButtonTextField_Face.layer.borderWidth = 1.0;
    retryButtonTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTextField_Face setAlpha:0.7];
    [retryButtonTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:retryButtonTextField_Face];
    
    //Transparency TextField
    retryButtonTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, retryButtonTransLabel.frame.origin.y + retryButtonTransLabel.frame.size.height + (height/100)*1, retryButtonTransLabel.frame.size.width, (height/100)*4)];
    [retryButtonTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    retryButtonTransTextField_Face.layer.cornerRadius = 5;
    retryButtonTransTextField_Face.layer.borderWidth = 1.0;
    retryButtonTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTransTextField_Face setAlpha:0.7];
    [retryButtonTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:retryButtonTransTextField_Face];
    
    //Retry Button Border/Transparency
    //Retry Button Border Label
    UILabel *retryButtonBorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,retryButtonTransTextField_Face.frame.origin.y + retryButtonTransTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [retryButtonBorderLabel setText:[LabelUtils getLabelForKey:@"retry_button_border_color"]];
    [retryButtonBorderLabel setAlpha:0.7];
    [retryButtonBorderLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonBorderLabel.numberOfLines = 0;
    retryButtonBorderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:retryButtonBorderLabel];
    
    //Transparency Label
    UILabel *retryButtonBorderTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,retryButtonTransTextField_Face.frame.origin.y + retryButtonTransTextField_Face.frame.size.height +  (height/100)*2, retryButtonTransTextField_Face.frame.size.width, (height/100)*2)];
    [retryButtonBorderTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonBorderTransLabel setAlpha:0.7];
    retryButtonBorderTransLabel.numberOfLines = 0;
    retryButtonBorderTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonBorderTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:retryButtonBorderTransLabel];
    
    //Retry Button Border TextField
    retryButtonBorderTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, retryButtonBorderLabel.frame.origin.y + retryButtonBorderLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [retryButtonBorderTextField_Face setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTextField_Face.layer.cornerRadius = 5;
    retryButtonBorderTextField_Face.layer.borderWidth = 1.0;
    retryButtonBorderTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTextField_Face setAlpha:0.7];
    [retryButtonBorderTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:retryButtonBorderTextField_Face];
    
    //Transparency TextField
    retryButtonBorderTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, retryButtonBorderTransLabel.frame.origin.y + retryButtonBorderTransLabel.frame.size.height + (height/100)*1, retryButtonBorderTransLabel.frame.size.width, (height/100)*4)];
    [retryButtonBorderTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    retryButtonBorderTransTextField_Face.layer.cornerRadius = 5;
    retryButtonBorderTransTextField_Face.layer.borderWidth = 1.0;
    retryButtonBorderTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonBorderTransTextField_Face setAlpha:0.7];
    [retryButtonBorderTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonBorderTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonBorderTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:retryButtonBorderTransTextField_Face];
    
    
    //Confirm Button/Transparency
    //Confirm Button Label
    UILabel *confirmButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,retryButtonBorderTextField_Face.frame.origin.y + retryButtonBorderTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [confirmButtonLabel setText:[LabelUtils getLabelForKey:@"confirm_button_color"]];
    [confirmButtonLabel setAlpha:0.7];
    [confirmButtonLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonLabel.numberOfLines = 0;
    confirmButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:confirmButtonLabel];
    
    //Transparency Label
    UILabel *confirmButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,retryButtonBorderTextField_Face.frame.origin.y + retryButtonBorderTextField_Face.frame.size.height +  (height/100)*2, retryButtonBorderTextField_Face.frame.size.width, (height/100)*2)];
    [confirmButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonTransLabel setAlpha:0.7];
    confirmButtonTransLabel.numberOfLines = 0;
    confirmButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:confirmButtonTransLabel];
    
    //Confirm Button TextField
    confirmButtonTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, confirmButtonLabel.frame.origin.y + confirmButtonLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTextField_Face setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTextField_Face.layer.cornerRadius = 5;
    confirmButtonTextField_Face.layer.borderWidth = 1.0;
    confirmButtonTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTextField_Face setAlpha:0.7];
    [confirmButtonTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:confirmButtonTextField_Face];
    
    //Transparency TextField
    confirmButtonTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, confirmButtonTransLabel.frame.origin.y + confirmButtonTransLabel.frame.size.height + (height/100)*1, confirmButtonTransLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTransTextField_Face.layer.cornerRadius = 5;
    confirmButtonTransTextField_Face.layer.borderWidth = 1.0;
    confirmButtonTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTransTextField_Face setAlpha:0.7];
    [confirmButtonTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:confirmButtonTransTextField_Face];
    
    //Confirm Button/Transparency Style
    //Confirm Button Label
    UILabel *confirmButtonStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,confirmButtonTextField_Face.frame.origin.y + confirmButtonTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [confirmButtonStyleLabel setText:[LabelUtils getLabelForKey:@"confirm_button_style"]];
    [confirmButtonStyleLabel setAlpha:0.7];
    [confirmButtonStyleLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonStyleLabel.numberOfLines = 0;
    confirmButtonStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:confirmButtonStyleLabel];
    
    //Transparency Label
    UILabel *confirmButtonStyleTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,confirmButtonTextField_Face.frame.origin.y + confirmButtonTextField_Face.frame.size.height +  (height/100)*2, confirmButtonTextField_Face.frame.size.width, (height/100)*2)];
    [confirmButtonStyleTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonStyleTransLabel setAlpha:0.7];
    confirmButtonStyleTransLabel.numberOfLines = 0;
    confirmButtonStyleTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonStyleTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:confirmButtonStyleTransLabel];
    
    //Confirm Button TextField
    confirmButtonStyleTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, confirmButtonStyleLabel.frame.origin.y + confirmButtonStyleLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [confirmButtonStyleTextField_Face setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTextField_Face.layer.cornerRadius = 5;
    confirmButtonStyleTextField_Face.layer.borderWidth = 1.0;
    confirmButtonStyleTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTextField_Face setAlpha:0.7];
    [confirmButtonStyleTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:confirmButtonStyleTextField_Face];
    
    //Transparency TextField
    confirmButtonStyleTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, confirmButtonStyleTransLabel.frame.origin.y + confirmButtonStyleTransLabel.frame.size.height + (height/100)*1, confirmButtonStyleTransLabel.frame.size.width, (height/100)*4)];
    [confirmButtonStyleTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    confirmButtonStyleTransTextField_Face.layer.cornerRadius = 5;
    confirmButtonStyleTransTextField_Face.layer.borderWidth = 1.0;
    confirmButtonStyleTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonStyleTransTextField_Face setAlpha:0.7];
    [confirmButtonStyleTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonStyleTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonStyleTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:confirmButtonStyleTransTextField_Face];
    
    //Instruction continue Button/Transparency
    //continue Button Label
    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,confirmButtonStyleTextField_Face.frame.origin.y + confirmButtonStyleTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
    [continueButtonLabel setAlpha:0.7];
    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonLabel.numberOfLines = 0;
    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonLabel];
    
    //Transparency Label
    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,confirmButtonStyleTransTextField_Face.frame.origin.y + confirmButtonStyleTransTextField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransLabel setAlpha:0.7];
    continueButtonTransLabel.numberOfLines = 0;
    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransLabel];
    
    //continue Button TextField
    instContinueButtonTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextField_Face setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextField_Face.layer.cornerRadius = 5;
    instContinueButtonTextField_Face.layer.borderWidth = 1.0;
    instContinueButtonTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextField_Face setAlpha:0.7];
    [instContinueButtonTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextField_Face];
    
    //Transparency TextField
    instContinueButtonTransTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*1, faceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextField_Face setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextField_Face.layer.cornerRadius = 5;
    instContinueButtonTransTextField_Face.layer.borderWidth = 1.0;
    instContinueButtonTransTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextField_Face setAlpha:0.7];
    [instContinueButtonTransTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextField_Face];
    
    //Instruction continue Text color Button/Transparency
    //Continue Button Text color Label
    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,instContinueButtonTextField_Face.frame.origin.y + instContinueButtonTextField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
    [continueButtonTextColorLabel setAlpha:0.7];
    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonTextColorLabel.numberOfLines = 0;
    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonTextColorLabel];
    
    //Transparency Label
    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,instContinueButtonTransTextField_Face.frame.origin.y + instContinueButtonTransTextField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransTextColorLabel setAlpha:0.7];
    continueButtonTransTextColorLabel.numberOfLines = 0;
    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransTextColorLabel];
    
    //Continue Button text color TextField
    instContinueButtonTextColorField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextColorField_Face setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextColorField_Face.layer.cornerRadius = 5;
    instContinueButtonTextColorField_Face.layer.borderWidth = 1.0;
    instContinueButtonTextColorField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextColorField_Face setAlpha:0.7];
    [instContinueButtonTextColorField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextColorField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextColorField_Face];
    
    //Transparency TextField
    instContinueButtonTransTextColorField_Face= [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*1, faceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextColorField_Face setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextColorField_Face.layer.cornerRadius = 5;
    instContinueButtonTransTextColorField_Face.layer.borderWidth = 1.0;
    instContinueButtonTransTextColorField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextColorField_Face setAlpha:0.7];
    [instContinueButtonTransTextColorField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextColorField_Face.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextColorField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextColorField_Face];
    
    //Start
    UILabel *instPreviewColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,instContinueButtonTextColorField_Face.frame.origin.y + instContinueButtonTextColorField_Face.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*5)];
    [instPreviewColorLabel setText:[LabelUtils getLabelForKey:@"instruction_preview_background_color"]];
    [instPreviewColorLabel setAlpha:0.7];
    [instPreviewColorLabel setFont:[UIFont systemFontOfSize:11]];
    instPreviewColorLabel.numberOfLines = 0;
    instPreviewColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:instPreviewColorLabel];
    
    UILabel *instPreviewTransColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,instContinueButtonTransTextColorField_Face.frame.origin.y + instContinueButtonTransTextColorField_Face.frame.size.height +  (height/100)*2, faceOutLineTransLabel.frame.size.width, (height/100)*2)];
    [instPreviewTransColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [instPreviewTransColorLabel setAlpha:0.7];
    instPreviewTransColorLabel.numberOfLines = 0;
    instPreviewTransColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [instPreviewTransColorLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:instPreviewTransColorLabel];
    
    // InstructionPreviewColorTextField
    instPreviewColorField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, instPreviewColorLabel.frame.origin.y + instPreviewColorLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [instPreviewColorField_Face setFont:[UIFont systemFontOfSize:12]];
    instPreviewColorField_Face.layer.cornerRadius = 5;
    instPreviewColorField_Face.layer.borderWidth = 1.0;
    instPreviewColorField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instPreviewColorField_Face setAlpha:0.7];
    [instPreviewColorField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instPreviewColorField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instPreviewColorField_Face];
    
    instPreviewTransColorField_Face= [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, instPreviewColorField_Face.frame.origin.y, faceOutLineTransLabel.frame.size.width, (height/100)*4)];
    [instPreviewTransColorField_Face setFont:[UIFont systemFontOfSize:12]];
    instPreviewTransColorField_Face.layer.cornerRadius = 5;
    instPreviewTransColorField_Face.layer.borderWidth = 1.0;
    instPreviewTransColorField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [instPreviewTransColorField_Face setAlpha:0.7];
    [instPreviewTransColorField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instPreviewTransColorField_Face.borderStyle = UITextBorderStyleRoundedRect;
    instPreviewTransColorField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instPreviewTransColorField_Face];
    //End
    
    //Select Face Image Type
    //Select Face Image Type label
    UILabel *selectFaceImageTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,instPreviewColorField_Face.frame.origin.y + instPreviewColorField_Face.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*5)];
    [selectFaceImageTypeLabel setText:[LabelUtils getLabelForKey:@"face_image_type"]];
    [selectFaceImageTypeLabel setAlpha:0.7];
    [selectFaceImageTypeLabel setFont:[UIFont systemFontOfSize:11]];
    selectFaceImageTypeLabel.numberOfLines = 0;
    selectFaceImageTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:selectFaceImageTypeLabel];
    
    //Select Title Image Edit Spinner
    faceImageTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, selectFaceImageTypeLabel.frame.origin.y + selectFaceImageTypeLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [faceImageTypeTextField setFont:[UIFont systemFontOfSize:12]];
    faceImageTypeTextField.layer.cornerRadius = 5;
    faceImageTypeTextField.layer.borderWidth = 1.0;
    faceImageTypeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceImageTypeTextField setAlpha:0.7];
    [faceImageTypeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceImageTypeTextField.borderStyle = UITextBorderStyleRoundedRect;
    //TODO [faceImageTypeTextField setText:_faceImgTypePickerData[0]];
    [scrollView addSubview:faceImageTypeTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImageFace = [[UIImageView alloc] initWithFrame:CGRectMake(faceImageTypeTextField.frame.origin.x + faceImageTypeTextField.frame.size.width - (width/100)*9 , faceImageTypeTextField.frame.origin.y + (faceImageTypeTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImageFace setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImageFace];
    
    //Select Title Image
    //Select Title Image label
    UILabel *selectTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceImageTypeTextField.frame.origin.y + faceImageTypeTextField.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*5)];
    [selectTitleImageLabel setText:[LabelUtils getLabelForKey:@"title_image"]];
    [selectTitleImageLabel setAlpha:0.7];
    [selectTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    selectTitleImageLabel.numberOfLines = 0;
    selectTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:selectTitleImageLabel];
    
    //Select Title Image Edit Spinner
    selectTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, selectTitleImageLabel.frame.origin.y + selectTitleImageLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [selectTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    selectTitleImgTextField.layer.cornerRadius = 5;
    selectTitleImgTextField.layer.borderWidth = 1.0;
    selectTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [selectTitleImgTextField setAlpha:0.7];
    [selectTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    selectTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:selectTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectTitleImgTextField.frame.origin.x + selectTitleImgTextField.frame.size.width - (width/100)*9 , selectTitleImgTextField.frame.origin.y + (selectTitleImgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImage];
    
    //FaceTitleAlignment
    UILabel *faceTitleAlignmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,selectTitleImgTextField.frame.origin.y + selectTitleImgTextField.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [faceTitleAlignmentLabel setText:[LabelUtils getLabelForKey:@"face_title_alignment"]];
    [faceTitleAlignmentLabel setAlpha:0.7];
    [faceTitleAlignmentLabel setFont:[UIFont systemFontOfSize:11]];
    faceTitleAlignmentLabel.numberOfLines = 0;
    faceTitleAlignmentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceTitleAlignmentLabel];
    
    faceTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceTitleAlignmentLabel.frame.origin.y + faceTitleAlignmentLabel.frame.size.height + (height/100)*1, faceTitleAlignmentLabel.frame.size.width, (height/100)*4)];
    [faceTitleTextField setFont:[UIFont systemFontOfSize:12]];
    faceTitleTextField.layer.cornerRadius = 5;
    faceTitleTextField.layer.borderWidth = 1.0;
    faceTitleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceTitleTextField setAlpha:0.7];
    [faceTitleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceTitleTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:faceTitleTextField];
    
    UIImageView *faceTitleImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceTitleTextField.frame.origin.x + faceTitleTextField.frame.size.width - (width/100)*9 , faceTitleTextField.frame.origin.y + (faceTitleTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceTitleImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceTitleImageDownArrowImage];
    
    faceTitleCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceTitleCheckBox.frame = CGRectMake(faceTitleTextField.frame.origin.x + faceTitleTextField.frame.size.width + (width/100)*2, faceTitleTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                       forState:UIControlStateNormal];
    [faceTitleCheckBox addTarget:self action:@selector(faceTitleCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceTitleCheckBox];
    
    UILabel *hideFaceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceTitleCheckBox.frame.origin.x + faceTitleCheckBox.frame.size.width + (width/100)*2, faceTitleCheckBox.frame.origin.y, faceTitleTextField.frame.size.width, (height/100)*4)];
    [hideFaceTitleLabel setText:[LabelUtils getLabelForKey:@"hide_face_title"]];
    [hideFaceTitleLabel setAlpha:0.7];
    [hideFaceTitleLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceTitleLabel.numberOfLines = 0;
    hideFaceTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideFaceTitleLabel];
    
    //FaceHintMessageAlignment
    UILabel *faceHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceTitleTextField.frame.origin.y + faceTitleTextField.frame.size.height + (height/100)*2, self.view.frame.size.width, (height/100)*2)];
    [faceHintMsgLabel setText:[LabelUtils getLabelForKey:@"face_hint_message_alignment"]];
    [faceHintMsgLabel setAlpha:0.7];
    [faceHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    faceHintMsgLabel.numberOfLines = 0;
    faceHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceHintMsgLabel];
    
    faceHintMsgTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceHintMsgLabel.frame.origin.y + faceHintMsgLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [faceHintMsgTextField setFont:[UIFont systemFontOfSize:12]];
    faceHintMsgTextField.layer.cornerRadius = 5;
    faceHintMsgTextField.layer.borderWidth = 1.0;
    faceHintMsgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceHintMsgTextField setAlpha:0.7];
    [faceHintMsgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceHintMsgTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceHintMsgTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:faceHintMsgTextField];
    
    UIImageView *faceHintMsgImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceHintMsgTextField.frame.origin.x + faceHintMsgTextField.frame.size.width - (width/100)*9 , faceHintMsgTextField.frame.origin.y + (faceHintMsgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceHintMsgImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceHintMsgImageDownArrowImage];
    
    faceHintMsgCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceHintMsgCheckBox.frame = CGRectMake(faceHintMsgTextField.frame.origin.x + faceHintMsgTextField.frame.size.width + (width/100)*2, faceHintMsgTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                         forState:UIControlStateNormal];
    [faceHintMsgCheckBox addTarget:self action:@selector(faceHintMsgCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceHintMsgCheckBox];
    
    UILabel *hideFaceHintMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceHintMsgCheckBox.frame.origin.x + faceHintMsgCheckBox.frame.size.width + (width/100)*2, faceHintMsgCheckBox.frame.origin.y, faceHintMsgTextField.frame.size.width, (height/100)*4)];
    [hideFaceHintMsgLabel setText:[LabelUtils getLabelForKey:@"hide_face_hint_message"]];
    [hideFaceHintMsgLabel setAlpha:0.7];
    [hideFaceHintMsgLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceHintMsgLabel.numberOfLines = 0;
    hideFaceHintMsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideFaceHintMsgLabel];
    
    //FaceHintIcon
    UILabel *faceHintIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceHintMsgTextField.frame.origin.y + faceHintMsgTextField.frame.size.height + (height/100)*2, self.view.frame.size.width, (height/100)*2)];
    [faceHintIconLabel setText:[LabelUtils getLabelForKey:@"face_hint_icon_alignment"]];
    [faceHintIconLabel setAlpha:0.7];
    [faceHintIconLabel setFont:[UIFont systemFontOfSize:11]];
    faceHintIconLabel.numberOfLines = 0;
    faceHintIconLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceHintIconLabel];
    
    faceHintIconTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceHintIconLabel.frame.origin.y + faceHintIconLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [faceHintIconTextField setFont:[UIFont systemFontOfSize:12]];
    faceHintIconTextField.layer.cornerRadius = 5;
    faceHintIconTextField.layer.borderWidth = 1.0;
    faceHintIconTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceHintIconTextField setAlpha:0.7];
    [faceHintIconTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceHintIconTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceHintIconTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:faceHintIconTextField];
    
    UIImageView *faceHintIconImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceHintIconTextField.frame.origin.x + faceHintIconTextField.frame.size.width - (width/100)*9 , faceHintIconTextField.frame.origin.y + (faceHintIconTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceHintIconImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceHintIconImageDownArrowImage];
    
    faceHintIconCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceHintIconCheckBox.frame = CGRectMake(faceHintIconTextField.frame.origin.x + faceHintIconTextField.frame.size.width + (width/100)*2, faceHintIconTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                          forState:UIControlStateNormal];
    [faceHintIconCheckBox addTarget:self action:@selector(faceHintIconCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceHintIconCheckBox];
    
    UILabel *hideFaceHintIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceHintIconCheckBox.frame.origin.x + faceHintIconCheckBox.frame.size.width + (width/100)*2, faceHintIconCheckBox.frame.origin.y, faceHintIconTextField.frame.size.width, (height/100)*4)];
    [hideFaceHintIconLabel setText:[LabelUtils getLabelForKey:@"hide_face_hint_icon"]];
    [hideFaceHintIconLabel setAlpha:0.7];
    [hideFaceHintIconLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceHintIconLabel.numberOfLines = 0;
    hideFaceHintIconLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideFaceHintIconLabel];
    
    //FaceTitleImageAlignment
    UILabel *faceTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceHintIconTextField.frame.origin.y + faceHintIconTextField.frame.size.height + (height/100)*2, self.view.frame.size.width, (height/100)*2)];
    [faceTitleImageLabel setText:[LabelUtils getLabelForKey:@"face_title_image_alignment"]];
    [faceTitleImageLabel setAlpha:0.7];
    [faceTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    faceTitleImageLabel.numberOfLines = 0;
    faceTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceTitleImageLabel];
    
    faceTitleImageTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceTitleImageLabel.frame.origin.y + faceTitleImageLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [faceTitleImageTextField setFont:[UIFont systemFontOfSize:12]];
    faceTitleImageTextField.layer.cornerRadius = 5;
    faceTitleImageTextField.layer.borderWidth = 1.0;
    faceTitleImageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceTitleImageTextField setAlpha:0.7];
    [faceTitleImageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceTitleImageTextField.borderStyle = UITextBorderStyleRoundedRect;
    faceTitleImageTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:faceTitleImageTextField];
    
    UIImageView *faceTiImageDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceTitleImageTextField.frame.origin.x + faceTitleImageTextField.frame.size.width - (width/100)*9 , faceTitleImageTextField.frame.origin.y + (faceTitleImageTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceTiImageDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceTiImageDownArrowImage];
    
    faceTitleImageCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    faceTitleImageCheckBox.frame = CGRectMake(faceTitleImageTextField.frame.origin.x + faceTitleImageTextField.frame.size.width + (width/100)*2, faceTitleImageTextField.frame.origin.y, (width/100)*7, (height/100)*4);
    [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [faceTitleImageCheckBox addTarget:self action:@selector(faceTitleImageCheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceTitleImageCheckBox];
    
    UILabel *hideFaceTitleImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceTitleImageCheckBox.frame.origin.x + faceTitleImageCheckBox.frame.size.width + (width/100)*2, faceTitleImageCheckBox.frame.origin.y, faceTitleImageTextField.frame.size.width, (height/100)*4)];
    [hideFaceTitleImageLabel setText:[LabelUtils getLabelForKey:@"hide_face_title_image"]];
    [hideFaceTitleImageLabel setAlpha:0.7];
    [hideFaceTitleImageLabel setFont:[UIFont systemFontOfSize:11]];
    hideFaceTitleImageLabel.numberOfLines = 0;
    hideFaceTitleImageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:hideFaceTitleImageLabel];
    
    //CustomizeUI
    UILabel *customizeUILabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceTitleImageTextField.frame.origin.y + faceTitleImageTextField.frame.size.height + (height/100)*3, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [customizeUILabel setText:[LabelUtils getLabelForKey:@"custom_overlay"]];
    [customizeUILabel setAlpha:0.7];
    [customizeUILabel setFont:[UIFont systemFontOfSize:11]];
    customizeUILabel.numberOfLines = 0;
    customizeUILabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:customizeUILabel];
    
    faceCustomizeUI = [UIButton buttonWithType:UIButtonTypeCustom];
    faceCustomizeUI.frame = CGRectMake(faceTitleImageTextField.frame.origin.x + faceTitleImageTextField.frame.size.width + (width/100)*2, customizeUILabel.frame.origin.y - (height/100)*1, (width/100)*7, (height/100)*4);
    [faceCustomizeUI setImage:[UIImage imageNamed:@"uncheck.png"]
                         forState:UIControlStateNormal];
    [faceCustomizeUI addTarget:self action:@selector(customizeUICheckBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceCustomizeUI];
    
    //Start
    //Show Preview Screen
    //show Preview Screen Label
    UILabel *showPreviewScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceCustomizeUI.frame.origin.y + faceCustomizeUI.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    showPreviewScreenLabel.numberOfLines = 0;
    showPreviewScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showPreviewScreenLabel setText:[LabelUtils getLabelForKey:@"show_preview_screen"]];
    [showPreviewScreenLabel setAlpha:0.7];
    [showPreviewScreenLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:showPreviewScreenLabel];
    
    //Launch Front camera No label
    UILabel *showPreviewScreenYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, showPreviewScreenLabel.frame.origin.y + showPreviewScreenLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [showPreviewScreenYESLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [showPreviewScreenYESLabel setAlpha:0.7];
    [showPreviewScreenYESLabel setFont:[UIFont systemFontOfSize:12]];
    [showPreviewScreenYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showPreviewScreenYESLabel];
    
    //toggleButton
    showPreviewScreenTogleButton_Face = [UIButton buttonWithType:UIButtonTypeCustom];
    showPreviewScreenTogleButton_Face.frame = CGRectMake(showPreviewScreenYESLabel.frame.origin.x + showPreviewScreenYESLabel.frame.size.width + (width/100)*2, showPreviewScreenYESLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [showPreviewScreenTogleButton_Face setImage:[UIImage imageNamed:@"toggleOf.png"]
                                  forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    showPreviewScreenTogleButton_Face.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [showPreviewScreenTogleButton_Face addTarget:self action:@selector(showPreviewScreenBtnClick_Face:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:showPreviewScreenTogleButton_Face];
    
    //Yes Label
    UILabel *showPreviewScreenNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(showPreviewScreenTogleButton_Face.frame.origin.x + showPreviewScreenTogleButton_Face.frame.size.width + (width/100)*2, showPreviewScreenTogleButton_Face.frame.origin.y, (width/100)*10, (height/100)*5)];
    [showPreviewScreenNOLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [showPreviewScreenNOLabel setAlpha:0.7];
    [showPreviewScreenNOLabel setFont:[UIFont systemFontOfSize:12]];
    [showPreviewScreenNOLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showPreviewScreenNOLabel];
    
    //Show Instruction Screen
    UILabel *showInstructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, faceCustomizeUI.frame.origin.y + faceCustomizeUI.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    showInstructionScreenLabel.numberOfLines = 0;
    showInstructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showInstructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [showInstructionScreenLabel setAlpha:0.7];
    [showInstructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:showInstructionScreenLabel];
    
    //Show Instruction Screen No label
    UILabel *showInstructionYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(showInstructionScreenLabel.frame.origin.x, showInstructionScreenLabel.frame.origin.y + showInstructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [showInstructionYESLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [showInstructionYESLabel setAlpha:0.7];
    [showInstructionYESLabel setFont:[UIFont systemFontOfSize:12]];
    [showInstructionYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showInstructionYESLabel];
    
    //toggleButton
    showInstScreenToggleButton_Face = [UIButton buttonWithType:UIButtonTypeCustom];
    showInstScreenToggleButton_Face.frame = CGRectMake(showInstructionYESLabel.frame.origin.x + showInstructionYESLabel.frame.size.width + (width/100)*2, showInstructionYESLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [showInstScreenToggleButton_Face setImage:[UIImage imageNamed:@"toggleOn.png"]
                                forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    showInstScreenToggleButton_Face.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [showInstScreenToggleButton_Face addTarget:self action:@selector(showInstScreenBtnClick_Face:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:showInstScreenToggleButton_Face];
    
    //Show Instruction Screen No Label
    UILabel *showInstScreenNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(showInstScreenToggleButton_Face.frame.origin.x + showInstScreenToggleButton_Face.frame.size.width + (width/100)*2, showInstScreenToggleButton_Face.frame.origin.y, (width/100)*10, (height/100)*5)];
    [showInstScreenNOLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [showInstScreenNOLabel setAlpha:0.7];
    [showInstScreenNOLabel setFont:[UIFont systemFontOfSize:12]];
    [showInstScreenNOLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:showInstScreenNOLabel];
    
    //
    
    //Id Capture Label Initialization
    UILabel *initFaceCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,showPreviewScreenTogleButton_Face.frame.origin.y + showPreviewScreenTogleButton_Face.frame.size.height + (height/100)*3, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [initFaceCaptureLabel setText:[LabelUtils getLabelForKey:@"id_capture_label"]];
    [initFaceCaptureLabel setAlpha:0.7];
    [initFaceCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    initFaceCaptureLabel.numberOfLines = 0;
    initFaceCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:initFaceCaptureLabel];
    
    faceCaptureLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, initFaceCaptureLabel.frame.origin.y + initFaceCaptureLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [faceCaptureLabelTextField setFont:[UIFont systemFontOfSize:12]];
    faceCaptureLabelTextField.layer.cornerRadius = 5;
    faceCaptureLabelTextField.layer.borderWidth = 1.0;
    faceCaptureLabelTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceCaptureLabelTextField setAlpha:0.7];
    [faceCaptureLabelTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceCaptureLabelTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceCaptureLabelTextField];
    
    UIImageView *faceCaptureLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceCaptureLabelTextField.frame.origin.x + faceCaptureLabelTextField.frame.size.width - (width/100)*9 , faceCaptureLabelTextField.frame.origin.y + (faceCaptureLabelTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceCaptureLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceCaptureLabelDownArrowImage];
    
    //English Label
    UILabel *englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,faceCaptureLabelTextField.frame.origin.y + faceCaptureLabelTextField.frame.size.height +   (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [englishLabel setText:[LabelUtils getLabelForKey:@"label_value"]];
    [englishLabel setAlpha:0.7];
    [englishLabel setFont:[UIFont systemFontOfSize:11]];
    englishLabel.numberOfLines = 0;
    englishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:englishLabel];
    
    //Spanish Label
    UILabel *spanishLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x,faceCaptureLabelTextField.frame.origin.y + faceCaptureLabelTextField.frame.size.height +  (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [spanishLabel setText:[LabelUtils getLabelForKey:@"spanish_label"]];
    [spanishLabel setAlpha:0.7];
    spanishLabel.numberOfLines = 0;
    spanishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [spanishLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:spanishLabel];
    [spanishLabel setHidden:YES];
    
    //English TextField
    englishLabelTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, englishLabel.frame.origin.y + englishLabel.frame.size.height + (height/100)*1, faceOutlineColorLabel.frame.size.width, (height/100)*4)];
    [englishLabelTextField_Face setFont:[UIFont systemFontOfSize:12]];
    englishLabelTextField_Face.layer.cornerRadius = 5;
    englishLabelTextField_Face.layer.borderWidth = 1.0;
    englishLabelTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [englishLabelTextField_Face setAlpha:0.7];
    [englishLabelTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    englishLabelTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:englishLabelTextField_Face];
    
    //Spanish TextField
    spanishLabelTextField_Face = [[UITextField alloc] initWithFrame:CGRectMake(faceOutLineTransLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*1, spanishLabel.frame.size.width, (height/100)*4)];
    [spanishLabelTextField_Face setFont:[UIFont systemFontOfSize:12]];
    spanishLabelTextField_Face.layer.cornerRadius = 5;
    spanishLabelTextField_Face.layer.borderWidth = 1.0;
    spanishLabelTextField_Face.layer.borderColor = [[UIColor grayColor]CGColor];
    [spanishLabelTextField_Face setAlpha:0.7];
    [spanishLabelTextField_Face setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    spanishLabelTextField_Face.borderStyle = UITextBorderStyleRoundedRect;
    spanishLabelTextField_Face.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:spanishLabelTextField_Face];
    [spanishLabelTextField_Face setHidden:YES];
    
    UIButton *addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frameAddLabel = CGRectMake(faceOutLineTransLabel.frame.origin.x, spanishLabel.frame.origin.y + spanishLabel.frame.size.height + (height/100)*1, spanishLabel.frame.size.width, (height/100)*6);
    [addLabelButton setFrame:frameAddLabel];
    addLabelButton.layer.cornerRadius = 20;
    addLabelButton.clipsToBounds = YES;
    [addLabelButton setTitle:[LabelUtils getLabelForKey:@"add_label"] forState:UIControlStateNormal];
    addLabelButton.titleLabel.textColor = [UIColor whiteColor];
    [addLabelButton setBackgroundColor:[UIColor blackColor]];
    [addLabelButton addTarget:self action:@selector(addLabelClickedSelfieCapture:) forControlEvents:UIControlEventTouchUpInside];
    [addLabelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:addLabelButton];
    
    //Face Contours
    UILabel *faceContoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x,addLabelButton.frame.origin.y + addLabelButton.frame.size.height + (height/100)*2, faceOutlineColorLabel.frame.size.width, (height/100)*2)];
    [faceContoursLabel setText:[LabelUtils getLabelForKey:@"face_contours"]];
    [faceContoursLabel setAlpha:0.7];
    [faceContoursLabel setFont:[UIFont systemFontOfSize:11]];
    faceContoursLabel.numberOfLines = 0;
    faceContoursLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:faceContoursLabel];
    
    faceContoursTextField = [[UITextField alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceContoursLabel.frame.origin.y + faceContoursLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [faceContoursTextField setFont:[UIFont systemFontOfSize:12]];
    faceContoursTextField.layer.cornerRadius = 5;
    faceContoursTextField.layer.borderWidth = 1.0;
    faceContoursTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [faceContoursTextField setAlpha:0.7];
    [faceContoursTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    faceContoursTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:faceContoursTextField];
    
    //Start
    //Enable Shadow
    //Enable Shadow Label
    UILabel *enableShadowLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, faceContoursTextField.frame.origin.y + faceContoursTextField.frame.size.height + (height/100)*2,(width/100)*49, (height/100)*2)];
    enableShadowLabel.numberOfLines = 0;
    enableShadowLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //[enableShadowLabel setText:[LabelUtils getLabelForKey:@"show_preview_screen"]];
    [enableShadowLabel setText:@"Enable Shadow"];
    [enableShadowLabel setAlpha:0.7];
    [enableShadowLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:enableShadowLabel];
    
    //Launch Front camera No label
    UILabel *enableShadowNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(faceOutlineColorLabel.frame.origin.x, enableShadowLabel.frame.origin.y + enableShadowLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [enableShadowNoLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [enableShadowNoLabel setAlpha:0.7];
    [enableShadowNoLabel setFont:[UIFont systemFontOfSize:12]];
    [enableShadowNoLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:enableShadowNoLabel];
    
    //toggleButton
    enableShadow_Face = [UIButton buttonWithType:UIButtonTypeCustom];
    enableShadow_Face.frame = CGRectMake(enableShadowNoLabel.frame.origin.x + enableShadowNoLabel.frame.size.width + (width/100)*2, enableShadowNoLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    //[togleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOf.png"]
                                       forState:UIControlStateNormal];
    //    togleButton.contentMode = UIViewContentModeScaleAspectFit;
    enableShadow_Face.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //    togleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [enableShadow_Face addTarget:self action:@selector(enableShadowBtnClick_Face:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:enableShadow_Face];
    
    //Yes Label
    UILabel *enableShadowYesLabel = [[UILabel alloc] initWithFrame:CGRectMake(enableShadow_Face.frame.origin.x + enableShadow_Face.frame.size.width + (width/100)*2, enableShadow_Face.frame.origin.y, (width/100)*10, (height/100)*5)];
    [enableShadowYesLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [enableShadowYesLabel setAlpha:0.7];
    [enableShadowYesLabel setFont:[UIFont systemFontOfSize:12]];
    [enableShadowYesLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:enableShadowYesLabel];
    
    UIImageView *faceContoursLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(faceContoursTextField.frame.origin.x + faceContoursTextField.frame.size.width - (width/100)*9 , faceContoursTextField.frame.origin.y + (faceContoursTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [faceContoursLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:faceContoursLabelDownArrowImage];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(faceOutlineColorLabel.frame.origin.x, enableShadow_Face.frame.origin.y + enableShadow_Face.frame.size.height + (height/100)*2, faceTitleImageTextField.frame.size.width, (height/100)*6);
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
    [saveBtn setHidden:YES];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(width/2 - (saveBtn.frame.size.width/2), saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn addTarget:self action:@selector(resetButtonSelfieCapture:) forControlEvents:UIControlEventTouchUpInside];
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)showPreviewScreenBtnClick_Face:(UIButton*)button {
    if(!showPreviewScreen_Face) {
        [showPreviewScreenTogleButton_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        showPreviewScreen_Face = true;
    } else {
        [showPreviewScreenTogleButton_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        showPreviewScreen_Face = false;
    }
}

-(void)showInstScreenBtnClick_Face:(UIButton*)button {
    if(!showInstructionScreen_Face) {
        [showInstScreenToggleButton_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        showInstructionScreen_Face = true;
    }else {
        [showInstScreenToggleButton_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        showInstructionScreen_Face = false;
    }
}

-(void)enableShadowBtnClick_Face:(UIButton*)button {
    if(!isEnableShadow_Face) {
        [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isEnableShadow_Face = true;
    }else {
        [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isEnableShadow_Face = false;
    }
}

-(void)enableShadowBtnClick_Id:(UIButton*)button {
//    if(!isEnableShadow_Id) {
//        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
//        isEnableShadow_Id = true;
//    }else {
//        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
//        isEnableShadow_Id = false;
//    }
    
    switch (selectConfig_row) {
        case 0:
              if(!isEnableShadow_IdFront) {
                    [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                    isEnableShadow_IdFront = true;
                }else {
                    [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                    isEnableShadow_IdFront = false;
                }
            break;
        case 1:
//            if(showInstScreen_IdBack) {
//                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
//                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
//                showInstScreen_IdBack = false;
//            }
            if(!isEnableShadow_IdBack) {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack = true;
            }else {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack = false;
            }
            break;
        case 2:
//            if(showInstScreen_Doc) {
//                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
//                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
//                showInstScreen_Doc = false;
//            }
            if(!isEnableShadow_IdBack_Doc) {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_Doc = true;
            }else {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_Doc = false;
            }
            break;
        case 3:
//            if(showInstScreen_Snippet) {
//                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
//                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
//                showInstScreen_Snippet = false;
//            }
            if(!isEnableShadow_IdBack_Snippet) {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_Snippet = true;
            }else {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_Snippet = false;
            }
            break;
        case 6:
//            if(isEnableShadow_Idf) {
//                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
//                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
//                showInstScreen_IdFront_sec = false;
//            }
            if(!isEnableShadow_IdFront_sec) {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                isEnableShadow_IdFront_sec = true;
            }else {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                isEnableShadow_IdFront_sec = false;
            }
            break;
        case 7:
//            if(showInstScreen_IdBack_sec) {
//                [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
//                [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
//                showInstScreen_IdBack_sec = false;
//            }
            if(!isEnableShadow_IdBack_sec) {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_sec = true;
            }else {
                [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
                isEnableShadow_IdBack_sec = false;
            }
            break;
            
        default:
            break;
    }
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

-(void)customizeUICheckBoxBtnClick:(UIButton*)button {
    if(!showFaceCustomizeUI) {
        [faceCustomizeUI setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
        showFaceCustomizeUI = true;
    } else {
        showFaceCustomizeUI = false;
        [faceCustomizeUI setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
}

-(void)addLabelClickedSelfieCapture:(UIButton*)button {
//    NSString *labelKey = faceCaptureLabelTextField.text;
//    if(![NSStringUtils stringIsNilOrEmpty:labelKey]){
//
//        NSString *englabel = englishLabelTextField_Face.text;
//        if(![NSStringUtils stringIsNilOrEmpty:englabel]){
//            [englishLabels setObject:englabel forKey:labelKey];
//        }
//
//        NSString *spalabel = spanishLabelTextField_Face.text;
//        if(![NSStringUtils stringIsNilOrEmpty:spalabel]){
//            [spanishLabels setObject:spalabel forKey:labelKey];
//        }
//    }
//    [englishLabelTextField_Face setText:@""];
//    [spanishLabelTextField_Face setText:@""];
    
    
    NSString *labelKey = faceCaptureLabelTextField.text;
    NSString *englabel = englishLabelTextField_Face.text;
    
    NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultFaceCaptureConfig] getLabelConfiguration];
    if(nil != labelConfig) {
        [labelConfig setObject:[englabel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
    }
    [englishLabelTextField_Face setText:@""];
}

-(void)resetButtonSelfieCapture:(UIButton*)button {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36",*dRetryButtonBorderColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dConfirmButtonStyle=@"FFFFFF", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",
        *dInstPreviewColor = @"487D95";
    int dOutsideFaceOutlineColorAlpha = 1;
    
    [faceOutlineColorTextField setText:dFaceOutlineColor];
    [faceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedFaceOutlineColorTextField setText:dDetectedFaceOutlineColor];
    [detectedFaceOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [outlineColorOfFaceOutlineTextField setText:dOutsideFaceOutlineColor];
//    [outlineColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [outlineColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [outlineDetectedColorOfFaceOutlineTextField setText:dDetectedOutsideFaceOutlineColor];
    [outlineDetectedColorOfFaceOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [backButtonTextField_Face setText:dBackButtonColor];
    [backButtonTransTextField_Face setText:[@(mAlpha) stringValue]];
    [textColorTextField_Face setText:dTextColor];
    [textColorTransTextField_Face setText:[@(mAlpha) stringValue]];
    [retryButtonTextField_Face setText:dRetryButtonColor];
    [retryButtonTransTextField_Face setText:[@(mAlpha) stringValue]];
    [retryButtonBorderTextField_Face setText:dRetryButtonBorderColor];
    [retryButtonBorderTransTextField_Face setText:[@(mAlpha) stringValue]];
    [confirmButtonTextField_Face setText:dConfirmButtonColor];
    [confirmButtonTransTextField_Face setText:[@(mAlpha) stringValue]];
    [confirmButtonStyleTextField_Face setText:dConfirmButtonStyle];
    [confirmButtonStyleTransTextField_Face setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextField_Face setText:dInstContinueButtonColor];
    [instContinueButtonTransTextField_Face setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextColorField_Face setText:dInstContinueButtonTextColor];
    [instContinueButtonTransTextColorField_Face setText:[@(mAlpha) stringValue]];
    [instPreviewColorField_Face setText:dInstPreviewColor];
    [instPreviewTransColorField_Face setText:[@(mAlpha) stringValue]];
    [headerTextColorTextField_Face setText:dTextColor];
    [headerTextColorTransTextField_Face setText:[@(mAlpha) stringValue]];
    [headerSizeTextField_Face setText:@""];
    [textSizeTextField_Face setText:@""];
    
    [faceTitleTextField setText:[LabelUtils getLabelForKey:@"Bottom"]];
    [faceHintMsgTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [faceHintIconTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    [faceTitleImageTextField setText:[LabelUtils getLabelForKey:@"Top"]];
    hideFaceTitle = false;
    hideFaceHintMessage = false;
    hideFaceHintIcon = false;
    hideFaceTitleImage = false;
    showFaceCustomizeUI = false;
    isEnableShadow_Face = true;
    [faceTitleCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                       forState:UIControlStateNormal];
    [faceHintMsgCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                         forState:UIControlStateNormal];
    [faceHintIconCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                          forState:UIControlStateNormal];
    [faceTitleImageCheckBox setImage:[UIImage imageNamed:@"uncheck.png"]
                            forState:UIControlStateNormal];
    [faceCustomizeUI setImage:[UIImage imageNamed:@"uncheck.png"]
                     forState:UIControlStateNormal];
    [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOn.png"]
                     forState:UIControlStateNormal];
    //Resetting the all labels value
    [englishLabels removeAllObjects];
    [spanishLabels removeAllObjects];
   // [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
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

-(void)saveSetting_Selfie {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36",*dRetryButtonBorderColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dConfirmButtonStyle=@"FFFFFF", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",
        *dInstPreviewColor = @"487D95";

    NSString *faceoutlinecolor = dFaceOutlineColor, *detectedfaceoutlinecolor = dDetectedFaceOutlineColor, *outsideoutlinecolor = dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutLineColor = dDetectedOutsideFaceOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor,*confirmButtonStyle=dConfirmButtonStyle, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor,*instPreviewColor = dInstPreviewColor;
    int faceoutlinetransparency = mAlpha, detectedfaceoutlinetransparency = mAlpha, outsideoutlinetransparency = mAlpha, dDetectedOutsideFaceOutLineColorAlpha = mAlpha,backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, confirmButtonStyleTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, headerTextColorTrans=mAlpha,instPreviewColorTrans=mAlpha;
    
    faceoutlinecolor = faceOutlineColorTextField.text;
    detectedfaceoutlinecolor = detectedFaceOutlineColorTextField.text;
    outsideoutlinecolor = outlineColorOfFaceOutlineTextField.text;
    faceoutlinetransparency = [faceOutlineColorTransTextField.text intValue];
    detectedfaceoutlinetransparency = [detectedFaceOutlineColorTransTextField.text intValue];
    outsideoutlinetransparency = [outlineColorOfFaceOutlineTransTextField.text intValue];
    dDetectedOutsideFaceOutLineColor = outlineDetectedColorOfFaceOutlineTextField.text;
    dDetectedOutsideFaceOutLineColorAlpha = [outlineDetectedColorOfFaceOutlineTransTextField.text intValue];
    backButtonColor = backButtonTextField_Face.text;
    retryButtonColor = retryButtonTextField_Face.text;
    confirmButtonColor = confirmButtonTextField_Face.text;
    retryButtonBorderColor = retryButtonBorderTextField_Face.text;
    confirmButtonStyle = confirmButtonStyleTextField_Face.text;
    fontStyle = fontStyleTextField_Face.text;
    textColor = textColorTextField_Face.text;
    instContinueButtonColor = instContinueButtonTextField_Face.text;
    instContinueButtonTextColor = instContinueButtonTextColorField_Face.text;
    backButtonTrans=[backButtonTransTextField_Face.text intValue];
    retryButtonTrans=[retryButtonTransTextField_Face.text intValue];
    confirmButtonTrans =[confirmButtonTransTextField_Face.text intValue];
    textColorTrans=[textColorTransTextField_Face.text intValue];
   instContinueButtonTrans=[instContinueButtonTransTextField_Face.text intValue];
    instContinueButtonTransText=[instContinueButtonTransTextColorField_Face.text intValue];
    headerTextColorTrans=[headerTextColorTransTextField_Face.text intValue];
    instPreviewColor = instPreviewColorField_Face.text;
    instPreviewColorTrans = [instPreviewTransColorField_Face.text intValue];
    
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
    [self saveSetting:@"faceInstPreviewColor" value:instPreviewColor];
    
    [self saveSetting:@"faceInstPreviewColorTransparency" value:[NSString stringWithFormat:@"%d",instPreviewColorTrans]];
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
    
    [self saveSetting:@"faceHeaderTextSize" value:[headerSizeTextField_Face text]];
    [self saveSetting:@"faceTextSize" value:[textSizeTextField_Face text]];
    [self saveSetting:@"faceHeaderTextColor" value:[headerTextColorTextField_Face text]];
    [self saveSetting:@"faceHeaderTextColorTransparency" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    
    NSString *hideFaceCapTitle, *hideFaceCaphintMsg, *hideFaceCaphintIcon,*hideFaceCapTitImage, *show_faceCustomizeUI;
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
    
    if(hideFaceHintIcon) {
        hideFaceCaphintIcon = @"Y";
    } else {
        hideFaceCaphintIcon = @"N";
    }
    
    if(hideFaceTitleImage) {
        hideFaceCapTitImage = @"Y";
    } else {
        hideFaceCapTitImage = @"N";
    }
    
    if(showFaceCustomizeUI) {
        show_faceCustomizeUI = @"Y";
    } else {
        show_faceCustomizeUI = @"N";
    }
    
    [self saveSetting:@"hideFaceTitle" value:hideFaceCapTitle];
    [self saveSetting:@"hideFacehintMsg" value:hideFaceCaphintMsg];
    [self saveSetting:@"hideFacehintIcon" value:hideFaceCaphintIcon];
    [self saveSetting:@"hideFacetitleImage" value:hideFaceCapTitImage];
    [self saveSetting:@"showFaceCustomizeUI" value:show_faceCustomizeUI];
    
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
}

-(void)sefieCaptureRetrieveSetting {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36",*dRetryButtonBorderColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dConfirmButtonStyle=@"FFFFFF", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",
        *dInstPreviewColor=@"487D95";
    
    int dOutSideFaceOutlineColorALpha = mAlpha;
    
    NSString *faceoutlinecolor = [self retrieveSetting:@"faceoutlinecolor" defaultValue: dFaceOutlineColor];
    NSString *faceoutlinetransparency = [self retrieveSetting:@"faceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *detectedfaceoutlinecolor = [self retrieveSetting:@"detectedfaceoutlinecolor" defaultValue: dDetectedFaceOutlineColor];
    NSString *detectedfaceoutlinetransparency = [self retrieveSetting:@"detectedfaceoutlinetransparency" defaultValue: [@(mAlpha) stringValue]];
    NSString *outsideoutlinecolor = [self retrieveSetting:@"_outsideoutlinecolor" defaultValue: dOutsideFaceOutlineColor];
    NSString *outsideoutlinetransparency = [self retrieveSetting:@"_outsideoutlinetransparency" defaultValue: [@(dOutSideFaceOutlineColorALpha) stringValue]];
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
    NSString *instPreviewColor = [self retrieveSetting:@"faceInstPreviewColor" defaultValue:dInstPreviewColor];
    NSString *instPreviewColorTrans = [self retrieveSetting:@"faceInstPreviewColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    
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
    
    if([@"Y" isEqualToString:[self retrieveSetting:@"showFaceCustomizeUI" defaultValue:@"N"]]) {
        showFaceCustomizeUI = true;
        [faceCustomizeUI setImage:[UIImage imageNamed:@"check.png"]
                                forState:UIControlStateNormal];
    } else {
        showFaceCustomizeUI = false;
        [faceCustomizeUI setImage:[UIImage imageNamed:@"uncheck.png"]
                                forState:UIControlStateNormal];
    }
    
    [faceOutlineColorTextField setText:faceoutlinecolor]; //
    [faceOutlineColorTransTextField setText:faceoutlinetransparency]; //
    
    [detectedFaceOutlineColorTextField setText:detectedfaceoutlinecolor]; //
    [detectedFaceOutlineColorTransTextField setText:detectedfaceoutlinetransparency];//
    
    [outlineColorOfFaceOutlineTextField setText:outsideoutlinecolor]; //
    [outlineColorOfFaceOutlineTransTextField setText:outsideoutlinetransparency]; //
    [outlineDetectedColorOfFaceOutlineTextField setText:detectedfaceoutsideoutlinecolor]; //
    [outlineDetectedColorOfFaceOutlineTransTextField setText:detectedfaceoutsideoutlinetransparency]; //
    
    [backButtonTextField_Face setText:backButton]; //
    [backButtonTransTextField_Face setText:backButtonTrans]; //
    
    [retryButtonTextField_Face setText:retryButton];//
    [retryButtonTransTextField_Face setText:retryButtonTrans];//
    
    [retryButtonBorderTextField_Face setText:retryButtonBorder]; //
    [retryButtonBorderTransTextField_Face setText:retryButtonBorderTrans]; //
    
    [confirmButtonTextField_Face setText:confirmButton]; //
    [confirmButtonTransTextField_Face setText:confirmButtonTrans]; //
    
    [confirmButtonStyleTextField_Face setText:confirmButtonStyle];//
    [confirmButtonStyleTransTextField_Face setText:confirmButtonStyleTrans];//
    
    [textColorTextField_Face setText:textColor];//
    [textColorTransTextField_Face setText:textColorTrans];//
    
    [instContinueButtonTextField_Face setText:instContinueButton]; //
    [instContinueButtonTransTextField_Face setText:instContinueButtonTrans]; //
    
    [instContinueButtonTextColorField_Face setText:instContinueTextColor]; //
    [instContinueButtonTransTextColorField_Face setText:instContinueTextColorTrans]; //
    
    [instPreviewColorField_Face setText:instPreviewColor];
    [instPreviewTransColorField_Face setText:instPreviewColorTrans];
    
    [headerTextColorTextField_Face setText:headerTextColor]; //
    [headerTextColorTransTextField_Face setText:headerTextColorTrans]; //
    
    [headerSizeTextField_Face setText:headerTextSize];
    [textSizeTextField_Face setText:textSize];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    //Show Inst Screen and Preview Screen
    if(showInstructionScreen_Face) {
        [showInstScreenToggleButton_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [showInstScreenToggleButton_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_Face) {
        [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
    
    if(showPreviewScreen_Face) {
        [showPreviewScreenTogleButton_Face setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [showPreviewScreenTogleButton_Face setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)selfieCapturePickerDataArray {
    
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
    
}

//Four FInger

- (float)scrollViewUI_FourFinger:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Font Style
    //Font Style Label
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField_4F = [[UITextField alloc] initWithFrame: CGRectMake(textFontStyleLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*88, (height/100)*4)];
    [fontStyleTextField_4F setFont:[UIFont systemFontOfSize:12]];
    fontStyleTextField_4F.layer.cornerRadius = 5;
    fontStyleTextField_4F.layer.borderWidth = 1.0;
    fontStyleTextField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [fontStyleTextField_4F setAlpha:0.7];
    [fontStyleTextField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    fontStyleTextField_4F.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:fontStyleTextField_4F];
    
    //Text Color/transparency
    //Text Color Label
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x,fontStyleTextField_4F.frame.origin.y + fontStyleTextField_4F.frame.size.height +   (height/100)*2, (width/100)*44, (height/100)*2)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textColorLabel];
    
    //Text Color TextField
    textColorTextField_4F = [[UITextField alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*1, textFontStyleLabel.frame.size.width, (height/100)*4)];
    [textColorTextField_4F setFont:[UIFont systemFontOfSize:12]];
    textColorTextField_4F.layer.cornerRadius = 5;
    textColorTextField_4F.layer.borderWidth = 1.0;
    textColorTextField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTextField_4F setAlpha:0.7];
    [textColorTextField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTextField_4F.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textColorTextField_4F];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,textColorLabel.frame.origin.y, textColorLabel.frame.size.width, (height/100)*2)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textColorTransLabel];
    
    //Transparency TextField
    textColorTransTextField_4F = [[UITextField alloc] initWithFrame:CGRectMake(textColorTransLabel.frame.origin.x, textColorTextField_4F.frame.origin.y, textColorTransLabel.frame.size.width, (height/100)*4)];
    [textColorTransTextField_4F setFont:[UIFont systemFontOfSize:12]];
    textColorTransTextField_4F.layer.cornerRadius = 5;
    textColorTransTextField_4F.layer.borderWidth = 1.0;
    textColorTransTextField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTransTextField_4F setAlpha:0.7];
    [textColorTransTextField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTransTextField_4F.borderStyle = UITextBorderStyleRoundedRect;
    textColorTransTextField_4F.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textColorTransTextField_4F];
    
    //Instruction continue Button/Transparency
    //continue Button Label
    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x,textColorTextField_4F.frame.origin.y + textColorTextField_4F.frame.size.height +   (height/100)*2, textFontStyleLabel.frame.size.width, (height/100)*2)];
    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
    [continueButtonLabel setAlpha:0.7];
    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonLabel.numberOfLines = 0;
    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonLabel];
    
    //continue Button TextField
    instContinueButtonTextField_4F = [[UITextField alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*1, textFontStyleLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextField_4F setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextField_4F.layer.cornerRadius = 5;
    instContinueButtonTextField_4F.layer.borderWidth = 1.0;
    instContinueButtonTextField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextField_4F setAlpha:0.7];
    [instContinueButtonTextField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextField_4F.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextField_4F];
    
    //Transparency Label
    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(textColorTransTextField_4F.frame.origin.x,textColorTransTextField_4F.frame.origin.y + textColorTransTextField_4F.frame.size.height +  (height/100)*2, textColorTransTextField_4F.frame.size.width, (height/100)*2)];
    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransLabel setAlpha:0.7];
    continueButtonTransLabel.numberOfLines = 0;
    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransLabel];
    
    //Transparency TextField
    instContinueButtonTransTextField_4F = [[UITextField alloc] initWithFrame:CGRectMake(continueButtonTransLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*1, continueButtonTransLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextField_4F setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextField_4F.layer.cornerRadius = 5;
    instContinueButtonTransTextField_4F.layer.borderWidth = 1.0;
    instContinueButtonTransTextField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextField_4F setAlpha:0.7];
    [instContinueButtonTransTextField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextField_4F.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextField_4F.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextField_4F];
    
    //Instruction continue Text color Button/Transparency
    //Continue Button Text color Label
    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x,instContinueButtonTransTextField_4F.frame.origin.y + instContinueButtonTransTextField_4F.frame.size.height +   (height/100)*2, textFontStyleLabel.frame.size.width, (height/100)*2)];
    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
    [continueButtonTextColorLabel setAlpha:0.7];
    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    continueButtonTextColorLabel.numberOfLines = 0;
    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:continueButtonTextColorLabel];
    
    //Continue Button text color TextField
    instContinueButtonTextColorField_4F = [[UITextField alloc] initWithFrame:CGRectMake(textFontStyleLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*1, textFontStyleLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTextColorField_4F setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTextColorField_4F.layer.cornerRadius = 5;
    instContinueButtonTextColorField_4F.layer.borderWidth = 1.0;
    instContinueButtonTextColorField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTextColorField_4F setAlpha:0.7];
    [instContinueButtonTextColorField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTextColorField_4F.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:instContinueButtonTextColorField_4F];
    
    //Transparency Label
    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(instContinueButtonTransTextField_4F.frame.origin.x,instContinueButtonTransTextField_4F.frame.origin.y + instContinueButtonTransTextField_4F.frame.size.height +  (height/100)*2, instContinueButtonTransTextField_4F.frame.size.width, (height/100)*2)];
    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [continueButtonTransTextColorLabel setAlpha:0.7];
    continueButtonTransTextColorLabel.numberOfLines = 0;
    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:continueButtonTransTextColorLabel];
    
    
    //Transparency TextField
    instContinueButtonTransTextColorField_4F= [[UITextField alloc] initWithFrame:CGRectMake(continueButtonTransTextColorLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*1, continueButtonTransTextColorLabel.frame.size.width, (height/100)*4)];
    [instContinueButtonTransTextColorField_4F setFont:[UIFont systemFontOfSize:12]];
    instContinueButtonTransTextColorField_4F.layer.cornerRadius = 5;
    instContinueButtonTransTextColorField_4F.layer.borderWidth = 1.0;
    instContinueButtonTransTextColorField_4F.layer.borderColor = [[UIColor grayColor]CGColor];
    [instContinueButtonTransTextColorField_4F setAlpha:0.7];
    [instContinueButtonTransTextColorField_4F setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    instContinueButtonTransTextColorField_4F.borderStyle = UITextBorderStyleRoundedRect;
    instContinueButtonTransTextColorField_4F.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:instContinueButtonTransTextColorField_4F];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(textFontStyleLabel.frame.origin.x, instContinueButtonTransTextColorField_4F.frame.origin.y + instContinueButtonTransTextColorField_4F.frame.size.height + (height/100)*2, (width/100)*44, (height/100)*6);
    [saveBtn setFrame:saveAccountframe];
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:[LabelUtils getLabelForKey:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:saveBtn];
    [saveBtn setHidden:YES];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(width/2 - (saveBtn.frame.size.width/2) , saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton_4F:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

//Voice Capture
- (float)scrollViewUI_VoiceCapture:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    // Play Button
    UILabel *btnColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,(height/100)*2, (width/100)*44, (height/100)*2)];
    [btnColorLabel setText:[LabelUtils getLabelForKey:@"voice_button_color"]];
    [btnColorLabel setAlpha:0.7];
    [btnColorLabel setFont:[UIFont systemFontOfSize:11]];
    btnColorLabel.numberOfLines = 0;
    btnColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:btnColorLabel];
    
    btnColorTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, btnColorLabel.frame.origin.y + btnColorLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [btnColorTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    btnColorTextField_voiceCapture.layer.cornerRadius = 5;
    btnColorTextField_voiceCapture.layer.borderWidth = 1.0;
    btnColorTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [btnColorTextField_voiceCapture setAlpha:0.7];
    [btnColorTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    btnColorTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:btnColorTextField_voiceCapture];
    
    UILabel *btnColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,btnColorLabel.frame.origin.y, btnColorLabel.frame.size.width, (height/100)*2)];
    [btnColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [btnColorTransLabel setAlpha:0.7];
    btnColorTransLabel.numberOfLines = 0;
    btnColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [btnColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:btnColorTransLabel];
    
    btnColorTransTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, btnColorTextField_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [btnColorTransTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    btnColorTransTextField_voiceCapture.layer.cornerRadius = 5;
    btnColorTransTextField_voiceCapture.layer.borderWidth = 1.0;
    btnColorTransTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [btnColorTransTextField_voiceCapture setAlpha:0.7];
    [btnColorTransTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    btnColorTransTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    btnColorTransTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:btnColorTransTextField_voiceCapture];
    
    //Background Color
    UILabel *backgroundBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,btnColorTextField_voiceCapture.frame.origin.y + btnColorTextField_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [backgroundBtnLabel setText:[LabelUtils getLabelForKey:@"voice_background_color"]];
    [backgroundBtnLabel setAlpha:0.7];
    [backgroundBtnLabel setFont:[UIFont systemFontOfSize:11]];
    backgroundBtnLabel.numberOfLines = 0;
    backgroundBtnLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:backgroundBtnLabel];
    
    backgroundBtnTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, backgroundBtnLabel.frame.origin.y + backgroundBtnLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [backgroundBtnTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    backgroundBtnTextField_voiceCapture.layer.cornerRadius = 5;
    backgroundBtnTextField_voiceCapture.layer.borderWidth = 1.0;
    backgroundBtnTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [backgroundBtnTextField_voiceCapture setAlpha:0.7];
    [backgroundBtnTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backgroundBtnTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:backgroundBtnTextField_voiceCapture];
    
    UILabel *backGroundBtnColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,backgroundBtnLabel.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*2)];
    [backGroundBtnColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backGroundBtnColorTransLabel setAlpha:0.7];
    backGroundBtnColorTransLabel.numberOfLines = 0;
    backGroundBtnColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backGroundBtnColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:backGroundBtnColorTransLabel];
    
    backGroundBtnTransColorTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, backgroundBtnTextField_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [backGroundBtnTransColorTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    backGroundBtnTransColorTextField_voiceCapture.layer.cornerRadius = 5;
    backGroundBtnTransColorTextField_voiceCapture.layer.borderWidth = 1.0;
    backGroundBtnTransColorTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [backGroundBtnTransColorTextField_voiceCapture setAlpha:0.7];
    [backGroundBtnTransColorTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backGroundBtnTransColorTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    backGroundBtnTransColorTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:backGroundBtnTransColorTextField_voiceCapture];
    
    //Title Label on Top
    UILabel *titleLabelAlignLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,backgroundBtnTextField_voiceCapture.frame.origin.y + backgroundBtnTextField_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [titleLabelAlignLabel setText:[LabelUtils getLabelForKey:@"voice_title_label_on_top"]];
    [titleLabelAlignLabel setAlpha:0.7];
    [titleLabelAlignLabel setFont:[UIFont systemFontOfSize:11]];
    titleLabelAlignLabel.numberOfLines = 0;
    titleLabelAlignLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:titleLabelAlignLabel];
    
    //No label
    UILabel *titleLabelAlignNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelAlignLabel.frame.origin.x, titleLabelAlignLabel.frame.origin.y + titleLabelAlignLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [titleLabelAlignNOLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [titleLabelAlignNOLabel setAlpha:0.7];
    [titleLabelAlignNOLabel setFont:[UIFont systemFontOfSize:12]];
    [titleLabelAlignNOLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:titleLabelAlignNOLabel];
    
    titleLabelOnTopBtn_voiceCapture = [UIButton buttonWithType:UIButtonTypeCustom];
    titleLabelOnTopBtn_voiceCapture.frame = CGRectMake(titleLabelAlignNOLabel.frame.origin.x + titleLabelAlignNOLabel.frame.size.width + (width/100)*2, titleLabelAlignNOLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    [titleLabelOnTopBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"]
                                  forState:UIControlStateNormal];
    titleLabelOnTopBtn_voiceCapture.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [titleLabelOnTopBtn_voiceCapture addTarget:self action:@selector(titleLabelOnTopBtnClick_VoiceCapture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:titleLabelOnTopBtn_voiceCapture];
    
    UILabel *titleLabelAlignYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelOnTopBtn_voiceCapture.frame.origin.x + titleLabelOnTopBtn_voiceCapture.frame.size.width + (width/100)*2, titleLabelOnTopBtn_voiceCapture.frame.origin.y, (width/100)*10, (height/100)*5)];
    [titleLabelAlignYESLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [titleLabelAlignYESLabel setAlpha:0.7];
    [titleLabelAlignYESLabel setFont:[UIFont systemFontOfSize:12]];
    [titleLabelAlignYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:titleLabelAlignYESLabel];
    
    //View Display Position
    UILabel *viewPositionLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,titleLabelAlignLabel.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*2)];
    [viewPositionLabel setText:[LabelUtils getLabelForKey:@"voice_display_position"]];
    [viewPositionLabel setAlpha:0.7];
    viewPositionLabel.numberOfLines = 0;
    viewPositionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [viewPositionLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:viewPositionLabel];
    
    viewPositionTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, titleLabelOnTopBtn_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [viewPositionTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    viewPositionTextField_voiceCapture.layer.cornerRadius = 5;
    viewPositionTextField_voiceCapture.layer.borderWidth = 1.0;
    viewPositionTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [viewPositionTextField_voiceCapture setAlpha:0.7];
    [viewPositionTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    viewPositionTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    viewPositionTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:viewPositionTextField_voiceCapture];
    
    UIImageView *viewPositionDownArrowImage_voiceCapture = [[UIImageView alloc] initWithFrame:CGRectMake(viewPositionTextField_voiceCapture.frame.origin.x + viewPositionTextField_voiceCapture.frame.size.width - (width/100)*9 , viewPositionTextField_voiceCapture.frame.origin.y + (viewPositionTextField_voiceCapture.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [viewPositionDownArrowImage_voiceCapture setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:viewPositionDownArrowImage_voiceCapture];

    //Voice Auto Play
    UILabel *autoPlayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,titleLabelOnTopBtn_voiceCapture.frame.origin.y + titleLabelOnTopBtn_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [autoPlayLabel setText:[LabelUtils getLabelForKey:@"voice_auto_play"]];
    [autoPlayLabel setAlpha:0.7];
    [autoPlayLabel setFont:[UIFont systemFontOfSize:11]];
    autoPlayLabel.numberOfLines = 0;
    autoPlayLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:autoPlayLabel];
    
    //NoLabel
    UILabel *autoPlayNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(autoPlayLabel.frame.origin.x, autoPlayLabel.frame.origin.y + autoPlayLabel.frame.size.height + (height/100)*1, (width/100)*10, (height/100)*5)];
    [autoPlayNOLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [autoPlayNOLabel setAlpha:0.7];
    [autoPlayNOLabel setFont:[UIFont systemFontOfSize:12]];
    [autoPlayNOLabel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:autoPlayNOLabel];
    
    autoPlayBtn_voiceCapture = [UIButton buttonWithType:UIButtonTypeCustom];
    autoPlayBtn_voiceCapture.frame = CGRectMake(autoPlayNOLabel.frame.origin.x + autoPlayNOLabel.frame.size.width + (width/100)*2, autoPlayNOLabel.frame.origin.y, (width/100)*10, (height/100)*5);
    [autoPlayBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"]
                           forState:UIControlStateNormal];
    autoPlayBtn_voiceCapture.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [autoPlayBtn_voiceCapture addTarget:self action:@selector(autoPlayBtnClick_VoiceCapture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:autoPlayBtn_voiceCapture];
    
    //YES
    UILabel *autoPlayYESLabel = [[UILabel alloc] initWithFrame:CGRectMake(autoPlayBtn_voiceCapture.frame.origin.x + autoPlayBtn_voiceCapture.frame.size.width + (width/100)*2, autoPlayBtn_voiceCapture.frame.origin.y, (width/100)*10, (height/100)*5)];
    [autoPlayYESLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [autoPlayYESLabel setAlpha:0.7];
    [autoPlayYESLabel setFont:[UIFont systemFontOfSize:12]];
    [autoPlayYESLabel setTextAlignment:NSTextAlignmentCenter];
    // [toggleYESLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:autoPlayYESLabel];
    
   //Text Label Color
    UILabel *textLabelcolorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,autoPlayBtn_voiceCapture.frame.origin.y + autoPlayBtn_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [textLabelcolorLabel setText:[LabelUtils getLabelForKey:@"voice_text_label_color"]];
    [textLabelcolorLabel setAlpha:0.7];
    [textLabelcolorLabel setFont:[UIFont systemFontOfSize:11]];
    textLabelcolorLabel.numberOfLines = 0;
    textLabelcolorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textLabelcolorLabel];
    
    textColortTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, textLabelcolorLabel.frame.origin.y + textLabelcolorLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [textColortTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    textColortTextField_voiceCapture.layer.cornerRadius = 5;
    textColortTextField_voiceCapture.layer.borderWidth = 1.0;
    textColortTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColortTextField_voiceCapture setAlpha:0.7];
    [textColortTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColortTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textColortTextField_voiceCapture];
    
    UILabel *textLabelColorAlphaLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,textLabelcolorLabel.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*2)];
    [textLabelColorAlphaLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textLabelColorAlphaLabel setAlpha:0.7];
    textLabelColorAlphaLabel.numberOfLines = 0;
    textLabelColorAlphaLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textLabelColorAlphaLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textLabelColorAlphaLabel];
    
    textColorAlphaTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, textColortTextField_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [textColorAlphaTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    textColorAlphaTextField_voiceCapture.layer.cornerRadius = 5;
    textColorAlphaTextField_voiceCapture.layer.borderWidth = 1.0;
    textColorAlphaTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorAlphaTextField_voiceCapture setAlpha:0.7];
    [textColorAlphaTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorAlphaTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    textColorAlphaTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textColorAlphaTextField_voiceCapture];
    
    //Title Text Label Color
    UILabel *titleTextLabelcolorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,textColortTextField_voiceCapture.frame.origin.y + textColortTextField_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [titleTextLabelcolorLabel setText:[LabelUtils getLabelForKey:@"voice_title_label_color"]];
    [titleTextLabelcolorLabel setAlpha:0.7];
    [titleTextLabelcolorLabel setFont:[UIFont systemFontOfSize:11]];
    titleTextLabelcolorLabel.numberOfLines = 0;
    titleTextLabelcolorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:titleTextLabelcolorLabel];
    
    titleTextColortTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, titleTextLabelcolorLabel.frame.origin.y + titleTextLabelcolorLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [titleTextColortTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    titleTextColortTextField_voiceCapture.layer.cornerRadius = 5;
    titleTextColortTextField_voiceCapture.layer.borderWidth = 1.0;
    titleTextColortTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [titleTextColortTextField_voiceCapture setAlpha:0.7];
    [titleTextColortTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    titleTextColortTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:titleTextColortTextField_voiceCapture];
    
    UILabel *titleTextLabelColorAlphaLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,titleTextLabelcolorLabel.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*2)];
    [titleTextLabelColorAlphaLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [titleTextLabelColorAlphaLabel setAlpha:0.7];
    titleTextLabelColorAlphaLabel.numberOfLines = 0;
    titleTextLabelColorAlphaLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [titleTextLabelColorAlphaLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:titleTextLabelColorAlphaLabel];
    
    titleTextColorAlphaTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, titleTextColortTextField_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [titleTextColorAlphaTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    titleTextColorAlphaTextField_voiceCapture.layer.cornerRadius = 5;
    titleTextColorAlphaTextField_voiceCapture.layer.borderWidth = 1.0;
    titleTextColorAlphaTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [titleTextColorAlphaTextField_voiceCapture setAlpha:0.7];
    [titleTextColorAlphaTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    titleTextColorAlphaTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    titleTextColorAlphaTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:titleTextColorAlphaTextField_voiceCapture];
    
    //Title text label size
    UILabel *titleLabelSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,titleTextColortTextField_voiceCapture.frame.origin.y + titleTextColortTextField_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [titleLabelSizeLabel setText:[LabelUtils getLabelForKey:@"voice_title_label_size"]];
    [titleLabelSizeLabel setAlpha:0.7];
    [titleLabelSizeLabel setFont:[UIFont systemFontOfSize:11]];
    titleLabelSizeLabel.numberOfLines = 0;
    titleLabelSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:titleLabelSizeLabel];
    
    titleLabelSizeTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, titleLabelSizeLabel.frame.origin.y + titleLabelSizeLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [titleLabelSizeTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    titleLabelSizeTextField_voiceCapture.layer.cornerRadius = 5;
    titleLabelSizeTextField_voiceCapture.layer.borderWidth = 1.0;
    titleLabelSizeTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [titleLabelSizeTextField_voiceCapture setAlpha:0.7];
    [titleLabelSizeTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    titleLabelSizeTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:titleLabelSizeTextField_voiceCapture];
    
    //Text Label Size
    UILabel *textSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,titleLabelSizeLabel.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*2)];
    [textSizeLabel setText:[LabelUtils getLabelForKey:@"voice_text_label_size"]];
    [textSizeLabel setAlpha:0.7];
    textSizeLabel.numberOfLines = 0;
    textSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textSizeLabel];
    
    textSizeTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorTransLabel.frame.origin.x, titleLabelSizeTextField_voiceCapture.frame.origin.y, btnColorTransLabel.frame.size.width, (height/100)*4)];
    [textSizeTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    textSizeTextField_voiceCapture.layer.cornerRadius = 5;
    textSizeTextField_voiceCapture.layer.borderWidth = 1.0;
    textSizeTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [textSizeTextField_voiceCapture setAlpha:0.7];
    [textSizeTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textSizeTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    textSizeTextField_voiceCapture.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textSizeTextField_voiceCapture];
    
    //Counter Label Size
    UILabel *counterSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4,titleLabelSizeTextField_voiceCapture.frame.origin.y + titleLabelSizeTextField_voiceCapture.frame.size.height +(height/100)*2, (width/100)*44, (height/100)*2)];
    [counterSizeLabel setText:[LabelUtils getLabelForKey:@"voice_counter_label_size"]];
    [counterSizeLabel setAlpha:0.7];
    [counterSizeLabel setFont:[UIFont systemFontOfSize:11]];
    counterSizeLabel.numberOfLines = 0;
    counterSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:counterSizeLabel];
    
    counterLabelSizeTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(btnColorLabel.frame.origin.x, counterSizeLabel.frame.origin.y + counterSizeLabel.frame.size.height + (height/100)*1, btnColorLabel.frame.size.width, (height/100)*4)];
    [counterLabelSizeTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    counterLabelSizeTextField_voiceCapture.layer.cornerRadius = 5;
    counterLabelSizeTextField_voiceCapture.layer.borderWidth = 1.0;
    counterLabelSizeTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [counterLabelSizeTextField_voiceCapture setAlpha:0.7];
    [counterLabelSizeTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    counterLabelSizeTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:counterLabelSizeTextField_voiceCapture];
    
    //Labels
    UILabel *initVoiceCaptureLabel = [[UILabel alloc] initWithFrame:CGRectMake(counterSizeLabel.frame.origin.x,counterLabelSizeTextField_voiceCapture.frame.origin.y + counterLabelSizeTextField_voiceCapture.frame.size.height + (height/100)*2, counterSizeLabel.frame.size.width, (height/100)*2)];
    [initVoiceCaptureLabel setText:[LabelUtils getLabelForKey:@"voice_recording_label"]];
    [initVoiceCaptureLabel setAlpha:0.7];
    [initVoiceCaptureLabel setFont:[UIFont systemFontOfSize:11]];
    initVoiceCaptureLabel.numberOfLines = 0;
    initVoiceCaptureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:initVoiceCaptureLabel];
    
    labelsTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(initVoiceCaptureLabel.frame.origin.x, initVoiceCaptureLabel.frame.origin.y + initVoiceCaptureLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [labelsTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    labelsTextField_voiceCapture.layer.cornerRadius = 5;
    labelsTextField_voiceCapture.layer.borderWidth = 1.0;
    labelsTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [labelsTextField_voiceCapture setAlpha:0.7];
    [labelsTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    labelsTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:labelsTextField_voiceCapture];
    
    UIImageView *voiceLabelDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(labelsTextField_voiceCapture.frame.origin.x + labelsTextField_voiceCapture.frame.size.width - (width/100)*9 , labelsTextField_voiceCapture.frame.origin.y + (labelsTextField_voiceCapture.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [voiceLabelDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:voiceLabelDownArrowImage];
    
    UILabel *englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(initVoiceCaptureLabel.frame.origin.x,labelsTextField_voiceCapture.frame.origin.y + labelsTextField_voiceCapture.frame.size.height +   (height/100)*2, initVoiceCaptureLabel.frame.size.width, (height/100)*2)];
    [englishLabel setText:[LabelUtils getLabelForKey:@"label_value"]];
    [englishLabel setAlpha:0.7];
    [englishLabel setFont:[UIFont systemFontOfSize:11]];
    englishLabel.numberOfLines = 0;
    englishLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:englishLabel];
    
    labelValueTextField_voiceCapture = [[UITextField alloc] initWithFrame:CGRectMake(initVoiceCaptureLabel.frame.origin.x, englishLabel.frame.origin.y + englishLabel.frame.size.height + (height/100)*1, initVoiceCaptureLabel.frame.size.width, (height/100)*4)];
    [labelValueTextField_voiceCapture setFont:[UIFont systemFontOfSize:12]];
    labelValueTextField_voiceCapture.layer.cornerRadius = 5;
    labelValueTextField_voiceCapture.layer.borderWidth = 1.0;
    labelValueTextField_voiceCapture.layer.borderColor = [[UIColor grayColor]CGColor];
    [labelValueTextField_voiceCapture setAlpha:0.7];
    [labelValueTextField_voiceCapture setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    labelValueTextField_voiceCapture.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:labelValueTextField_voiceCapture];
    
    UIButton *addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frameAddLabel = CGRectMake(btnColorTransLabel.frame.origin.x, labelValueTextField_voiceCapture.frame.origin.y, englishLabel.frame.size.width, (height/100)*6);
    [addLabelButton setFrame:frameAddLabel];
    addLabelButton.layer.cornerRadius = 20;
    addLabelButton.clipsToBounds = YES;
    [addLabelButton setTitle:[LabelUtils getLabelForKey:@"add_label"] forState:UIControlStateNormal];
    addLabelButton.titleLabel.textColor = [UIColor whiteColor];
    [addLabelButton setBackgroundColor:[UIColor blackColor]];
    [addLabelButton addTarget:self action:@selector(addLabelClickedVoiceCapture:) forControlEvents:UIControlEventTouchUpInside];
    [addLabelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:addLabelButton];
    
    //
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(counterSizeLabel.frame.origin.x, addLabelButton.frame.origin.y + addLabelButton.frame.size.height + (height/100)*2, (width/100)*44, (height/100)*6);
    [saveBtn setFrame:saveAccountframe];
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:[LabelUtils getLabelForKey:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:saveBtn];
    [saveBtn setHidden:YES];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(width/2 - (saveBtn.frame.size.width/2) , saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton_voiceCapture:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;;
}

-(void)addLabelClickedVoiceCapture:(UIButton*)button {
    
    NSString *labelKey = labelsTextField_voiceCapture.text;
    
    NSMutableDictionary *labelConfig = [[CustomizeUIConfigManager getDefaultVoiceCaptureConfig] getLabelConfiguration];
    
    if(nil != labelConfig) {
        [labelConfig setObject:[[labelValueTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:labelKey];
        
    }
    [labelValueTextField_voiceCapture setText:@""];
}

-(void)voiceCapturePickerDataArray {
    _voiceCaptureLabelPickerData = @[@"voice_title_label_message",@"voice_start",@"voice_play",@"voice_pause",@"voice_stop",@"voice_delete",@"voice_save",@"voice_retry"];
}

-(void)titleLabelOnTopBtnClick_VoiceCapture:(UIButton*)button {
    if(isTitleLabelOnTop_voiceCapture) {
        [titleLabelOnTopBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isTitleLabelOnTop_voiceCapture = false;
    } else {
        [titleLabelOnTopBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isTitleLabelOnTop_voiceCapture = true;
    }
}

-(void)autoPlayBtnClick_VoiceCapture:(UIButton*)button {
    if(isAutoPlay_voiceCapture) {
        [autoPlayBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isAutoPlay_voiceCapture = false;
    } else {
        [autoPlayBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isAutoPlay_voiceCapture = true;
    }
}

-(void)saveSetting_voiceCapture {
    NSString *buttonColor = @"FFFFFF", *backgroundColor = @"000000", *titleLabelOnTop = @"Y", *viewPosition = @"Center", *autoPlay = @"Y", *textColor = @"FFFFFF", *titleTextColor = @"FFFFFF", *titleSize = @"12", *textSize = @"12", *counterTextSize = @"30";
    
    [self saveSetting:@"buttonColor_voice" value:[btnColorTextField_voiceCapture text]];
    [self saveSetting:@"buttonColorAlpha_voice" value:[btnColorTransTextField_voiceCapture text]];
    
    [self saveSetting:@"backgroundColor_voice" value:[backgroundBtnTextField_voiceCapture text]];
    [self saveSetting:@"backgroundColorAlpha_voice" value:[backGroundBtnTransColorTextField_voiceCapture text]];
    
    if(isTitleLabelOnTop_voiceCapture) {
        [self saveSetting:@"titleLabelAlign_voice" value:@"Y"];
    } else {
        [self saveSetting:@"titleLabelAlign_voice" value:@"N"];
    }
    
    [self saveSetting:@"viewPosition_voice" value:[viewPositionTextField_voiceCapture text]];
    
    if(isAutoPlay_voiceCapture) {
        [self saveSetting:@"autoPlay_voice" value:@"Y"];
    } else {
        [self saveSetting:@"autoPlay_voice" value:@"N"];
    }
    
    [self saveSetting:@"textColor_voice" value:[textColortTextField_voiceCapture text]];
    [self saveSetting:@"textColorAlpha_voice" value:[textColorAlphaTextField_voiceCapture text]];
    
    [self saveSetting:@"titleTextColor_voice" value:[titleTextColortTextField_voiceCapture text]];
    [self saveSetting:@"titleTextColorAlpha_voice" value:[titleTextColorAlphaTextField_voiceCapture text]];
    
    [self saveSetting:@"titleSize_voice" value:[titleLabelSizeTextField_voiceCapture text]];
    [self saveSetting:@"textSize_voice" value:[textSizeTextField_voiceCapture text]];
    
    [self saveSetting:@"counterTextSize_voice" value:[counterLabelSizeTextField_voiceCapture text]];
    
}

-(void)retrieveSettingVoiceCapture {
    NSString *buttonColor = @"FFFFFF", *backgroundColor = @"000000", *titleLabelOnTop = @"Y", *viewPosition = @"Center", *autoPlay = @"Y", *textColor = @"FFFFFF", *titleTextColor = @"FFFFFF", *titleSize = @"12", *textSize = @"12", *counterTextSize = @"30";
    
    [btnColorTextField_voiceCapture setText:[self retrieveSetting:@"buttonColor_voice" defaultValue:buttonColor]];
    [btnColorTransTextField_voiceCapture setText:[self retrieveSetting:@"buttonColorAlpha_voice" defaultValue:[@(mAlpha) stringValue]]];
    
    [backgroundBtnTextField_voiceCapture setText:[self retrieveSetting:@"backgroundColor_voice" defaultValue:backgroundColor]];
    [backGroundBtnTransColorTextField_voiceCapture setText:[self retrieveSetting:@"backgroundColorAlpha_voice" defaultValue:[@(mAlpha) stringValue]]];
    
    NSString *title_Label_align = [self retrieveSetting:@"titleLabelAlign_voice" defaultValue:titleLabelOnTop];
    if(![@"Y" isEqualToString:[title_Label_align uppercaseString]]) {
        isTitleLabelOnTop_voiceCapture = false;
        [titleLabelOnTopBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOf.png"]
        forState:UIControlStateNormal];
    }
    
    [viewPositionTextField_voiceCapture setText:[self retrieveSetting:@"viewPosition_voice" defaultValue:viewPosition]];
    
    NSString *auto_play = [self retrieveSetting:@"autoPlay_voice" defaultValue:autoPlay];
    if(![@"Y" isEqualToString:[auto_play uppercaseString]]) {
        isAutoPlay_voiceCapture = false;
        [autoPlayBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOf.png"]
        forState:UIControlStateNormal];
    }
    
    [textColortTextField_voiceCapture setText:[self retrieveSetting:@"textColor_voice" defaultValue:textColor]];
    [textColorAlphaTextField_voiceCapture setText:[self retrieveSetting:@"textColorAlpha_voice" defaultValue:[@(mAlpha) stringValue]]];
    
    [titleTextColortTextField_voiceCapture setText:[self retrieveSetting:@"titleTextColor_voice" defaultValue:titleTextColor]];
    [titleTextColorAlphaTextField_voiceCapture setText:[self retrieveSetting:@"titleTextColorAlpha_voice" defaultValue:[@(mAlpha) stringValue]]];
    
    [titleLabelSizeTextField_voiceCapture setText:[self retrieveSetting:@"titleSize_voice" defaultValue:titleSize]];
    [textSizeTextField_voiceCapture setText:[self retrieveSetting:@"textSize_voice" defaultValue:textSize]];
    
    [counterLabelSizeTextField_voiceCapture setText:[self retrieveSetting:@"counterTextSize_voice" defaultValue:counterTextSize]];
    
}

-(void)FourFCaptureRetrieveSetting {

    NSString *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95";
    
    NSString *textColor = [self retrieveSetting:@"textColor_4F" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_4F" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_4F" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_4F" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_4F" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_4F" defaultValue:[@(mAlpha) stringValue]];
    
    [textColorTextField_4F setText:textColor];
    [textColorTransTextField_4F setText:textColorTrans];
    [instContinueButtonTextField_4F setText:instContinueButton];
    [instContinueButtonTransTextField_4F setText:instContinueButtonTrans];
    [instContinueButtonTextColorField_4F setText:instContinueTextColor];
    [instContinueButtonTransTextColorField_4F setText:instContinueTextColorTrans];
}

-(void)resetButton_voiceCapture:(UIButton*)button {
    
    NSString *btnColor = @"FFFFFF", *backgroundColor = @"000000",*textColor = @"FFFFFF", *titleTextColor = @"FFFFFF", *titleSize = @"12", *textSize = @"12", *counterLabelSize = @"30";
    
    [btnColorTextField_voiceCapture setText:btnColor];
    [btnColorTransTextField_voiceCapture setText:[@(mAlpha) stringValue]];
    
    [backgroundBtnTextField_voiceCapture setText:backgroundColor];
    [backGroundBtnTransColorTextField_voiceCapture setText:[@(mAlpha) stringValue]];
    
    [textColortTextField_voiceCapture setText:textColor];
    [textColorAlphaTextField_voiceCapture setText:[@(mAlpha) stringValue]];
    
    [titleTextColortTextField_voiceCapture setText:titleTextColor];
    [titleTextColorAlphaTextField_voiceCapture setText:[@(mAlpha) stringValue]];
    
    [titleLabelSizeTextField_voiceCapture setText:titleSize];
    [textSizeTextField_voiceCapture setText:textSize];
    [counterLabelSizeTextField_voiceCapture setText:counterLabelSize];
    
    if(!isTitleLabelOnTop_voiceCapture) {
        [titleLabelOnTopBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"]
        forState:UIControlStateNormal];
        isTitleLabelOnTop_voiceCapture = true;
    }
    
    if(!isAutoPlay_voiceCapture) {
        [autoPlayBtn_voiceCapture setImage:[UIImage imageNamed:@"toggleOn.png"]
        forState:UIControlStateNormal];
        isAutoPlay_voiceCapture = true;
    }
    
    [viewPositionTextField_voiceCapture setText:_idCaptureHintMsgPickerData[0]];
    
    //Resetting Value
    NSMutableDictionary *uiDictionary;
    uiDictionary = [[CustomizeUIConfigManager getDefaultVoiceCaptureConfig] getLabelConfiguration];
    uiDictionary = [[NSMutableDictionary alloc] init];
    [self saveSettingDict:@"voice_recording" value:uiDictionary];
    [CustomizeUIConfigManager initCustomizeUIConfig];
//    [CustomizeUIConfigManager storeConfig:@"voice_recording"];
    
}

-(void)saveSettingDict:(NSString*)key value:(NSMutableDictionary*)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

-(void)resetButton_4F:(UIButton*)button {
    
    NSString *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95";
    
    [textColorTextField_4F setText:dTextColor];
    [textColorTransTextField_4F setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextField_4F setText:dInstContinueButtonColor];
    [instContinueButtonTransTextField_4F setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextColorField_4F setText:dInstContinueButtonTextColor];
    [instContinueButtonTransTextColorField_4F setText:[@(mAlpha) stringValue]];
    
}

-(void)saveSetting_4F {
    
    [self saveSetting:@"textColor_4F" value:[NSString stringWithFormat:@"%@", [textColorTextField_4F text]]]; //
    [self saveSetting:@"instContinueButton_4F" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextField_4F text]]]; //
    [self saveSetting:@"instContinueButtonText_4F" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextColorField_4F text]]]; //
    [self saveSetting:@"textColorTransparency_4F" value:[NSString stringWithFormat:@"%@",[textColorTransTextField_4F text]]]; //
    [self saveSetting:@"instContinueButtonTransparency_4F" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextField_4F text]]]; //
    [self saveSetting:@"instContinueButtonTextTransparency_4F" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextColorField_4F text]]];
    
}

-(void)idCaptureBackRetrieveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor_IDBack" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor_IDBack" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor_IDBack" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline_IDBack" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton_IDBack" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor_IDBack" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton_IDBack" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder_IDBack" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton_IDBack" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle_IDBack" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_IDBack" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_IDBack" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel_IDBack" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage_IDBack" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage_IDBack" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle_IDBack" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg_IDBack" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage_IDBack" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize_IDBack" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize_IDBack" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor_IDBack" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor_IDBack" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency_IDBack" defaultValue:[@(mAlpha) stringValue]];
    
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
    [idCaptureButtonColorTextField setText:captureButtonColor];
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_IdBack) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdBack) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)saveSetting_IdBack {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle, *captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, captureButtonColorTrans=mAlpha;
    
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
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];

    
    [self saveSetting:@"idoutlinecolor_IDBack" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor_IDBack" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency_IDBack" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency_IDBack" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor_IDBack" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency_IDBack" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline_IDBack" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency_IDBack" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton_IDBack" value:backButtonColor];
    [self saveSetting:@"retryButton_IDBack" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder_IDBack" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton_IDBack" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle_IDBack" value:confirmButtonStyle];
    [self saveSetting:@"textColor_IDBack" value:textColor];
    [self saveSetting:@"instContinueButton_IDBack" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText_IDBack" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency_IDBack" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency_IDBack" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency_IDBack" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency_IDBack" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency_IDBack" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency_IDBack" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency_IDBack" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency_IDBack" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel_IDBack" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage_IDBack" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage_IDBack" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize_IDBack" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize_IDBack" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor_IDBack" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency_IDBack" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor_IDBack" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency_IDBack" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];
    
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
    
    [self saveSetting:@"hideIdCaptureTitle_IDBack" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg_IDBack" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage_IDBack" value:hideIdCapTitImage];
}

-(void)secondaryIdCaptureFrontRetrieveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor_SecIDFront" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor_SecIDFront" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor_SecIDFront" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline_SecIDFront" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton_SecIDFront" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor_SecIDFront" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton_SecIDFront" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder_SecIDFront" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton_SecIDFront" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle_SecIDFront" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_SecIDFront" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_SecIDFront" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel_SecIDFront" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage_SecIDFront" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage_SecIDFront" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle_SecIDFront" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg_SecIDFront" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage_SecIDFront" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize_SecIDFront" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize_SecIDFront" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor_SecIDFront" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor_SecIDFront" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency_SecIDFront" defaultValue:[@(mAlpha) stringValue]];
    
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
    [idCaptureButtonColorTextField setText:captureButtonColor];
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_IdFront_sec) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdFront_sec) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)saveSetting_SecondaryIdFront {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle, *captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, captureButtonColorTrans=mAlpha;
    
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
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];

    [self saveSetting:@"idoutlinecolor_SecIDFront" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor_SecIDFront" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency_SecIDFront" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency_SecIDFront" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor_SecIDFront" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency_SecIDFront" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline_SecIDFront" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton_SecIDFront" value:backButtonColor];
    [self saveSetting:@"retryButton_SecIDFront" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder_SecIDFront" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton_SecIDFront" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle_SecIDFront" value:confirmButtonStyle];
    [self saveSetting:@"textColor_SecIDFront" value:textColor];
    [self saveSetting:@"instContinueButton_SecIDFront" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText_SecIDFront" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel_SecIDFront" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage_SecIDFront" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage_SecIDFront" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize_SecIDFront" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize_SecIDFront" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor_SecIDFront" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor_SecIDFront" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency_SecIDFront" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];
    
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
    
    [self saveSetting:@"hideIdCaptureTitle_SecIDFront" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg_SecIDFront" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage_SecIDFront" value:hideIdCapTitImage];
}

-(void)secondaryIdCaptureBackRetrieveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor_SecIDBack" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor_SecIDBack" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor_SecIDBack" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline_SecIDBack" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton_SecIDBack" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor_SecIDBack" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton_SecIDBack" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder_SecIDBack" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton_SecIDBack" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle_SecIDBack" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_SecIDBack" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_SecIDBack" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel_SecIDBack" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage_SecIDBack" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage_SecIDBack" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle_SecIDBack" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg_SecIDBack" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage_SecIDBack" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize_SecIDBack" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize_SecIDBack" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor_SecIDBack" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor_SecIDBack" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency_SecIDBack" defaultValue:[@(mAlpha) stringValue]];
    
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
    [idCaptureButtonColorTextField setText:captureButtonColor];
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_IdBack_sec) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdBack_sec) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)saveSetting_SecondaryIdBack {
    
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36",*dCaptureButtonColor=@"FFFFFF";
    
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle,*captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, captureButtonColorTrans=mAlpha;
    
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
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];
    
    [self saveSetting:@"idoutlinecolor_SecIDBack" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor_SecIDBack" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency_SecIDBack" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency_SecIDBack" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor_SecIDBack" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency_SecIDBack" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline_SecIDBack" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton_SecIDBack" value:backButtonColor];
    [self saveSetting:@"retryButton_SecIDBack" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder_SecIDBack" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton_SecIDBack" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle_SecIDBack" value:confirmButtonStyle];
    [self saveSetting:@"textColor_SecIDBack" value:textColor];
    [self saveSetting:@"instContinueButton_SecIDBack" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText_SecIDBack" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel_SecIDBack" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage_SecIDBack" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage_SecIDBack" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize_SecIDBack" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize_SecIDBack" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor_SecIDBack" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor_SecIDBack" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency_SecIDBack" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];
    
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
    
    [self saveSetting:@"hideIdCaptureTitle_SecIDBack" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg_SecIDBack" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage_SecIDBack" value:hideIdCapTitImage];
}

-(void)documentRetrieveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor_Doc" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor_Doc" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor_Doc" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline_Doc" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton_Doc" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor_Doc" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton_Doc" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder_Doc" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton_Doc" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle_Doc" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_Doc" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_Doc" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel_Doc" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage_Doc" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage_Doc" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle_Doc" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg_Doc" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage_Doc" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize_Doc" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize_Doc" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor_Doc" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor_Doc" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency_Doc" defaultValue:[@(mAlpha) stringValue]];
    
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
    [idCaptureButtonColorTextField setText:captureButtonColor];
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans];

    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_Doc) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdBack_Doc) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)saveSetting_Document {
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle, *captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, captureButtonColorTrans=mAlpha;
    
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
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];
    
    [self saveSetting:@"idoutlinecolor_Doc" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor_Doc" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency_Doc" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency_Doc" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor_Doc" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency_Doc" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline_Doc" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency_Doc" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton_Doc" value:backButtonColor];
    [self saveSetting:@"retryButton_Doc" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder_Doc" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton_Doc" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle_Doc" value:confirmButtonStyle];
    [self saveSetting:@"textColor_Doc" value:textColor];
    [self saveSetting:@"instContinueButton_Doc" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText_Doc" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency_Doc" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency_Doc" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency_Doc" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency_Doc" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency_Doc" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency_Doc" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency_Doc" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency_Doc" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel_Doc" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage_Doc" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage_Doc" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize_Doc" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize_Doc" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor_Doc" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency_Doc" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor_Doc" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency_Doc" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];

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
    
    [self saveSetting:@"hideIdCaptureTitle_Doc" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg_Doc" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage_Doc" value:hideIdCapTitImage];
}

-(void)snippetRetrieveSetting {
    
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor,*dBackButtonColor, *dRetryButtonColor, *dConfirmButtonColor, *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor, *dRetryButtonBorderColor, *dConfirmButtonStyle, *dCaptureButtonColor;
    
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95", dBackButtonColor=@"FEAD36", dRetryButtonColor=@"FEAD36", dConfirmButtonColor=@"FEAD36", dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95",dConfirmButtonStyle=@"FFFFFF",dRetryButtonBorderColor=@"FEAD36",dCaptureButtonColor=@"FFFFFF";
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor_Snippet" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor_Snippet" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor_Snippet" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline_Snippet" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *backButton = [self retrieveSetting:@"backButton_Snippet" defaultValue:dBackButtonColor];
    NSString *backButtonTrans = [self retrieveSetting:@"backButtonTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *textColor = [self retrieveSetting:@"textColor_Snippet" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButton = [self retrieveSetting:@"retryButton_Snippet" defaultValue:dRetryButtonColor];
    NSString *retryButtonTrans = [self retrieveSetting:@"retryButtonTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *retryButtonBorder = [self retrieveSetting:@"retryButtonBorder_Snippet" defaultValue:dRetryButtonBorderColor];
    NSString *retryButtonBorderTrans = [self retrieveSetting:@"retryButtonBorderTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButton = [self retrieveSetting:@"confirmButton_Snippet" defaultValue:dConfirmButtonColor];
    NSString *confirmButtonTrans = [self retrieveSetting:@"confirmButtonTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *confirmButtonStyle = [self retrieveSetting:@"confirmButtonStyle_Snippet" defaultValue:dConfirmButtonStyle];
    NSString *confirmButtonStyleTrans = [self retrieveSetting:@"confirmButtonStyleTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton_Snippet" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText_Snippet" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    
    NSString *idCaptureTitleLabelString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleLabel_Snippet" defaultValue:@"Top"]];
    NSString *idCaptureHintMessageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureHintMessage_Snippet" defaultValue:@"Center"]];
    NSString *idCaptureTitleImageString = [self getIdCaptureAlignmentAccordingLanguage:[self retrieveSetting:@"idCaptureTitleImage_Snippet" defaultValue:@"Bottom"]];
    
    NSString *hideIdCaptureTitleString = [self retrieveSetting:@"hideIdCaptureTitle_Snippet" defaultValue:@"N"];
    NSString *hideIdCaptureHintMsgString = [self retrieveSetting:@"hideIdCaptureHintMsg_Snippet" defaultValue:@"N"];
    NSString *hideIdCaptureTitleImgString = [self retrieveSetting:@"hideIdCaptureTitleImage_Snippet" defaultValue:@"N"];
    
    NSString *headerTextSize = [self retrieveSetting:@"headerTextSize_Snippet" defaultValue:@""];
    NSString *textSize = [self retrieveSetting:@"textSize_Snippet" defaultValue:@""];
    NSString *headerTextColor = [self retrieveSetting:@"headerTextColor_Snippet" defaultValue:dTextColor];
    NSString *headerTextColorTrans = [self retrieveSetting:@"headerTextColorTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    NSString *captureButtonColor = [self retrieveSetting:@"captureButtonColor_Snippet" defaultValue:dCaptureButtonColor];
    NSString *captureButtonColorTrans = [self retrieveSetting:@"captureButtonColorTransparency_Snippet" defaultValue:[@(mAlpha) stringValue]];
    
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
    [idCaptureButtonColorTextField setText:captureButtonColor];
    [idCaptureButtonColorTransTextField setText:captureButtonColorTrans];
    
    englishLabels = [[NSMutableDictionary alloc] init];
    spanishLabels = [[NSMutableDictionary alloc] init];
    
    if(showInstScreen_Snippet) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    } else {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    }
    
    //Enable Shadow
    if(isEnableShadow_IdBack_Snippet) {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    } else {
        [enableShadow_Id setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(void)saveSetting_Snippet {
    NSString *dFaceOutlineColor = @"FFAD36", *dDetectedFaceOutlineColor = @"6EB24C", *dOutsideFaceOutlineColor = @"487D95",*dDetectedOutsideFaceOutlineColor = @"487D95",*dIdOutlineColor = @"FFAD36", *dDetectedIdOutlineColor = @"6EB24C", *dOutsideIdOutlineColor = @"487D95",*dDetectedPOAOutlineColor = @"6EB24C",*dDetectedIdOutsideOutlineColor = @"487D95",*dDetectedPOAOutsideOutlineColor = @"487D95", *dBackButtonColor=@"FEAD36", *dRetryButtonColor=@"FEAD36", *dConfirmButtonColor=@"FEAD36", *dFontStyle=@"Default", *dTextColor=@"FFFFFF", *dInstContinueButtonColor=@"FFFFFF", *dInstContinueButtonTextColor=@"487D95",*dConfirmButtonStyle=@"FFFFFF",*dRetryButtonBorderColor=@"FEAD36", *dCaptureButtonColor=@"FFFFFF";
    
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor, *backButtonColor = dBackButtonColor, *retryButtonColor=dRetryButtonColor, *retryButtonBorderColor=dRetryButtonBorderColor, *confirmButtonColor=dConfirmButtonColor, *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor, *confirmButtonStyle=dConfirmButtonStyle, *captureButtonColor=dCaptureButtonColor;
    
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha, backButtonTrans=mAlpha, retryButtonTrans=mAlpha, retryButtonBorderTrans=mAlpha, confirmButtonTrans =mAlpha, textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha, confirmButtonStyleTrans =mAlpha, headerTextColorTrans=mAlpha, captureButtonColorTrans=mAlpha;
    
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
    captureButtonColor=idCaptureButtonColorTextField.text;
    captureButtonColorTrans=[idCaptureButtonColorTransTextField.text intValue];
    
    [self saveSetting:@"idoutlinecolor_Snippet" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor_Snippet" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency_Snippet" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency_Snippet" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor_Snippet" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency_Snippet" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline_Snippet" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency_Snippet" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    [self saveSetting:@"backButton_Snippet" value:backButtonColor];
    [self saveSetting:@"retryButton_Snippet" value:retryButtonColor];
    [self saveSetting:@"retryButtonBorder_Snippet" value:retryButtonBorderColor];
    [self saveSetting:@"confirmButton_Snippet" value:confirmButtonColor];
    [self saveSetting:@"confirmButtonStyle_Snippet" value:confirmButtonStyle];
    [self saveSetting:@"textColor_Snippet" value:textColor];
    [self saveSetting:@"instContinueButton_Snippet" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText_Snippet" value:instContinueButtonTextColor];
    
    [self saveSetting:@"backButtonTransparency_Snippet" value:[NSString stringWithFormat:@"%d",backButtonTrans]];
    [self saveSetting:@"retryButtonTransparency_Snippet" value:[NSString stringWithFormat:@"%d",retryButtonTrans]];
    [self saveSetting:@"confirmButtonTransparency_Snippet" value:[NSString stringWithFormat:@"%d",confirmButtonTrans]];
    [self saveSetting:@"retryButtonBorderTransparency_Snippet" value:[NSString stringWithFormat:@"%d",retryButtonBorderTrans]];
    [self saveSetting:@"confirmButtonStyleTransparency_Snippet" value:[NSString stringWithFormat:@"%d",confirmButtonStyleTrans]];
    [self saveSetting:@"textColorTransparency_Snippet" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency_Snippet" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency_Snippet" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    [self saveSetting:@"idCaptureTitleLabel_Snippet" value:[idCaptureTitleTextField text]];
    [self saveSetting:@"idCaptureHintMessage_Snippet" value:[idCaptureHintMsgTextField text]];
    [self saveSetting:@"idCaptureTitleImage_Snippet" value:[idCapturetitleImageTextField text]];
    [self saveSetting:@"headerTextSize_Snippet" value:[headerSizeTextField text]];
    [self saveSetting:@"textSize_Snippet" value:[textSizeTextField text]];
    [self saveSetting:@"headerTextColor_Snippet" value:[headerTextColorTextField text]];
    [self saveSetting:@"headerTextColorTransparency_Snippet" value:[NSString stringWithFormat:@"%d",headerTextColorTrans]];
    [self saveSetting:@"captureButtonColor_Snippet" value:captureButtonColor];
    [self saveSetting:@"captureButtonColorTransparency_Snippet" value:[NSString stringWithFormat:@"%d",captureButtonColorTrans]];
    
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
    
    [self saveSetting:@"hideIdCaptureTitle_Snippet" value:hideIdCapTitle];
    [self saveSetting:@"hideIdCaptureHintMsg_Snippet" value:hideIdCaphintMsg];
    [self saveSetting:@"hideIdCaptureTitleImage_Snippet" value:hideIdCapTitImage];
}

-(void) updateSelfieConfig {
    NSMutableDictionary *uiDictionary;
    
    uiDictionary = [[CustomizeUIConfigManager getDefaultFaceCaptureConfig] getUIConfiguration];
    
    if(nil != uiDictionary) {
        
        [uiDictionary setObject:[[faceOutlineColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_outline_color"];
        
        [uiDictionary setObject:[[faceOutlineColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_outline_color_alpha"];
        
        [uiDictionary setObject:[[detectedFaceOutlineColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_detected_face_outline_color"];
        
        [uiDictionary setObject:[[detectedFaceOutlineColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_detected_face_outline_color_alpha"];
        
        [uiDictionary setObject:[[outlineColorOfFaceOutlineTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_outside_face_outline_color"];
        
        [uiDictionary setObject:[[outlineColorOfFaceOutlineTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_outside_face_outline_color_alpha"];
        
        [uiDictionary setObject:[[outlineDetectedColorOfFaceOutlineTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_detected_outside_face_outline_color"];
        
        [uiDictionary setObject:[[outlineDetectedColorOfFaceOutlineTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_detected_outside_face_outline_color_alpha"];
        
        [uiDictionary setObject:[[backButtonTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_back_button_color"];
        
        [uiDictionary setObject:[[backButtonTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_back_button_color_alpha"];
        
        [uiDictionary setObject:[[retryButtonTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_retry_button_color"];
        
        [uiDictionary setObject:[[retryButtonTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_retry_button_color_alpha"];
        
        [uiDictionary setObject:[[retryButtonBorderTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_retry_button_border_color"];
        
        [uiDictionary setObject:[[retryButtonBorderTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_retry_button_border_color_alpha"];
        
        [uiDictionary setObject:[[confirmButtonTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_confirm_button_color"];
        
        [uiDictionary setObject:[[confirmButtonTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_confirm_button_color_alpha"];
        
        [uiDictionary setObject:[[confirmButtonStyleTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_confirm_button_background_color"];
        
        [uiDictionary setObject:[[confirmButtonStyleTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_confirm_button_background_color_alpha"];
        
        [uiDictionary setObject:[[textColorTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_label_text_color"];
        
        [uiDictionary setObject:[[textColorTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_label_text_alpha"];
        
        [uiDictionary setObject:[[headerTextColorTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_header_text_label_color"];
        
        [uiDictionary setObject:[[headerTextColorTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_header_text_label_alpha"];
        
        [uiDictionary setObject:[[instContinueButtonTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_button_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_button_alpha"];
        
        [uiDictionary setObject:[[instContinueButtonTextColorField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_button_txt_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextColorField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_button_txt_alpha"];
        
        [uiDictionary setObject:[[instPreviewColorField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_preview_background_color"];
        
        [uiDictionary setObject:[[instPreviewTransColorField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_instruction_preview_background_color_alpha"];
        
        NSString *faceCountors = [self getFaceContours:[[faceContoursTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] defaultValue:@"Low"];
        
         [uiDictionary setObject:faceCountors forKey:@"fd_face_contours"];
        
        NSString *headerFontStyle_Face=[self getFontStyle:[headerFontStyleTextField_Face text] defaultValue:@"Default"];
        
         [uiDictionary setObject:[headerFontStyle_Face stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_header_text_style"];
        
        NSString *fontStyle_Face=[self getFontStyle:[fontStyleTextField_Face text] defaultValue:@"Default"];
        
        [uiDictionary setObject:[fontStyle_Face stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_label_text_style"];
        
        NSString *hideFace_Title = hideFaceTitle ? @"Y" : @"N";
        
        NSString *hideFaceHint_Msg = hideFaceHintMessage ? @"Y" : @"N";
        
        NSString *hideFaceTitle_Image = hideFaceTitleImage ? @"Y" : @"N";
        
        [uiDictionary setObject:[hideFace_Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_hide_face_title_lable"];
        
        [uiDictionary setObject:[hideFaceHint_Msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_hide_face_hint_message"];
        
        [uiDictionary setObject:[hideFaceTitle_Image stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_hide_title_image"];
        
        NSString *faceTitleLabelString= [self getIdCaptureAlignmentAccordingLanguage:[faceTitleTextField text]];
        
        NSString *faceTitleLabelString_bool =  [[self getIdCaptureAlignment:faceTitleLabelString defaultValue:@"Bottom"] isEqualToString:@"Top"] ? @"Y" : @"N";
        
        [uiDictionary setObject:[faceTitleLabelString_bool stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_face_title_label_on_top"];
        
        NSString *faceHintMsgLabelString= [self getIdCaptureAlignmentAccordingLanguage:[faceHintMsgTextField text]];
        
        NSString *faceHintMsgLabelString_bool =  [[self getIdCaptureAlignment:faceHintMsgLabelString defaultValue:@"Top"] isEqualToString:@"Top"] ? @"Y" : @"N";
        
        [uiDictionary setObject:[faceHintMsgLabelString_bool stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_face_hint_message_on_top"];
        
        NSString *faceTitleImageLabelString= [self getIdCaptureAlignmentAccordingLanguage:[faceTitleImageTextField text]];
                                           
        NSString *faceTitleImageLabelString_bool =  [[self getIdCaptureAlignment:faceTitleImageLabelString defaultValue:@"Top"] isEqualToString:@"Top"] ? @"Y" : @"N";
        
        [uiDictionary setObject:[faceTitleImageLabelString_bool stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_title_image_on_top"];
        
        [uiDictionary setObject:[[headerSizeTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_header_text_label_size"];
        
        [uiDictionary setObject:[[textSizeTextField_Face text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fd_label_text_size"];
        
        NSString *titlebase64String;
        if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[selectTitleImgTextField text]]) {
            titlebase64String = @"";
        } else {
            UIImage *titleImageFace = [UIImage imageNamed:@"title_image"];
            
            titlebase64String = [self imageToNSString:titleImageFace];
        }
        
        //id_title_img_bitmap_base64
        [uiDictionary setObject:titlebase64String forKey:@"fd_title_img_bitmap_base64"];
        
        NSString *showPreviewScreen = showPreviewScreen_Face ? @"Y" : @"N";
        NSString *showInstScreen = showInstructionScreen_Face ? @"Y" : @"N";
        NSString *enableShadow = isEnableShadow_Face ? @"Y" : @"N";
        
        [uiDictionary setObject:showPreviewScreen forKey:@"fd_show_preview_screen"];
        
        [uiDictionary setObject:showInstScreen forKey:@"fd_show_instruction_screen"];
        
        [uiDictionary setObject:enableShadow forKey:@"fd_enable_label_shadow"];

        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        
        if(showFaceCustomizeUI) {
        
            NSString *progressImage = @"fd_progress_1, fd_progress_2, fd_progress_3, fd_progress_4, fd_progress_5, fd_progress_6, fd_progress_7, fd_progress_8, fd_progress_9, fd_progress_10, fd_progress_11";
            NSString *turnArrow = @"left_turn_arrow, up_move_arrow, right_turn_arrow, down_move_arrow";
            
            [uiDictionary setObject:@"Y" forKey:@"fd_show_custom_ui"];
            [uiDictionary setObject:bundleIdentifier forKey:@"fd_image_bundle_id"];
            [uiDictionary setObject:@"fd_outline" forKey:@"fd_face_outline_image_id"];
            [uiDictionary setObject:@"fd_background" forKey:@"fd_outside_face_outline_image_id"];
            [uiDictionary setObject:progressImage forKey:@"fd_face_outline_progress_images"];
            [uiDictionary setObject:@"10" forKey:@"fd_face_outline_progress_images_delay"];
            [uiDictionary setObject:turnArrow forKey:@"fd_face_turn_arrow_list"];
            [uiDictionary setObject:@"fd_toggle_camera_icon" forKey:@"fd_toggle_camera_button_icon"];
            
        } else {
            
            [uiDictionary setObject:@"N" forKey:@"fd_show_custom_ui"];
            [uiDictionary setObject:bundleIdentifier forKey:@"fd_image_bundle_id"];
            [uiDictionary setObject:@"" forKey:@"fd_face_outline_image_id"];
            [uiDictionary setObject:@"" forKey:@"fd_outside_face_outline_image_id"];
            [uiDictionary setObject:@"" forKey:@"fd_face_outline_progress_images"];
            [uiDictionary setObject:@"10" forKey:@"fd_face_outline_progress_images_delay"];
            [uiDictionary setObject:@"" forKey:@"fd_face_turn_arrow_list"];
            [uiDictionary setObject:@"" forKey:@"fd_toggle_camera_button_icon"];
            
        }
        
        [CustomizeUIConfigManager storeConfig:@"face_capture"];
        
    }
}

-(void) updateFingerPrintConfig {
    
    NSMutableDictionary *uiDictionary;
    uiDictionary = [[CustomizeUIConfigManager getDefaultFingerPrintCaptureConfig] getUIConfiguration];
    
    if(nil != uiDictionary) {
        
        
        NSString *fontStyle=[self getFontStyle:[fontStyleTextField_4F text] defaultValue:@"Default"];
        
        [uiDictionary setObject:[fontStyle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_label_text_style"];
        
        [uiDictionary setObject:[[textColorTextField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_label_text_color"];
        
        [uiDictionary setObject:[[textColorTransTextField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_label_text_color_alpha"];
        
        [uiDictionary setObject:[[instContinueButtonTextField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_instruction_button_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_instruction_button_alpha"];
        
        [uiDictionary setObject:[[instContinueButtonTextColorField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_instruction_button_txt_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextColorField_4F text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"cfc_instruction_button_txt_alpha"];
        
        [CustomizeUIConfigManager storeConfig:@"camera_finger_capture"];
    }
}

-(void)updateVoiceConfig {
    NSMutableDictionary *uiDictionary;
    uiDictionary = [[CustomizeUIConfigManager getDefaultVoiceCaptureConfig] getUIConfiguration];
    
    if(nil != uiDictionary) {
        
        [uiDictionary setObject:[[btnColorTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_button_color"];
        [uiDictionary setObject:[[btnColorTransTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_button_color_alpha"];
        [uiDictionary setObject:[[backgroundBtnTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_background_color"];
        [uiDictionary setObject:[[backGroundBtnTransColorTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_background_color_alpha"];
        
        NSString *title_label_on_top = isTitleLabelOnTop_voiceCapture ? @"Y" : @"N";
        NSString *auto_play = isAutoPlay_voiceCapture ? @"Y" : @"N";
        
        [uiDictionary setObject:[title_label_on_top stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_title_label_on_top"];
        
        [uiDictionary setObject:[[viewPositionTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_display_position"];
        
        [uiDictionary setObject:[auto_play stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_auto_play"];
        
        [uiDictionary setObject:[[textColortTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_text_label_color"];
        [uiDictionary setObject:[[textColorAlphaTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_text_label_color_alpha"];
        [uiDictionary setObject:[[titleTextColortTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_title_label_color"];
        [uiDictionary setObject:[[titleTextColorAlphaTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_title_label_color_alpha"];
        [uiDictionary setObject:[[titleLabelSizeTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_title_label_size"];
        [uiDictionary setObject:[[textSizeTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_text_label_size"];
        [uiDictionary setObject:[[counterLabelSizeTextField_voiceCapture text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"voice_counter_label_size"];
        
        [CustomizeUIConfigManager storeConfig:@"voice_recording"];
    }
}

-(void) updateIDConfig:(int)select_config_row {
 
    NSMutableDictionary *uiDictionary;
//    if([@"id_capture_front" isEqualToString:featureType]) {
    NSString *featureType;
    NSString *showInstScreen;
    NSString *enableShadowId;
    if(0 == select_config_row) {
        [self saveSetting_IdFront];
        uiDictionary = [[CustomizeUIConfigManager getDefaultIDCaptureFrontConfig] getUIConfiguration];
        featureType = @"id_capture_front";
        
        //Show Instruction
        showInstScreen = showInstScreen_IdFront ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdFront ? @"Y" : @"N";
        
    } else if(1 == select_config_row) {
        [self saveSetting_IdBack];
        uiDictionary = [[CustomizeUIConfigManager getDefaultIDCaptureBackConfig] getUIConfiguration];
        featureType = @"id_capture_back";
        
        //Show Instruction
        showInstScreen = showInstScreen_IdBack ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdBack ? @"Y" : @"N";
    } else if(2 == select_config_row) {
        [self saveSetting_Document];
        uiDictionary = [[CustomizeUIConfigManager getDefaultDocCaptureConfig] getUIConfiguration];
        featureType = @"document_capture";
        
        //Show Instruction
        showInstScreen = showInstScreen_Doc ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdBack_Doc ? @"Y" : @"N";
    } else if(3 == select_config_row) {
        [self saveSetting_Snippet];
        uiDictionary = [[CustomizeUIConfigManager getDefaultSnippetCaptureConfig] getUIConfiguration];
        featureType = @"snippet_capture";
        
        //Show Instruction
        showInstScreen = showInstScreen_Snippet ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdBack_Snippet ? @"Y" : @"N";
    } else if(6 == select_config_row) {
        [self saveSetting_SecondaryIdFront];
        
        uiDictionary = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureFrontConfig] getUIConfiguration];
        featureType = @"secondary_id_capture_front";
        
        //Show Instruction
        showInstScreen = showInstScreen_IdFront_sec ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdFront_sec ? @"Y" : @"N";
    } else if(7 == select_config_row) {
        [self saveSetting_SecondaryIdBack];
        
        uiDictionary = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureBackConfig] getUIConfiguration];
        featureType = @"secondary_id_capture_back";
        
        //Show Instruction
        showInstScreen = showInstScreen_IdBack_sec ? @"Y" : @"N";
        enableShadowId = isEnableShadow_IdBack_sec ? @"Y" : @"N";
    }
    
    if(nil != uiDictionary) {
        [uiDictionary setObject:[[idOutlineColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_outline_color"];
        
        [uiDictionary setObject:[[idOutlineColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_outline_color_alpha"];
        
        [uiDictionary setObject:[[detectedIdOutlineColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_detected_id_outline_color"];
        
        [uiDictionary setObject:[[detectedIdOutlineColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_detected_id_outline_color_alpha"];
        
        [uiDictionary setObject:[[colorOutsideOutlineTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_outside_outline_color"];
        
        [uiDictionary setObject:[[colorOutsideOutlineTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_outside_outline_color_aplha"];
        
        [uiDictionary setObject:[[detectedColorOutsideOutlineTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_detected_id_outside_outline_color"];
        
        [uiDictionary setObject:[[detectedColorOutsideOutlineTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_detected_id_outside_outline_color_alpha"];
        
        [uiDictionary setObject:[[backButtonTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_back_button_color"];
        
        [uiDictionary setObject:[[backButtonTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_back_button_color_alpha"];
        
        [uiDictionary setObject:[[retryButtonTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_retry_button_color"];
        
        [uiDictionary setObject:[[retryButtonTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_retry_button_color_alpha"];
        
        [uiDictionary setObject:[[retryButtonBorderTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_retry_button_border_color"];
        
        [uiDictionary setObject:[[retryButtonBorderTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_retry_button_border_color_alpha"];
        
        [uiDictionary setObject:[[confirmButtonTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_confirm_button_color"];
        
        [uiDictionary setObject:[[confirmButtonTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_confirm_button_color_alpha"];
        
        [uiDictionary setObject:[[confirmButtonStyleTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_confirm_button_background_color"];
        
        [uiDictionary setObject:[[confirmButtonStyleTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_confirm_button_background_color_alpha"];
        
        [uiDictionary setObject:[[textColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_label_text_color"];
        
        [uiDictionary setObject:[[textColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_label_text_alpha"];
        
        [uiDictionary setObject:[[instContinueButtonTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_instruction_button_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_instruction_button_alpha"];
        
        
        [uiDictionary setObject:[[instContinueButtonTextColorField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_instruction_button_txt_color"];
        
        [uiDictionary setObject:[[instContinueButtonTransTextColorField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_instruction_button_txt_alpha"];
        
        [uiDictionary setObject:[[headerTextColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_header_text_label_color"];
        
        [uiDictionary setObject:[[headerTextColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_header_text_label_alpha"];
        
        [uiDictionary setObject:[[headerSizeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_header_text_label_size"];
        
        [uiDictionary setObject:[[textSizeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_label_text_size"];
        
        NSString *fontStyle=[self getFontStyle:[fontStyleTextField text] defaultValue:@"Default"];
        
        [uiDictionary setObject:[fontStyle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_label_text_style"];
        
        NSString *headerFontStyle=[self getFontStyle:[headerFontStyleTextField text] defaultValue:@"Default"];
        
        [uiDictionary setObject:[headerFontStyle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_header_text_style"];
        
        NSString *idCaptureBorderLabel= [self getIdCaptureBorder:[idCaptureBorderLabelTextField text] defaultValue:@"Thick"];
        
        [uiDictionary setObject:[idCaptureBorderLabel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_capture_border_style"];
        
        NSString *idCaptureTitleLabelString= [self getIdCaptureAlignmentAccordingLanguage:[idCaptureTitleTextField text]];
        
        NSString *idCaptureTitleLabelString_eng = [self getIdCaptureAlignment:idCaptureTitleLabelString defaultValue:@"Top"];
        
        [uiDictionary setObject:[idCaptureTitleLabelString_eng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_title_label_alignment"];
        
        NSString *idCaptureHintMessageString= [self getIdCaptureAlignmentAccordingLanguage:[idCaptureHintMsgTextField text]];
        
        NSString *idCaptureHintMessageString_eng = [self getIdCaptureAlignment:idCaptureHintMessageString defaultValue:@"Center"];
        
        [uiDictionary setObject:[idCaptureHintMessageString_eng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_hint_message_alignment"];
        
        NSString *idCaptureTitleImageString= [self getIdCaptureAlignmentAccordingLanguage:[idCapturetitleImageTextField text]];
        
        NSString *idCaptureTitleImageString_eng = [self getIdCaptureAlignment:idCaptureTitleImageString defaultValue:@"Bottom"];
        
        [uiDictionary setObject:[idCaptureTitleImageString_eng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_title_image_alignment"];
        
        NSString *hideIDTitle = hideIdCaptureTitle ? @"Y" : @"N";
        
        NSString *hideIDHintMsg = hideIdHintMessage ? @"Y" : @"N";
        
        NSString *hideIDTitleImage = hideIdTitleImage ? @"Y" : @"N";
        
       // NSString *enableShadowId = isEnableShadow_Id ? @"Y" : @"N";
        
        [uiDictionary setObject:[hideIDTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_hide_id_title_label"];
        
        [uiDictionary setObject:[hideIDHintMsg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_hide_id_hint_message"];
        
        [uiDictionary setObject:[hideIDTitleImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_hide_id_title_image"];
        
        [uiDictionary setObject:[enableShadowId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_enable_label_shadow"];
        
        [uiDictionary setObject:[[idCaptureButtonColorTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_capture_button_color"];
        
        [uiDictionary setObject:[[idCaptureButtonColorTransTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"id_capture_button_alpha"];
        
        NSString *showTitleImage = [showTitleImgTextField text];
        NSString *titlebase64String;
        if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[showTitleImgTextField text]]) {
            titlebase64String = @"";
        } else {
           UIImage *titleImageFace = [UIImage imageNamed:@"title_image"];
            
           titlebase64String = [self imageToNSString:titleImageFace];
        }
        
        //id_title_img_bitmap_base64
        [uiDictionary setObject:titlebase64String forKey:@"id_title_img_bitmap_base64"];
        
        //ShowInstructionScreen
        [uiDictionary setObject:showInstScreen forKey:@"id_show_instruction"];
        
        [CustomizeUIConfigManager storeConfig:featureType];
        
    }
}

-(NSString *)imageToNSString:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(UIImage *)stringToUIImage:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
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

@end
