//
//  DataCaptureController.m
//  AppItDepedency
//
//  Created by  on 14/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "DataCaptureController.h"
#import "ArrayObjectController.h"
#import "SidePanelController.h"
#import "FinalStepController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"
#import "KeyValue.h"
#define KEY_TAG 1
#define VALUE_TAG 2

@interface DataCaptureController ()

@end

@implementation DataCaptureController {
    UILabel *titleLabel;
    UITextField *uniqueCustNoTextView, *customerNameTextView, *selectServiceTextField, *serviceIdTextView, *custTypeTextView, *custPhonenoTextView, *custEmailTextView, *custAttributeTextView, *uniqueMerNoTextView, *uniqueEmpNoTextView, *uniqueEmpCodeTextView, *oldCustNoTextView, *custAddress1, *custAddress2, *custCountry, *custState, *custCity, *custPostalCode, *custGender, *formIdField, *formKeyField, *formValueField;
    UIButton *toggleManualRevButton, *toggleByPassAgeValidButton, *toggleByPassNameMatchButton, *toggDedublicationReqButton, *toggNeedImmediateResponseButton, *captureSecondaryImageButton, *addFieldButton;
    bool isManualReviewRequired, isByPassAgeValidation, isByPassNameMatching, isDedublicationRequired, isNeedImmediateResponse, isCaptureSecondaryImage;
    NSArray *selectedPickerData;
    NSArray *genderFieldPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UITableView *myTableView;
    NSMutableArray *keyValueList;
}

