//
//  SecondaryIdFaceDetailsViewController.m
//  AppItDepedency
//
//  Created by Sanket Garde on 08/06/20.
//  Copyright © 2020 idmission solutions pvt ltd . All rights reserved.
//

#import "SecondaryIdFaceDetailsViewController.h"
#import "RootPageViewController.h"
#import "ArrayObjectController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "NSStringUtilsDemo.h"
#import "AppDelegate.h"
#import "LabelUtils.h"

@interface SecondaryIdFaceDetailsViewController ()

@end

@implementation SecondaryIdFaceDetailsViewController {
   UITextField *selectIdTypeTextField, *selectIdCountryTextField, *selectIdStateTextField, *selectIdTypeTextField_sec, *selectIdCountryTextField_sec, *selectIdStateTextField_sec; //*faceImageTypeTextField, *idImageTypeTextField;

    NSArray *_selectedPickerData;
    NSArray *_IdTypePickerData, *_IdTypePickerDataValue;
    NSArray *_IdCountryPickerData, *_IdCountryPickerDataValue;
    
    NSArray *_faceImgTypePickerDataValue;
    NSArray *_FaceMatchTypePickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UILabel *selectIdStateTypeLabel, *selectIdStateTypeLabel_sec, *selectIdTypeLabel_sec, *selectIdCountryTypeLabel_sec;
    UIImageView *downArrowImageFaceImage, *downArrowImage_IdType_sec, *downArrowImageCountry_IdCountry_sec;
    UILabel *faceImageTypeLabel;
    UIButton *backBtn, *nextBtn;
    bool isFirstTime;
    NSString *textFieldTypeForPicker;
    int service_id;
    NSMutableArray *backUpArray;
    bool containIDBack;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self nextButtonChanges];
}

