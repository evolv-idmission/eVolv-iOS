//
//  DefineProductController.m
//  AppItDepedency
//
//  Created by  on 18/12/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "DefineProductController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "FinalStepController.h"
#import "LabelUtils.h"

@interface DefineProductController ()

@end

@implementation DefineProductController {
    UILabel *titleLabel;
    NSArray *_selectGroupPickerData, *_selectGroupPickerDataValue;
    NSArray *_selectFieldNamePickerData, *_selectFieldNamePickerDataValue;
    NSArray *_selectFieldValuePickerData, *_selectFieldValuePickerDataValue;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    bool isFirstTime;
    NSArray *_selectedPickerData;
    UITextField *selectGroupTextField,*selectFieldNameTextField,*fieldValueTextField,*productConfigTextField;
    UIScrollView *scrollView, *mainPageScrollView;
    NSMutableDictionary *groupNameDict;
    UIView *configureView;
    int counter;
    UIButton *exitConfigureViewBtn;
    UITextField *selectOtherGroupTextField, *selectOtherfieldNameTextField, *selectOtherfieldValueTextField;
    UIButton *addButton;
    UIImageView *downArrowImage,*downArrowFieldNameImage,*downArrowFieldValueImage;
    UIButton *downArrowProductConfigImage;
    UILabel  *selectIdTypeLabel,*selectOtherFieldGroupLabel,*selectFieldNameLabel,*selectOtherFieldNameLabel,*selectFieldValueLabel,*selectOtherFieldValueLabel,*selectConfigValueLabel;
}

