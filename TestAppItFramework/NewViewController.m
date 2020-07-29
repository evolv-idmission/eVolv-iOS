//
//  NewViewController.m
//  AppItDepedency
//
//  Created by  on 09/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "NewViewController.h"
#import "ArrayObjectController.h"
#import "AccountSetUpViewController.h"
#import "AppDelegate.h"
#import "LabelUtils.h"
#import "CustomizeUIConfigManager.h"

@interface NewViewController ()

@end

@implementation NewViewController {
    UIButton *Continuebutton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)viewDidAppear:(BOOL)animated {
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    
    [self.view setUserInteractionEnabled:YES];
    // FlashScreen
    UIImageView *evolveImage = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - (width/100)*40, (height/100)*35, (width/100)*80, (height/100)*20)];
    [evolveImage setContentMode:UIViewContentModeScaleAspectFit];
    [evolveImage setImage:[UIImage imageNamed:@"evolve.png"]];
    //[evolveImage setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:evolveImage];
    
    Continuebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(width/2 - (width/100)*25, (height/100)*65, (width/100)*50, (height/100)*6);
    [Continuebutton setFrame:frame];
    Continuebutton.layer.cornerRadius = 18;
    Continuebutton.clipsToBounds = YES;
    [Continuebutton setTitle:[LabelUtils getLabelForKey:@"continue_btn"]forState:UIControlStateNormal];
    Continuebutton.titleLabel.textColor = [UIColor whiteColor];
    [Continuebutton setBackgroundColor:[UIColor blackColor]];
    [Continuebutton addTarget:self action:@selector(continuebtn:) forControlEvents:UIControlEventTouchUpInside];
    [Continuebutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:Continuebutton];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*80, (width/100)*50, (height/100)*4)];
    NSString * version = nil;
    version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (!version) {
        version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    NSString * buildnumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSMutableString *versionString = [NSMutableString stringWithFormat:@"%@ %@(%@)", [LabelUtils getLabelForKey:@"version"], version, buildnumber];
    [versionLabel setText:versionString];
    [versionLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont* itallicFont = [UIFont italicSystemFontOfSize:[UIFont systemFontSize]];
    [versionLabel setFont:itallicFont];
    [self.view addSubview:versionLabel];
    
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [CustomizeUIConfigManager initCustomizeUIConfig];
}

-(void)continuePlease:(id)sender {
    NSLog(@"Touch UP inside");
}

-(void)continuebtn:(UIButton*)button {
    AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

//ImageProcessingResponse Listener
-(void)initializeSDKResponse : (NSMutableDictionary*) result {
    NSLog(@"initializeSDKResponse Response : %@ ", result);
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


@end
