//
//  EmployeeDataViewController.m
//  AppItDepedency
//
//  Created by  on 29/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "EmployeeDataViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "FinalStepController.h"
#import "LabelUtils.h"

@interface EmployeeDataViewController ()

@end

@implementation EmployeeDataViewController {
     UILabel *titleLabel;
     UITextField *employeeCodeTextField, *empLoginIdTextField, *empEmailTextField, *empCompId, *empDeptTextField, *empNameTextField, *empTypeTextField, *genderTextField,
     *empMobileNumb, *empCountryTextField, *maritalStatusTextField, *empAddress1TextField, *empAddress2TextField, *empStateTextField, *empCityTextField, *empZipCodeTextField, *empSpouseNameTextField, *empNoOfChildrenTextField, *empPostalCode;
    NSArray *selectedPickerData;
    NSArray *genderFieldPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
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
    [genderTextField setInputView:myPickerView];
    [genderTextField setInputAccessoryView:toolbarForPicker];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    // [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"IDCaptureBack"]];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"employee_data_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, slideView.frame.origin.y + slideView.frame.size.height + (height/100)*2, width, [ArrayObjectController getPageControlY] - (height/100)*13 - slideView.frame.origin.y - slideView.frame.size.height)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setContentSize:CGSizeMake(width, height + height)];
    [self.view addSubview:scrollView];
    
    //EmployeeCode
    employeeCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*3 , width - (width/100)*14, (height/100)*7)];
//    employeeCodeTextField.textAlignment = UITextAlignmentCenter;
//    employeeCodeTextField.layer.cornerRadius = 5;
//    employeeCodeTextField.layer.borderWidth = 1.0;
//    employeeCodeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [employeeCodeTextField setAlpha:0.7];
//    employeeCodeTextField.borderStyle = UITextBorderStyleNone;
    [NSStringUtilsDemo setEditTextUITextFieldStyle:employeeCodeTextField];
    [scrollView addSubview:employeeCodeTextField];
    
    NSString *employeecn = [LabelUtils getLabelForKey:@"employee_code"];
    CGSize employeeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeecn size:11];
    UILabel *employeeCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(employeeCodeTextField.frame.origin.x + 15, employeeCodeTextField.frame.origin.y - (employeeSize.height/2), employeeSize.width, employeeSize.height)];
    [employeeCodeLabel setText:employeecn];
    [NSStringUtilsDemo setEditTextUILabelStyle:employeeCodeLabel];
    [scrollView addSubview:employeeCodeLabel];
    
    //Employee Type
    empTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, employeeCodeTextField.frame.origin.y + employeeCodeTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empTypeTextField];
    [scrollView addSubview:empTypeTextField];
    
    NSString *employeeTypecn = [LabelUtils getLabelForKey:@"employee_type"];
    CGSize employeeTypeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeTypecn size:11];
    UILabel *empTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(empTypeTextField.frame.origin.x + 15, empTypeTextField.frame.origin.y - (employeeTypeSize.height/2), employeeTypeSize.width, employeeTypeSize.height)];
    [empTypeLabel setText:employeeTypecn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empTypeLabel];
    [scrollView addSubview:empTypeLabel];
    
    //Employee Login ID
    empLoginIdTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empTypeTextField.frame.origin.y + empTypeTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empLoginIdTextField];
    [scrollView addSubview:empLoginIdTextField];
    
    NSString *employeeLoginIdcn = [LabelUtils getLabelForKey:@"employee_login_id"];
    CGSize employeeLoginIdSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeLoginIdcn size:11];
    UILabel *empLoginIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(empLoginIdTextField.frame.origin.x + 15, empLoginIdTextField.frame.origin.y - (employeeLoginIdSize.height/2), employeeLoginIdSize.width, employeeLoginIdSize.height)];
    [empLoginIdLabel setText:employeeLoginIdcn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empLoginIdLabel];
    [scrollView addSubview:empLoginIdLabel];
    
    //Employee Email
    empEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empLoginIdTextField.frame.origin.y + empLoginIdTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empEmailTextField];
    [scrollView addSubview:empEmailTextField];
    
    NSString *employeeEmailcn = [LabelUtils getLabelForKey:@"employee_email"];
    CGSize employeeEmailSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeEmailcn size:11];
    UILabel *empEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(empEmailTextField.frame.origin.x + 15, empEmailTextField.frame.origin.y - (employeeEmailSize.height/2), employeeEmailSize.width, employeeEmailSize.height)];
    [empEmailLabel setText:employeeEmailcn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empEmailLabel];
    [scrollView addSubview:empEmailLabel];
    