-(void)viewDidAppear:(BOOL)animated {
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
//    if([@"620" isEqualToString:[_serviceIdNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] && !isFirstTime) {
//        _pageControlFields = backUpArray;
//    }
    
    if(isFirstTime) {
        isFirstTime = false;
//        backUpArray = [_pageControlFields mutableCopy];
        myPickerView = [[UIPickerView alloc] init];
        myPickerView.delegate = self;
        myPickerView.dataSource = self;
        
        [selectIdTypeTextField setDelegate:(id)self];
        [selectIdCountryTextField setDelegate:(id)self];
        [selectIdStateTextField setDelegate:(id)self];
        
        [selectIdTypeTextField_sec setDelegate:(id)self];
        [selectIdCountryTextField_sec setDelegate:(id)self];
        [selectIdStateTextField_sec setDelegate:(id)self];
        
        [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
       // myPickerView.layer.borderWidth = 1.0;
       // myPickerView.layer.cornerRadius = 5.0;
        myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        //Adding Toolbar with 'Done' button on picker view
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
        
        toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
        NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
        [toolbarForPicker setItems:toolbarItems];
        
        [selectIdTypeTextField setInputView:myPickerView];
        [selectIdCountryTextField setInputView:myPickerView];
        
        [selectIdTypeTextField_sec setInputView:myPickerView];
        [selectIdCountryTextField_sec setInputView:myPickerView];
        
        [selectIdTypeTextField setInputAccessoryView:toolbarForPicker];
        [selectIdCountryTextField setInputAccessoryView:toolbarForPicker];
        
        [selectIdTypeTextField_sec setInputAccessoryView:toolbarForPicker];
        [selectIdCountryTextField_sec setInputAccessoryView:toolbarForPicker];
        
        NSInteger usaIndex = [_IdCountryPickerData indexOfObject:@"United States of America"];
            
        [selectIdTypeTextField setText:_IdTypePickerData[0]];
        [selectIdCountryTextField setText:_IdCountryPickerData[usaIndex]];
        
        [selectIdTypeTextField_sec setText:_IdTypePickerData[0]];
        [selectIdCountryTextField_sec setText:_IdCountryPickerData[usaIndex]];
        
//        containIDBack = [_pageControlFields containsObject:@"IDCaptureBack"];
    }
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");

    [selectIdTypeTextField resignFirstResponder];
    [selectIdCountryTextField resignFirstResponder];
    
    [selectIdTypeTextField_sec resignFirstResponder];
    [selectIdCountryTextField_sec resignFirstResponder];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectIdTypeTextField) {
        
        textFieldTypeForPicker = @"selectIdTypeTextField";
        _selectedPickerData = _IdTypePickerData;
        [myPickerView reloadAllComponents];
        
    } else if(textField == selectIdTypeTextField_sec) {
        
        textFieldTypeForPicker = @"selectIdTypeTextField_sec";
        _selectedPickerData = _IdTypePickerData;
        [myPickerView reloadAllComponents];
        
    } else if(textField == selectIdCountryTextField) {
        
        textFieldTypeForPicker = @"selectIdCountryTextField";
        _selectedPickerData = _IdCountryPickerData;
        [myPickerView reloadAllComponents];
        
    } else if(textField == selectIdCountryTextField_sec) {
        
        textFieldTypeForPicker = @"selectIdCountryTextField_sec";
        _selectedPickerData = _IdCountryPickerData;
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
    
    if([textFieldTypeForPicker isEqualToString:@"selectIdTypeTextField"]) {
        [selectIdTypeTextField setText:_IdTypePickerData[row]];
        [selectIdTypeTextField setTag:row+1];
    }
    
    if([textFieldTypeForPicker isEqualToString:@"selectIdTypeTextField_sec"]) {
        [selectIdTypeTextField_sec setText:_IdTypePickerData[row]];
        [selectIdTypeTextField_sec setTag:row+1];
    }
    
    if([textFieldTypeForPicker isEqualToString:@"selectIdCountryTextField"]) {
        [selectIdCountryTextField setText:_IdCountryPickerData[row]];
        [selectIdCountryTextField setTag:row+1];
    }
    
    if([textFieldTypeForPicker isEqualToString:@"selectIdCountryTextField_sec"]) {
        [selectIdCountryTextField_sec setText:_IdCountryPickerData[row]];
        [selectIdCountryTextField_sec setTag:row+1];
    }
    
//    if([[self getIdType:[selectIdTypeTextField text] defaultValue:@"PASSPORT"] isEqualToString:@"DRIVERS_LICENSE"]
//       && ([selectIdCountryTextField.text isEqualToString:@"United States of America"]
//           || [selectIdCountryTextField.text isEqualToString:@"CANADA"]
//           || [selectIdCountryTextField.text isEqualToString:@"AUSTRALIA"])) {
//           [self showIdState];
//       } else {
//           [self hideIdState];
//       }
    
    if(nil != selectIdTypeTextField_sec) {
        
        if(!selectIdTypeTextField_sec.isHidden) {
            if([[self getIdType:[selectIdTypeTextField_sec text] defaultValue:@"PASSPORT"] isEqualToString:@"DRIVERS_LICENSE"]
               && ([selectIdCountryTextField_sec.text isEqualToString:@"United States of America"]
                   || [selectIdCountryTextField_sec.text isEqualToString:@"CANADA"]
                   || [selectIdCountryTextField_sec.text isEqualToString:@"AUSTRALIA"])) {
                   
                   [self showSecondaryIdState];
                   
            } else {
                
                   [self hideSecondaryIdState];
                
            }
        }
    }
    
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstTime = true;
    
//    _IdTypePickerData = @[@"PASSPORT", @"NATIONAL_ID", @"RESIDENCE_CARD", @"DRIVERS_LICENSE", @"VOTER_ID_CARD", @"TAX_ID_CARD", @"WORK_VISA_PERMIT", @"STUDENT_VISA_PERMIT", @"MILITARY_POLICE_GOVERNMENT_ID", @"BOAT_SHIP_ID_CARD", @"IDM", @"OTHERS"];
    _IdTypePickerData = @[[LabelUtils getLabelForKey:@"PP"], [LabelUtils getLabelForKey:@"NID"], [LabelUtils getLabelForKey:@"RID"], [LabelUtils getLabelForKey:@"DL"], [LabelUtils getLabelForKey:@"VID"], [LabelUtils getLabelForKey:@"TID"], [LabelUtils getLabelForKey:@"WV"], [LabelUtils getLabelForKey:@"SV"], [LabelUtils getLabelForKey:@"GID"], [LabelUtils getLabelForKey:@"BID"], [LabelUtils getLabelForKey:@"IDM"],[LabelUtils getLabelForKey:@"OTH"]];
    
    _IdTypePickerDataValue = @[@"PP", @"NID", @"RID", @"DL", @"VID", @"TID", @"WV", @"SV", @"GID", @"BID", @"IDM", @"OTH"];
    
    _IdCountryPickerData = @[@"AFGHANISTAN",
                             @"ALAND ISLANDS",
                             @"ALBANIA",
                             @"ALGERIA",
                             @"ALL",
                             @"AMERICAN SAMOA",
                             @"ANDORRA",
                             @"ANGOLA",
                             @"ANGUILLA",
                             @"ANTARCTICA",
                             @"ANTIGUA AND BARBUDA",
                             @"ARGENTINA",
                             @"ARMENIA",
                             @"ARUBA",
                             @"AUSTRALIA",
                             @"AUSTRIA",
                             @"AZERBAIJAN",
                             @"BAHAMAS",
                             @"BAHRAIN",
                             @"BANGLADESH",
                             @"BARBADOS",
                             @"BELARUS",
                             @"BELGIUM",
                             @"BELIZE",
                             @"BENIN",
                             @"BERMUDA",
                             @"BHUTAN",
                             @"BOLIVIA",
                             @"BOSNIA AND HERZEGOWINA",
                             @"BOTSWANA",
                             @"BOUVET ISLAND",
                             @"BRAZIL",
                             @"BRITISH INDIAN OCEAN TERRITORY",
                             @"BRUNEI DARUSSALAM",
                             @"BULGARIA",
                             @"BURKINA FASO",
                             @"BURUNDI",
                             @"CAMBODIA",
                             @"CAMEROON",
                             @"CANADA",
                             @"CAPE VERDE",
                             @"CARIBBEAN NETHERLANDS",
                             @"CAYMAN ISLANDS",
                             @"CENTRAL AFRICAN REPUBLIC",
                             @"CHAD",
                             @"CHILE",
                             @"CHINA",
                             @"CHRISTMAS ISLAND",
                             @"COCOS (KEELING) ISLANDS",
                             @"COLOMBIA",
                             @"COMOROS",
                             @"CONGO",
                             @"CONGO THE DRC",
                             @"COOK ISLANDS",
                             @"COSTA RICA",
                             @"COTE D'IVOIRE",
                             @"CROATIA (local name: Hrvatska)",
                             @"CUBA",
                             @"CURAÇAO",
                             @"CYPRUS",
                             @"CZECH REPUBLIC",
                             @"DENMARK",
                             @"DJIBOUTI",
                             @"DOMINICA",
                             @"DOMINICAN REPUBLIC",
                             @"EAST TIMOR",
                             @"ECUADOR",
                             @"EGYPT",
                             @"EL SALVADOR",
                             @"EQUATORIAL GUINEA",
                             @"ERITREA",
                             @"ESTONIA",
                             @"ETHIOPIA",
                             @"FALKLAND ISLANDS (MALVINAS)",
                             @"FAROE ISLANDS",
                             @"FIJI",
                             @"FINLAND",
                             @"FRANCE",
                             @"FRANCE METROPOLITAN",
                             @"FRENCH GUIANA",
                             @"FRENCH POLYNESIA",
                             @"FRENCH SOUTHERN TERRITORIES",
                             @"GABON",
                             @"GAMBIA",
                             @"GEORGIA",
//                             @"GERMANY",
                             @"GERMANY",
                             @"GHANA",
                             @"GIBRALTAR",
                             @"GREECE",
                             @"GREENLAND",
                             @"GRENADA",
                             @"GUADELOUPE",
                             @"GUAM",
                             @"GUATEMALA",
                             @"GUERNSEY",
                             @"GUINEA",
                             @"GUINEA-BISSAU",
                             @"GUYANA",
                             @"HAITI",
                             @"HEARD AND MC DONALD ISLANDS",
                             @"HOLY SEE (VATICAN CITY STATE)",
                             @"HONDURAS",
                             @"HONG KONG",
                             @"HUNGARY",
                             @"ICELAND",
                             @"INDIA",
                             @"INDONESIA",
                             @"IRAN (ISLAMIC REPUBLIC OF)",
                             @"IRAQ",
                             @"IRELAND",
                             @"ISLE OF MAN",
                             @"ISRAEL",
                             @"ITALY",
                             @"JAMAICA",
                             @"JAPAN",
                             @"JERSEY",
                             @"JORDAN",
                             @"KAZAKHSTAN",
                             @"KENYA",
                             @"KIRIBATI",
                             @"KOREA D.P.R.O.",
                             @"KOREA REPUBLIC OF",
                             @"KOSOVO",
                             @"KUWAIT",
                             @"KYRGYZSTAN",
                             @"LAOS",
                             @"LATVIA",
                             @"LEBANON",
                             @"LESOTHO",
                             @"LIBERIA",
                             @"LIBYAN ARAB JAMAHIRIYA",
                             @"LIECHTENSTEIN",
                             @"LITHUANIA",
                             @"LUXEMBOURG",
                             @"MACAU",
                             @"MACEDONIA",
                             @"MADAGASCAR",
                             @"MALAWI",
                             @"MALAYSIA",
                             @"MALDIVES",
                             @"MALI",
                             @"MALTA",
                             @"MARSHALL ISLANDS",
                             @"MARTINIQUE",
                             @"MAURITANIA",
                             @"MAURITIUS",
                             @"MAYOTTE",
                             @"MEXICO",
                             @"MICRONESIA FEDERATED STATES OF",
                             @"MOLDOVA REPUBLIC OF",
                             @"MONACO",
                             @"MONGOLIA",
                             @"MONTENEGRO",
                             @"MONTSERRAT",
                             @"MOROCCO",
                             @"MOZAMBIQUE",
                             @"MYANMAR (Burma)",
                             @"NAMIBIA",
                             @"NAURU",
                             @"NEPAL",
                             @"NETHERLANDS",
                             @"NETHERLANDS ANTILLES",
                             @"NEW CALEDONIA",
                             @"NEW ZEALAND",
                             @"NICARAGUA",
                             @"NIGER",
                             @"NIGERIA",
                             @"NIUE",
                             @"NORFOLK ISLAND",
                             @"NORTHERN MARIANA ISLANDS",
                             @"NORWAY",
                             @"OMAN",
                             @"PAKISTAN",
                             @"PALAU",
                             @"PALESTINIAN TERRITORY",
                             @"PANAMA",
                             @"PAPUA NEW GUINEA",
                             @"PARAGUAY",
                             @"PERU",
                             @"PHILIPPINES",
                             @"PITCAIRN",
                             @"POLAND",
                             @"PORTUGAL",
                             @"PUERTO RICO",
                             @"QATAR",
                             @"REUNION",
                             @"ROMANIA",
                             @"RUSSIAN FEDERATION",
                             @"RWANDA",
                             @"SAINT BARTHELEMY",
                             @"SAINT KITTS AND NEVIS",
                             @"SAINT LUCIA",
                             @"SAINT MARTIN",
                             @"SAINT VINCENT AND THE GRENADINES",
                             @"SAMOA",
                             @"SAN MARINO",
                             @"SAO TOME AND PRINCIPE",
                             @"SAUDI ARABIA",
                             @"SENEGAL",
                             @"SERBIA",
                             @"SEYCHELLES",
                             @"SIERRA LEONE",
                             @"SINGAPORE",
                             @"SINT MAARTEN",
                             @"SLOVAKIA (Slovak Republic)",
                             @"SLOVENIA",
                             @"SOLOMON ISLANDS",
                             @"SOMALIA",
                             @"SOUTH AFRICA",
                             @"SOUTH GEORGIA AND SOUTH S.S.",
                             @"SOUTH SUDAN",
                             @"SPAIN",
                             @"SRI LANKA",
                             @"ST. HELENA",
                             @"ST. PIERRE AND MIQUELON",
                             @"SUDAN",
                             @"SURINAME",
                             @"SVALBARD AND JAN MAYEN ISLANDS",
                             @"SWAZILAND",
                             @"SWEDEN",
                             @"SWITZERLAND",
                             @"SYRIAN ARAB REPUBLIC",
                             @"TAIWAN PROVINCE OF CHINA",
                             @"TAJIKISTAN",
                             @"TANZANIA UNITED REPUBLIC OF",
                             @"THAILAND",
                             @"TOGO",
                             @"TOKELAU",
                             @"TONGA",
                             @"TRINIDAD AND TOBAGO",
                             @"TUNISIA",
                             @"TURKEY",
                             @"TURKMENISTAN",
                             @"TURKS AND CAICOS ISLANDS",
                             @"TUVALU",
                             @"U.S. MINOR ISLANDS",
                             @"UGANDA",
                             @"UKRAINE",
                             @"UNITED ARAB EMIRATES",
                             @"UNITED KINGDOM",
                             @"United States of America",
                             @"URUGUAY",
                             @"UZBEKISTAN",
                             @"VANUATU",
                             @"VENEZUELA",
                             @"VIET NAM",
                             @"VIRGIN ISLANDS (BRITISH)",
                             @"VIRGIN ISLANDS (U.S.)",
                             @"WALLIS AND FUTUNA ISLANDS",
                             @"WESTERN SAHARA",
                             @"YEMEN",
                             @"ZAMBIA",
                             @"ZIMBABWE"];
    
    _IdCountryPickerDataValue = @[@"AFG",
                                  @"ALA",
                                  @"ALB",
                                  @"DZA",
                                  @"ALL",
                                  @"ASM",
                                  @"AND",
                                  @"AGO",
                                  @"AIA",
                                  @"ATA",
                                  @"ATG",
                                  @"ARG",
                                  @"ARM",
                                  @"ABW",
                                  @"AUS",
                                  @"AUT",
                                  @"AZE",
                                  @"BHS",
                                  @"BHR",
                                  @"BGD",
                                  @"BRB",
                                  @"BLR",
                                  @"BEL",
                                  @"BLZ",
                                  @"BEN",
                                  @"BMU",
                                  @"BTN",
                                  @"BOL",
                                  @"BIH",
                                  @"BWA",
                                  @"BVT",
                                  @"BRA",
                                  @"IOT",
                                  @"BRN",
                                  @"BGR",
                                  @"BFA",
                                  @"BDI",
                                  @"KHM",
                                  @"CMR",
                                  @"CAN",
                                  @"CPV",
                                  @"BES",
                                  @"CYM",
                                  @"CAF",
                                  @"TCD",
                                  @"CHL",
                                  @"CHN",
                                  @"CXR",
                                  @"CCK",
                                  @"COL",
                                  @"COM",
                                  @"COG",
                                  @"COD",
                                  @"COK",
                                  @"CRI",
                                  @"CIV",
                                  @"HRV",
                                  @"CUB",
                                  @"CUW",
                                  @"CYP",
                                  @"CZE",
                                  @"DNK",
                                  @"DJI",
                                  @"DMA",
                                  @"DOM",
                                  @"TMP",
                                  @"ECU",
                                  @"EGY",
                                  @"SLV",
                                  @"GNQ",
                                  @"ERI",
                                  @"EST",
                                  @"ETH",
                                  @"FLK",
                                  @"FRO",
                                  @"FJI",
                                  @"FIN",
                                  @"FRA",
                                  @"FXX",
                                  @"GUF",
                                  @"PYF",
                                  @"ATF",
                                  @"GAB",
                                  @"GMB",
                                  @"GEO",
//                                  @"D  ",
                                  @"DEU",
                                  @"GHA",
                                  @"GIB",
                                  @"GRC",
                                  @"GRL",
                                  @"GRD",
                                  @"GLP",
                                  @"GUM",
                                  @"GTM",
                                  @"GGY",
                                  @"GIN",
                                  @"GNB",
                                  @"GUY",
                                  @"HTI",
                                  @"HMD",
                                  @"VAT",
                                  @"HND",
                                  @"HKG",
                                  @"HUN",
                                  @"ISL",
                                  @"IND",
                                  @"IDN",
                                  @"IRN",
                                  @"IRQ",
                                  @"IRL",
                                  @"IMN",
                                  @"ISR",
                                  @"ITA",
                                  @"JAM",
                                  @"JPN",
                                  @"JEY",
                                  @"JOR",
                                  @"KAZ",
                                  @"KEN",
                                  @"KIR",
                                  @"PRK",
                                  @"KOR",
                                  @"RKS",
                                  @"KWT",
                                  @"KGZ",
                                  @"LAO",
                                  @"LVA",
                                  @"LBN",
                                  @"LSO",
                                  @"LBR",
                                  @"LBY",
                                  @"LIE",
                                  @"LTU",
                                  @"LUX",
                                  @"MAC",
                                  @"MKD",
                                  @"MDG",
                                  @"MWI",
                                  @"MYS",
                                  @"MDV",
                                  @"MLI",
                                  @"MLT",
                                  @"MHL",
                                  @"MTQ",
                                  @"MRT",
                                  @"MUS",
                                  @"MYT",
                                  @"MEX",
                                  @"FSM",
                                  @"MDA",
                                  @"MCO",
                                  @"MNG",
                                  @"MNE",
                                  @"MSR",
                                  @"MAR",
                                  @"MOZ",
                                  @"MMR",
                                  @"NAM",
                                  @"NRU",
                                  @"NPL",
                                  @"NLD",
                                  @"ANT",
                                  @"NCL",
                                  @"NZL",
                                  @"NIC",
                                  @"NER",
                                  @"NGA",
                                  @"NIU",
                                  @"NFK",
                                  @"MNP",
                                  @"NOR",
                                  @"OMN",
                                  @"PAK",
                                  @"PLW",
                                  @"PSE",
                                  @"PAN",
                                  @"PNG",
                                  @"PRY",
                                  @"PER",
                                  @"PHL",
                                  @"PCN",
                                  @"POL",
                                  @"PRT",
                                  @"PRI",
                                  @"QAT",
                                  @"REU",
                                  @"ROU",
                                  @"RUS",
                                  @"RWA",
                                  @"BLM",
                                  @"KNA",
                                  @"LCA",
                                  @"MAF",
                                  @"VCT",
                                  @"WSM",
                                  @"SMR",
                                  @"STP",
                                  @"SAU",
                                  @"SEN",
                                  @"SRB",
                                  @"SYC",
                                  @"SLE",
                                  @"SGP",
                                  @"SXM",
                                  @"SVK",
                                  @"SVN",
                                  @"SLB",
                                  @"SOM",
                                  @"ZAF",
                                  @"SGS",
                                  @"SSD",
                                  @"ESP",
                                  @"LKA",
                                  @"SHN",
                                  @"SPM",
                                  @"SDN",
                                  @"SUR",
                                  @"SJM",
                                  @"SWZ",
                                  @"SWE",
                                  @"CHE",
                                  @"SYR",
                                  @"TWN",
                                  @"TJK",
                                  @"TZA",
                                  @"THA",
                                  @"TGO",
                                  @"TKL",
                                  @"TON",
                                  @"TTO",
                                  @"TUN",
                                  @"TUR",
                                  @"TKM",
                                  @"TCA",
                                  @"TUV",
                                  @"UMI",
                                  @"UGA",
                                  @"UKR",
                                  @"ARE",
                                  @"GBR",
                                  @"USA",
                                  @"URY",
                                  @"UZB",
                                  @"VUT",
                                  @"VEN",
                                  @"VNM",
                                  @"VGB",
                                  @"VIR",
                                  @"WLF",
                                  @"ESH",
                                  @"YEM",
                                  @"ZMB",
                                  @"ZWE"];
    
    _faceImgTypePickerDataValue = @[@"FACE_IMAGE", @"PROCESSED_FACE", @"OVAL_FACE"];
    
    _FaceMatchTypePickerData = @[@"INPUT IMAGE FRONT", @"PROCESSED IMAGE FRONT"];
    
     service_id = [ArrayObjectController getServiceId];
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    // [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"IDCaptureBack"]];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"secondary_id_details"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    titleLabel.numberOfLines = 2;
    //[self setWrapUILabel:titleLabel];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    //Select ID Type
    selectIdTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdTypeTextField];
    [self.view addSubview:selectIdTypeTextField];
    [selectIdTypeTextField setHidden:YES];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectIdTypeTextField.frame.origin.x + selectIdTypeTextField.frame.size.width - (width/100)*9 , selectIdTypeTextField.frame.origin.y + (selectIdTypeTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImage];
    [downArrowImage setHidden:YES];
    
    NSString *selectIDtypecn = [LabelUtils getLabelForKey:@"select_id_type"];
    CGSize selectIDtypeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDtypecn size:14];
    UILabel *selectIdTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectIdTypeTextField.frame.origin.x + 15, selectIdTypeTextField.frame.origin.y - (selectIDtypeSize.height/2), selectIDtypeSize.width, selectIDtypeSize.height)];
    [selectIdTypeLabel setText:selectIDtypecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdTypeLabel];
    [self.view addSubview:selectIdTypeLabel];
    [selectIdTypeLabel setHidden:YES];
    
    //Select ID Country
    selectIdCountryTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectIdTypeTextField.frame.origin.y + selectIdTypeTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdCountryTextField];
    [self.view addSubview:selectIdCountryTextField];
    [selectIdCountryTextField setHidden:YES];
    
    //Down Arrow Image
    UIImageView *downArrowImageCountry = [[UIImageView alloc] initWithFrame:CGRectMake(selectIdCountryTextField.frame.origin.x + selectIdCountryTextField.frame.size.width - (width/100)*9 , selectIdCountryTextField.frame.origin.y + (selectIdCountryTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImageCountry setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImageCountry];
    [downArrowImageCountry setHidden:YES];
    
    NSString *selectIdCountrycn = [LabelUtils getLabelForKey:@"select_id_country"];
    CGSize selectIdCountrySize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIdCountrycn size:14];
    UILabel *selectIdCountryTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectIdCountryTextField.frame.origin.x + 15, selectIdCountryTextField.frame.origin.y - (selectIdCountrySize.height/2), selectIdCountrySize.width, selectIdCountrySize.height)];
    [selectIdCountryTypeLabel setText:selectIdCountrycn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdCountryTypeLabel];
    [self.view addSubview:selectIdCountryTypeLabel];
    [selectIdCountryTypeLabel setHidden:YES];
    
    //Select Id State
    selectIdStateTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectIdCountryTextField.frame.origin.y + selectIdCountryTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [selectIdStateTextField setPlaceholder:[LabelUtils getLabelForKey:@"enter_iso_code"]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdStateTextField];
    [self.view addSubview:selectIdStateTextField];
    [selectIdStateTextField setHidden:YES];
    
    NSString *selectIDStatecn = [LabelUtils getLabelForKey:@"select_id_state"];
    CGSize selectIDStateSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDStatecn size:14];
    selectIdStateTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectIdStateTextField.frame.origin.x + 15, selectIdStateTextField.frame.origin.y - (selectIDStateSize.height/2), selectIDStateSize.width, selectIDStateSize.height)];
    [selectIdStateTypeLabel setText:selectIDStatecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdStateTypeLabel];
    [self.view addSubview:selectIdStateTypeLabel];
    [selectIdStateTypeLabel setHidden:YES];
    
