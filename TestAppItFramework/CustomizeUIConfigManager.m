//
//  CustomizeUIConfigManager.m
//  AppItDepedency
//
//  Created by Sanket Garde on 04/06/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import "CustomizeUIConfigManager.h"

static CustomizeUIConfig *id_capture_front_ui_config, *id_capture_back_ui_config, *doc_capture_ui_config, *snippet_capture_ui_config, *face_capture_ui_config, *fp_capture_ui_config, *slant_capture_ui_config, *id_capture_front_ui_config_secondary, *id_capture_back_ui_config_secondary, *voice_capture_ui_config;

@implementation CustomizeUIConfigManager

//Default UI configuration getter/setter
+(CustomizeUIConfig *)getDefaultIDCaptureFrontConfig {
    return id_capture_front_ui_config;
}

+(CustomizeUIConfig *)getDefaultSecondaryIDCaptureFrontConfig {
    return id_capture_front_ui_config_secondary;
}

+(CustomizeUIConfig *)getDefaultIDCaptureBackConfig {
    return id_capture_back_ui_config;
}

+(CustomizeUIConfig *)getDefaultSecondaryIDCaptureBackConfig {
    return id_capture_back_ui_config_secondary;
}

+(CustomizeUIConfig *)getDefaultDocCaptureConfig {
    return doc_capture_ui_config;
}

+(CustomizeUIConfig *)getDefaultSnippetCaptureConfig {
    return snippet_capture_ui_config;
}

+(CustomizeUIConfig *)getDefaultFaceCaptureConfig {
    return face_capture_ui_config;
}

+(CustomizeUIConfig *)getDefaultFingerPrintCaptureConfig {
    return fp_capture_ui_config;
}

+(CustomizeUIConfig *)getDefaultSlantCaptureConfig {
    return slant_capture_ui_config;
}

+(CustomizeUIConfig *)getDefaultVoiceCaptureConfig {
    return voice_capture_ui_config;
}