//    //Employee Company Id
//    empCompId = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empEmailTextField.frame.origin.y + empEmailTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
//    [NSStringUtilsDemo setEditTextUITextFieldStyle:empCompId];
//    [scrollView addSubview:empCompId];
    
//    NSString *employeeCompanyIdcn = @"Employee Company Id";
//    CGSize employeeCompanyIDSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeCompanyIdcn size:11];
//    UILabel *empCompIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(empCompId.frame.origin.x + 15, empCompId.frame.origin.y - (employeeCompanyIDSize.height/2), employeeCompanyIDSize.width, employeeCompanyIDSize.height)];
//    [empCompIdLabel setText:employeeCompanyIdcn];
//    [NSStringUtilsDemo setEditTextUILabelStyle:empCompIdLabel];
//    [scrollView addSubview:empCompIdLabel];
    
    //Employee Department
    empDeptTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empEmailTextField.frame.origin.y + empEmailTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empDeptTextField];
    [scrollView addSubview:empDeptTextField];
    
    NSString *employeeDeptcn = [LabelUtils getLabelForKey:@"employee_department"];
    CGSize employeeDeptSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeDeptcn size:11];
    UILabel *empDeptLabel = [[UILabel alloc] initWithFrame:CGRectMake(empDeptTextField.frame.origin.x + 15, empDeptTextField.frame.origin.y - (employeeDeptSize.height/2), employeeDeptSize.width, employeeDeptSize.height)];
    [empDeptLabel setText:employeeDeptcn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empDeptLabel];
    [scrollView addSubview:empDeptLabel];
    
    //Employee Name
    empNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empDeptTextField.frame.origin.y + empDeptTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empNameTextField];
    [scrollView addSubview:empNameTextField];
    
    NSString *employeeNamecn = [LabelUtils getLabelForKey:@"employee_name"];
    CGSize employeeNameSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeNamecn size:11];
    UILabel *empNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(empNameTextField.frame.origin.x + 15, empNameTextField.frame.origin.y - (employeeNameSize.height/2), employeeNameSize.width, employeeNameSize.height)];
    [empNameLabel setText:employeeNamecn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empNameLabel];
    [scrollView addSubview:empNameLabel];
    
    //Employee Mobile Number
    empMobileNumb = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empNameTextField.frame.origin.y + empNameTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empMobileNumb];
    [scrollView addSubview:empMobileNumb];
    
    NSString *empMobilecn = [LabelUtils getLabelForKey:@"employee_mobile_no"];
    CGSize empMobileSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empMobilecn size:11];
    UILabel *empMobNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(empMobileNumb.frame.origin.x + 15, empMobileNumb.frame.origin.y - (empMobileSize.height/2), empMobileSize.width, empMobileSize.height)];
    [empMobNumLabel setText:empMobilecn];
    [NSStringUtilsDemo setEditTextUILabelStyle:empMobNumLabel];
    [scrollView addSubview:empMobNumLabel];
    