-(void)viewDidAppear:(BOOL)animated {
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    genderFieldPickerData = @[@"M", @"F"];
    selectedPickerData = @[@"M", @"F"];
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.tintColor = [ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0];
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    [custGender setInputView:myPickerView];
    [custGender setInputAccessoryView:toolbarForPicker];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isManualReviewRequired = false;
    isByPassAgeValidation = false;
    isByPassNameMatching = false;
    isDedublicationRequired = false;
    isNeedImmediateResponse = false;
    isCaptureSecondaryImage = false;
    
    keyValueList = [[NSMutableArray alloc] init];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    // [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"IDCaptureBack"]];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"data_captur_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, slideView.frame.origin.y + slideView.frame.size.height + (height/100)*2, width, height - (height/100)*20 - slideView.frame.origin.y - slideView.frame.size.height - 37)];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, slideView.frame.origin.y + slideView.frame.size.height + (height/100)*2, width, [ArrayObjectController getPageControlY] - (height/100)*13 - slideView.frame.origin.y - slideView.frame.size.height)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setContentSize:CGSizeMake(width, height + height)];
    [self.view addSubview:scrollView];

    //Manual Review Required Start
    UILabel *manualReviewLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*2, (width/100)*50, (height/100)*5)];
    [manualReviewLabel setTextAlignment:UITextAlignmentLeft];
    [manualReviewLabel setText:[LabelUtils getLabelForKey:@"manual_review_required"]];
    [manualReviewLabel setFont:[UIFont systemFontOfSize:14]];
    [manualReviewLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:manualReviewLabel];
    
    UILabel *noManualRevLabel = [[UILabel alloc] initWithFrame:CGRectMake(manualReviewLabel.frame.origin.x + manualReviewLabel.frame.size.width + (width/100)*5, manualReviewLabel.frame.origin.y, (width/100)*10, manualReviewLabel.frame.size.height)];
    [noManualRevLabel setTextAlignment:NSTextAlignmentRight];
    [noManualRevLabel setText:[LabelUtils getLabelForKey:@"no"]];
    noManualRevLabel.lineBreakMode = UILineBreakModeWordWrap;
    noManualRevLabel.numberOfLines = 2;
    [noManualRevLabel setFont:[UIFont systemFontOfSize:14]];
    [noManualRevLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noManualRevLabel];
    
    toggleManualRevButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleManualRevButton setFrame:CGRectMake(noManualRevLabel.frame.origin.x + noManualRevLabel.frame.size.width + (width/100)*3, noManualRevLabel.frame.origin.y, (width/100)*10, noManualRevLabel.frame.size.height)];
    [toggleManualRevButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggleManualRevButton addTarget:self action:@selector(manualReviewToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggleManualRevButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:toggleManualRevButton];
    
    UILabel *yesManualRevLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleManualRevButton.frame.origin.x + toggleManualRevButton.frame.size.width + (width/100)*3, toggleManualRevButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesManualRevLabel setTextAlignment:NSTextAlignmentLeft];
    [yesManualRevLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    yesManualRevLabel.lineBreakMode = UILineBreakModeWordWrap;
    yesManualRevLabel.numberOfLines = 2;
    [yesManualRevLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesManualRevLabel];
    //Manual Review Required End

    //ByPass Age Validation start
    UILabel *byPassAgeValidationLabel = [[UILabel alloc] initWithFrame:CGRectMake(manualReviewLabel.frame.origin.x, manualReviewLabel.frame.origin.y + manualReviewLabel.frame.size.height + (height/100)*3, manualReviewLabel.frame.size.width, manualReviewLabel.frame.size.height)];
    [byPassAgeValidationLabel setTextAlignment:UITextAlignmentLeft];
    [byPassAgeValidationLabel setText:[LabelUtils getLabelForKey:@"bypass_age_validation"]];
    [byPassAgeValidationLabel setFont:[UIFont systemFontOfSize:14]];
    [byPassAgeValidationLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:byPassAgeValidationLabel];
    
    UILabel *noByPassAgeValidLabel = [[UILabel alloc] initWithFrame:CGRectMake(byPassAgeValidationLabel.frame.origin.x + byPassAgeValidationLabel.frame.size.width + (width/100)*5, byPassAgeValidationLabel.frame.origin.y, (width/100)*10, byPassAgeValidationLabel.frame.size.height)];
    [noByPassAgeValidLabel setTextAlignment:NSTextAlignmentRight];
    [noByPassAgeValidLabel setText:[LabelUtils getLabelForKey:@"no"]];
    noByPassAgeValidLabel.lineBreakMode = UILineBreakModeWordWrap;
    noByPassAgeValidLabel.numberOfLines = 2;
    [noByPassAgeValidLabel setFont:[UIFont systemFontOfSize:14]];
    [noByPassAgeValidLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noByPassAgeValidLabel];
    
    toggleByPassAgeValidButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleByPassAgeValidButton setFrame:CGRectMake(noByPassAgeValidLabel.frame.origin.x + noByPassAgeValidLabel.frame.size.width + (width/100)*3, noByPassAgeValidLabel.frame.origin.y, (width/100)*10, noManualRevLabel.frame.size.height)];
    [toggleByPassAgeValidButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggleByPassAgeValidButton addTarget:self action:@selector(byPassAgeValidToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggleByPassAgeValidButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:toggleByPassAgeValidButton];
   
    UILabel *yesByPassAgeValidLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleByPassAgeValidButton.frame.origin.x + toggleByPassAgeValidButton.frame.size.width + (width/100)*3, toggleByPassAgeValidButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesByPassAgeValidLabel setTextAlignment:NSTextAlignmentLeft];
    [yesByPassAgeValidLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    yesByPassAgeValidLabel.lineBreakMode = UILineBreakModeWordWrap;
    yesByPassAgeValidLabel.numberOfLines = 2;
    [yesByPassAgeValidLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesByPassAgeValidLabel];
    //ByPass Age Validation end
    
    //ByPass Name Matching Start
    UILabel *byPassNameMatchingLabel = [[UILabel alloc] initWithFrame:CGRectMake(byPassAgeValidationLabel.frame.origin.x, byPassAgeValidationLabel.frame.origin.y + byPassAgeValidationLabel.frame.size.height + (height/100)*3, byPassAgeValidationLabel.frame.size.width, byPassAgeValidationLabel.frame.size.height)];
    [byPassNameMatchingLabel setTextAlignment:UITextAlignmentLeft];
    [byPassNameMatchingLabel setText:[LabelUtils getLabelForKey:@"bypass_name_matching"]];
    [byPassNameMatchingLabel setFont:[UIFont systemFontOfSize:14]];
    [byPassNameMatchingLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:byPassNameMatchingLabel];
    
    UILabel *noByPassNameMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(byPassNameMatchingLabel.frame.origin.x + byPassNameMatchingLabel.frame.size.width + (width/100)*5, byPassNameMatchingLabel.frame.origin.y, (width/100)*10, byPassNameMatchingLabel.frame.size.height)];
    [noByPassNameMatchLabel setTextAlignment:NSTextAlignmentRight];
    [noByPassNameMatchLabel setText:[LabelUtils getLabelForKey:@"no"]];
    noByPassNameMatchLabel.lineBreakMode = UILineBreakModeWordWrap;
    noByPassNameMatchLabel.numberOfLines = 2;
    [noByPassNameMatchLabel setFont:[UIFont systemFontOfSize:14]];
    [noByPassNameMatchLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noByPassNameMatchLabel];
    
    toggleByPassNameMatchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleByPassNameMatchButton setFrame:CGRectMake(noByPassNameMatchLabel.frame.origin.x + noByPassNameMatchLabel.frame.size.width + (width/100)*3, noByPassNameMatchLabel.frame.origin.y, (width/100)*10, noManualRevLabel.frame.size.height)];
    [toggleByPassNameMatchButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggleByPassNameMatchButton addTarget:self action:@selector(byPassNameMatchToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggleByPassNameMatchButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:toggleByPassNameMatchButton];
    
    UILabel *yesByPassNameMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleByPassNameMatchButton.frame.origin.x + toggleByPassNameMatchButton.frame.size.width + (width/100)*3, toggleByPassNameMatchButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesByPassNameMatchLabel setTextAlignment:NSTextAlignmentLeft];
    [yesByPassNameMatchLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    yesByPassNameMatchLabel.lineBreakMode = UILineBreakModeWordWrap;
    yesByPassNameMatchLabel.numberOfLines = 2;
    [yesByPassNameMatchLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesByPassNameMatchLabel];
    //ByPass Name Matching End
    
    //Dedublication required Start
    UILabel *dedublicationRequiredLabel = [[UILabel alloc] initWithFrame:CGRectMake(byPassNameMatchingLabel.frame.origin.x, byPassNameMatchingLabel.frame.origin.y + byPassNameMatchingLabel.frame.size.height + (height/100)*3, byPassNameMatchingLabel.frame.size.width, byPassNameMatchingLabel.frame.size.height)];
    [dedublicationRequiredLabel setTextAlignment:UITextAlignmentLeft];
    [dedublicationRequiredLabel setText:[LabelUtils getLabelForKey:@"deduplication_required"]];
    [dedublicationRequiredLabel setFont:[UIFont systemFontOfSize:14]];
    [dedublicationRequiredLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:dedublicationRequiredLabel];
    
    UILabel *noDedublicationReqLabel = [[UILabel alloc] initWithFrame:CGRectMake(dedublicationRequiredLabel.frame.origin.x + dedublicationRequiredLabel.frame.size.width + (width/100)*5, dedublicationRequiredLabel.frame.origin.y, (width/100)*10, dedublicationRequiredLabel.frame.size.height)];
    [noDedublicationReqLabel setTextAlignment:NSTextAlignmentRight];
    [noDedublicationReqLabel setText:[LabelUtils getLabelForKey:@"no"]];
    noDedublicationReqLabel.lineBreakMode = UILineBreakModeWordWrap;
    noDedublicationReqLabel.numberOfLines = 2;
    [noDedublicationReqLabel setFont:[UIFont systemFontOfSize:14]];
    [noDedublicationReqLabel setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noDedublicationReqLabel];
    
    toggDedublicationReqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggDedublicationReqButton setFrame:CGRectMake(noDedublicationReqLabel.frame.origin.x + noDedublicationReqLabel.frame.size.width + (width/100)*3, noDedublicationReqLabel.frame.origin.y, (width/100)*10, noDedublicationReqLabel.frame.size.height)];
    [toggDedublicationReqButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggDedublicationReqButton addTarget:self action:@selector(dedublicationToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggDedublicationReqButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:toggDedublicationReqButton];
    
    UILabel *yesDedublicationReqLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggDedublicationReqButton.frame.origin.x + toggDedublicationReqButton.frame.size.width + (width/100)*3, toggDedublicationReqButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesDedublicationReqLabel setTextAlignment:NSTextAlignmentLeft];
    [yesDedublicationReqLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    yesDedublicationReqLabel.lineBreakMode = UILineBreakModeWordWrap;
    yesDedublicationReqLabel.numberOfLines = 2;
    [yesDedublicationReqLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesDedublicationReqLabel];
    //Dedublication required End
    
    //Need Immediate Response Start
    UILabel *needImmediateResponseLable = [[UILabel alloc] initWithFrame:CGRectMake(dedublicationRequiredLabel.frame.origin.x, dedublicationRequiredLabel.frame.origin.y + dedublicationRequiredLabel.frame.size.height + (height/100)*3, dedublicationRequiredLabel.frame.size.width, dedublicationRequiredLabel.frame.size.height)];
    [needImmediateResponseLable setTextAlignment:UITextAlignmentLeft];
    [needImmediateResponseLable setText:[LabelUtils getLabelForKey:@"need_immediate_response"]];
    [needImmediateResponseLable setFont:[UIFont systemFontOfSize:14]];
    [needImmediateResponseLable setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:needImmediateResponseLable];
    
    UILabel *noNeedImmediateResponseLable = [[UILabel alloc] initWithFrame:CGRectMake(needImmediateResponseLable.frame.origin.x + needImmediateResponseLable.frame.size.width + (width/100)*5, needImmediateResponseLable.frame.origin.y, (width/100)*10, needImmediateResponseLable.frame.size.height)];
    [noNeedImmediateResponseLable setTextAlignment:NSTextAlignmentRight];
    [noNeedImmediateResponseLable setText:[LabelUtils getLabelForKey:@"no"]];
    noNeedImmediateResponseLable.lineBreakMode = UILineBreakModeWordWrap;
    noNeedImmediateResponseLable.numberOfLines = 2;
    [noNeedImmediateResponseLable setFont:[UIFont systemFontOfSize:14]];
    [noNeedImmediateResponseLable setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noNeedImmediateResponseLable];
    
    toggNeedImmediateResponseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggNeedImmediateResponseButton setFrame:CGRectMake(noNeedImmediateResponseLable.frame.origin.x + noNeedImmediateResponseLable.frame.size.width + (width/100)*3, noNeedImmediateResponseLable.frame.origin.y, (width/100)*10, noNeedImmediateResponseLable.frame.size.height)];
    [toggNeedImmediateResponseButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggNeedImmediateResponseButton addTarget:self action:@selector(needImmediateResponseToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggNeedImmediateResponseButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:toggNeedImmediateResponseButton];
    
    UILabel *yesNeedImmediateResponseLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggNeedImmediateResponseButton.frame.origin.x + toggNeedImmediateResponseButton.frame.size.width + (width/100)*3, toggNeedImmediateResponseButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesNeedImmediateResponseLabel setTextAlignment:NSTextAlignmentLeft];
    [yesNeedImmediateResponseLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    yesNeedImmediateResponseLabel.lineBreakMode = UILineBreakModeWordWrap;
    yesNeedImmediateResponseLabel.numberOfLines = 2;
    [yesNeedImmediateResponseLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesNeedImmediateResponseLabel];
    //Need Immediate Response Label End
    
    //Secondary Capture Field
   
    UILabel *captureSecondaryImageLable = [[UILabel alloc] initWithFrame:CGRectMake(needImmediateResponseLable.frame.origin.x, needImmediateResponseLable.frame.origin.y + needImmediateResponseLable.frame.size.height + (height/100)*3, needImmediateResponseLable.frame.size.width, needImmediateResponseLable.frame.size.height)];
    [captureSecondaryImageLable setTextAlignment:UITextAlignmentLeft];
//    [captureSecondaryImageLable setText:[LabelUtils getLabelForKey:@"need_immediate_response"]];
    [captureSecondaryImageLable setText:[LabelUtils getLabelForKey:@"process_sec_id"]];
    [captureSecondaryImageLable setFont:[UIFont systemFontOfSize:14]];
    [captureSecondaryImageLable setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:captureSecondaryImageLable];
    
    UILabel *noCaptureSecondaryImageLable = [[UILabel alloc] initWithFrame:CGRectMake(captureSecondaryImageLable.frame.origin.x + captureSecondaryImageLable.frame.size.width + (width/100)*5, captureSecondaryImageLable.frame.origin.y, (width/100)*10, captureSecondaryImageLable.frame.size.height)];
    [noCaptureSecondaryImageLable setTextAlignment:NSTextAlignmentRight];
    [noCaptureSecondaryImageLable setText:[LabelUtils getLabelForKey:@"no"]];
    noCaptureSecondaryImageLable.lineBreakMode = UILineBreakModeWordWrap;
    noCaptureSecondaryImageLable.numberOfLines = 2;
    [noCaptureSecondaryImageLable setFont:[UIFont systemFontOfSize:14]];
    [noCaptureSecondaryImageLable setTextColor:[UIColor darkGrayColor]];
    [scrollView addSubview:noCaptureSecondaryImageLable];
    
    captureSecondaryImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [captureSecondaryImageButton setFrame:CGRectMake(noCaptureSecondaryImageLable.frame.origin.x + noCaptureSecondaryImageLable.frame.size.width + (width/100)*3, noCaptureSecondaryImageLable.frame.origin.y, (width/100)*10, noCaptureSecondaryImageLable.frame.size.height)];
    [captureSecondaryImageButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [captureSecondaryImageButton addTarget:self action:@selector(captureSecondaryImageToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    captureSecondaryImageButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:captureSecondaryImageButton];
    
    UILabel *yesCaptureSecondaryImageLable = [[UILabel alloc] initWithFrame:CGRectMake(captureSecondaryImageButton.frame.origin.x + captureSecondaryImageButton.frame.size.width + (width/100)*3, captureSecondaryImageButton.frame.origin.y, noManualRevLabel.frame.size.width, noManualRevLabel.frame.size.height)];
    [yesCaptureSecondaryImageLable setTextAlignment:NSTextAlignmentLeft];
    [yesCaptureSecondaryImageLable setText:[LabelUtils getLabelForKey:@"yes"]];
    yesCaptureSecondaryImageLable.lineBreakMode = UILineBreakModeWordWrap;
    yesCaptureSecondaryImageLable.numberOfLines = 2;
    [yesCaptureSecondaryImageLable setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:yesCaptureSecondaryImageLable];
    
    //    uniqueCustNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    
    if(![ArrayObjectController getIsSecondaryIDCaptureImage]) {
        [captureSecondaryImageLable setHidden:true];
        [noCaptureSecondaryImageLable setHidden:true];
        [captureSecondaryImageButton setHidden:true];
        [yesCaptureSecondaryImageLable setHidden:true];
        
        uniqueCustNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, needImmediateResponseLable.frame.origin.y + needImmediateResponseLable.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    } else {
        uniqueCustNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, captureSecondaryImageLable.frame.origin.y + captureSecondaryImageLable.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    }
    
    [NSStringUtilsDemo setEditTextUITextFieldStyle:uniqueCustNoTextView];
    [scrollView addSubview:uniqueCustNoTextView];
    
    NSString *ucn = [LabelUtils getLabelForKey:@"unique_customer_number"];
    CGSize ucnSize = [NSStringUtilsDemo getUILabelSizeFromLabel:ucn size:11];
    UILabel *uniqueCustNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(uniqueCustNoTextView.frame.origin.x + 15, uniqueCustNoTextView.frame.origin.y - ucnSize.height/2, ucnSize.width, ucnSize.height)];
    [uniqueCustNameLabel setText:ucn];
    [NSStringUtilsDemo setEditTextUILabelStyle:uniqueCustNameLabel];
    [scrollView addSubview:uniqueCustNameLabel];
    
    customerNameTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, uniqueCustNoTextView.frame.origin.y + uniqueCustNoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:customerNameTextView];
    [scrollView addSubview:customerNameTextView];
    
    NSString *cn = [LabelUtils getLabelForKey:@"customer_name"];
    CGSize cnSize = [NSStringUtilsDemo getUILabelSizeFromLabel:cn size:11];
    UILabel *customerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(customerNameTextView.frame.origin.x + 15,
                                                                           customerNameTextView.frame.origin.y - cnSize.height/2,
                                                                           cnSize.width,
                                                                           cnSize.height)];
    [customerNameLabel setText:cn];
    [NSStringUtilsDemo setEditTextUILabelStyle:customerNameLabel];
    [scrollView addSubview:customerNameLabel];
    