-(void)viewDidAppear:(BOOL)animated {
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    _selectGroupPickerData = @[@"ID_Image_Processing", @"Customer_Photo_Processing", @"Employee_Information", @"Proof_Of_Address", @"Biometric_Information", @"Signature_Data", @"OTHER"];
    _selectGroupPickerDataValue = @[@"ID_Image_Processing", @"Customer_Photo_Processing", @"Employee_Information", @"Proof_Of_Address", @"Biometric_Information", @"Signature_Data", @"OTHER"];
    
    _selectFieldNamePickerData = @[@"ID_Type", @"ID_Country", @"ID_State", @"ID_Image_Front", @"ID_Image_Front_Secondary", @"ID_Image_Back", @"ID_Image_Back_Secondary", @"Live_Customer_Photo", @"Live_Customer_Photo_Secondary", @"Customer_Photo_for_Face_Matching", @"Customer_Photo_for_Face_Matching_Secondary", @"Signature_Image", @"Voice_Data", @"OTHER"];
    _selectFieldNamePickerDataValue = @[@"ID_Type", @"ID_Country", @"ID_State", @"ID_Image_Front", @"ID_Image_Front_Secondary", @"ID_Image_Back", @"ID_Image_Back_Secondary", @"Live_Customer_Photo", @"Live_Customer_Photo_Secondary", @"Customer_Photo_for_Face_Matching", @"Customer_Photo_for_Face_Matching_Secondary", @"Signature_Image", @"Voice_Data", @"OTHER"];
    
    _selectFieldValuePickerData = @[@"FRONT_IMAGE", @"BACK_IMAGE", @"FACE_IMAGE", @"PROCESSED_FACE_IMAGE", @"OVAL_FACE_IMAGE", @"SIGNATURE_IMAGE", @"VOICE_DATA", @"FINGERPRINT_DATA", @"OTHER"];
    _selectFieldValuePickerDataValue = @[@"FRONT_IMAGE", @"BACK_IMAGE", @"FACE_IMAGE", @"PROCESSED_FACE_IMAGE", @"OVAL_FACE_IMAGE", @"SIGNATURE_IMAGE", @"VOICE_DATA", @"FINGERPRINT_DATA", @"OTHER"];
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    
    [selectGroupTextField setDelegate:(id)self];
    [selectFieldNameTextField setDelegate:(id)self];
    [fieldValueTextField setDelegate:(id)self];
    [productConfigTextField setDelegate:(id)self];
    
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    // myPickerView.layer.borderWidth = 1.0;
    // myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    
    [selectGroupTextField setInputView:myPickerView];
    [selectFieldNameTextField setInputView:myPickerView];
    [fieldValueTextField setInputView:myPickerView];
    
    [selectGroupTextField setInputAccessoryView:toolbarForPicker];
    [selectFieldNameTextField setInputAccessoryView:toolbarForPicker];
    [fieldValueTextField setInputAccessoryView:toolbarForPicker];
    
    [selectGroupTextField setText:_selectGroupPickerData[0]];
    [selectFieldNameTextField setText:_selectFieldNamePickerData[0]];
    [fieldValueTextField setText:_selectFieldValuePickerData[0]];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    
    [selectGroupTextField resignFirstResponder];
    [selectFieldNameTextField resignFirstResponder];
    [fieldValueTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectGroupTextField){
        _selectedPickerData = _selectGroupPickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == selectFieldNameTextField){
        _selectedPickerData = _selectFieldNamePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == fieldValueTextField){
        _selectedPickerData = _selectFieldValuePickerData;
        [myPickerView reloadAllComponents];
    } else if(textField == productConfigTextField) {
        [self showConfigurationList];
        return NO;
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
    if([_selectedPickerData isEqualToArray:_selectGroupPickerData]){
        [selectGroupTextField setText:_selectGroupPickerData[row]];
        [selectGroupTextField setTag:row+1];
        if([@"OTHER" isEqualToString:[selectGroupTextField text]]) {
            [selectOtherGroupTextField setUserInteractionEnabled:YES];
        } else {
            [selectOtherGroupTextField setUserInteractionEnabled:NO];
        }
    }
    if([_selectedPickerData isEqualToArray:_selectFieldNamePickerData]){
        [selectFieldNameTextField setText:_selectFieldNamePickerData[row]];
        [selectFieldNameTextField setTag:row+1];
        if([@"OTHER" isEqualToString:[selectFieldNameTextField text]]) {
            [selectOtherfieldNameTextField setUserInteractionEnabled:YES];
        } else {
            [selectOtherfieldNameTextField setUserInteractionEnabled:NO];
        }
    }
    if([_selectedPickerData isEqualToArray:_selectFieldValuePickerData]){
        [fieldValueTextField setText:_selectFieldValuePickerData[row]];
        [fieldValueTextField setTag:row+1];
        if([@"OTHER" isEqualToString:[fieldValueTextField text]]) {
            [selectOtherfieldValueTextField setUserInteractionEnabled:YES];
        } else {
            [selectOtherfieldValueTextField setUserInteractionEnabled:NO];
        }
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    counter = 1;
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    [titleLabel setText:[LabelUtils getLabelForKey:@"define_product_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    mainPageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, slideView.frame.origin.y + slideView.frame.size.height + (height/100)*1, width, [ArrayObjectController getPageControlY] - (height/100)*8 - (height/100)*3 - slideView.frame.origin.y - slideView.frame.size.height)];
    mainPageScrollView.showsVerticalScrollIndicator=YES;
    [mainPageScrollView setScrollEnabled:YES];
    [mainPageScrollView setShowsHorizontalScrollIndicator:YES];
    [mainPageScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:mainPageScrollView];
    
    //Select Group Type
     selectGroupTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*2 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectGroupTextField];
    [mainPageScrollView addSubview:selectGroupTextField];
    [selectGroupTextField setText:@"ID_Image_Processing"];
    
    //Down Arrow Image
    downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectGroupTextField.frame.origin.x + selectGroupTextField.frame.size.width - (width/100)*9 , selectGroupTextField.frame.origin.y + (selectGroupTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [mainPageScrollView addSubview:downArrowImage];
    
    NSString *selectIDtypecn =[LabelUtils getLabelForKey:@"select_group"];
    CGSize selectIDtypeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDtypecn size:14];
    selectIdTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectGroupTextField.frame.origin.x + 15, selectGroupTextField.frame.origin.y - (selectIDtypeSize.height/2), selectIDtypeSize.width, selectIDtypeSize.height)];
    [selectIdTypeLabel setText:selectIDtypecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdTypeLabel];
    [mainPageScrollView addSubview:selectIdTypeLabel];
    
    //Select Group
    selectOtherGroupTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectGroupTextField.frame.origin.y + selectGroupTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectOtherGroupTextField];
    [selectOtherGroupTextField setUserInteractionEnabled:NO];
    [mainPageScrollView addSubview:selectOtherGroupTextField];
    
    NSString *selectOtherFieldGroupcn = [LabelUtils getLabelForKey:@"enter_group_name"];
    CGSize selectOtherFieldGroupSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectOtherFieldGroupcn size:14];
    selectOtherFieldGroupLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectOtherGroupTextField.frame.origin.x + 15, selectOtherGroupTextField.frame.origin.y - (selectOtherFieldGroupSize.height/2), selectOtherFieldGroupSize.width, selectOtherFieldGroupSize.height)];
    [selectOtherFieldGroupLabel setText:selectOtherFieldGroupcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectOtherFieldGroupLabel];
    [mainPageScrollView addSubview:selectOtherFieldGroupLabel];
    
    //Select Field Name
    selectFieldNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectOtherGroupTextField.frame.origin.y + selectOtherGroupTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectFieldNameTextField];
    [mainPageScrollView addSubview:selectFieldNameTextField];
    
    //Down Arrow Image
    downArrowFieldNameImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectFieldNameTextField.frame.origin.x + selectFieldNameTextField.frame.size.width - (width/100)*9 , selectFieldNameTextField.frame.origin.y + (selectFieldNameTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowFieldNameImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [mainPageScrollView addSubview:downArrowFieldNameImage];
    
    NSString *selectFieldNamecn = [LabelUtils getLabelForKey:@"select_field_name"];
    CGSize selectFieldNameSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectFieldNamecn size:14];
    selectFieldNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectFieldNameTextField.frame.origin.x + 15, selectFieldNameTextField.frame.origin.y - (selectFieldNameSize.height/2), selectFieldNameSize.width, selectFieldNameSize.height)];
    [selectFieldNameLabel setText:selectFieldNamecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectFieldNameLabel];
    [mainPageScrollView addSubview:selectFieldNameLabel];
   
    //Field Name
    selectOtherfieldNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectFieldNameTextField.frame.origin.y + selectFieldNameTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectOtherfieldNameTextField];
    [selectOtherfieldNameTextField setUserInteractionEnabled:NO];
    [mainPageScrollView addSubview:selectOtherfieldNameTextField];
    
    NSString *selectOtherFieldNamecn = [LabelUtils getLabelForKey:@"enter_field_name"];
    CGSize selectOtherFieldNameSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectOtherFieldNamecn size:14];
    selectOtherFieldNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectOtherfieldNameTextField.frame.origin.x + 15, selectOtherfieldNameTextField.frame.origin.y - (selectOtherFieldNameSize.height/2), selectOtherFieldNameSize.width, selectOtherFieldNameSize.height)];
    [selectOtherFieldNameLabel setText:selectOtherFieldNamecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectOtherFieldNameLabel];
    [mainPageScrollView addSubview:selectOtherFieldNameLabel];
    
    //Field Value
    fieldValueTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectOtherfieldNameTextField.frame.origin.y + selectOtherfieldNameTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:fieldValueTextField];
    [mainPageScrollView addSubview:fieldValueTextField];
    
    downArrowFieldValueImage = [[UIImageView alloc] initWithFrame:CGRectMake(fieldValueTextField.frame.origin.x + fieldValueTextField.frame.size.width - (width/100)*9 , fieldValueTextField.frame.origin.y + (fieldValueTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowFieldValueImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [mainPageScrollView addSubview:downArrowFieldValueImage];
    
    NSString *selectFieldValuecn = [LabelUtils getLabelForKey:@"select_field_value"];
    CGSize selectFieldValueSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectFieldValuecn size:14];
    selectFieldValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(fieldValueTextField.frame.origin.x + 15, fieldValueTextField.frame.origin.y - (selectFieldValueSize.height/2), selectFieldValueSize.width, selectFieldValueSize.height)];
    [selectFieldValueLabel setText:selectFieldValuecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectFieldValueLabel];
    [mainPageScrollView addSubview:selectFieldValueLabel];
    
    //Other Field Value
    selectOtherfieldValueTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,fieldValueTextField.frame.origin.y + fieldValueTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectOtherfieldValueTextField];
    [selectOtherfieldValueTextField setUserInteractionEnabled:NO];
    [mainPageScrollView addSubview:selectOtherfieldValueTextField];
    
    NSString *selectOtherFieldValuecn = [LabelUtils getLabelForKey:@"enter_field_value"];
    CGSize selectOtherFieldValueSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectOtherFieldValuecn size:14];
    selectOtherFieldValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectOtherfieldValueTextField.frame.origin.x + 15, selectOtherfieldValueTextField.frame.origin.y - (selectOtherFieldValueSize.height/2), selectOtherFieldValueSize.width, selectOtherFieldValueSize.height)];
    [selectOtherFieldValueLabel setText:selectOtherFieldValuecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectOtherFieldValueLabel];
    [mainPageScrollView addSubview:selectOtherFieldValueLabel];
    
    // Add Button
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(selectOtherfieldValueTextField.frame.origin.x, selectOtherfieldValueTextField.frame.origin.y + selectOtherfieldValueTextField.frame.size.height + (height/100)*3, selectOtherfieldValueTextField.frame.size.width, (height/100)*6);
    [addButton setFrame:frame];
    addButton.layer.cornerRadius = 20;
    addButton.clipsToBounds = YES;
    [addButton setTitle:[LabelUtils getLabelForKey:@"add"] forState:UIControlStateNormal];
    addButton.titleLabel.textColor = [UIColor whiteColor];
    [addButton setBackgroundColor:[UIColor blackColor]];
    [addButton addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [mainPageScrollView addSubview:addButton];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(fieldValueTextField.frame.origin.x,[ArrayObjectController getPageControlY] - (height/100)*8, (fieldValueTextField.frame.size.width/100)*45, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (fieldValueTextField.frame.size.width/100)*5, backBtn.frame.origin.y , backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    //Product Config Text Field
    productConfigTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,addButton.frame.origin.y + addButton.frame.size.height + (height/100)*3 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:productConfigTextField];
    //[productConfigTextField addTarget:self
    //              action:@selector(productConfigClick:)
    //    forControlEvents:UIControlEventAllTouchEvents];
    [mainPageScrollView addSubview:productConfigTextField];
    
    downArrowProductConfigImage = [[UIButton alloc] initWithFrame:CGRectMake(productConfigTextField.frame.origin.x + productConfigTextField.frame.size.width - (width/100)*9 , productConfigTextField.frame.origin.y + (productConfigTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowProductConfigImage setImage:[UIImage imageNamed:@"drop_down.png"] forState:UIControlStateNormal];
    [downArrowProductConfigImage addTarget:self action:@selector(productConfigClick:) forControlEvents:UIControlEventTouchUpInside];
    [downArrowProductConfigImage setContentMode:UIViewContentModeScaleAspectFill];
    [mainPageScrollView addSubview:downArrowProductConfigImage];
    
    NSString *selectProductConfigcn = [LabelUtils getLabelForKey:@"product_config"];
    CGSize selectProductConfigSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectProductConfigcn size:14];
    selectConfigValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(productConfigTextField.frame.origin.x + 15, productConfigTextField.frame.origin.y - (selectFieldValueSize.height/2), selectProductConfigSize.width, selectProductConfigSize.height)];
    [selectConfigValueLabel setText:selectProductConfigcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectConfigValueLabel];
    [mainPageScrollView addSubview:selectConfigValueLabel];
    
    configureView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*10, (height/100)*10, (width/100)*80, [ArrayObjectController getPageControlY] - (height/100)*20)];
    [configureView setBackgroundColor:[UIColor whiteColor]];
    [mainPageScrollView addSubview:configureView];
    [configureView setHidden:YES];

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, configureView.frame.size.width, configureView.frame.size.height)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [configureView addSubview:scrollView];
    
    exitConfigureViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitConfigureViewBtn setFrame:CGRectMake(configureView.frame.origin.x + configureView.frame.size.width - (configureView.frame.size.width/100)*10, configureView.frame.origin.y - (configureView.frame.size.width/100)*10, (configureView.frame.size.width/100)*10, (configureView.frame.size.width/100)*10)];
    [exitConfigureViewBtn setImage:[UIImage imageNamed:@"cancelsnippet.png"] forState:UIControlStateNormal];
    [mainPageScrollView addSubview:exitConfigureViewBtn];
    [exitConfigureViewBtn setHidden:YES];
    [exitConfigureViewBtn addTarget:self action:@selector(exitFromConfigureView:) forControlEvents:UIControlEventTouchUpInside];
    [exitConfigureViewBtn setContentMode:UIViewContentModeScaleToFill];
    
    NSMutableDictionary *ID_Image_Processing_Dict = [[NSMutableDictionary alloc] init];
    NSString *IdType, *IdCountry, *IdState;
    IdType = [ArrayObjectController getIdType];
    IdCountry = [ArrayObjectController getCountryType];
    IdState = [ArrayObjectController getStateType];
    
    if(nil == IdType) {
        IdType = @"";
    }
    
    if(nil == IdCountry) {
        IdCountry = @"";
    }
    
    if(nil == IdState) {
        IdState = @"";
    }
     NSMutableDictionary *Customer_Photo_Processing_Dict = [[NSMutableDictionary alloc] init];
    
    int service_id = [ArrayObjectController getServiceId];
    
    if(service_id == 360) {
        [ID_Image_Processing_Dict setObject:IdType forKey:@"ID_Type"];
        [ID_Image_Processing_Dict setObject:IdCountry forKey:@"ID_Country"];
        [ID_Image_Processing_Dict setObject:IdState forKey:@"ID_State"];
        [ID_Image_Processing_Dict setObject:@"FRONT_IMAGE" forKey:@"ID_Image_Front"];
        [ID_Image_Processing_Dict setObject:@"BACK_IMAGE" forKey:@"ID_Image_Back"];
        
        [Customer_Photo_Processing_Dict setObject:@"FACE_IMAGE" forKey:@"Live_Customer_Photo"];
        [Customer_Photo_Processing_Dict setObject:@"FRONT_IMAGE" forKey:@"Customer_Photo_for_Face_Matching"];
    } else if(service_id == 361) {
        [ID_Image_Processing_Dict setObject:IdType forKey:@"ID_Type_Secondary"];
        [ID_Image_Processing_Dict setObject:IdCountry forKey:@"ID_Country_Secondary"];
        [ID_Image_Processing_Dict setObject:IdState forKey:@"ID_State"];
        [ID_Image_Processing_Dict setObject:@"FRONT_IMAGE" forKey:@"ID_Image_Front_Secondary"];
        [ID_Image_Processing_Dict setObject:@"BACK_IMAGE" forKey:@"ID_Image_Back_Secondary"];
        
        [Customer_Photo_Processing_Dict setObject:@"FACE_IMAGE" forKey:@"Live_Customer_Photo_Secondary"];
        [Customer_Photo_Processing_Dict setObject:@"FRONT_IMAGE" forKey:@"Customer_Photo_for_Face_Matching_Secondary"];
    }
    
    groupNameDict = [[NSMutableDictionary alloc] init];
    [groupNameDict setObject:Customer_Photo_Processing_Dict forKey:@"Customer_Photo_Processing"];
    [groupNameDict setObject:ID_Image_Processing_Dict forKey:@"ID_Image_Processing"];
    [productConfigTextField setText:[[groupNameDict allKeys] firstObject]];
     NSLog(@"");
    
    [mainPageScrollView setContentSize:CGSizeMake(mainPageScrollView.frame.size.width,  productConfigTextField.frame.origin.y + productConfigTextField.frame.size.height + (width/100)*3)];
    
}

