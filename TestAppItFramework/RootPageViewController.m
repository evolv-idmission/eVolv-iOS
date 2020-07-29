//
//  RootPageViewController.m
//  NewProjectForPageView
//
//  Created by  on 02/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "RootPageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ArrayObjectController.h"
#import "FingerPrintViewController.h"
#import "LocationViewController.h"
#import "VideoViewController.h"
#import "SnippetViewController.h"
#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "ResultViewController.h"
#import "IDCaptureFrontController.h"
#import "FirstViewController.h"
#import "ThirdViewController.h"
#import "VideoViewController.h"
#import "SecondViewController.h"
#import "LocationViewController.h"
#import "SanBarcodeViewController.h"
#import "POACaptureViewController.h"
#import "SelfieEmployeeController.h"
#import "UINavigationController+Orientation.h"
#import "SnippetViewController.h"
#import "VideoConfViewController.h"
#import "CardScanController.h"
#import "SlantViewController.h"
#import "SecondaryIDCaptureFrontController.h"
#import "SecondaryIDCaptureBackController.h"
#import "AutofillBackController.h"
#import "AutoFillFrontController.h"

@interface RootPageViewController ()

@property (nonatomic, retain) UIViewController *first;
@property (nonatomic, retain) UIViewController *second;
@property (nonatomic, retain) UIViewController *third;
@property (nonatomic, retain) UIViewController *fourth;
@property (nonatomic, retain) UIViewController *fifth;
@property (nonatomic, retain) UIViewController *sixth;
@property (nonatomic, retain) UIViewController *seventh;
@property (nonatomic, retain) UIViewController *eight;
@property (nonatomic, retain) UIViewController *ninth;
@property (nonatomic, retain) UIViewController *tenth;
@property (nonatomic, retain) UIViewController *eleven;
@property (nonatomic, retain) UIViewController *twelve;
@property (nonatomic, retain) UIViewController *thirteen;
@property (nonatomic, retain) UIViewController *fourteen;
@property (nonatomic, retain) UIViewController *fifteen;
@property (nonatomic, retain) UIViewController *sixteen;
@property (nonatomic, retain) UIViewController *seventeen;
@property (nonatomic, retain) UIViewController *eightteen;

@end