//    serviceIdTextView = [[UITextField alloc] initWithFrame:CGRectMake(serviceIDLabel.frame.origin.x, custEnrolmentLabel.frame.origin.y + custEnrolmentLabel.frame.size.height + (serviceViewHeight/100)*5, serviceViewWidth - (serviceViewWidth/100)*3, (height/100)*7)];
    
//    serviceIdTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, customerNameTextView.frame.origin.y + customerNameTextView.frame.size.height + (height/100)*3, width - (width/100)*14, (height/100)*7)];
//    serviceIdTextView.layer.cornerRadius = 5;
//    serviceIdTextView.layer.borderWidth = 1.0;
//    serviceIdTextView.layer.borderColor = [[UIColor grayColor]CGColor];
//    [serviceIdTextView setAlpha:0.7];
//    [serviceIdTextView setTextAlignment:NSTextAlignmentCenter];
//    [scrollView addSubview:serviceIdTextView];
//
//    UILabel *serviceIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(serviceIdTextView.frame.origin.x + 15, serviceIdTextView.frame.origin.y - ((height/100)*2), ((serviceIdTextView.frame.size.width)/100)*40, ((height/100)*4))];
//    [serviceIDLabel setText:@"Service Id"];
//    [serviceIDLabel setFont:[UIFont systemFontOfSize:11]];
//    [serviceIDLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    [serviceIDLabel setTextColor:[UIColor grayColor]];
//    [serviceIDLabel setTextAlignment:NSTextAlignmentCenter];
//    [scrollView addSubview:serviceIDLabel];
    