+(void)initCustomizeUIConfig {
    
    NSMutableDictionary *idCaptureFrontConfig = [self retrieveSetting:@"id_capture_front" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureBackConfig = [self retrieveSetting:@"id_capture_back" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *docCaptureConfig = [self retrieveSetting:@"document_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *snippetCaptureConfig = [self retrieveSetting:@"snippet_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *faceCaptureConfig = [self retrieveSetting:@"face_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *fpCaptureConfig = [self retrieveSetting:@"camera_finger_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *slantCaptureConfig = [self retrieveSetting:@"slant_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureFrontConfig_secondary = [self retrieveSetting:@"secondary_id_capture_front" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureBackConfig_secondary = [self retrieveSetting:@"secondary_id_capture_back" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *voiceCaptureConfig = [self retrieveSetting:@"voice_recording" defaultValue:[[NSMutableDictionary alloc] init]];
    
//    NSMutableDictionary *jsonConfigDta = [self JSONFromFile];
//
//    NSMutableDictionary *mutableJSONConfigData = [jsonConfigDta mutableCopy];
    
    NSString *language = [self retrieveSetting_String:@"language" defaultValue:@"en"];
    NSMutableDictionary *mutableJSONConfigData;
    if([@"es" isEqualToString:language]) {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization_es"];
        
        mutableJSONConfigData = [jsonConfigDta mutableCopy];
        
    } else if([@"my" isEqualToString:language]) {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization_my"];
        
        mutableJSONConfigData = [jsonConfigDta mutableCopy];
        
    } else {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization"];
        
        mutableJSONConfigData = [jsonConfigDta mutableCopy];
        
    }
    
    //Front
    if(nil == idCaptureFrontConfig || [idCaptureFrontConfig count] == 0) {
        idCaptureFrontConfig = [[mutableJSONConfigData objectForKey:@"id_capture_front"] mutableCopy];
    }
    
    if(nil == id_capture_front_ui_config) {
        id_capture_front_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [id_capture_front_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:idCaptureFrontConfig] mutableCopy]];
    [id_capture_front_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:idCaptureFrontConfig] mutableCopy]];
    
    //Secondary Front
    if(nil == idCaptureFrontConfig_secondary || [idCaptureFrontConfig_secondary count] == 0) {
        idCaptureFrontConfig_secondary = [[mutableJSONConfigData objectForKey:@"secondary_id_capture_front"] mutableCopy];
    }
    
    if(nil == id_capture_front_ui_config_secondary) {
        id_capture_front_ui_config_secondary = [[CustomizeUIConfig alloc] init];
    }
    [id_capture_front_ui_config_secondary setUiConfiguration:[[self generateUIConfigKeyValuePair:idCaptureFrontConfig_secondary] mutableCopy]];
    [id_capture_front_ui_config_secondary setLabelConfiguration:[[self generateLabelConfigKeyValuePair:idCaptureFrontConfig_secondary] mutableCopy]];
    
    //Back
    if(nil == idCaptureBackConfig || [idCaptureBackConfig count] == 0) {
        idCaptureBackConfig = [[mutableJSONConfigData objectForKey:@"id_capture_back"] mutableCopy];
    }
    
    if(nil == id_capture_back_ui_config) {
        id_capture_back_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [id_capture_back_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:idCaptureBackConfig] mutableCopy]];
    [id_capture_back_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:idCaptureBackConfig] mutableCopy]];
    
    //Secondary Back
    if(nil == idCaptureBackConfig_secondary || [idCaptureBackConfig_secondary count] == 0) {
        idCaptureBackConfig_secondary = [[mutableJSONConfigData objectForKey:@"secondary_id_capture_back"] mutableCopy];
    }
    
    if(nil == id_capture_back_ui_config_secondary) {
        id_capture_back_ui_config_secondary = [[CustomizeUIConfig alloc] init];
    }
    [id_capture_back_ui_config_secondary setUiConfiguration:[[self generateUIConfigKeyValuePair:idCaptureBackConfig_secondary] mutableCopy]];
    [id_capture_back_ui_config_secondary setLabelConfiguration:[[self generateLabelConfigKeyValuePair:idCaptureBackConfig_secondary] mutableCopy]];
    
    //Document
    if(nil == docCaptureConfig || [docCaptureConfig count] == 0) {
        docCaptureConfig = [[mutableJSONConfigData objectForKey:@"document_capture"] mutableCopy];
    }
    
    if(nil == doc_capture_ui_config) {
        doc_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [doc_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:docCaptureConfig] mutableCopy]];
    [doc_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:docCaptureConfig] mutableCopy]];
    
    //Snippet
    if(nil == snippetCaptureConfig || [snippetCaptureConfig count] == 0) {
        snippetCaptureConfig = [[mutableJSONConfigData objectForKey:@"snippet_capture"] mutableCopy];
    }
    
    if(nil == snippet_capture_ui_config) {
        snippet_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [snippet_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:snippetCaptureConfig] mutableCopy]];
    [snippet_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:snippetCaptureConfig] mutableCopy]];
    
    //Face
    if(nil == faceCaptureConfig || [faceCaptureConfig count] == 0) {
        faceCaptureConfig = [[mutableJSONConfigData objectForKey:@"face_capture"] mutableCopy];
    }
    
    if(nil == face_capture_ui_config) {
        face_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [face_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:faceCaptureConfig] mutableCopy]];
    [face_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:faceCaptureConfig] mutableCopy]];
    
    //Four Finger
    if(nil == fpCaptureConfig || [fpCaptureConfig count] == 0) {
        fpCaptureConfig = [[mutableJSONConfigData objectForKey:@"camera_finger_capture"] mutableCopy];
    }
    
    if(nil == fp_capture_ui_config) {
        fp_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [fp_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:fpCaptureConfig] mutableCopy]];
    [fp_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:fpCaptureConfig] mutableCopy]];
    
    //Slant
    if(nil == slantCaptureConfig || [slantCaptureConfig count] == 0) {
        slantCaptureConfig = [[mutableJSONConfigData objectForKey:@"slant_capture"] mutableCopy];
    }
    
    if(nil == slant_capture_ui_config) {
        slant_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [slant_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:slantCaptureConfig] mutableCopy]];
    [slant_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:slantCaptureConfig] mutableCopy]];
    
    //Voice Capture
    if(nil == voiceCaptureConfig || [voiceCaptureConfig count] == 0) {
        voiceCaptureConfig = [[mutableJSONConfigData objectForKey:@"voice_recording"] mutableCopy];
    }
    
    if(nil == voice_capture_ui_config) {
        voice_capture_ui_config = [[CustomizeUIConfig alloc] init];
    }
    [voice_capture_ui_config setUiConfiguration:[[self generateUIConfigKeyValuePair:voiceCaptureConfig] mutableCopy]];
    [voice_capture_ui_config setLabelConfiguration:[[self generateLabelConfigKeyValuePair:voiceCaptureConfig] mutableCopy]];
}