@implementation RootPageViewController {
    NSArray *viewControllers;
    NSArray *arrPageTitles;
    bool isAfterViewController;
    NSMutableArray *controllersArray;
    int currentIndex;
    bool isFirstTime;
    
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

- (UIViewController *)returnControllerWithIdentifier:(NSString *)identifier controllerIndex:(int)controllerIndex{
    
    UIViewController *nextBeforeController;
    switch (controllerIndex) {
        case 0:
            if(!_first) {
                _first = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [ArrayObjectController setPageDelegate:self];
                [_first.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _first;
            break;
        case 1:
            if(!_second) {
                _second = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_second.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _second;
            break;
        case 2:
            if(!_third) {
                _third = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_third.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _third;
            break;
        case 3:
            if(!_fourth) {
                _fourth = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_fourth.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _fourth;
            break;
        case 4:
            if(!_fifth) {
                _fifth = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_fifth.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _fifth;
            break;
        case 5:
            if(!_sixth) {
                _sixth = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_sixth.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _sixth;
            break;
        case 6:
            if(!_seventh) {
                _seventh = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_seventh.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _seventh;
            break;
        case 7:
            if(!_eight) {
                _eight = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_eight.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _eight;
            break;
        case 8:
            if(!_ninth) {
                _ninth = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_ninth.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _ninth;
            break;
        case 9:
            if(!_tenth) {
                _tenth = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_tenth.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _tenth;
            break;
        case 10:
            if(!_eleven) {
                _eleven = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_eleven.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _eleven;
            break;
        case 11:
            if(!_twelve) {
                _twelve = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_twelve.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _twelve;
            break;
        case 12:
            if(!_thirteen) {
                _thirteen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_thirteen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _thirteen;
            break;
        case 13:
            if(!_fourteen) {
                _fourteen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_fourteen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _fourteen;
            break;
        case 14:
            if(!_fifteen) {
                _fifteen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_fifteen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _fifteen;
            break;
        case 15:
            if(!_sixteen) {
                _sixteen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_sixteen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _sixteen;
            break;
        case 16:
            if(!_seventeen) {
                _seventeen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_seventeen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _seventeen;
            break;
        case 17:
            if(!_eightteen) {
                _eightteen = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                [ArrayObjectController setTitleStringForDictionary:identifier];
                [_eightteen.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
            }
            nextBeforeController = _eightteen;
        default:
            
            break;
    }
    
    return nextBeforeController;
}

-(void)viewWillAppear:(BOOL)animated {
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [ArrayObjectController setEnableCaptureEmployee:NO];
    
    controllersArray = [[NSMutableArray alloc] init];

    self.pageViewControler.delegate = self;
    isFirstTime = true;
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    NSMutableArray *pageArray = _pageControlFields;
    UINavigationItem* navItem = [[UINavigationItem alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = _serviceType;
    [label sizeToFit];
    int checkCount = _pageControlFields.count;
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
    self.navigationController.navigationBar.translucent = NO;
    
    isAfterViewController = true;
    arrPageTitles = @[@"SignatureView",@"Document",@"Voice",@"FingerPrint",@"Location/GPS",@"Video",@"Snippet"];
    [ArrayObjectController setSnippetFieldDict:arrPageTitles];
    
    //Setting Service Type
    [ArrayObjectController setServiceType:_serviceType];
    
    self.dataSource = self;
//    UIViewController *firstC = [self returnControllerWithIdentifier:[_pageControlFields firstObject] controllerIndex:0];
//    currentIndex = 0;
//    [ArrayObjectController setTitleStringForDictionary:[_pageControlFields firstObject]];
//    [self setViewControllers:@[firstC]
//                   direction:UIPageViewControllerNavigationDirectionForward
//                    animated:YES
//                  completion:nil];

}

- (void)viewDidLayoutSubviews {
//    CGFloat pageControlHeight;
//    CGFloat pageCtrlY;
//    CGFloat pageCtrlX;
//    UIPageControl *democtrl = [UIPageControl appearance];;
//    for (UIView* view in self.view.subviews) {
//        if ([view isKindOfClass:[UIPageControl class]]) {
//            pageControlHeight = view.frame.size.height;
//            pageCtrlX = view.frame.origin.x;
//            pageCtrlY = view.frame.origin.y;
//        }
//    }
//
//    [ArrayObjectController setPageControlHeight:pageControlHeight];
//
//    [ArrayObjectController setPageControlY:pageCtrlY];
 //   [super viewDidLayoutSubviews];
    
}

-(void)viewDidAppear:(BOOL)animated {
    isSnackBarVisible = false;
    if(isFirstTime) {
        isFirstTime = false;
        CGFloat pageControlHeight;
        CGFloat pageCtrlY;
        CGFloat pageCtrlX;
        UIPageControl *democtrl = [UIPageControl appearance];;
        for (UIView* view in self.view.subviews) {
            if ([view isKindOfClass:[UIPageControl class]]) {
                pageControlHeight = view.frame.size.height;
                pageCtrlX = view.frame.origin.x;
                pageCtrlY = view.frame.origin.y;
//                view.frame = CGRectMake(view.frame.origin.x, 50, view.frame.size.width, view.frame.size.height);
            }
        }

        [ArrayObjectController setPageControlHeight:pageControlHeight];

        [ArrayObjectController setPageControlY:pageCtrlY];
        
        UIViewController *firstC = [self returnControllerWithIdentifier:[_pageControlFields firstObject] controllerIndex:0];
        currentIndex = 0;
        [ArrayObjectController setTitleStringForDictionary:[_pageControlFields firstObject]];

        [self setViewControllers:@[firstC]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:nil];
    }
}

-(void)nextViewController {
    
}

-(void)previousViewControler {
    
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

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    UIViewController *prevViewController = nil;
    isAfterViewController = false;
   
    for(int i = _pageControlFields.count - 1; i >= 0; i--) {
        bool breakLoop = false;
        if(viewController == [self returnControllerWithIdentifier:_pageControlFields[i] controllerIndex:i]) {
            
            if(i-1 < 0 ) {
                breakLoop = true;
            } else {
                prevViewController = [self returnControllerWithIdentifier:_pageControlFields[i-1] controllerIndex:i-1];
                currentIndex = i - 1;
                breakLoop = true;
            }
        }
        if(breakLoop) {
            break;
        }
    }
    
    return prevViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    isAfterViewController =true;
    UIViewController *nextViewController = nil;
    NSLog(@"");
    for(int i=0;i<_pageControlFields.count;i++) {
        bool breakLoop = false;
        if(viewController == [self returnControllerWithIdentifier:_pageControlFields[i] controllerIndex:i]) {
            
            if(i+1 >= _pageControlFields.count ) {
                breakLoop = true;
            } else {
                nextViewController = [self returnControllerWithIdentifier:_pageControlFields[i+1] controllerIndex:i+1];
                currentIndex = i + 1;
                breakLoop = true;
            }
        }
        if(breakLoop) {
            break;
        }
    }
    
    return nextViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return _pageControlFields.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return currentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

-(void)setNextViewController:(NSString *)storyID {
    
    int nextIndex = [_pageControlFields indexOfObject:storyID];
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex + 1] controllerIndex:nextIndex + 1];
    currentIndex = nextIndex + 1;
    [self setViewControllers:@[nextCntroller]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

-(void)setPreviousViewController:(NSString *)storyBoardID {
    int previousIndex = [_pageControlFields indexOfObject:storyBoardID];
    if(previousIndex > 0) {
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[previousIndex - 1] controllerIndex:previousIndex - 1];
        currentIndex = previousIndex - 1;
        [self setViewControllers:@[nextCntroller]
                       direction:UIPageViewControllerNavigationDirectionReverse
                        animated:YES
                      completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dismissViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)autoFillResponse : (NSMutableDictionary*) result {
    
    NSLog(@"autoFillResponse Response : %@ ", result);
    
    NSString *imageType = [result objectForKey:@"ImageType"];
    
    if(![NSStringUtils stringIsNilOrEmpty:imageType] && [imageType isEqualToString:@"FRONT"]){
        int nextIndex = [_pageControlFields indexOfObject:@"AutofillFrontController"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([AutoFillFrontController class])] ) {
            [((AutoFillFrontController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
        
    }else if(![NSStringUtils stringIsNilOrEmpty:imageType] && [imageType isEqualToString:@"BACK"]){
        int nextIndex = [_pageControlFields indexOfObject:@"AutofillBackController"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([AutofillBackController class])] ) {
            [((AutofillBackController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
    }
}

//Capture Front Back Response
-(void)captureImageResponse : (NSMutableDictionary*) result {
    NSLog(@"");
    NSLog(@"captureImageResponse Response : %@ ", result);
    
    NSString *front = [result objectForKey:@"FRONT"];
    NSString *back = [result objectForKey:@"BACK"];
    NSString *slant = [result objectForKey:@"SLANT"];
    NSString *front_secondary = [result objectForKey:@"FRONT_SECONDARY"];
    NSString *back_secondary = [result objectForKey:@"BACK_SECONDARY"];
    
    if(nil != front){
        int nextIndex = [_pageControlFields indexOfObject:@"IDCaptureFront"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([IDCaptureFrontController class])] ) {
            [((IDCaptureFrontController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
        
    }else if(nil != back){
        int nextIndex = [_pageControlFields indexOfObject:@"IDCaptureBack"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([IDCaptureBackController class])] ) {
            [((IDCaptureBackController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
    }else if(nil != slant){
        int nextIndex = [_pageControlFields indexOfObject:@"SlantCapture"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([SlantViewController class])] ) {
            [((SlantViewController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
    } else if(nil != front_secondary) {
        int nextIndex = [_pageControlFields indexOfObject:@"SecondaryIDCaptureFront"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([SecondaryIDCaptureFrontController class])] ) {
            [((SecondaryIDCaptureFrontController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
    } else if(nil != back_secondary) {
        
        int nextIndex = [_pageControlFields indexOfObject:@"SecondaryIDCaptureBack"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([SecondaryIDCaptureBackController class])] ) {
            [((SecondaryIDCaptureBackController *)nextCntroller) captureResponse:result];
        }
        
        currentIndex = nextIndex;
        
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
    
}

// Process Image Response
-(void)processImageResponse : (NSMutableDictionary*) result {
    NSLog(@"processImageResponse Response : %@ ", result);
    
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    ResultViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    controller.resultDictionary = retriedDict;
    [self.navigationController pushViewController:controller animated:YES];

}
// Snippet Capture Response
-(void)snippetCaptureResponse : (NSMutableDictionary *)result {
     NSLog(@"snippetCaptureResponse Response : %@ ", result);
    
    NSMutableDictionary *retriedDict = [result objectForKey:@"Result"];
    
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
            
            int nextIndex = [_pageControlFields indexOfObject:@"SnippetView"];
            
            UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
            if ( [nextCntroller isKindOfClass:([SnippetViewController class])] ) {
                [((SnippetViewController *)nextCntroller) setResultData:result];
            }
        
            currentIndex = nextIndex;
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
    
    
}

//Face Detection Response
-(void)faceDetectionResponse : (NSMutableDictionary*) result {
    NSLog(@"faceDetectionResponse Response : %@ ", result);
    //    resultTextView.text = [NSString stringWithFormat:@"Result Object: %@", result];
    
    NSString *face = [result objectForKey:@"FACE"];
    NSString *processedFace = [result objectForKey:@"PROCESSED_FACE"];
    NSString *ovalFace = [result objectForKey:@"OVAL_FACE"];
    
    if(nil != face){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:face options:0];
        UIImage* image = [UIImage imageWithData:data];
        if(![ArrayObjectController getEnableCaptureEmployee]) {
            
            int nextIndex = [_pageControlFields indexOfObject:@"SelfieCapture"];
            
            UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
            if ( [nextCntroller isKindOfClass:([SelfieCaptureController class])] ) {
                [((SelfieCaptureController *)nextCntroller) setResultImage:result];
            }
            currentIndex = nextIndex;
            
        } else {
            int nextIndex = [_pageControlFields indexOfObject:@"SelfieEmployee"];
            
            UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
            if ( [nextCntroller isKindOfClass:([SelfieEmployeeController class])] ) {
                [((SelfieEmployeeController *)nextCntroller) setResultImage:result];
            }
            currentIndex = nextIndex;
        }
        
    } else if ([@"5" isEqualToString:[result objectForKey:@"statusCode"]]) {
        int nextIndex = [_pageControlFields indexOfObject:@"SelfieCapture"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([SelfieCaptureController class])] ) {
            [((SelfieCaptureController *)nextCntroller) setResultImage:result];
        }
        currentIndex = nextIndex;
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//Signature Capture Response
-(void)captureSignatureResponse : (NSMutableDictionary*) result {
    NSLog(@"Capture Signature Response");
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        NSString *signatureCaptureImage = [result objectForKey:@"signatureImage"];
        if(nil != signatureCaptureImage) {
            NSData* data = [[NSData alloc] initWithBase64EncodedString:signatureCaptureImage options:0];
            UIImage* image = [UIImage imageWithData:data];
            
            int nextIndex = [_pageControlFields indexOfObject:@"SignatureCapture"];
            
            UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
            if ( [nextCntroller isKindOfClass:([FirstViewController class])] ) {
                [((FirstViewController *)nextCntroller) setResultImage:image];
            }
            
            currentIndex = nextIndex;
        }
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//Barcode Response
-(void)scanBarcodeResponse : (NSMutableDictionary*) result {
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        NSLog(@"Barcode Scan Response");
       
//        NSString *barcodeImage = [result objectForKey:@"defaultBarcodeImage"];
//        if(nil != barcodeImage) {
        if([result objectForKey:@"defaultBarcodeImage"]) {
//            NSData* data = [[NSData alloc] initWithBase64EncodedString:barcodeImage options:0];
//            UIImage* image = [UIImage imageWithData:data];
            
            int nextIndex = [_pageControlFields indexOfObject:@"BarcodeScan"];
            
            UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
            if ( [nextCntroller isKindOfClass:([SanBarcodeViewController class])] ) {
//                [((SanBarcodeViewController *)nextCntroller) setResultImage:image];
                [((SanBarcodeViewController *)nextCntroller) setResultImage:result];
            }
            
            currentIndex = nextIndex;
        }
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//Voice Recording Response
-(void)voiceRecordingResponse : (NSMutableDictionary*) result {
    NSLog(@"Voice Recording Response ");

    int nextIndex = [_pageControlFields indexOfObject:@"VoiceCapture"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([ThirdViewController class])] ) {
        [((ThirdViewController *)nextCntroller) voiceResponse:result];
    }
    
    currentIndex = nextIndex;
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
      //  [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//VideoRecording Response
-(void)videoRecordingResponse:(NSMutableDictionary*) result {
    NSLog(@"Video Recording Response ");
    int nextIndex = [_pageControlFields indexOfObject:@"VideoView"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([VideoViewController class])] ) {
        [((VideoViewController *)nextCntroller) videoResponse:result];
    }
    
    currentIndex = nextIndex;
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//Generic Document Capture
-(void)genericDocumentResponse : (NSMutableDictionary*) result {
    NSLog(@"genericDocumentResponse Response : %@ ", result);
    //genericDocResponse
    int nextIndex = [_pageControlFields indexOfObject:@"DocumentCapture"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([SecondViewController class])] ) {
        [((SecondViewController *)nextCntroller) genericDocResponse:result];
    }
    
    currentIndex = nextIndex;
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
      //  [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

//GPS Capture Response
-(void)gpsCoordinateResponse : (NSMutableDictionary*) result {
    NSLog(@"GPS coordinate Response");
    
    int nextIndex = [_pageControlFields indexOfObject:@"LocationView"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([LocationViewController class])] ) {
        [((LocationViewController *)nextCntroller) gpsResponse:result];
    }
    
    currentIndex = nextIndex;
}

//4F fingerprint response
-(void)fourFingerprintDetectionResponse : (NSMutableDictionary*) result {
    NSLog(@"captureFingerprintResponse Response : %@ ", result);
    
    int nextIndex = [_pageControlFields indexOfObject:@"FingerPrint"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([FingerPrintViewController class])] ) {
        [((FingerPrintViewController *)nextCntroller) fourFingerResponse:result];
    }
    
    currentIndex = nextIndex;
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
       // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
    
}

-(void)videoConferencingResponse : (NSMutableDictionary*) result{
    NSLog(@"Video conferencing response::: %@", result);
    
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        NSLog(@"Video Conference Response");
        
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
        // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
    
    int nextIndex = [_pageControlFields indexOfObject:@"VideoConference"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    if ( [nextCntroller isKindOfClass:([VideoConfViewController class])] ) {
        [((VideoConfViewController *)nextCntroller) setResult:result];
    }
    
}

//Proof of Address response
-(void)proofOfAddressDetectionResponse : (NSMutableDictionary*) result {
    NSLog(@"proofOfAddressDetectionResponse Response : %@ ", result);
    NSString *poa = [result objectForKey:@"POA_IMAGE"];
    if(nil != poa){
        
        NSData* data = [[NSData alloc] initWithBase64EncodedString:poa options:0];
        UIImage* image = [UIImage imageWithData:data];
        int nextIndex = [_pageControlFields indexOfObject:@"poacaptureview"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([POACaptureViewController class])] ) {
            [((POACaptureViewController *)nextCntroller) setResultImage:image];
        }
        
        currentIndex = nextIndex;
        
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
        //[self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}

-(void)cardDetectionResponse:(NSMutableDictionary *)result{
    
    NSLog(@"Card Scan Response");
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        int nextIndex = [_pageControlFields indexOfObject:@"CardScan"];
        
        UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
        if ( [nextCntroller isKindOfClass:([CardScanController class])] ) {
            [((CardScanController *)nextCntroller) setResultImage:result];
        }
        
        currentIndex = nextIndex;
        
    }
    
    if(![@"Success" isEqualToString:[result objectForKey:@"statusMessage"]]) {
        // [self snackBarView:[result objectForKey:@"statusMessage"]];
    }
}


-(void)settingSelfieEmployeeIndex {
      int nextIndex = [_pageControlFields indexOfObject:@"SelfieEmployee"];
    
    UIViewController *nextCntroller = [self returnControllerWithIdentifier:_pageControlFields[nextIndex] controllerIndex:nextIndex];
    
    currentIndex = nextIndex;
    
    [self setViewControllers:@[nextCntroller]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

-(void)snackBarView:(NSString*)snackMessage {
    
    //    int width = self.navigationController.view.frame.size.width;
    //    int height = self.navigationController.view.frame.size.height;
    
//    int height = self.view.frame.size.height;
//    int width = self.view.frame.size.width;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if(!isSnackBarVisible) {
    showMSGLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - (height/100)*8 + (height/100)*8, width, (height/100)*8)];
    [showMSGLabel setText:snackMessage];
    [showMSGLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#5D5A59" alpha:1.0]];
    [showMSGLabel setTextAlignment:NSTextAlignmentCenter];
    [showMSGLabel setTextColor:[UIColor whiteColor]];
    //    [self.navigationController.view addSubview:showMSGLabel];
    [self.navigationController.view addSubview:showMSGLabel];
    [self.navigationController.view bringSubviewToFront:showMSGLabel];
    isSnackBarVisible = true;
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

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end