//    UIView *serviceIDView = [[UIView alloc] initWithFrame:CGRectMake((width/100) * 7, customerNameTextView.frame.origin.y + customerNameTextView.frame.size.height + (height/100)*3, width - (width/100)*14, (height/100)*30)];
//    serviceIDView.layer.cornerRadius = 5;
//    serviceIDView.layer.borderWidth = 1.0;
//    serviceIDView.layer.borderColor = [[UIColor grayColor]CGColor];
//    [serviceIDView setAlpha:0.7];
//    [scrollView addSubview:serviceIDView];
//
//    int serviceViewHeight = serviceIDView.frame.size.height;
//    int serviceViewWidth = serviceIDView.frame.size.width;
//
//    UILabel *serviceIDLabel = [[UILabel alloc] initWithFrame:CGRectMake((serviceViewWidth/100)*2, (serviceViewHeight/100)*3, (serviceViewWidth/100)*30, (serviceViewHeight/100)*10)];
//    [serviceIDLabel setText:@"Service ID"];
//    [serviceIDLabel setFont:[UIFont systemFontOfSize:12]];
//    [serviceIDLabel setTextColor:[UIColor grayColor]];
//    [serviceIDView addSubview:serviceIDLabel];
//
//    selectServiceTextField = [[UITextField alloc] initWithFrame:CGRectMake(serviceIDLabel.frame.origin.x, serviceIDLabel.frame.origin.y + serviceIDLabel.frame.size.height, serviceViewWidth - (serviceViewWidth/100)*2, (height/100)*7)];
//    [selectServiceTextField setText:@"10 ID Validation and Face Match"];
//    selectServiceTextField.layer.cornerRadius = 0;
//    selectServiceTextField.layer.borderWidth = 0.0;
//    selectServiceTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [serviceIDView addSubview:selectServiceTextField];
//
//    UILabel *custEnrolmentLabel = [[UILabel alloc] initWithFrame:CGRectMake((serviceViewWidth/100)*5, selectServiceTextField.frame.origin.y + selectServiceTextField.frame.size.height + (serviceViewHeight/100)*3, selectServiceTextField.frame.size.width, (height/100)*3)];
//    [custEnrolmentLabel setText:@"10 ID Validation and Face Match with cust Enrol"];
//    [custEnrolmentLabel setFont:[UIFont systemFontOfSize:9]];
//    [custEnrolmentLabel setTextColor:[UIColor grayColor]];
//    [serviceIDView addSubview:custEnrolmentLabel];
    
//    serviceIDView.frame = CGRectMake(serviceIDView.frame.origin.x, serviceIDView.frame.origin.y, serviceIDView.frame.size.width, serviceIdTextView.frame.origin.y + serviceIdTextView.frame.size.height + (height/100)*3);
//
    
//    serviceIdTextView = [[UITextField alloc] initWithFrame:CGRectMake(serviceIDLabel.frame.origin.x, custEnrolmentLabel.frame.origin.y + custEnrolmentLabel.frame.size.height + (serviceViewHeight/100)*5, serviceViewWidth - (serviceViewWidth/100)*3, (height/100)*7)];
//    [serviceIdTextView setText:@" 10"];
//    serviceIdTextView.layer.cornerRadius = 4;
//    serviceIdTextView.layer.borderWidth = 1.0;
//    serviceIdTextView.layer.borderColor = [[UIColor grayColor]CGColor];
//    [selectServiceTextField setAlpha:0.7];
//    [serviceIDView addSubview:serviceIdTextView];
    
    //Customer Type
    custTypeTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, customerNameTextView.frame.origin.y + customerNameTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custTypeTextView];
    [scrollView addSubview:custTypeTextView];
    
    NSString *ct = [LabelUtils getLabelForKey:@"customer_type"];
    CGSize ctSize = [NSStringUtilsDemo getUILabelSizeFromLabel:ct size:11];
    UILabel *customerTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(custTypeTextView.frame.origin.x + 15, custTypeTextView.frame.origin.y - ctSize.height/2, ctSize.width, ctSize.height)];
    [customerTypeLabel setText:ct];
    [NSStringUtilsDemo setEditTextUILabelStyle:customerTypeLabel];
    [scrollView addSubview:customerTypeLabel];
    
    //Customer Phone
    custPhonenoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custTypeTextView.frame.origin.y + custTypeTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custPhonenoTextView];
    [scrollView addSubview:custPhonenoTextView];
    
    NSString *cp = [LabelUtils getLabelForKey:@"customer_phone"];
    CGSize cpSize = [NSStringUtilsDemo getUILabelSizeFromLabel:cp size:11];
    UILabel *customerPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(custPhonenoTextView.frame.origin.x + 15, custPhonenoTextView.frame.origin.y - cpSize.height/2, cpSize.width, cpSize.height)];
    [customerPhoneLabel setText:cp];
    [NSStringUtilsDemo setEditTextUILabelStyle:customerPhoneLabel];
    [scrollView addSubview:customerPhoneLabel];
    
    //Customer Email
    custEmailTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custPhonenoTextView.frame.origin.y + custPhonenoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custEmailTextView];
    [scrollView addSubview:custEmailTextView];
    
    NSString *ce = [LabelUtils getLabelForKey:@"customer_email"];
    CGSize ceSize = [NSStringUtilsDemo getUILabelSizeFromLabel:ce size:11];
    UILabel *customerEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(custEmailTextView.frame.origin.x + 15, custEmailTextView.frame.origin.y - ceSize.height/2, ceSize.width, ceSize.height)];
    [customerEmailLabel setText:ce];
    [NSStringUtilsDemo setEditTextUILabelStyle:customerEmailLabel];
    [scrollView addSubview:customerEmailLabel];
    
    //Customer Attribute
    custAttributeTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custEmailTextView.frame.origin.y + custEmailTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custAttributeTextView];
    [scrollView addSubview:custAttributeTextView];
    
    NSString *ca = [LabelUtils getLabelForKey:@"customer_attribute"];
    CGSize caSize = [NSStringUtilsDemo getUILabelSizeFromLabel:ca size:11];
    UILabel *customerAttributeLabel = [[UILabel alloc] initWithFrame:CGRectMake(custAttributeTextView.frame.origin.x + 15, custAttributeTextView.frame.origin.y - caSize.height/2, caSize.width, caSize.height)];
    [customerAttributeLabel setText:ca];
    [NSStringUtilsDemo setEditTextUILabelStyle:customerAttributeLabel];
    [scrollView addSubview:customerAttributeLabel];
    
    //Unique Merchant Number
    uniqueMerNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custAttributeTextView.frame.origin.y + custAttributeTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:uniqueMerNoTextView];
    [scrollView addSubview:uniqueMerNoTextView];
    
    NSString *umn = [LabelUtils getLabelForKey:@"unique_merchant_number"];
    CGSize umnSize = [NSStringUtilsDemo getUILabelSizeFromLabel:umn size:11];
    UILabel *uniqueMerchantNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(uniqueMerNoTextView.frame.origin.x + 15, uniqueMerNoTextView.frame.origin.y - umnSize.height/2, umnSize.width, umnSize.height)];
    [uniqueMerchantNumLabel setText:umn];
    [NSStringUtilsDemo setEditTextUILabelStyle:uniqueMerchantNumLabel];
    [scrollView addSubview:uniqueMerchantNumLabel];
    
    //Unique Employee Number
    uniqueEmpNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, uniqueMerNoTextView.frame.origin.y + uniqueMerNoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:uniqueEmpNoTextView];
    [scrollView addSubview:uniqueEmpNoTextView];
    
    NSString *uen =[LabelUtils getLabelForKey:@"unique_employee_number"];
    CGSize uenSize = [NSStringUtilsDemo getUILabelSizeFromLabel:uen size:11];
    UILabel *uniqueEmployeeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(uniqueEmpNoTextView.frame.origin.x + 15, uniqueEmpNoTextView.frame.origin.y - uenSize.height/2, uenSize.width, uenSize.height)];
    [uniqueEmployeeNumLabel setText:uen];
    [NSStringUtilsDemo setEditTextUILabelStyle:uniqueEmployeeNumLabel];
    [scrollView addSubview:uniqueEmployeeNumLabel];
    
    //Unique Employee Code
    uniqueEmpCodeTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, uniqueEmpNoTextView.frame.origin.y + uniqueEmpNoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:uniqueEmpCodeTextView];
    [scrollView addSubview:uniqueEmpCodeTextView];
    
    NSString *uec = [LabelUtils getLabelForKey:@"unique_employee_code"];
    CGSize uecSize = [NSStringUtilsDemo getUILabelSizeFromLabel:uec size:11];
    UILabel *uniqueEmployeeCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(uniqueEmpCodeTextView.frame.origin.x + 15, uniqueEmpCodeTextView.frame.origin.y - uecSize.height/2, uecSize.width, uecSize.height)];
    [uniqueEmployeeCodeLabel setText:uec];
    [NSStringUtilsDemo setEditTextUILabelStyle:uniqueEmployeeCodeLabel];
    [scrollView addSubview:uniqueEmployeeCodeLabel];
    
    //OldClient Cust Number
    oldCustNoTextView = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, uniqueEmpCodeTextView.frame.origin.y + uniqueEmpCodeTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:oldCustNoTextView];
    [scrollView addSubview:oldCustNoTextView];
    
    NSString *occn =[LabelUtils getLabelForKey:@"old_client_customer_number"];
    CGSize occnSize = [NSStringUtilsDemo getUILabelSizeFromLabel:occn size:11];
    UILabel *oldClientCustNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(oldCustNoTextView.frame.origin.x + 15, oldCustNoTextView.frame.origin.y - occnSize.height/2, occnSize.width, occnSize.height)];
    [oldClientCustNumLabel setText:occn];
    [NSStringUtilsDemo setEditTextUILabelStyle:oldClientCustNumLabel];
    [scrollView addSubview:oldClientCustNumLabel];
    