-(void)productConfigClick:(UIButton*)button {
    NSLog(@"Product Config Text Field click");
    [self showConfigurationList];
}

-(void)showConfigurationList{
    if([configureView isHidden]){
        [configureView setHidden:false];
        [exitConfigureViewBtn setHidden:false];
        [self reloadAllTheViews];
    }else{
        [configureView setHidden:true];
        [exitConfigureViewBtn setHidden:true];
        [self removeAllTheViewFromScrolView];
    }
}

- (IBAction)cancelBtnClicked:(id)sender {
    NSLog(@"Cancel Button Clicked");
    int inte = [sender tag];
    NSArray *subViews = [scrollView subviews];
    for(UIButton *view in subViews) {
        if(inte == [view tag]) {
            NSString *group, *keyField;
            NSString *groupAndKey = [view currentTitle];
            NSString *regEx = [NSString stringWithFormat:@"SEPERATE"];
            NSRange range = [groupAndKey rangeOfString:regEx options:NSRegularExpressionSearch];
            if (range.location != NSNotFound)
            {
                group = [groupAndKey substringToIndex:(range.location+range.length)];
            }
            keyField = [groupAndKey stringByReplacingOccurrencesOfString:group withString:@""];
            group = [group stringByReplacingOccurrencesOfString:@"SEPERATE" withString:@""];
            NSMutableDictionary *keyFieldDictionary = [groupNameDict objectForKey:group];
            [keyFieldDictionary removeObjectForKey:keyField];
            [groupNameDict setObject:keyFieldDictionary forKey:group];
            [self reloadAllTheViews];
     }
   }
}