+(NSMutableDictionary*)retrieveSetting:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}


+(NSMutableDictionary*)retrieveSetting:(NSString*)key defaultValue:(NSMutableDictionary*)defaultValue{
    NSMutableDictionary *val = [self retrieveSetting:key];
    if(val != nil){
        return val;
    }else{
        return defaultValue;
    }
}

+(void)saveSetting:(NSString*)key value:(NSMutableDictionary*)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (NSMutableDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"evolv_ui_customization" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (NSMutableDictionary *)JSONFromFile:(NSString *)fileName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
}

+(NSMutableDictionary *) generateUIConfigKeyValuePair:(NSMutableDictionary *) jsonObject {
    
    //    NSMutableDictionary *configJSONObj = jsonObject;
    //
    //    if([configJSONObj objectForKey:@"labels"]) {
    //        [configJSONObj removeObjectForKey:@"labels"];
    //    }
    
    return jsonObject;
}

+(NSMutableDictionary *) generateLabelConfigKeyValuePair:(NSMutableDictionary *) jsonObject {
    
    NSMutableDictionary *configJSONObj = jsonObject;
    
    NSMutableDictionary *labelObject = [configJSONObj objectForKey:@"labels"];
    
    return labelObject;
}

+(NSMutableDictionary *) getUIConfigDictionary:(NSString *)featureType {
    
    NSMutableDictionary *uiConfig, *labelConfig;
    if([@"id_capture_front" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultIDCaptureFrontConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultIDCaptureFrontConfig] getLabelConfiguration];
        
    } else if([@"id_capture_back" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultIDCaptureBackConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultIDCaptureBackConfig] getLabelConfiguration];
        
    } else if([@"document_capture" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultDocCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultDocCaptureConfig] getLabelConfiguration];
        
    } else if([@"snippet_capture" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultSnippetCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultSnippetCaptureConfig] getLabelConfiguration];
        
    } else if([@"face_capture" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultFaceCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultFaceCaptureConfig] getLabelConfiguration];
        
    } else if([@"camera_finger_capture" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultFingerPrintCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultFingerPrintCaptureConfig] getLabelConfiguration];
        
    } else if([@"slant_capture" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultSlantCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultSlantCaptureConfig] getLabelConfiguration];
        
    } else if([@"secondary_id_capture_front" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureFrontConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureFrontConfig] getLabelConfiguration];
        
    } else if([@"secondary_id_capture_back" isEqualToString:featureType]) {
        
        uiConfig = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureBackConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultSecondaryIDCaptureBackConfig] getLabelConfiguration];
        
    } else if([@"voice_recording" isEqualToString:featureType]) {
        uiConfig = [[CustomizeUIConfigManager getDefaultVoiceCaptureConfig] getUIConfiguration];
        labelConfig = [[CustomizeUIConfigManager getDefaultVoiceCaptureConfig] getLabelConfiguration];
    }
    
    if((nil == uiConfig && nil == labelConfig) || (nil == uiConfig)) {
        uiConfig = [[NSMutableDictionary alloc] init];
    }
    
    if(nil != uiConfig) {
        if(nil == labelConfig) {
            labelConfig = [[NSMutableDictionary alloc] init];
        }
        [uiConfig setObject:labelConfig forKey:@"labels"];
    }
    
    return uiConfig;
}