//    //Gender
//    custGender = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, oldCustNoTextView.frame.origin.y + oldCustNoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
//    [NSStringUtilsDemo setEditTextUITextFieldStyle:custGender];
//    [scrollView addSubview:custGender];
//
//    NSString *gender = @"Gender";
//    CGSize genderSize = [NSStringUtilsDemo getUILabelSizeFromLabel:gender size:11];
//    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(custGender.frame.origin.x + 15, custGender.frame.origin.y - genderSize.height/2, genderSize.width, genderSize.height)];
//    [genderLabel setText:gender];
//    [NSStringUtilsDemo setEditTextUILabelStyle:genderLabel];
//    [scrollView addSubview:genderLabel];

    custGender = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, oldCustNoTextView.frame.origin.y + oldCustNoTextView.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [custGender setText:@"M"];
    [custGender setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custGender];
    [scrollView addSubview:custGender];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(custGender.frame.origin.x + custGender.frame.size.width - (width/100)*9 , custGender.frame.origin.y + (custGender.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImage];
    
    NSString *languagecn = [LabelUtils getLabelForKey:@"gender"];
    CGSize languageSize = [NSStringUtilsDemo getUILabelSizeFromLabel:languagecn size:14];
    UILabel *languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(custGender.frame.origin.x + 15, custGender.frame.origin.y - (languageSize.height/2), languageSize.width, languageSize.height)];
    [languageLabel setText:languagecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:languageLabel];
    [scrollView addSubview:languageLabel];
    
    //AddressLine 1
    custAddress1 = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custGender.frame.origin.y + custGender.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custAddress1];
    [scrollView addSubview:custAddress1];
    
    NSString *al1 = [LabelUtils getLabelForKey:@"address_line_1"];
    CGSize al1Size = [NSStringUtilsDemo getUILabelSizeFromLabel:al1 size:11];
    UILabel *addressLine1Label = [[UILabel alloc] initWithFrame:CGRectMake(custAddress1.frame.origin.x + 15, custAddress1.frame.origin.y - al1Size.height/2, al1Size.width, al1Size.height)];
    [addressLine1Label setText:al1];
    [NSStringUtilsDemo setEditTextUILabelStyle:addressLine1Label];
    [scrollView addSubview:addressLine1Label];
    
    //Address Line 2
    custAddress2 = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custAddress1.frame.origin.y + custAddress1.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custAddress2];
    [scrollView addSubview:custAddress2];
    
    NSString *al2 = [LabelUtils getLabelForKey:@"address_line_2"];
    CGSize al2Size = [NSStringUtilsDemo getUILabelSizeFromLabel:al2 size:11];
    UILabel *addressLine2Label = [[UILabel alloc] initWithFrame:CGRectMake(custAddress2.frame.origin.x + 15, custAddress2.frame.origin.y - al2Size.height/2, al2Size.width, al2Size.height)];
    [addressLine2Label setText:al2];
    [NSStringUtilsDemo setEditTextUILabelStyle:addressLine2Label];
    [scrollView addSubview:addressLine2Label];
    
    //Country
    custCountry = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custAddress2.frame.origin.y + custAddress2.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custCountry];
    [scrollView addSubview:custCountry];
    
    NSString *cnt = [LabelUtils getLabelForKey:@"country"];
    CGSize cntSize = [NSStringUtilsDemo getUILabelSizeFromLabel:cnt size:11];
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(custCountry.frame.origin.x + 15, custCountry.frame.origin.y - cntSize.height/2, cntSize.width, cntSize.height)];
    [countryLabel setText:cnt];
    [NSStringUtilsDemo setEditTextUILabelStyle:countryLabel];
    [scrollView addSubview:countryLabel];
    
    //State
    custState = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custCountry.frame.origin.y + custCountry.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custState];
    [scrollView addSubview:custState];
    
    NSString *st = [LabelUtils getLabelForKey:@"state"];
    CGSize stSize = [NSStringUtilsDemo getUILabelSizeFromLabel:st size:11];