//    //Employee Country
//    empCountryTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empMobileNumb.frame.origin.y + empMobileNumb.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
//    [NSStringUtilsDemo setEditTextUITextFieldStyle:empCountryTextField];
//    [scrollView addSubview:empCountryTextField];
//
//    NSString *employeeNumbercn = @"Unique Employee Number";
//    CGSize employeeNumberSize = [NSStringUtilsDemo getUILabelSizeFromLabel:employeeNumbercn size:11];
//    UILabel *empCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(empCountryTextField.frame.origin.x + 15, empCountryTextField.frame.origin.y - (employeeNumberSize.height/2), employeeNumberSize.width, employeeNumberSize.height)];
//    [empCountryLabel setText:employeeNumbercn];
//    [NSStringUtilsDemo setEditTextUILabelStyle:empCountryLabel];
//    [scrollView addSubview:empCountryLabel];
    
    genderTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empMobileNumb.frame.origin.y + empMobileNumb.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [genderTextField setText:@"M"];
    [genderTextField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:genderTextField];
    [scrollView addSubview:genderTextField];

    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(genderTextField.frame.origin.x + genderTextField.frame.size.width - (width/100)*9 , genderTextField.frame.origin.y + (genderTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [scrollView addSubview:downArrowImage];

    NSString *languagecn = [LabelUtils getLabelForKey:@"gender"];
    CGSize languageSize = [NSStringUtilsDemo getUILabelSizeFromLabel:languagecn size:14];
    UILabel *languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(genderTextField.frame.origin.x + 15, genderTextField.frame.origin.y - (languageSize.height/2), languageSize.width, languageSize.height)];
    [languageLabel setText:languagecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:languageLabel];
    [scrollView addSubview:languageLabel];

    //Employee Marital Status
    maritalStatusTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, genderTextField.frame.origin.y + genderTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:maritalStatusTextField];
    [scrollView addSubview:maritalStatusTextField];
    
    NSString *empMaritalStatus =[LabelUtils getLabelForKey:@"marital_status"];
    CGSize empMaritalStatusSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empMaritalStatus size:11];
    UILabel *empMaritalStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(maritalStatusTextField.frame.origin.x + 15, maritalStatusTextField.frame.origin.y - (empMaritalStatusSize.height/2), empMaritalStatusSize.width, empMaritalStatusSize.height)];
    [empMaritalStatusLabel setText:empMaritalStatus];
    [NSStringUtilsDemo setEditTextUILabelStyle:empMaritalStatusLabel];
    [scrollView addSubview:empMaritalStatusLabel];
    
    //Employee Country
    empCountryTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, maritalStatusTextField.frame.origin.y + maritalStatusTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empCountryTextField];
    [scrollView addSubview:empCountryTextField];
    
    NSString *empCountry = [LabelUtils getLabelForKey:@"employee_country"];
    CGSize empCountrySize = [NSStringUtilsDemo getUILabelSizeFromLabel:empCountry size:11];
    UILabel *empCountryLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(empCountryTextField.frame.origin.x + 15, empCountryTextField.frame.origin.y - (empCountrySize.height/2), empCountrySize.width, empCountrySize.height)];
    [empCountryLabel1 setText:empCountry];
    [NSStringUtilsDemo setEditTextUILabelStyle:empCountryLabel1];
    [scrollView addSubview:empCountryLabel1];
    
    //Employee Address 1
    empAddress1TextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empCountryTextField.frame.origin.y + empCountryTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empAddress1TextField];
    [scrollView addSubview:empAddress1TextField];
    
    NSString *empAddress1 = [LabelUtils getLabelForKey:@"employee_address_line_1"];
    CGSize empAddress1Size = [NSStringUtilsDemo getUILabelSizeFromLabel:empAddress1 size:11];
    UILabel *empAddress1Label = [[UILabel alloc] initWithFrame:CGRectMake(empAddress1TextField.frame.origin.x + 15, empAddress1TextField.frame.origin.y - (empAddress1Size.height/2), empAddress1Size.width, empAddress1Size.height)];
    [empAddress1Label setText:empAddress1];
    [NSStringUtilsDemo setEditTextUILabelStyle:empAddress1Label];
    [scrollView addSubview:empAddress1Label];
    
    //Employee Address 2
    empAddress2TextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empAddress1TextField.frame.origin.y + empAddress1TextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empAddress2TextField];
    [scrollView addSubview:empAddress2TextField];
    
    NSString *empAddress2 = [LabelUtils getLabelForKey:@"employee_address_line_2"];
    CGSize empAddress2Size = [NSStringUtilsDemo getUILabelSizeFromLabel:empAddress2 size:11];
    UILabel *empAddress2Label = [[UILabel alloc] initWithFrame:CGRectMake(empAddress2TextField.frame.origin.x + 15, empAddress2TextField.frame.origin.y - (empAddress2Size.height/2), empAddress2Size.width, empAddress2Size.height)];
    [empAddress2Label setText:empAddress2];
    [NSStringUtilsDemo setEditTextUILabelStyle:empAddress2Label];
    [scrollView addSubview:empAddress2Label];
    
    //Employee state
    empStateTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empAddress2TextField.frame.origin.y + empAddress2TextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empStateTextField];
    [scrollView addSubview:empStateTextField];
    
    NSString *empState = [LabelUtils getLabelForKey:@"employee_address_line_2"];
    CGSize empStateSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empState size:11];
    UILabel *empStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(empStateTextField.frame.origin.x + 15, empStateTextField.frame.origin.y - (empStateSize.height/2), empStateSize.width, empStateSize.height)];
    [empStateLabel setText:empState];
    [NSStringUtilsDemo setEditTextUILabelStyle:empStateLabel];
    [scrollView addSubview:empStateLabel];
    
    //Employee city
    empCityTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empStateTextField.frame.origin.y + empStateTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empCityTextField];
    [scrollView addSubview:empCityTextField];
    
    NSString *empCity = [LabelUtils getLabelForKey:@"city"];
    CGSize empCitySize = [NSStringUtilsDemo getUILabelSizeFromLabel:empCity size:11];
    UILabel *empCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(empCityTextField.frame.origin.x + 15, empCityTextField.frame.origin.y - (empCitySize.height/2), empCitySize.width, empCitySize.height)];
    [empCityLabel setText:empCity];
    [NSStringUtilsDemo setEditTextUILabelStyle:empCityLabel];
    [scrollView addSubview:empCityLabel];
    
    //Employee Zip Code
    empZipCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empCityTextField.frame.origin.y + empCityTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empZipCodeTextField];
    [scrollView addSubview:empZipCodeTextField];
    
    NSString *empZipCode = [LabelUtils getLabelForKey:@"zip_code"];
    CGSize empZipCodeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empZipCode size:11];
    UILabel *empZipCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(empZipCodeTextField.frame.origin.x + 15, empZipCodeTextField.frame.origin.y - (empZipCodeSize.height/2), empZipCodeSize.width, empZipCodeSize.height)];
    [empZipCodeLabel setText:empZipCode];
    [NSStringUtilsDemo setEditTextUILabelStyle:empZipCodeLabel];
    [scrollView addSubview:empZipCodeLabel];
    
    //Employee Spouse Name
    empSpouseNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empZipCodeTextField.frame.origin.y + empZipCodeTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empSpouseNameTextField];
    [scrollView addSubview:empSpouseNameTextField];
    
    NSString *empSpouseName = [LabelUtils getLabelForKey:@"spouse_name"];
    CGSize empSpouseNameSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empSpouseName size:11];
    UILabel *empSpouseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(empSpouseNameTextField.frame.origin.x + 15, empSpouseNameTextField.frame.origin.y - (empSpouseNameSize.height/2), empSpouseNameSize.width, empSpouseNameSize.height)];
    [empSpouseNameLabel setText:empSpouseName];
    [NSStringUtilsDemo setEditTextUILabelStyle:empSpouseNameLabel];
    [scrollView addSubview:empSpouseNameLabel];
    
    //No of children
    empNoOfChildrenTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, empSpouseNameTextField.frame.origin.y + empSpouseNameTextField.frame.size.height + (height/100)*3 , width - (width/100)*14, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:empNoOfChildrenTextField];
    [scrollView addSubview:empNoOfChildrenTextField];
    
    NSString *empNoOfChildren = [LabelUtils getLabelForKey:@"number_of_children"];
    CGSize empNoOfChildrenSize = [NSStringUtilsDemo getUILabelSizeFromLabel:empNoOfChildren size:11];
    UILabel *empNoOfChildrenLabel = [[UILabel alloc] initWithFrame:CGRectMake(empNoOfChildrenTextField.frame.origin.x + 15, empNoOfChildrenTextField.frame.origin.y - (empNoOfChildrenSize.height/2), empNoOfChildrenSize.width, empNoOfChildrenSize.height)];
    [empNoOfChildrenLabel setText:empNoOfChildren];
    [NSStringUtilsDemo setEditTextUILabelStyle:empNoOfChildrenLabel];
    [scrollView addSubview:empNoOfChildrenLabel];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(empNoOfChildrenTextField.frame.origin.x, scrollView.frame.origin.y + scrollView.frame.size.height + (height/100)*2, (empNoOfChildrenTextField.frame.size.width/100)*45, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (empCountryTextField.frame.size.width/100)*5, backBtn.frame.origin.y , backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
    [scrollView setContentSize:CGSizeMake(width, empNoOfChildrenTextField.frame.origin.y + empNoOfChildrenTextField.frame.size.height + (height/100)*3 + (height/100)*30)];
    
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [genderTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == genderTextField){
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
        [genderTextField setText:genderFieldPickerData[row]];
        [genderTextField setTag:row+1];
    }
}
//Picker Changes End

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
    [ArrayObjectController setEmployeeCode:[[employeeCodeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [ArrayObjectController setEmployeeDataDictionary:[self getEmployeeDict]];
    
    int service_id = [ArrayObjectController getServiceId];
    
//    if(service_id == 30 || service_id == 55 || service_id == 10 || service_id == 160 || service_id == 165 || service_id == 75 || service_id == 191) {
    if(service_id == 30 || service_id == 10 || service_id == 160 || service_id == 165 || service_id == 75 || service_id == 191) {
        FinalStepController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalStepController"];
       // controller.getAdditionalDataDictionary = [self getAdditionalDataDictionary];
        [self.navigationController pushViewController:controller animated:YES];
        
    } else {
        RootPageViewController *controller = [ArrayObjectController getPageDelegate];
        [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
    }
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(NSMutableDictionary*)getEmployeeDict {
     NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
     NSString *employeeCodeString = [[employeeCodeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeTypeString = [[empTypeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeLoginIDString = [[empLoginIdTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeEmailString = [[empEmailTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeCompIdString = [[empCompId text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeDeptString = [[empDeptTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeNameString = [[empNameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeMobNum = [[empMobileNumb text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *employeeCountryString = [[empCountryTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empGender = [[genderTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empMaritalStatus = [[maritalStatusTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empAdress1 = [[empAddress1TextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empAdress2 = [[empAddress2TextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empState = [[empStateTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *empCity = [[empCityTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *empZipCode = [[empZipCodeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeCodeString]){
        [nsDict setObject:employeeCodeString forKey:@"Employee_Code"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeTypeString]){
        [nsDict setObject:employeeTypeString forKey:@"Employee_Type"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeLoginIDString]){
        [nsDict setObject:employeeLoginIDString forKey:@"Login_ID"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeEmailString]){
        [nsDict setObject:employeeEmailString forKey:@"Employee_Email"];
    }
    
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeCompIdString]){
//        [nsDict setObject:employeeCompIdString forKey:@"Company_ID"];
//    }
    [nsDict setObject:[AppItSDK getCompanyID] forKey:@"Company_ID"];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeDeptString]){
        [nsDict setObject:employeeDeptString forKey:@"Dept"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeNameString]){
        [nsDict setObject:employeeNameString forKey:@"Employee_Name"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeMobNum]){
        [nsDict setObject:employeeMobNum forKey:@"Employee_MobileNumber"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:employeeCountryString]){
        [nsDict setObject:employeeCountryString forKey:@"Employee_Country"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empGender]){
        [nsDict setObject:empGender forKey:@"Gender"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empGender]){
        [nsDict setObject:empGender forKey:@"Employee_Gender"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empMaritalStatus]){
        [nsDict setObject:empMaritalStatus forKey:@"Employee_Country"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empAdress1]){
        [nsDict setObject:empAdress1 forKey:@"Employee_AddresLine1"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empAdress1]){
        [nsDict setObject:empAdress1 forKey:@"Employee_AddressLine1"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empAdress2]){
        [nsDict setObject:empAdress2 forKey:@"Employee_AddresLine2"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empAdress2]){
        [nsDict setObject:empAdress2 forKey:@"Employee_AddressLine2"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empState]){
        [nsDict setObject:empState forKey:@"Employee_State"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empCity]){
        [nsDict setObject:empCity forKey:@"Employee_City"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empZipCode]){
        [nsDict setObject:empZipCode forKey:@"Employee_ZipCode"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:empZipCode]){
        [nsDict setObject:empZipCode forKey:@"Employee_PostalCode"];
    }
    
    if([nsDict count] > 0){
        return nsDict;
    }
    return nil;
    
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