//    if(service_id == 60 || service_id == 300 || service_id == 330 || service_id == 320) {
//    if(service_id == 60 || service_id == 65 || service_id == 100 || service_id == 105 || service_id == 300 || service_id == 305 || service_id == 310 || service_id == 320 || service_id == 330) {
//        selectIdTypeTextField.frame = CGRectMake(selectIdTypeTextField.frame.origin.x, 0, selectIdTypeTextField.frame.size.width, 0);
//
//        selectIdCountryTextField.frame = CGRectMake(selectIdCountryTextField.frame.origin.x, 0, selectIdCountryTextField.frame.size.width, 0);
//
//        selectIdStateTextField.frame = CGRectMake(selectIdStateTextField.frame.origin.x, 0, selectIdStateTextField.frame.size.width, 0);
//
//        [selectIdTypeLabel setHidden:YES];
//        [downArrowImage setHidden:YES];
//        [selectIdCountryTypeLabel setHidden:YES];
//        [downArrowImageCountry setHidden:YES];
//        [selectIdStateTypeLabel setHidden:YES];
//
//    }
    //Hiding Select Id State
    [selectIdStateTextField setHidden:YES];
    [selectIdStateTypeLabel setHidden:YES];
    
    CGRect secondaryCaptureCGRect;
    secondaryCaptureCGRect = selectIdCountryTextField.frame;
    if(true) {
        secondaryCaptureCGRect = [self secoundryIDCaptureChanges:secondaryCaptureCGRect slideViewRect:slideView.frame];
    }
    
    //Back
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(selectIdCountryTextField.frame.origin.x, secondaryCaptureCGRect.origin.y + secondaryCaptureCGRect.size.height + (height/100)*2, (selectIdCountryTextField.frame.size.width/100)*48, (height/100)*6);
    [backBtn setFrame:saveAccountframe];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    //Next
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(selectIdCountryTextField.frame.origin.x + (selectIdCountryTextField.frame.size.width/100)*52, backBtn.frame.origin.y, backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
}

