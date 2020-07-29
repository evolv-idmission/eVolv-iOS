//
//  OpenCvViewController.h
//  appit-ios
//
//  Created by Goran Rauker on 2/2/15.
//  Copyright (c) 2015 IDMission. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "TargetRectangle.h"
#import "NSStringUtils.h"
#import "AppItSDK.h"
#import "SnippetCaptureController.h"

@interface OpenCvViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate> {

    IBOutlet UIView *baseView;
    IBOutlet UIView *previewView;
    IBOutlet TargetRectangle *targetRectangle;
    IBOutlet UIProgressView *progressView;
    IBOutlet UILabel *textView;
   // IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *intensityAndFocusTextView;
    IBOutlet UILabel *documentNameLabel;
    IBOutlet UIButton *backButton;
//    IBOutlet UIButton *backPortraitButton;
    IBOutlet UIButton *backButtonPortrait;
    IBOutlet UIButton *rotatePortraitButton;
    IBOutlet UIButton *rotateLandscapeButton;
    IBOutlet UIButton *captureButton;
    
    AVCaptureVideoPreviewLayer *previewLayer;
    AVCaptureVideoDataOutput *videoDataOutput;

    dispatch_queue_t videoDataOutputQueue;
    

}

@property(nonatomic,assign)id delegate;

@property(nonatomic) BOOL capture_in_portrait_mode;
@property(nonatomic) BOOL capturedImagePressed;
@property(nonatomic) int imageWidth;
@property(nonatomic) int imageHeight;
@property(nonatomic) NSString *imageType;
@property(nonatomic) NSMutableDictionary *resultDictionary;

@property(nonatomic)  size_t MinImageIntensity;
@property(nonatomic)  size_t MinImageFocusScore;
@property(nonatomic) BOOL enable_glare_detection;
@property(nonatomic, assign) int glare_percentage_threshold;
//(nonatomic) BOOL enable_capture_button;
@property(nonatomic, assign) int enable_capture_button_time;
@property(nonatomic, assign) NSString *id_outline_color;
@property(nonatomic, assign) int id_outline_color_alpha;
@property(nonatomic, assign) NSString *id_outline_outside_color;
@property(nonatomic, assign) int id_outline_outside_color_alpha;
@property(nonatomic, assign) NSString *detected_id_outline_color;
@property(nonatomic, assign) int detected_id_outline_color_alpha;
@property(nonatomic, assign) NSString *title_message_style;
@property(nonatomic, assign) NSString *hint_message_style;
@property(nonatomic, assign) NSString *title_message_color;
@property(nonatomic, assign) NSString *hint_message_color;
@property(nonatomic, assign) int title_message_color_alpha;
@property(nonatomic, assign) int hint_message_color_alpha;
@property(nonatomic, assign) NSString *back_button_color;
@property(nonatomic, assign) int back_button_color_alpha;
@property(nonatomic, assign) NSString *text_font_size;
@property(nonatomic, assign) NSString *header_font_size;

@property(nonatomic) NSString *genericFieldName;
@property(nonatomic) int mrzRetryCount;
@property(nonatomic) int mrzAndBarcodeRetryCount;

- (IBAction)rotatePortrait:(id)sender;
- (IBAction)rotateLandscape:(id)sender;
- (IBAction)backPressedLandscape:(id)sender;
- (IBAction)backPressedPortrait:(id)sender;
- (IBAction)captureImage:(id)sender;

@end