-(void) removeAllTheViewFromScrolView {
    for (UIView *v in scrollView.subviews) {
        [v removeFromSuperview];
    }
}

-(void) reloadAllTheViews {
    for (UIView *v in scrollView.subviews) {
        [v removeFromSuperview];
    }
    [self addViewToScrollView];
}

-(void) addViewToScrollView {
    __block float endViewPosition = 0;
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    [groupNameDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSMutableDictionary *valueDict = obj;
        NSString *groupKeyValue = key;
        [valueDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            endViewPosition = [self addDataInScrollView:scrollView scrollY:(height/100)*2 + endViewPosition groupName:groupKeyValue fieldType:key fieldValue:obj];
        }];
    }];
    [scrollView setContentSize:CGSizeMake(configureView.frame.size.width,  endViewPosition + (width/100)*3)];
}

-(void)exitFromConfigureView:(UIButton*)button {
    NSLog(@"Exit from Configure View");
    [self reloadAllTheViews];
    [configureView setHidden:YES];
    [exitConfigureViewBtn setHidden:YES];
//    [productConfigTextField setText:[[groupNameDict allKeys] firstObject]];
    NSArray *allKeys = [groupNameDict allKeys];
    for(int i = 0; i<allKeys.count; i++) {
        NSMutableDictionary *fieldAndKeyDict = [groupNameDict objectForKey:allKeys[i]];
        if(fieldAndKeyDict.count > 0) {
            [productConfigTextField setText:allKeys[i]];
            break;
        } else {
            [productConfigTextField setText:@""];
        }
    }
    NSLog(@"JUST To Check");
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    FinalStepController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalStepController"];
//    controller.getAdditionalDataDictionary = [ArrayObjectController getAdditionalDataDictionary];
    controller.customProductDefinationDict = groupNameDict;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)addBtn:(UIButton*)button {
    
    NSString *groupName = @"", *fieldName = @"", *fieldValue = @"";
    
    if([@"OTHER" isEqualToString:[selectGroupTextField text]]) {
        groupName = [[selectOtherGroupTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        groupName = [selectGroupTextField text];
    }
    
    if([@"OTHER" isEqualToString:[selectFieldNameTextField text]]) {
        fieldName = [[selectOtherfieldNameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        fieldName = [selectFieldNameTextField text];
    }
    
    if([@"OTHER" isEqualToString:[fieldValueTextField text]]) {
        fieldValue = [[selectOtherfieldValueTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        fieldValue = [fieldValueTextField text];
    }
    
    if([groupNameDict objectForKey:groupName]){
        NSMutableDictionary *fieldNameValueDict = [groupNameDict objectForKey:groupName];
        [fieldNameValueDict setObject:fieldValue forKey:fieldName];
        [groupNameDict setObject:fieldNameValueDict forKey:groupName];
    } else {
        NSMutableDictionary *fieldNameValueDict = [[NSMutableDictionary alloc] init];
        [fieldNameValueDict setObject:fieldValue forKey:fieldName];
        [groupNameDict setObject:fieldNameValueDict forKey:groupName];
    }
    
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(float)addDataInScrollView:(UIScrollView *)scrollView scrollY:(float)scrollY groupName:(NSString*)groupName fieldType:(NSString*)fieldType fieldValue:(NSString*)fieldValue{
    int width = scrollView.frame.size.width;
    int height = scrollView.frame.size.height;
    
    // GroupNAme
    UILabel *idGroupName = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*2, scrollY, (width/100)*60, (height/100)*4)];
    [idGroupName setText:groupName];
    [idGroupName setFont:[UIFont systemFontOfSize:12]];
   // [idGroupName setTag:counter];
    [scrollView addSubview:idGroupName];
    
    //CancelButton
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(width - (width/100)*4 - (width/100)*8, scrollY, (width/100)*10, (height/100)*6)];
    [cancelButton setImage:[UIImage imageNamed:@"snippet_cancel.png"] forState:UIControlStateNormal];
    [cancelButton setTag:counter];
    NSString *groupAndKey  = groupName;
    groupAndKey = [groupAndKey stringByAppendingString:@"SEPERATE"];
    groupAndKey = [groupAndKey stringByAppendingString:fieldType];
    [cancelButton setTitle:groupAndKey forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setContentMode:UIViewContentModeScaleAspectFit];
    [scrollView addSubview:cancelButton];
    
    //Field Type
    UILabel *fieldTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*2, idGroupName.frame.origin.y + idGroupName.frame.size.height + (height/100)*2, (width/100)*50, (height/100)*4)];
    [fieldTypeLabel setText:fieldType];
   // [fieldTypeLabel setTag:counter];
    [fieldTypeLabel setFont:[UIFont systemFontOfSize:12]];
    [scrollView addSubview:fieldTypeLabel];
    
    //Field Value
    UILabel *fieldValueLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/2), idGroupName.frame.origin.y + idGroupName.frame.size.height + (height/100)*2, (width/100)*60, (height/100)*4)];
    [fieldValueLabel setText:fieldValue];
   // [fieldValueLabel setTag:counter];
    [fieldValueLabel setFont:[UIFont systemFontOfSize:12]];
    [scrollView addSubview:fieldValueLabel];
    
    UIView *addLineView = [[UIView alloc] initWithFrame:CGRectMake(0, fieldValueLabel.frame.origin.y + fieldValueLabel.frame.size.height + (width/100)*5, width, (width/100)*0.2)];
    [addLineView setBackgroundColor:[UIColor grayColor]];
    //[fieldValueLabel setTag:counter];
    [scrollView addSubview:addLineView];
    
    counter++;
    
    return (addLineView.frame.origin.y + addLineView.frame.size.height);
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