-(CGRect) secoundryIDCaptureChanges:(CGRect )rect slideViewRect:(CGRect)slideViewRect{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Secondary Select ID Type
    selectIdTypeTextField_sec = [[UITextField alloc] initWithFrame:CGRectMake(rect.origin.x,  slideViewRect.origin.y + slideViewRect.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdTypeTextField_sec];
    [self.view addSubview:selectIdTypeTextField_sec];
    
    //Down Arrow Image
    downArrowImage_IdType_sec = [[UIImageView alloc] initWithFrame:CGRectMake(selectIdTypeTextField_sec.frame.origin.x + selectIdTypeTextField_sec.frame.size.width - (width/100)*9 , selectIdTypeTextField_sec.frame.origin.y + (selectIdTypeTextField_sec.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage_IdType_sec setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImage_IdType_sec];
    
    NSString *selectIDtypecn = [LabelUtils getLabelForKey:@"select_id_type_sec"];
    CGSize selectIDtypeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDtypecn size:14];
    selectIdTypeLabel_sec = [[UILabel alloc] initWithFrame:CGRectMake(selectIdTypeTextField_sec.frame.origin.x + 15, selectIdTypeTextField_sec.frame.origin.y - (selectIDtypeSize.height/2), selectIDtypeSize.width, selectIDtypeSize.height)];
    [selectIdTypeLabel_sec setText:selectIDtypecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdTypeLabel_sec];
    [self.view addSubview:selectIdTypeLabel_sec];
    
    //Select Secondary ID Country
    selectIdCountryTextField_sec = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectIdTypeTextField_sec.frame.origin.y + selectIdTypeTextField_sec.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdCountryTextField_sec];
    [self.view addSubview:selectIdCountryTextField_sec];
    
    //Down Arrow Image
    downArrowImageCountry_IdCountry_sec = [[UIImageView alloc] initWithFrame:CGRectMake(selectIdCountryTextField_sec.frame.origin.x + selectIdCountryTextField_sec.frame.size.width - (width/100)*9 , selectIdCountryTextField_sec.frame.origin.y + (selectIdCountryTextField_sec.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImageCountry_IdCountry_sec setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImageCountry_IdCountry_sec];
    
    NSString *selectIdCountrycn = [LabelUtils getLabelForKey:@"select_id_country_sec"];
    CGSize selectIdCountrySize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIdCountrycn size:14];
    selectIdCountryTypeLabel_sec = [[UILabel alloc] initWithFrame:CGRectMake(selectIdCountryTextField_sec.frame.origin.x + 15, selectIdCountryTextField_sec.frame.origin.y - (selectIdCountrySize.height/2), selectIdCountrySize.width, selectIdCountrySize.height)];
    [selectIdCountryTypeLabel_sec setText:selectIdCountrycn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdCountryTypeLabel_sec];
    [self.view addSubview:selectIdCountryTypeLabel_sec];
    
    //Secondary Select Id State
    selectIdStateTextField_sec = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,selectIdCountryTextField_sec.frame.origin.y + selectIdCountryTextField_sec.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    [selectIdStateTextField_sec setPlaceholder:[LabelUtils getLabelForKey:@"enter_iso_code"]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectIdStateTextField_sec];
    [self.view addSubview:selectIdStateTextField_sec];
    
    NSString *selectIDStatecn = [LabelUtils getLabelForKey:@"select_id_state"];
    CGSize selectIDStateSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDStatecn size:14];
    selectIdStateTypeLabel_sec = [[UILabel alloc] initWithFrame:CGRectMake(selectIdStateTextField_sec.frame.origin.x + 15, selectIdStateTextField_sec.frame.origin.y - (selectIDStateSize.height/2), selectIDStateSize.width, selectIDStateSize.height)];
    [selectIdStateTypeLabel_sec setText:selectIDStatecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:selectIdStateTypeLabel_sec];
    [self.view addSubview:selectIdStateTypeLabel_sec];
    
    [selectIdStateTextField_sec setHidden:YES];
    [selectIdStateTypeLabel_sec setHidden:YES];
    
    return selectIdCountryTextField_sec.frame;
}

-(void) hideSecondaryIdState {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if(!selectIdStateTextField_sec.isHidden) {
        
        [selectIdStateTextField_sec setHidden:YES];
        [selectIdStateTypeLabel_sec setHidden:YES];
        
        [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdCountryTextField_sec.frame.origin.y + selectIdCountryTextField_sec.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
        
        [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
    }
    
}

-(void) hideIdState {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
   
    if(nil == selectIdCountryTextField_sec) {
        
        if(!selectIdStateTextField.isHidden) {
            
            [selectIdStateTextField setHidden:YES];
            [selectIdStateTypeLabel setHidden:YES];
            
            [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdCountryTextField.frame.origin.y + selectIdCountryTextField.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
            
            [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
            
        }
        
    } else {
        
        [selectIdStateTextField setHidden:YES];
        [selectIdStateTypeLabel setHidden:YES];
        
        [self showHideSecondaryIdDetails:selectIdCountryTextField];
        
    }
    
}

-(void) showSecondaryIdState {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if(selectIdStateTextField_sec.isHidden) {
        
        [selectIdStateTextField_sec setHidden:NO];
        [selectIdStateTypeLabel_sec setHidden:NO];
        
        [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdStateTextField_sec.frame.origin.y + selectIdStateTextField_sec.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
        
        [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
        
    }

}

-(void) showIdState {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if(nil == selectIdCountryTextField_sec) {
        
        if(selectIdStateTextField.isHidden) {
            [selectIdStateTextField setHidden:NO];
            [selectIdStateTypeLabel setHidden:NO];
            
            [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdStateTextField.frame.origin.y + selectIdStateTextField.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
            
            [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
            
        }
        
    } else {
        
        [selectIdStateTextField setHidden:NO];
        [selectIdStateTypeLabel setHidden:NO];
        
        [self showHideSecondaryIdDetails:selectIdStateTextField];
        
    }

}

-(void) showHideSecondaryIdDetails:(UITextField *)idTextField {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    [selectIdTypeTextField_sec setFrame:CGRectMake(selectIdTypeTextField_sec.frame.origin.x, idTextField.frame.origin.y + idTextField.frame.size.height + (height/100)*5, selectIdTypeTextField_sec.frame.size.width, selectIdTypeTextField_sec.frame.size.height)];
    [downArrowImage_IdType_sec setFrame:CGRectMake(selectIdTypeTextField_sec.frame.origin.x + selectIdTypeTextField_sec.frame.size.width - (width/100)*9 , selectIdTypeTextField_sec.frame.origin.y + (selectIdTypeTextField_sec.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    NSString *selectIDtypecn = [LabelUtils getLabelForKey:@"select_id_type_sec"];
    CGSize selectIDtypeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDtypecn size:14];
    [selectIdTypeLabel_sec setFrame:CGRectMake(selectIdTypeTextField_sec.frame.origin.x + 15, selectIdTypeTextField_sec.frame.origin.y - (selectIDtypeSize.height/2), selectIDtypeSize.width, selectIDtypeSize.height)];
    
    [selectIdCountryTextField_sec setFrame:CGRectMake(selectIdCountryTextField_sec.frame.origin.x, selectIdTypeTextField_sec.frame.origin.y + selectIdTypeTextField_sec.frame.size.height + (height/100)*5, selectIdCountryTextField_sec.frame.size.width, selectIdCountryTextField_sec.frame.size.height)];
    [downArrowImageCountry_IdCountry_sec setFrame:CGRectMake(selectIdCountryTextField_sec.frame.origin.x + selectIdCountryTextField_sec.frame.size.width - (width/100)*9 , selectIdCountryTextField_sec.frame.origin.y + (selectIdCountryTextField_sec.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    NSString *selectIdCountrycn = [LabelUtils getLabelForKey:@"select_id_country_sec"];
    CGSize selectIdCountrySize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIdCountrycn size:14];
    [selectIdCountryTypeLabel_sec setFrame:CGRectMake(selectIdCountryTextField_sec.frame.origin.x + 15, selectIdCountryTextField_sec.frame.origin.y - (selectIdCountrySize.height/2), selectIdCountrySize.width, selectIdCountrySize.height)];
    
    [selectIdStateTextField_sec setFrame:CGRectMake(selectIdStateTextField_sec.frame.origin.x, selectIdCountryTextField_sec.frame.origin.y + selectIdCountryTextField_sec.frame.size.height + (height/100)*5, selectIdStateTextField_sec.frame.size.width, selectIdStateTextField_sec.frame.size.height)];
    NSString *selectIDStatecn = [LabelUtils getLabelForKey:@"select_id_state"];
    CGSize selectIDStateSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectIDStatecn size:14];
    [selectIdStateTypeLabel_sec setFrame:CGRectMake(selectIdStateTextField_sec.frame.origin.x + 15, selectIdStateTextField_sec.frame.origin.y - (selectIDStateSize.height/2), selectIDStateSize.width, selectIDStateSize.height)];
    
    if(selectIdStateTextField_sec.isHidden) {
        
        [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdCountryTextField_sec.frame.origin.y + selectIdCountryTextField_sec.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
        
        [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
        
    } else {
        
        [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, selectIdStateTextField_sec.frame.origin.y + selectIdStateTextField_sec.frame.size.height + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
        
        [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, backBtn.frame.origin.y, nextBtn.frame.size.width, nextBtn.frame.size.height)];
        
    }
    
}

-(void)backButton:(UIButton*)button {
    //    [self.navigationController popViewControllerAnimated:YES];
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
//    [self nextButtonChanges];
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}



-(void) nextButtonChanges {
//    if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdTypeTextField text]]) {
//            NSString *image;
//            NSInteger selectedImageType = [selectIdTypeTextField tag] - 1;
//            if(selectedImageType != -1){
//                image = [_IdTypePickerDataValue objectAtIndex:selectedImageType];
//            } else {
//                image = @"PP";
//            }
//
//            [ArrayObjectController setIdType:image];
//        }
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdTypeTextField_sec text]]) {
            NSString *image;
            NSInteger selectedImageType = [selectIdTypeTextField_sec tag] - 1;
            if(selectedImageType != -1){
                image = [_IdTypePickerDataValue objectAtIndex:selectedImageType];
            } else {
                image = @"PP";
            }
            
            [ArrayObjectController setSecondaryIdType:image];
        }

//        if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdCountryTextField text]]) {
//            NSString *image;
//            NSInteger selectedImageType = [selectIdCountryTextField tag] - 1;
//            if(selectedImageType != -1){
//                image = [_IdCountryPickerDataValue objectAtIndex:selectedImageType];
//            } else {
//                image = @"USA";
//            }
//            [ArrayObjectController setCountryType:image];
//            NSLog(@"");
//        }
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdCountryTextField_sec text]]) {
            NSString *image;
            NSInteger selectedImageType = [selectIdCountryTextField_sec tag] - 1;
            if(selectedImageType != -1){
                image = [_IdCountryPickerDataValue objectAtIndex:selectedImageType];
            } else {
                image = @"USA";
            }
            [ArrayObjectController setSecondaryCountryType:image];
            NSLog(@"");
        }

    //    if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdCountryTextField text]]) {
    //        [ArrayObjectController setCountryType:[selectIdCountryTextField text]];
    //    }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdStateTextField text]] && !selectIdStateTextField.isHidden) {
//            [ArrayObjectController setStateType:[selectIdStateTextField text]];
//        } else {
//            [ArrayObjectController setStateType:@""];
//        }
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:[selectIdStateTextField_sec text]] && !selectIdStateTextField_sec.isHidden) {
            [ArrayObjectController setSecondaryStateType:[selectIdStateTextField_sec text]];
        } else {
            [ArrayObjectController setSecondaryStateType:@""];
        }
    //    if(![NSStringUtilsDemo stringIsNilOrEmpty:[faceImageTypeTextField text]]) {
    //        [ArrayObjectController setFaceImageType:[faceImageTypeTextField text]];
    //    }
    //    if(![NSStringUtilsDemo stringIsNilOrEmpty:[idImageTypeTextField text]]) {
    //        [ArrayObjectController setIdFaceType:[idImageTypeTextField text]];
//        [ArrayObjectController setIdFaceType:@""];
    //    }

        //In Case of Passport Remove IDCaptureBack Screen
        //if([@"PASSPORT" isEqualToString:[selectIdTypeTextField text]]) {
//        if([@"PASSPORT" isEqualToString:[self getIdType:[selectIdTypeTextField text] defaultValue:@"PASSPORT"]]) {
//           if([_pageControlFields containsObject:@"IDCaptureBack"]) {
//                [_pageControlFields removeObjectAtIndex:1];
//            }
//        }else{
//            //Put back if "Passport is not selected"
//            if(containIDBack && ![_pageControlFields containsObject:@"IDCaptureBack"]){
//                [_pageControlFields insertObject:@"IDCaptureBack" atIndex:1];
//            }
//        }

        if([@"PASSPORT" isEqualToString:[self getIdType:[selectIdTypeTextField_sec text] defaultValue:@"PASSPORT"]]) {

            [ArrayObjectController setHideSecondaryIdBack:true];
//            if([_pageControlFields containsObject:@"SecondaryIDCaptureBack"]) {
//                [_pageControlFields removeObject:@"SecondaryIDCaptureBack"];
//            }
        } else {
            [ArrayObjectController setHideSecondaryIdBack:false];
//            if([_pageControlFields containsObject:@"SecondaryIDCaptureFront"]) {
//                if(![_pageControlFields containsObject:@"SecondaryIDCaptureBack"]) {
//                    NSUInteger indexOfSecIDCaptureFront = [_pageControlFields indexOfObject:@"SecondaryIDCaptureFront"];
//                    [_pageControlFields insertObject:@"SecondaryIDCaptureBack" atIndex:++indexOfSecIDCaptureFront];
//                }
//            }
        }
    
//    NSMutableDictionary *commonfunctionObject = [[NSMutableDictionary alloc] init];
//
//    [commonfunctionObject setObject:[ArrayObjectController getIdType] forKey:@"id_type"];
//    [commonfunctionObject setObject:[ArrayObjectController getCountryType] forKey:@"id_country"];
//    [commonfunctionObject setObject:[ArrayObjectController getStateType] forKey:@"id_state"];
//
//    [AppItSDK getAutoFillFieldInformation:self uiConfigDictionary:commonfunctionObject];
//    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
//    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

- (void) showAlertMsg:(NSString *)title message:(NSString *)message {

    UIAlertController * alert = [UIAlertController alertControllerWithTitle : title
                                                                    message : message
                                                             preferredStyle : UIAlertControllerStyleAlert];

    UIAlertAction * ok = [UIAlertAction
                          actionWithTitle:@"OK"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
        
    }];

    [alert addAction:ok];
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
//    });

}

-(void)onAutoFillFieldInformationAvailable : (NSMutableDictionary*) result {
    
    if([@"620" isEqualToString:[_serviceIdNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(nil != result && result.count>0) {
            if(![result objectForKey:@"FRONT"]) {
                //                [_pageControlFields removeObjectAtIndex:0];
                [_pageControlFields removeObject:@"AutofillFrontController"];
            }

            if(![result objectForKey:@"BACK"]) {
                //                [_pageControlFields removeObjectAtIndex:1];
                [_pageControlFields removeObject:@"AutofillBackController"];
            }
        } else {
            [self showAlertMsg:@"" message:[LabelUtils getLabelForKey:@"barcode_mrz_not_found"]];
            return;
        }
    }

    if([ArrayObjectController getCustomizedUIConfig]) {
//        CustomizeUIConfigurationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomizeUIConfiguration"];
//        controller.pageControlFields = _pageControlFields;
//        controller.serviceType = _serviceType;
//        [self.navigationController pushViewController:controller animated:YES];
    } else {
        RootPageViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RootPageViewController"];
        controller.pageControlFields = _pageControlFields;
        controller.serviceType = _serviceType;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self navigationCode];
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
    label.text = _serviceType;
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

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
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

-(NSString*)getIdType:(NSString*)label defaultValue:(NSString*)defaultValue{
    NSString *idType=defaultValue;
    if ([label isEqualToString:@"PASSPORT"]){
        idType=@"PASSPORT";
    }else if([label isEqualToString:@"Pasaporte"]){
        idType=@"PASSPORT";
    }else if([label isEqualToString:@"နိုင်ငံကူးလက်မှတ်"]){
        idType=@"PASSPORT";
    }
    
    if ([label isEqualToString:@"NATIONAL_ID"]){
        idType=@"NATIONAL_ID";
    }else if([label isEqualToString:@"Identificación Nacional"]){
        idType=@"NATIONAL_ID";
    }else if([label isEqualToString:@"အမျိုးသားအိုင်ဒီ"]){
        idType=@"NATIONAL_ID";
    }
    
    if ([label isEqualToString:@"RESIDENCE_CARD"]){
        idType=@"RESIDENCE_CARD";
    }else if([label isEqualToString:@"Tarjeta de Residencia"]){
        idType=@"RESIDENCE_CARD";
    }else if([label isEqualToString:@"နေအိမ်သို့ကဒ်"]){
        idType=@"RESIDENCE_CARD";
    }
    
    if ([label isEqualToString:@"NATIONAL_ID"]){
        idType=@"NATIONAL_ID";
    }else if([label isEqualToString:@"Identificación Nacional"]){
        idType=@"NATIONAL_ID";
    }else if([label isEqualToString:@"အမျိုးသားအိုင်ဒီ"]){
        idType=@"NATIONAL_ID";
    }
    
    if ([label isEqualToString:@"DRIVERS_LICENSE"]){
        idType=@"DRIVERS_LICENSE";
    }else if([label isEqualToString:@"Licencia de Conducir"]){
        idType=@"DRIVERS_LICENSE";
    }else if([label isEqualToString:@"ယာဥ်မောင်းလိုင်စင်"]){
        idType=@"DRIVERS_LICENSE";
    }
    
    if ([label isEqualToString:@"VOTER_ID_CARD"]){
        idType=@"VOTER_ID_CARD";
    }else if([label isEqualToString:@"TARJETA DE IDENTIFICACION DE VOTANTE"]){
        idType=@"VOTER_ID_CARD";
    }else if([label isEqualToString:@"မဲဆန္ဒရှင်အိုင်ဒီကဒ်"]){
        idType=@"VOTER_ID_CARD";
    }
    if ([label isEqualToString:@"TAX_ID_CARD"]){
        idType=@"TAX_ID_CARD";
    }else if([label isEqualToString:@"TARJETA DE IDENTIFICACIÓN DE IMPUESTOS"]){
        idType=@"TAX_ID_CARD";
    }else if([label isEqualToString:@"အခွန်အိုင်ဒီကဒ်"]){
        idType=@"TAX_ID_CARD";
    }
    
    if ([label isEqualToString:@"WORK_VISA_PERMIT"]){
        idType=@"WORK_VISA_PERMIT";
    }else if([label isEqualToString:@"PERMISO DE VISA DE TRABAJO"]){
        idType=@"WORK_VISA_PERMIT";
    }else if([label isEqualToString:@"အလုပ်မှာဗီဇာပါမစ်"]){
        idType=@"WORK_VISA_PERMIT";
    }
    
    if ([label isEqualToString:@"STUDENT_VISA_PERMIT"]){
        idType=@"STUDENT_VISA_PERMIT";
    }else if([label isEqualToString:@"PERMISO DE VISA DE ESTUDIANTE"]){
        idType=@"STUDENT_VISA_PERMIT";
    }else if([label isEqualToString:@"ကျောင်းသားဗီဇာပါမစ်"]){
        idType=@"STUDENT_VISA_PERMIT";
    }
    
    if ([label isEqualToString:@"MILITARY_POLICE_GOVERNMENT_ID"]){
        idType=@"MILITARY_POLICE_GOVERNMENT_ID";
    }else if([label isEqualToString:@"Tarjeta Militar/Policial/Gobierno"]){
        idType=@"MILITARY_POLICE_GOVERNMENT_ID";
    }else if([label isEqualToString:@"စစ်ရဲအစိုးရ ID ကို"]){
        idType=@"MILITARY_POLICE_GOVERNMENT_ID";
    }
    
    if ([label isEqualToString:@"BOAT_SHIP_ID_CARD"]){
        idType=@"BOAT_SHIP_ID_CARD";
    }else if([label isEqualToString:@"TARJETA DE IDENTIFICACIÓN DE BARCO"]){
        idType=@"BOAT_SHIP_ID_CARD";
    }else if([label isEqualToString:@"လှေသင်္ဘောများ ID ကိုကဒ်"]){
        idType=@"BOAT_SHIP_ID_CARD";
    }
    
    if ([label isEqualToString:@"OTHERS"]){
        idType=@"OTHERS";
    }else if([label isEqualToString:@"OTRAS"]){
        idType=@"OTHERS";
    }else if([label isEqualToString:@"အခြားသူတွေ"]){
        idType=@"OTHERS";
    }

    return idType;
}

@end