//    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(custCountry.frame.origin.x + 15, custState.frame.origin.y - ((height/100)*2), [NSStringUtilsDemo getUILabelWidthFromLabel:st size:11], ((height/100)*4))];
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(custState.frame.origin.x + 15, custState.frame.origin.y - stSize.height/2, stSize.width, stSize.height)];
    [stateLabel setText:st];
    [NSStringUtilsDemo setEditTextUILabelStyle:stateLabel];
    [scrollView addSubview:stateLabel];
    
    //City
    custCity = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custState.frame.origin.y + custState.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custCity];
    [scrollView addSubview:custCity];
    
    NSString *city = [LabelUtils getLabelForKey:@"city"];
    CGSize citySize = [NSStringUtilsDemo getUILabelSizeFromLabel:city size:11];
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(custCity.frame.origin.x + 15, custCity.frame.origin.y - citySize.height/2, citySize.width, citySize.height)];
    [cityLabel setText:city];
    [NSStringUtilsDemo setEditTextUILabelStyle:cityLabel];
    [scrollView addSubview:cityLabel];
    
    //Postal Code
    custPostalCode = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custCity.frame.origin.y + custCity.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:custPostalCode];
    [scrollView addSubview:custPostalCode];
    
    NSString *postalCode = [LabelUtils getLabelForKey:@"postal_code"];
    CGSize postalCodeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:postalCode size:11];
    UILabel *postalCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(custPostalCode.frame.origin.x + 15, custPostalCode.frame.origin.y - postalCodeSize.height/2, postalCodeSize.width, postalCodeSize.height)];
    [postalCodeLabel setText:postalCode];
    [NSStringUtilsDemo setEditTextUILabelStyle:postalCodeLabel];
    [scrollView addSubview:postalCodeLabel];

    //Form Id
    formIdField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, custPostalCode.frame.origin.y + custPostalCode.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:formIdField];
    [scrollView addSubview:formIdField];
    
    NSString *formId = [LabelUtils getLabelForKey:@"previous_formid"];
    CGSize formIdLabelSize = [NSStringUtilsDemo getUILabelSizeFromLabel:formId size:11];
    UILabel *formIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(formIdField.frame.origin.x + 15, formIdField.frame.origin.y - formIdLabelSize.height/2, formIdLabelSize.width, formIdLabelSize.height)];
    [formIdLabel setText:formId];
    [NSStringUtilsDemo setEditTextUILabelStyle:formIdLabel];
    [scrollView addSubview:formIdLabel];
    
    //Form key
    int x = (width/100) * 7;
    int remainingWidth = width - x;
    formKeyField = [[UITextField alloc] initWithFrame:CGRectMake(x, formIdField.frame.origin.y + formIdField.frame.size.height + (height/100)*3 , remainingWidth*0.40, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:formKeyField];
    [scrollView addSubview:formKeyField];
    
    NSString *formKey = [LabelUtils getLabelForKey:@"form_key"];
    CGSize formKeyLabelSize = [NSStringUtilsDemo getUILabelSizeFromLabel:formKey size:11];
    UILabel *formKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake((formKeyField.frame.origin.x + 15)/2+14, formKeyField.frame.origin.y - formKeyLabelSize.height/2, formKeyLabelSize.width/2+30, formKeyLabelSize.height)];
    [formKeyLabel setText:formKey];
    [NSStringUtilsDemo setEditTextUILabelStyle:formKeyLabel];
    [scrollView addSubview:formKeyLabel];
    
    //Form value
    formValueField = [[UITextField alloc] initWithFrame:CGRectMake(formKeyField.frame.origin.x + formKeyField.frame.size.width + 10, formIdField.frame.origin.y + formIdField.frame.size.height + (height/100)*3 , remainingWidth*0.40, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:formValueField];
    [scrollView addSubview:formValueField];
    
    NSString *formValue = [LabelUtils getLabelForKey:@"form_value"];
    CGSize formValueLabelSize = [NSStringUtilsDemo getUILabelSizeFromLabel:formKey size:11];
    UILabel *formValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(formValueField.frame.origin.x + 10, formValueField.frame.origin.y - formValueLabelSize.height/2, formValueLabelSize.width/2+50, formValueLabelSize.height)];
    [formValueLabel setText:formValue];
    [NSStringUtilsDemo setEditTextUILabelStyle:formValueLabel];
    [scrollView addSubview:formValueLabel];
    
    addFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addFieldButton setFrame:CGRectMake(formValueField.frame.origin.x + formValueField.frame.size.width , formValueField.frame.origin.y, remainingWidth*0.20, formValueField.frame.size.height)];
    [addFieldButton setImage:[UIImage imageNamed:@"addsnippet.png"] forState:UIControlStateNormal];
    [addFieldButton addTarget:self action:@selector(addFieldBtn:) forControlEvents:UIControlEventTouchUpInside];
    addFieldButton.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:addFieldButton];
    
    //create the table view for List view
    myTableView= [[UITableView alloc] initWithFrame:CGRectMake((width/100) * 7,formKeyField.frame.origin.y + formKeyField.frame.size.height + (height/100)*3, width - (width/100)*14, (height/100)*7+100) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    [myTableView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [myTableView setHidden:true];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scrollView addSubview:myTableView];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(myTableView.frame.origin.x, scrollView.frame.origin.y + scrollView.frame.size.height + (height/100)*2, (myTableView.frame.size.width/100)*45, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (custCity.frame.size.width/100)*5, backBtn.frame.origin.y , backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    //Adding (height/100)*35 for Keypad height
    [scrollView setContentSize:CGSizeMake(width, formValueField.frame.origin.y + formValueField.frame.size.height + (height/100)*3 + (height/100)*30)];
    
    if(620 == [ArrayObjectController getServiceId] || 660 == [ArrayObjectController getServiceId]) {
        [scrollView setUserInteractionEnabled:false];
    }
    
//    NSString *uCustName = [self retrieveSetting:@"Customer_Name"];
//    NSString *uCustNo = [self retrieveSetting:@"Unique_Customer_Number"];
//    NSString *uMerNo = [self retrieveSetting:@"Unique_Merchant_Number"];
//    NSString *custType = [self retrieveSetting:@"Customer_Type"];
//    NSString *custAttr = [self retrieveSetting:@"Customer_Attribute"];
//    NSString *custPhone = [self retrieveSetting:@"Customer_Phone"];
//    NSString *custEmail = [self retrieveSetting:@"Customer_Email"];
//    NSString *uEmpCode = [self retrieveSetting:@"Unique_Employee_Code"];
//    NSString *uEmpNo = [self retrieveSetting:@"Unique_Employee_Number"];
//    NSString *oldCustNo = [self retrieveSetting:@"Old_Client_Customer_Number"];
//    NSString *add1 = [self retrieveSetting:@"AddressLine1"];
//    NSString *add2 = [self retrieveSetting:@"AddressLine2"];
//    NSString *state = [self retrieveSetting:@"State"];
//    NSString *country = [self retrieveSetting:@"Country"];
//
//    [customerNameTextView setText:uCustName];
//    [uniqueCustNoTextView setText:uCustNo];
//    [uniqueMerNoTextView setText:uMerNo];
//    //[serviceIdTextView setText:serID];
//    [custTypeTextView setText:custType];
//    [custAttributeTextView setText:custAttr];
//    [custPhonenoTextView setText:custPhone];
//    [custEmailTextView setText:custEmail];
//    [uniqueEmpCodeTextView setText:uEmpCode];
//    [uniqueEmpNoTextView setText:uEmpNo];
//    [oldCustNoTextView setText:oldCustNo];
//    [custAddress1 setText:add1];
//    [custAddress2 setText:add2];
//    [custState setText:state];
//    [custCountry setText:country];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [custGender resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == custGender){
        selectedPickerData = genderFieldPickerData;
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
    return [selectedPickerData count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [selectedPickerData objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    
    if([selectedPickerData isEqualToArray:genderFieldPickerData]){
        [custGender setText:genderFieldPickerData[row]];
        [custGender setTag:row+1];
    }
}
//Picker Changes End
-(void)manualReviewToggleBtn:(UIButton*)button {
    if(isManualReviewRequired) {
        isManualReviewRequired = false;
        [toggleManualRevButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isManualReviewRequired = true;
        [toggleManualRevButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)byPassAgeValidToggleBtn:(UIButton*)button {
    if(isByPassAgeValidation) {
        isByPassAgeValidation = false;
        [toggleByPassAgeValidButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isByPassAgeValidation = true;
        [toggleByPassAgeValidButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)byPassNameMatchToggleBtn:(UIButton*)button {
    if(isByPassNameMatching) {
        isByPassNameMatching = false;
        [toggleByPassNameMatchButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isByPassNameMatching = true;
        [toggleByPassNameMatchButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)addFieldBtn:(UIButton*)button {
    NSString *formKey = [formKeyField text];
    NSString *formValue = [formValueField text];
    
    if(![NSStringUtils stringIsNilOrEmpty:formKey] && ![NSStringUtils stringIsNilOrEmpty:formValue]){
        //populate item on list view
        [self populateKeyValueData:formKey value:formValue];
        
        [formKeyField setText:@""];
        [formValueField setText:@""];
        
        //reload list item
        [myTableView reloadData];
        
        if(keyValueList!=nil && [keyValueList count] > 0){
            [myTableView setHidden:false];
        }else{
             [myTableView setHidden:true];
        }
    }
}

-(void)dedublicationToggleBtn:(UIButton*)button {
    if(isDedublicationRequired) {
        isDedublicationRequired = false;
        [toggDedublicationReqButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isDedublicationRequired = true;
        [toggDedublicationReqButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)needImmediateResponseToggleBtn:(UIButton*)button {
    if(isNeedImmediateResponse) {
        isNeedImmediateResponse = false;
        [toggNeedImmediateResponseButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isNeedImmediateResponse = true;
        [toggNeedImmediateResponseButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)captureSecondaryImageToggleBtn:(UIButton*)button {
    if(isCaptureSecondaryImage) {
        isCaptureSecondaryImage = false;
        [captureSecondaryImageButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        isCaptureSecondaryImage = true;
        [captureSecondaryImageButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
    [AppItSDK setCallExecutionParameter:[self getCallExecutionParameterJSON]];
    
    int service_id = [ArrayObjectController getServiceId];
//    if(service_id == 360 || service_id == 361 || service_id == 30 || service_id == 55 || service_id == 165) {
    if(service_id == 360 || service_id == 361 || service_id == 30 || service_id == 165) {
        [ArrayObjectController setAdditionalDataDictionary:[self getAdditionalDataDictionary]];
        RootPageViewController *controller = [ArrayObjectController getPageDelegate];
        [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
    } else {
        FinalStepController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalStepController"];
//        controller.getAdditionalDataDictionary = [self getAdditionalDataDictionary];
        [ArrayObjectController setAdditionalDataDictionary:[self getAdditionalDataDictionary]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(NSMutableDictionary*)getAdditionalDataDictionary{
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *custName = [customerNameTextView text];
    NSString *uniqueCustNo = [uniqueCustNoTextView text];
    NSString *uniqueMerNo = [uniqueMerNoTextView text];
//    NSString *serviceId = [serviceIdTextView text];
    int serviceId = [ArrayObjectController getServiceId];
//    if([@"330" isEqualToString:serviceId]) {
//        if(![ArrayObjectController getEnableCaptureEmployee]) {
//            serviceId = @"310";
//        } else {
//            serviceId = @"330";
//        }
//    }
//
//    if([@"320" isEqualToString:serviceId]) {
//        if(![ArrayObjectController getEnableCaptureEmployee]) {
//            serviceId = @"60";
//        } else {
//            serviceId = @"320";
//        }
//    }
    
    NSString *custType = [custTypeTextView text];
    NSString *custAttribute = [custAttributeTextView text];
    NSString *custPhoneno = [custPhonenoTextView text];
    NSString *custEmail = [custEmailTextView text];
    NSString *uniqueEmpCode = [uniqueEmpCodeTextView text];
    NSString *uniqueEmpNo = [uniqueEmpNoTextView text];
    NSString *oldCustNo = [oldCustNoTextView text];
    
    NSString *address1 = [custAddress1 text];
    NSString *address2 = [custAddress2 text];
    NSString *state= [custState text];
    NSString *country = [custCountry text];
    NSString *gender = [custGender text];
    NSString *city = [custCity text];
    NSString *postalCode = [custPostalCode text];
    NSString *previousFormID = [formIdField text];

    
    /**************************
     * Add keys without spaces
     **************************/
    if(![NSStringUtilsDemo stringIsNilOrEmpty:custName]){
        [nsDict setObject:custName forKey:@"Customer_Name"];
        [self saveSetting:@"Customer_Name" value:custName];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:uniqueCustNo]){
        [nsDict setObject:uniqueCustNo forKey:@"Unique_Customer_Number"];
        [self saveSetting:@"Unique_Customer_Number" value:uniqueCustNo];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:uniqueMerNo]){
        [nsDict setObject:uniqueMerNo forKey:@"Unique_Merchant_Number"];
        [self saveSetting:@"Unique_Merchant_Number" value:uniqueMerNo];
    }
    
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:serviceId]){
        [nsDict setObject:@(serviceId).stringValue forKey:@"Service_ID"];
       // [self saveSetting:@"Service_ID" value:serviceId];
//    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:custType]){
        [nsDict setObject:custType forKey:@"Customer_Type"];
        [self saveSetting:@"Customer_Type" value:custType];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:custAttribute]){
        [nsDict setObject:custAttribute forKey:@"Customer_Attribute"];
        [self saveSetting:@"Customer_Attribute" value:custAttribute];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:custPhoneno]){
        [nsDict setObject:custPhoneno forKey:@"Customer_Phone"];
        [self saveSetting:@"Customer_Phone" value:custPhoneno];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:custEmail]){
        [nsDict setObject:custEmail forKey:@"Customer_Email"];
        [self saveSetting:@"Customer_Email" value:custEmail];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:uniqueEmpCode]){
        [nsDict setObject:uniqueEmpCode forKey:@"Unique_Employee_Code"];
        [self saveSetting:@"Unique_Employee_Code" value:uniqueEmpCode];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:uniqueEmpNo]){
        [nsDict setObject:uniqueEmpNo forKey:@"Unique_Employee_Number"];
        [self saveSetting:@"Unique_Employee_Number" value:uniqueEmpNo];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:oldCustNo]){
        [nsDict setObject:oldCustNo forKey:@"Old_Client_Customer_Number"];
        [self saveSetting:@"Old_Client_Customer_Number" value:oldCustNo];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:address1]){
        [nsDict setObject:address1 forKey:@"AddressLine1"];
        [self saveSetting:@"AddressLine1" value:address1];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:address2]){
        [nsDict setObject:address2 forKey:@"AddressLine2"];
        [self saveSetting:@"AddressLine2" value:address2];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:state]){
        [nsDict setObject:state forKey:@"State"];
        [self saveSetting:@"State" value:state];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:country]){
        [nsDict setObject:country forKey:@"Country"];
        [self saveSetting:@"Country" value:country];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:gender]){
        [nsDict setObject:gender forKey:@"Customer_Gender"];
        [self saveSetting:@"Customer_Gender" value:gender];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:postalCode]){
        [nsDict setObject:postalCode forKey:@"Postal_Code"];
        [self saveSetting:@"Postal_Code" value:postalCode];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:previousFormID]){
        [nsDict setObject:previousFormID forKey:@"PreviousFormId"];
        [self saveSetting:@"PreviousFormId" value:previousFormID];
    }
    if(![NSStringUtilsDemo stringIsNilOrEmpty:city]){
        [nsDict setObject:city forKey:@"City"];
        [self saveSetting:@"City" value:city];
    }
    
    if(keyValueList!=nil && [keyValueList count] > 0){
        for (int i = 0; i < [keyValueList count]; i++) {
            KeyValue *keyValueObj = [[KeyValue alloc] init];
            keyValueObj = [keyValueList objectAtIndex:i];
            
            NSString *formKey=keyValueObj.key;
            NSString *formValue=keyValueObj.value;
            
            if(![NSStringUtilsDemo stringIsNilOrEmpty:formKey] && ![NSStringUtilsDemo stringIsNilOrEmpty:formValue]){
                [nsDict setObject:formValue forKey:formKey];
                [self saveSetting:formKey value:formValue];
            }
        }
    }
    
    [nsDict setObject:isManualReviewRequired ? @"Y" : @"N" forKey:@"Manual_Review_Required"];
    
    [nsDict setObject:isByPassAgeValidation ? @"Y" : @"N" forKey:@"Bypass_Age_Validation"];
    
    [nsDict setObject:isByPassNameMatching ? @"Y" : @"N" forKey:@"Bypass_Name_Matching"];
    
    [nsDict setObject:isDedublicationRequired ? @"Y" : @"N" forKey:@"Deduplication_Required"];
    
    [nsDict setObject:isNeedImmediateResponse ? @"Y" : @"N" forKey:@"Need_Immediate_Response"];
    
    [nsDict setObject:isCaptureSecondaryImage ? @"Y" : @"N" forKey:@"Capture_Secondary_ID"];
    
    if([nsDict count] > 0){
        return nsDict;
    }
    return nil;
}


-(NSMutableDictionary*)getCallExecutionParameterJSON{
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    int serviceId = [ArrayObjectController getServiceId];
    
    [nsDict setObject:@(serviceId).stringValue forKey:@"Service_ID"];
    [nsDict setObject:isManualReviewRequired ? @"Y" : @"N" forKey:@"Manual_Review_Required"];
    [nsDict setObject:isByPassAgeValidation ? @"Y" : @"N" forKey:@"Bypass_Age_Validation"];
    [nsDict setObject:isByPassNameMatching ? @"Y" : @"N" forKey:@"Bypass_Name_Matching"];
    [nsDict setObject:isDedublicationRequired ? @"Y" : @"N" forKey:@"Deduplication_Required"];
    [nsDict setObject:isNeedImmediateResponse ? @"Y" : @"N" forKey:@"Need_Immediate_Response"];
    
//    [nsDict setObject:@"30" forKey:@"Service_ID"];
//    [nsDict setObject:false ? @"Y" : @"N" forKey:@"Manual_Review_Required"];
//    [nsDict setObject:false ? @"Y" : @"N" forKey:@"Bypass_Age_Validation"];
//    [nsDict setObject:true ? @"Y" : @"N" forKey:@"Bypass_Name_Matching"];
//    [nsDict setObject:true ? @"Y" : @"N" forKey:@"Deduplication_Required"];
    
    if([nsDict count] > 0){
        return nsDict;
    }
    return nil;
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

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
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

//create mutable array to hold list of countries that will be displayed
- (void) populateKeyValueData:(NSString *)key value:(NSString *)_value {

    KeyValue *keyValue = [[KeyValue alloc] initWithCode:key value:_value];
    [keyValueList addObject:keyValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger )section {
    if(section == 0) {
        return 6;
    } else {
        return 1.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

//asks the data source to return the number of rows in a given section of a table view
//we are returning the number of countries in a given continent
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%@",@"Called number of Rows in a Section");
    NSInteger numberOfRows = 0;
    
    if ([tableView isEqual:myTableView]){
        numberOfRows = keyValueList.count;
    }
    return numberOfRows;
}

- (void) removeListRecord:(UIButton *)sender {
    
    UITableViewCell *ownerCell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [myTableView indexPathForCell:ownerCell];
    
    KeyValue *keyValueObj = [[KeyValue alloc] init];
    keyValueObj = [keyValueList objectAtIndex:indexPath.row];
     //NSLog(@"KEY VALUE is %i %@ %@", indexPath.row, keyValueObj.key, keyValueObj.value);
    
    [keyValueList removeObject:keyValueObj];
    
    NSMutableArray *keyValueListCopy =  keyValueList;
    keyValueList = nil;
    [myTableView reloadData];
    
    keyValueList = keyValueListCopy;
    [myTableView reloadData];
    
    if(keyValueList!=nil && [keyValueList count] > 0){
        [myTableView setHidden:false];
    }else{
        [myTableView setHidden:true];
    }
}

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat result = 20.0f;
    if ([tableView isEqual:myTableView]){
        result = 30.0f;
    }
    return result;
    
}

//asks the data source for a cell to insert in a particular location of the table view
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",@"Render cell at a given Index Path Section and Row");
    UITableViewCell *myCellView = nil;
    UILabel *keyLabel, *valueLabel;
    UIButton *recordRemoveImageView;
    
    if ([tableView isEqual:myTableView]){
        
        static NSString *TableViewCellIdentifier = @"KeyValueCell";
        myCellView = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
//        if (myCellView == nil){
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            
            myCellView = [[UITableViewCell alloc]
                          initWithStyle:UITableViewCellStyleDefault
                          reuseIdentifier:TableViewCellIdentifier];
            
            [myCellView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];

            //create custom labels and button inside the cell view
            //CGRect myFrame = CGRectMake(10.0, 0.0, 220, 25.0);
//            keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(((width/100) * 7)/2, 0.0, ((width - (width/100)*14)/2)-20, 25.0)];
        keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(((width/100) * 7)/2, 0.0, width*0.30, 25.0)];
            //keyLabel = [[UILabel alloc] initWithFrame:myFrame];
            //keyLabel.tag = KEY_TAG;
           // keyLabel.font = [UIFont boldSystemFontOfSize:17.0];
            keyLabel.backgroundColor = [UIColor clearColor];
            [myCellView.contentView addSubview:keyLabel];
            
//            valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(((width/100) * 7)/2+(width-width/2)-20, 0 , ((width - (width/100)*14)/2)-20, 25.0)];
            valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(((width/100) * 7)/2+(width-width/2)-20, 0 , width*0.30, 25.0)];
            //myFrame.origin.y += 25;
            //valueLabel = [[UILabel alloc] initWithFrame:myFrame];
            // valueLabel.tag = VALUE_TAG;
            //valueLabel.font = [UIFont systemFontOfSize:17.0];
            valueLabel.backgroundColor = [UIColor clearColor];
            [myCellView.contentView addSubview:valueLabel];
            
            recordRemoveImageView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            recordRemoveImageView.frame = CGRectMake(valueLabel.frame.origin.x + valueLabel.frame.size.width, 5.0, 25.0, 25.0);
        recordRemoveImageView.frame = CGRectMake(valueLabel.frame.origin.x + valueLabel.frame.size.width, 0.0, width*0.10, 25.0);
          //  [recordRemoveImageView setFrame:CGRectMake(valueLabel.frame.origin.x + valueLabel.frame.size.width + (width/100)*3-5, 10.0, (width/100)*10, 25.0)];
            UIImage *cancel = [UIImage imageNamed:@"snippet_cancel.png"];
            [recordRemoveImageView setImage:cancel forState:UIControlStateNormal];
            recordRemoveImageView.contentMode = UIViewContentModeScaleAspectFit;
            [recordRemoveImageView addTarget:self
                                 action:@selector(removeListRecord:)
                       forControlEvents:UIControlEventTouchUpInside];
            recordRemoveImageView.tintColor = [UIColor blackColor];
            [myCellView.contentView addSubview:recordRemoveImageView];
//        }else {
//            keyLabel = (UILabel *)[myCellView.contentView viewWithTag:KEY_TAG];
//            valueLabel = (UILabel *)[myCellView.contentView viewWithTag:VALUE_TAG];
//        }
        
        KeyValue *keyValueObj = [[KeyValue alloc] init];
        keyValueObj = [keyValueList objectAtIndex:indexPath.row];
        
        //populate data from your country object to table view cell
        keyLabel.text = [NSString stringWithFormat:@"%@", keyValueObj.key];
        valueLabel.text = [NSString stringWithFormat:@"%@", keyValueObj.value];
    }
    return myCellView;
}

@end