+(void) storeConfig:(NSString *)featureType {
    NSMutableDictionary *uiJson = [self getUIConfigDictionary:featureType];
    
    if(nil != uiJson) {
        [self saveSetting:featureType value:uiJson];
    }
}

+(NSMutableDictionary *) getCompleteUIConfigDictionary {
    
    NSMutableDictionary *uiCofig = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *idFrontConfig = [self getUIConfigDictionary:@"id_capture_front"];
    NSMutableDictionary *idBacktConfig = [self getUIConfigDictionary:@"id_capture_back"];
    NSMutableDictionary *docConfig = [self getUIConfigDictionary:@"document_capture"];
    NSMutableDictionary *snippetConfig = [self getUIConfigDictionary:@"snippet_capture"];
    NSMutableDictionary *faceCaptureConfig = [self getUIConfigDictionary:@"face_capture"];
    NSMutableDictionary *fingerConfig = [self getUIConfigDictionary:@"camera_finger_capture"];
    NSMutableDictionary *slantCaptureConfig = [self getUIConfigDictionary:@"slant_capture"];
    NSMutableDictionary *idFrontConfig_secondary = [self getUIConfigDictionary:@"secondary_id_capture_front"];
    NSMutableDictionary *idBacktConfig_secondary = [self getUIConfigDictionary:@"secondary_id_capture_back"];
    NSMutableDictionary *voiceCaptureConfig = [self getUIConfigDictionary:@"voice_recording"];
    
    [uiCofig setObject:idFrontConfig forKey:@"id_capture_front"];
    [uiCofig setObject:idBacktConfig forKey:@"id_capture_back"];
    [uiCofig setObject:docConfig forKey:@"document_capture"];
    [uiCofig setObject:snippetConfig forKey:@"snippet_capture"];
    [uiCofig setObject:faceCaptureConfig forKey:@"face_capture"];
    [uiCofig setObject:fingerConfig forKey:@"camera_finger_capture"];
    [uiCofig setObject:slantCaptureConfig forKey:@"slant_capture"];
    [uiCofig setObject:idFrontConfig_secondary forKey:@"secondary_id_capture_front"];
    [uiCofig setObject:idBacktConfig_secondary forKey:@"secondary_id_capture_back"];
    [uiCofig setObject:voiceCaptureConfig forKey:@"voice_recording"];
    
    return uiCofig;
    
}

+(void)reinitWithLanguageChange:(NSString *)language {
    
    NSMutableDictionary *idCaptureFrontConfig = [self retrieveSetting:@"id_capture_front" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureBackConfig = [self retrieveSetting:@"id_capture_back" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *docCaptureConfig = [self retrieveSetting:@"document_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *snippetCaptureConfig = [self retrieveSetting:@"snippet_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *faceCaptureConfig = [self retrieveSetting:@"face_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *fpCaptureConfig = [self retrieveSetting:@"camera_finger_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *slantCaptureConfig = [self retrieveSetting:@"slant_capture" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureFrontConfig_secondary = [self retrieveSetting:@"secondary_id_capture_front" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *idCaptureBackConfig_secondary = [self retrieveSetting:@"secondary_id_capture_back" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *voiceCaptureConfig = [self retrieveSetting:@"voice_recording" defaultValue:[[NSMutableDictionary alloc] init]];
    
    NSMutableDictionary *uiConfigJson;
    if([@"es" isEqualToString:language]) {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization_es"];
        
        uiConfigJson = [jsonConfigDta mutableCopy];
        
    } else if([@"my" isEqualToString:language]) {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization_my"];
        
        uiConfigJson = [jsonConfigDta mutableCopy];
        
    } else {
        
        NSMutableDictionary *jsonConfigDta = [self JSONFromFile:@"evolv_ui_customization"];
        
        uiConfigJson = [jsonConfigDta mutableCopy];
        
    }
    
    
    if(nil != idCaptureFrontConfig && [idCaptureFrontConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"id_capture_front"] mutableCopy];
        
        NSMutableDictionary *id_capture_front_config = [idCaptureFrontConfig mutableCopy];
        [id_capture_front_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"id_capture_front" value:id_capture_front_config];
        
    }
    
    if(nil != idCaptureFrontConfig_secondary && [idCaptureFrontConfig_secondary count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"secondary_id_capture_front"] mutableCopy];
        
        NSMutableDictionary *id_capture_front_config_secondary = [idCaptureFrontConfig_secondary mutableCopy];
        [id_capture_front_config_secondary setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"secondary_id_capture_front" value:id_capture_front_config_secondary];
        
    }
    
    if(nil != idCaptureBackConfig && [idCaptureBackConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"id_capture_back"] mutableCopy];
        
        NSMutableDictionary *id_capture_back_config = [idCaptureBackConfig mutableCopy];
        [id_capture_back_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"id_capture_back" value:id_capture_back_config];
        
    }
    
    if(nil != idCaptureBackConfig_secondary && [idCaptureBackConfig_secondary count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"secondary_id_capture_back"] mutableCopy];
        
        NSMutableDictionary *id_capture_back_config_secondary = [idCaptureBackConfig_secondary mutableCopy];
        [id_capture_back_config_secondary setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"id_capture_back" value:id_capture_back_config_secondary];
        
    }
    
    if(nil != docCaptureConfig && [docCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"document_capture"] mutableCopy];
        
        NSMutableDictionary *doc_capture_config = [docCaptureConfig mutableCopy];
        [doc_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"document_capture" value:doc_capture_config];
        
    }
    
    if(nil != snippetCaptureConfig && [snippetCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"snippet_capture"] mutableCopy];
        
        NSMutableDictionary *snippet_capture_config = [snippetCaptureConfig mutableCopy];
        [snippet_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"snippet_capture" value:snippet_capture_config];
        
    }
    
    if(nil != faceCaptureConfig && [faceCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"face_capture"] mutableCopy];
        
        NSMutableDictionary *face_capture_config = [faceCaptureConfig mutableCopy];
        [face_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"face_capture" value:face_capture_config];
        
    }
    
    if(nil != fpCaptureConfig && [fpCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"camera_finger_capture"] mutableCopy];
        
        NSMutableDictionary *finger_capture_config = [fpCaptureConfig mutableCopy];
        [finger_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"camera_finger_capture" value:finger_capture_config];
        
    }
    
    if(nil != slantCaptureConfig && [slantCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"slant_capture"] mutableCopy];
        
        NSMutableDictionary *slant_capture_config = [slantCaptureConfig mutableCopy];
        [slant_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"slant_capture" value:slant_capture_config];
        
    }
    
    if(nil != voiceCaptureConfig && [voiceCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"camera_finger_capture"] mutableCopy];
        
        NSMutableDictionary *finger_capture_config = [fpCaptureConfig mutableCopy];
        [finger_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"camera_finger_capture" value:finger_capture_config];
        
    }
    
    if(nil != voiceCaptureConfig && [voiceCaptureConfig count] > 0) {
        NSMutableDictionary *defaultConfig = [[uiConfigJson objectForKey:@"voice_recording"] mutableCopy];
        
        NSMutableDictionary *voice_capture_config = [voiceCaptureConfig mutableCopy];
        [voice_capture_config setObject:[[defaultConfig objectForKey:@"labels"] mutableCopy] forKey:@"labels"];
        [self saveSetting:@"voice_recording" value:voice_capture_config];
        
    }
    
}


+(NSString*)retrieveSetting_String:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+(NSString*)retrieveSetting_String:(NSString*)key defaultValue:(NSString*)defaultValue{
    NSString *val = [self retrieveSetting_String:key];
    if(val != nil){
        return val;
    }else{
        return defaultValue;
    }
}

@end
