//
//  LabelUtils.m
//  AppItDepedency
//
//  Created by  on 04/04/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import "LabelUtils.h"
#import "NSStringUtilsDemo.h"

static NSMutableDictionary* currentSDKLabels;
static NSMutableDictionary* pickersSDKLabels;

@implementation LabelUtils

+(NSString*)getKeyForLabel:(NSString*)label {
    NSArray *keyArray = [[NSArray alloc] init];
    if(currentSDKLabels == nil || [currentSDKLabels count] == 0){
        [self initializeCurrentLabels:@"en"];
    }
    keyArray = [currentSDKLabels allKeysForObject:label];
    
    return keyArray[0];
}

+(NSString*)getKeyForPickerLabel:(NSString*)label {
    NSArray *keyArray = [[NSArray alloc] init];
    if(pickersSDKLabels == nil || [pickersSDKLabels count] == 0){
        [self initializePickerLabels:@"en"];
    }
    keyArray = [pickersSDKLabels allKeysForObject:label];
    
    return keyArray[0];
}

+(NSString*)getLabelForKey:(NSString*)key{
    NSString *label = @"";
    if(currentSDKLabels == nil || [currentSDKLabels count] == 0){
        [self initializeCurrentLabels:@"en"];       //Init with default language
    }
    if([NSStringUtilsDemo stringIsNilOrEmpty:label]){
        label = [currentSDKLabels objectForKey:key];//If custom label is not available use default value
    }
    return label;
}

+(NSString*)getLabelForPickerKey:(NSString*)key{
    NSString *label = @"";
    if(pickersSDKLabels == nil || [pickersSDKLabels count] == 0){
        [self initializePickerLabels:@"en"];       //Init with default language
    }
    if([NSStringUtilsDemo stringIsNilOrEmpty:label]){
        label = [pickersSDKLabels objectForKey:key];//If custom label is not available use default value
    }
    return label;
}

+(void) initializePickerLabels:(NSString*)language {
    NSString *lang = @"en"; //Default language
    
    if(pickersSDKLabels == nil){
        pickersSDKLabels = [NSMutableDictionary new];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:language] && [self isLanguageSupported:language]){
        lang = language;
    }
    
    if([lang isEqualToString:@"es"]) {
        [pickersSDKLabels setObject:@"Parte superior" forKey:@"Top"];
        [pickersSDKLabels setObject:@"Centrar" forKey:@"Center"];
        [pickersSDKLabels setObject:@"Fondo" forKey:@"Bottom"];
    } else {
        [pickersSDKLabels setObject:@"Top" forKey:@"Top"];
        [pickersSDKLabels setObject:@"Center" forKey:@"Center"];
        [pickersSDKLabels setObject:@"Bottom" forKey:@"Bottom"];
    }
}

+(void)initializeCurrentLabels:(NSString*)language{
    
    NSString *lang = @"en"; //Default language
    
    if(currentSDKLabels == nil){
        currentSDKLabels = [NSMutableDictionary new];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:language] && [self isLanguageSupported:language]){
        lang = language;
    }
    
    if([lang isEqualToString:@"es"]){
        
        //Account Setup
        // [currentSDKLabels setObject:@"Account Setup" forKey:@"account_setup"];
        [currentSDKLabels setObject:@"URL de prueba" forKey:@"test_url"];
        [currentSDKLabels setObject:@"Nombre de usuario" forKey:@"login_id"];
        [currentSDKLabels setObject:@"Contraseña" forKey:@"password"];
        [currentSDKLabels setObject:@"ID del comerciante" forKey:@"merchant_id"];
        [currentSDKLabels setObject:@"ID del producto" forKey:@"product_id"];
        [currentSDKLabels setObject:@"Nombre del producto" forKey:@"product"];
        [currentSDKLabels setObject:@"Idioma" forKey:@"language"];
        [currentSDKLabels setObject:@"Guardar cuenta" forKey:@"save_account"];
        [currentSDKLabels setObject:@"Editar cuenta" forKey:@"edit_account"];
        [currentSDKLabels setObject:@"Modo de depuración" forKey:@"debaug_mode"];
        [currentSDKLabels setObject:@"INICIALIZAR" forKey:@"initialize"];
        [currentSDKLabels setObject:@"INGRESE URL" forKey:@"enter_url"];
        [currentSDKLabels setObject:@"INGRESE NOMBRE DE USUARIO" forKey:@"enter_login_id"];
        [currentSDKLabels setObject:@"INGRESE CONTRASEÑA" forKey:@"enter_password"];
        [currentSDKLabels setObject:@"INGRESE ID DEL COMERCIANTE" forKey:@"enter_merchant_id"];
        [currentSDKLabels setObject:@"INGRESE ID DEL PRODUCTO" forKey:@"enter_product_id"];
        [currentSDKLabels setObject:@"INGRESE NOMBRE DEL PRODUCTO" forKey:@"enter_product_name"];
        [currentSDKLabels setObject:@"Apagar" forKey:@"off"];
        [currentSDKLabels setObject:@" Encender" forKey:@"on"];
        [currentSDKLabels setObject:@"Es necesario habilitar permisos a la camara." forKey:@"camera_permission"];//
        
        //Card Capture
        [currentSDKLabels setObject:@"Capturar" forKey:@"captute"];
        [currentSDKLabels setObject:@"< Atrás" forKey:@"back_capture"];
        [currentSDKLabels setObject:@"Siguiente >" forKey:@"next_capture"];
        [currentSDKLabels setObject:@"Detalles de la tarjeta" forKey:@"card_details"];
        
        //ID Capture
        [currentSDKLabels setObject:@"CONFIGURACIÓN" forKey:@"configuration"];
        [currentSDKLabels setObject:@"ID del color del contorno" forKey:@"id_outline_color"];
        [currentSDKLabels setObject:@"Transparencia (1-100)" forKey:@"transparency"];
        [currentSDKLabels setObject:@"ID del color del contorno detectado" forKey:@"detected_id_outline_color"];
        [currentSDKLabels setObject:@"Color fuera del contorno" forKey:@"color_outside_outline"];
        [currentSDKLabels setObject:@"Color detectado fuera del contorno" forKey:@"detected_color_outside_outline"];
        [currentSDKLabels setObject:@"Umbral de luz" forKey:@"light_threshold"];
        [currentSDKLabels setObject:@"Umbral de enfoque mínimo" forKey:@"min_focus_threshold"];
        [currentSDKLabels setObject:@"Umbral de enfoque máximo" forKey:@"max_focus_threshold"];
        [currentSDKLabels setObject:@"Porcentaje de deslumbramiento" forKey:@"glare_percentage"];
        [currentSDKLabels setObject:@"Habilitar el tiempo del botón de captura (segundo)" forKey:@"enable_capture_button_time"];
        [currentSDKLabels setObject:@"Tamaño máximo de la imagen (kb)" forKey:@"max_image_size"];
        [currentSDKLabels setObject:@"Altura de imagen" forKey:@"image_height"];
        [currentSDKLabels setObject:@"Ancho de la imagen" forKey:@"image_width"];
        [currentSDKLabels setObject:@"Tamaño de la etiqueta del texto en encabezado" forKey:@"header_text_label_size"];
        [currentSDKLabels setObject:@"Tamaño de etiqueta de texto" forKey:@"text_label_size"];
        [currentSDKLabels setObject:@"Tipo de fuente de texto" forKey:@"text_font_type"];
        [currentSDKLabels setObject:@"Estilo de letra del texto" forKey:@"text_font_style"];
        [currentSDKLabels setObject:@"Tipo de fuente del texto en encabezado" forKey:@"header_text_font_type"];
        [currentSDKLabels setObject:@"Estilo de fuente del texto en encabezado" forKey:@"header_text_font_style"];
        [currentSDKLabels setObject:@"Color de la etiqueta de texto" forKey:@"text_label_color"];
        [currentSDKLabels setObject:@"Color de la etiqueta del texto en encabezado" forKey:@"header_text_label_color"];
        [currentSDKLabels setObject:@"Color del botón trasero" forKey:@"back_button_color"];
        [currentSDKLabels setObject:@"Reintentar el color del botón" forKey:@"retry_button_color"];
        [currentSDKLabels setObject:@"Reintentar el color del borde del botón" forKey:@"retry_button_border_color"];
        [currentSDKLabels setObject:@"Confirmar el color del botón" forKey:@"confirm_button_color"];
        [currentSDKLabels setObject:@"Confirmar el estilo del botón" forKey:@"confirm_button_style"];
        [currentSDKLabels setObject:@"Color del botón de instrucción" forKey:@"instruction_button_color"];
        [currentSDKLabels setObject:@"Color de texto del botón de instrucción" forKey:@"instruction_button_text_color"];
        [currentSDKLabels setObject:@"ID del borde de captura" forKey:@"id_capture_border"];
        [currentSDKLabels setObject:@"Mostrar etiqueta de captura" forKey:@"show_capture_label"];
        [currentSDKLabels setObject:@"No" forKey:@"no"];
        [currentSDKLabels setObject:@"Sí" forKey:@"yes"];
        [currentSDKLabels setObject:@"Ingrese la etiqueta de captura" forKey:@"enter_capture_label"];
        [currentSDKLabels setObject:@"Orientación por defecto" forKey:@"default_orientation"];
        [currentSDKLabels setObject:@"Retrato" forKey:@"portrait"];
        [currentSDKLabels setObject:@"Paisaje" forKey:@"landscape"];
        [currentSDKLabels setObject:@"ID alineación del título de captura" forKey:@"id_capture_title_alignment"];
        [currentSDKLabels setObject:@"Ocultar ID título de captura" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"ID capturar la alineación en mensaje de sugerencia" forKey:@"id_capture_hint_message_alignment"];
        // [currentSDKLabels setObject:@"Ocultar ID mensaje de sugerencia" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"ID capturar la alineación de la imagen del título" forKey:@"id_capture_hint_message_alignment"];
        [currentSDKLabels setObject:@"Ocultar ID mensaje de sugerencia" forKey:@"hide_id_hint_message"];
        [currentSDKLabels setObject:@"ID captura de identificación" forKey:@"id_capture_title_image_alignment"];
        [currentSDKLabels setObject:@"Ocultar ID imagen del título" forKey:@"hide_id_title_image"];
        [currentSDKLabels setObject:@"ID captura de identificación" forKey:@"id_capture_label"];
        [currentSDKLabels setObject:@"Etiqueta en inglés" forKey:@"english_label"];
        [currentSDKLabels setObject:@"Añadir etiqueta" forKey:@"add_label"];
        [currentSDKLabels setObject:@"Guardar" forKey:@"save"];
        [currentSDKLabels setObject:@"Reiniciar" forKey:@"reset"];
        [currentSDKLabels setObject:@"Mostrar pantalla de instrucciones" forKey:@"show_inst_screen"];//
        [currentSDKLabels setObject:@"Mostrar titulo de la imagen" forKey:@"show_title_image"];//
        [currentSDKLabels setObject:@"Etiqueta en español" forKey:@"spanish_label"];
        
        //4F Capture
        [currentSDKLabels setObject:@"Umbral de enfoque" forKey:@"focus_threshold"];
        [currentSDKLabels setObject:@"Umbral de deslumbramiento" forKey:@"glare_threshold"];
        [currentSDKLabels setObject:@"No. de dedo para comprobar el enfoque" forKey:@"no_of_finger_to_check_focus"];
        [currentSDKLabels setObject:@"Umbral de huella digital" forKey:@"finger_print_threshold"];
        [currentSDKLabels setObject:@"Dedo índice (Min)" forKey:@"index_finger_min"];
        [currentSDKLabels setObject:@"Dedo índice (Máximo)" forKey:@"index_finger_max"];
        [currentSDKLabels setObject:@"Dedo medio (Min)" forKey:@"middle_finger_Max"];
        [currentSDKLabels setObject:@"Dedo anular (Min)" forKey:@"ring_finger_min"];
        [currentSDKLabels setObject:@"Dedo anular (Max)" forKey:@"ring_finger_max"];
        [currentSDKLabels setObject:@"Dedo meñique (Min)" forKey:@"baby_finger_max"];
        [currentSDKLabels setObject:@"Guardar ancho de imagen" forKey:@"save_image_width"];
        [currentSDKLabels setObject:@"Factor de agresividad" forKey:@"aggresiveness_factor"];
        [currentSDKLabels setObject:@"Valor mínimo de NFIQ" forKey:@"minimum_NFIQ_value"];
        [currentSDKLabels setObject:@"Tiempo de espera del dispositivo" forKey:@"device_timeout"];
        [currentSDKLabels setObject:@"Tamaño de la imagen (KB)" forKey:@"image_size"];
        [currentSDKLabels setObject:@"Seleccionar dedo" forKey:@"reset"];
        [currentSDKLabels setObject:@"Seleccionar dedo" forKey:@"select_finger"];//
        [currentSDKLabels setObject:@"Claro" forKey:@"clear"];
        [currentSDKLabels setObject:@"Borrar datos de huellas dactilares" forKey:@"clear_fp_data"];//
        [currentSDKLabels setObject:@"Por favor ingrese el número de dedos" forKey:@"enter_finger_count"];//
        [currentSDKLabels setObject:@"Por favor ingrese el porcentaje de deslumbramiento" forKey:@"enter_glare_percentage"];//
        [currentSDKLabels setObject:@"Por favor, ingrese el umbral de enfoque" forKey:@"enter_focus_threshold"];//
        
        //Selfie Capture
        [currentSDKLabels setObject:@"Tipo de imagen del rostro" forKey:@"face_image_type"];
        [currentSDKLabels setObject:@"Umbral de detección de rostros" forKey:@"face_detection_threshold"];
        [currentSDKLabels setObject:@"Iniciar cámara frontal" forKey:@"launch_front_camera"];
        [currentSDKLabels setObject:@"Toggle de la cámara" forKey:@"toggle_camera"];
        [currentSDKLabels setObject:@"Mostrar pantalla de vista previa" forKey:@"show_preview_screen"];
        [currentSDKLabels setObject:@"Color del contorno del rostro" forKey:@"face_outline_color"];
        [currentSDKLabels setObject:@"Detectar el color del contorno del rostro" forKey:@"detect_face_outline_color"];
        [currentSDKLabels setObject:@"Color exterior del contorno del rostro" forKey:@"outside_color_of_face_outLine"];
        [currentSDKLabels setObject:@"Color exterior detectado del contorno del rostro" forKey:@"outside_detected_color_of_face_outline"];
        [currentSDKLabels setObject:@"Alineación del título del rostro" forKey:@"face_title_alignment"];
        [currentSDKLabels setObject:@"Ocultar el título del rostro" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"Alineación del mensaje de sugerencia" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"Ocultar mensaje de sugerencia del rostro" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"Alineación del icono de sugerencia del rostro" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"Ocultar icono de sugerencia del rostro" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"Alineación del título del rostro" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"Ocultar el título del rostro" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"Alineación del mensaje de sugerencia" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"Ocultar mensaje de sugerencia del rostro" forKey:@"hide_face_hint_message"];
        [currentSDKLabels setObject:@"Alineación del icono de sugerencia del rostro" forKey:@"face_hint_icon_alignment"];
        [currentSDKLabels setObject:@"Ocultar icono de sugerencia del rostro" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"Alineación de la imagen del título del rostro" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"Ocultar la imagen del título del rostro" forKey:@"hide_face_title_image"];
        [currentSDKLabels setObject:@"Etiqueta de captura del rostro" forKey:@"face_capture_label"];
        [currentSDKLabels setObject:@"Etiqueta en español" forKey:@"spanish_label"];
        [currentSDKLabels setObject:@"Contornos del rostro" forKey:@"face_contours"];
        [currentSDKLabels setObject:@"Seleccione la imagen del título" forKey:@"title_image"];//
        [currentSDKLabels setObject:@"Color de fondo de vista previa de instrucciones" forKey:@"instruction_preview_background_color"];
        [currentSDKLabels setObject:@"Método de detección de rostros" forKey:@"face_detection_method"];
        [currentSDKLabels setObject:@"Activa" forKey:@"active"];
        [currentSDKLabels setObject:@"Pasiva" forKey:@"passive"];
        
        //video Capture
        [currentSDKLabels setObject:@"Tiempo de grabación del video (Segundo)" forKey:@"video_recording_time"];
        [currentSDKLabels setObject:@"Ingrese datos de texto" forKey:@"text_data"];
        
        //voice Capture
        [currentSDKLabels setObject:@"Tiempo de grabación de voz (Segundo)" forKey:@"voice_recording_time"];
        [currentSDKLabels setObject:@"Por favor ingrese el tiempo" forKey:@"enter_time"];//
        [currentSDKLabels setObject:@"Color del botón de voz" forKey:@"voice_button_color"];
        [currentSDKLabels setObject:@"Color de fondo" forKey:@"voice_background_color"];
        [currentSDKLabels setObject:@"Etiqueta del título en la parte superior" forKey:@"voice_title_label_on_top"];
        [currentSDKLabels setObject:@"Posición de visualización de la IU" forKey:@"voice_display_position"];
        [currentSDKLabels setObject:@"Auto-reproducción" forKey:@"voice_auto_play"];
        [currentSDKLabels setObject:@"Color de etiqueta de texto" forKey:@"voice_text_label_color"];
        [currentSDKLabels setObject:@"Título Etiqueta Color" forKey:@"voice_title_label_color"];
        [currentSDKLabels setObject:@"Tamaño de etiqueta de título" forKey:@"voice_title_label_size"];
        [currentSDKLabels setObject:@"Tamaño de etiqueta de texto" forKey:@"voice_text_label_size"];
        [currentSDKLabels setObject:@"Tamaño de etiqueta de mostrador" forKey:@"voice_counter_label_size"];
        [currentSDKLabels setObject:@"Etiqueta de grabación de voz" forKey:@"voice_recording_label"];
        
        //signature Capture
        [currentSDKLabels setObject:@"Fondo transparente" forKey:@"transparent_background"];

        //Customize product
        [currentSDKLabels setObject:@"Selecciona grupo" forKey:@"select_group"];
        [currentSDKLabels setObject:@"Ingrese el nombre del grupo" forKey:@"enter_group_name"];
        [currentSDKLabels setObject:@"Seleccione el nombre del campo" forKey:@"select_field_name"];
        [currentSDKLabels setObject:@"Ingrese el nombre del campo" forKey:@"enter_field_name"];
        [currentSDKLabels setObject:@"Seleccione el valor del campo" forKey:@"select_field_value"];
        [currentSDKLabels setObject:@"Ingrese el valor del campo" forKey:@"enter_field_value"];
        [currentSDKLabels setObject:@"Añadir" forKey:@"add"];
        [currentSDKLabels setObject:@"Configuración del producto" forKey:@"product_config"];
        
        //Data Capture
        [currentSDKLabels setObject:@"Revisión manual requerida" forKey:@"manual_review_required"];
        [currentSDKLabels setObject:@"Validación de la edad desviada" forKey:@"bypass_age_validation"];
        [currentSDKLabels setObject:@"Coincidencia del nombre desviado" forKey:@"bypass_name_matching"];
        [currentSDKLabels setObject:@"Se requiere deduplicación" forKey:@"deduplication_required"];
        [currentSDKLabels setObject:@"Número de cliente único" forKey:@"unique_customer_number"];
        [currentSDKLabels setObject:@"Nombre del cliente" forKey:@"customer_name"];
        [currentSDKLabels setObject:@"ID de servicio" forKey:@"service_id"];
        [currentSDKLabels setObject:@"Tipo de cliente" forKey:@"customer_type"];
        [currentSDKLabels setObject:@"Teléfono del cliente" forKey:@"customer_phone"];
        [currentSDKLabels setObject:@"Correo electrónico del cliente" forKey:@"customer_email"];
        [currentSDKLabels setObject:@"Atributo del cliente" forKey:@"customer_attribute"];
        [currentSDKLabels setObject:@"Número de comerciante único" forKey:@"unique_merchant_number"];
        [currentSDKLabels setObject:@"Número de empleado único" forKey:@"unique_employee_number"];
        [currentSDKLabels setObject:@"Código de empleado único" forKey:@"unique_employee_code"];
        [currentSDKLabels setObject:@"Número de cliente antiguo" forKey:@"old_client_customer_number"];
        [currentSDKLabels setObject:@"Género" forKey:@"gender"];
        [currentSDKLabels setObject:@"Dirección Línea 1" forKey:@"address_line_1"];
        [currentSDKLabels setObject:@"Dirección Línea 2" forKey:@"address_line_2"];
        [currentSDKLabels setObject:@"País" forKey:@"country"];
        [currentSDKLabels setObject:@"Estado" forKey:@"state"];
        [currentSDKLabels setObject:@"Ciudad" forKey:@"city"];
        [currentSDKLabels setObject:@"Código postal" forKey:@"postal_code"];
        [currentSDKLabels setObject:@"ID de formulario anterior" forKey:@"previous_formid"];
        [currentSDKLabels setObject:@"Clave de formulario" forKey:@"form_key"];
        [currentSDKLabels setObject:@"Valor del formulario" forKey:@"form_value"];
        [currentSDKLabels setObject:@"Capturar ID secundario" forKey:@"capture_sec_id"];
        [currentSDKLabels setObject:@"ID secundario del proceso" forKey:@"process_sec_id"];
        
        //Document Capture
        [currentSDKLabels setObject:@"Captura frontal" forKey:@"capture_front"];
        [currentSDKLabels setObject:@"Ingrese el nombre del documento" forKey:@"enter_document_name"];
        
        //Employee Data
        [currentSDKLabels setObject:@"Código de empleado" forKey:@"employee_code"];
        [currentSDKLabels setObject:@"Tipo de empleado" forKey:@"employee_type"];
        [currentSDKLabels setObject:@"ID del nombre de usuario del empleado" forKey:@"employee_login_id"];
        [currentSDKLabels setObject:@"Correo electrónico del empleado" forKey:@"employee_email"];
        [currentSDKLabels setObject:@"ID de la empresa del empleado" forKey:@"employee_company_id"];
        [currentSDKLabels setObject:@"Departamento de empleados" forKey:@"employee_department"];
        [currentSDKLabels setObject:@"Nombre de empleado" forKey:@"employee_name"];
        [currentSDKLabels setObject:@"Teléfono de celular del empleado" forKey:@"employee_mobile_no"];
        [currentSDKLabels setObject:@"Estado civil" forKey:@"marital_status"];
        [currentSDKLabels setObject:@"País del empleado" forKey:@"employee_country"];
        [currentSDKLabels setObject:@"Dirección del empleado línea 1" forKey:@"employee_address_line_1"];
        [currentSDKLabels setObject:@"Dirección del empleado línea 2" forKey:@"employee_address_line_2"];
        [currentSDKLabels setObject:@"Código postal" forKey:@"zip_code"];
        [currentSDKLabels setObject:@"Nombre del cónyuge" forKey:@"spouse_name"];
        [currentSDKLabels setObject:@"Número de hijos" forKey:@"number_of_children"];
        
        //Final Steps
        [currentSDKLabels setObject:@"Último paso" forKey:@"final_step"];
        [currentSDKLabels setObject:@"Verificar" forKey:@"verify"];
        [currentSDKLabels setObject:@"Extraer" forKey:@"extract"];
        [currentSDKLabels setObject:@"Presentación final" forKey:@"final_submit"];
        [currentSDKLabels setObject:@"Llave de forma clara" forKey:@"clear_form_key"];
        
        //Generate OTP
        [currentSDKLabels setObject:@"Ingrese ID del correo electrónico" forKey:@"enter_email_id"];
        [currentSDKLabels setObject:@"Ingrese el número de celular" forKey:@"enter_mobile_number"];
        [currentSDKLabels setObject:@"Seleccione el tipo de notificación" forKey:@"select_notification_type"];
        
        //Help Dialog
        [currentSDKLabels setObject:@"Ayuda" forKey:@"help"];
        [currentSDKLabels setObject:@"Aceptar" forKey:@"okay"];
        
        //Id Details
        [currentSDKLabels setObject:@"Seleccione tipo de ID" forKey:@"select_id_type"];
        [currentSDKLabels setObject:@"Seleccionar tipo de ID secundaria" forKey:@"select_id_type_sec"];
        [currentSDKLabels setObject:@"Seleccione ID del país " forKey:@"select_id_country"];
        [currentSDKLabels setObject:@"Seleccionar país de identificación secundaria" forKey:@"select_id_country_sec"];
        [currentSDKLabels setObject:@"Detalles de identificación secundaria" forKey:@"secondary_id_details"];
        [currentSDKLabels setObject:@"Introduzca el código ISO de dos letras para el estado" forKey:@"enter_iso_code"];
        [currentSDKLabels setObject:@"Seleccione ID Estado" forKey:@"select_id_state"];
        [currentSDKLabels setObject:@"Seleccionar estado de ID secundario" forKey:@"select_id_state_sec"];
        [currentSDKLabels setObject:@"Id Image Type" forKey:@"id_image_type"];
        
        //POA Capture
        [currentSDKLabels setObject:@"Dirección 1" forKey:@"address_1"];
        [currentSDKLabels setObject:@"Dirección 2" forKey:@"address_2"];
        
        //Process flow
        [currentSDKLabels setObject:@"Flujo del proceso" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"Seleccione servicio" forKey:@"select_service"];
        [currentSDKLabels setObject:@"ID de validación y coincidencia de rostro: ID de servicio" forKey:@"id_validation_and_face_Match"];
        [currentSDKLabels setObject:@"¿Necesitas características adicionales?" forKey:@"need_additional_features"];
        [currentSDKLabels setObject:@"Capturar la firma" forKey:@"signature_capture"];
        [currentSDKLabels setObject:@"Capturar documentos" forKey:@"document_capture"];
        [currentSDKLabels setObject:@"Capturar voz" forKey:@"voice_capture"];
        [currentSDKLabels setObject:@"Capturar huellas dactilares" forKey:@"fingerprint_capture"];
        [currentSDKLabels setObject:@"Capturar huella dactilar (4F)" forKey:@"fingerprint_capture_4F"];
        [currentSDKLabels setObject:@"Frente de captura de identificación secundaria" forKey:@"secondary_id_capture_front"];
        [currentSDKLabels setObject:@"Captura de ID secundaria" forKey:@"secondary_id_capture_back"];
        [currentSDKLabels setObject:@"Grabación de voz" forKey:@"voice_recording"];
        [currentSDKLabels setObject:@"Ubicación/Captura de GPS" forKey:@"location_capture"];
        [currentSDKLabels setObject:@"Capturar video" forKey:@"video_capture"];
        [currentSDKLabels setObject:@"Fragmento de imagen OCR" forKey:@"image_snippet_OCR"];
        [currentSDKLabels setObject:@"Escanear código de barras" forKey:@"barcode_scan"];
        [currentSDKLabels setObject:@"Video conferencia" forKey:@"video_conference"];
        [currentSDKLabels setObject:@"Capturar tarjeta" forKey:@"card_capture"];

        [currentSDKLabels setObject:@"Captura de ID secundaria" forKey:@"secondary_id_capture"];

        [currentSDKLabels setObject:@"Captura inclinada" forKey:@"slant_capture"];

        [currentSDKLabels setObject:@"Continuar" forKey:@"continue_btn"];
        
        // Result View
        [currentSDKLabels setObject:@"Hecho" forKey:@"done"];
        
        //Splash screen
        [currentSDKLabels setObject:@"Splash Screen" forKey:@"splash_screen"];
        [currentSDKLabels setObject:@"Versión" forKey:@"version"];
        
        //Snippet capture
        [currentSDKLabels setObject:@"Agregue campo" forKey:@"add_field"];
        [currentSDKLabels setObject:@"Habilitar el botón de captura" forKey:@"enable_capture_button"];
        [currentSDKLabels setObject:@"Ingresar la etiqueta de captura" forKey:@"enable_capture_label"];
        [currentSDKLabels setObject:@"Campos" forKey:@"fields"];
        [currentSDKLabels setObject:@"El nombre del campo no debe estar en blanco" forKey:@"field_name_blank"];
        [currentSDKLabels setObject:@"Por favor agregue el campo" forKey:@"please_add_field"];
        
        //Verify OTP
        [currentSDKLabels setObject:@"Ingresar código de verificación" forKey:@"enter_otp"];
        
        //View Pager
        [currentSDKLabels setObject:@"ID de la captura frontal" forKey:@"capture_id_front_tab"];
        [currentSDKLabels setObject:@"ID de la captura trasera" forKey:@"capture_id_back_tab"];
        [currentSDKLabels setObject:@"Capturar ID secundario frontal" forKey:@"secondary_id_front_tab"];
        [currentSDKLabels setObject:@"Capturar ID secundario" forKey:@"secondary_id_back_tab"];
        [currentSDKLabels setObject:@"Captura de autorretrato" forKey:@"selfie_capture_tab"];
        [currentSDKLabels setObject:@"Captura de firma" forKey:@"signature_capture_tab"];
        [currentSDKLabels setObject:@"Captura de documentos" forKey:@"document_capture_tab"];
        [currentSDKLabels setObject:@"Captura de voz" forKey:@"voice_capture_tab"];
        [currentSDKLabels setObject:@"Captura de huellas dactilares" forKey:@"fingerprint_capture_tab"];
        [currentSDKLabels setObject:@"Captura de huella dactilar (4F)" forKey:@"fingerprint_capture_4f_tab"];
        [currentSDKLabels setObject:@"Ubicación/Captura de GPS" forKey:@"location_capture_tab"];
        [currentSDKLabels setObject:@"Captura de video" forKey:@"video_capture_tab"];
        [currentSDKLabels setObject:@"Fragmento de imagen OCR" forKey:@"image_snippet_OCR_tab"];
        [currentSDKLabels setObject:@"Escaneo de código de barras" forKey:@"barcode_scan_tab"];
        [currentSDKLabels setObject:@"Video conferencia" forKey:@"video_conference_tab"];
        [currentSDKLabels setObject:@"Captura de POA" forKey:@"poa_capture_tab"];
        [currentSDKLabels setObject:@"Autorretrato del empleado" forKey:@"selfie_employee_tab"];
        [currentSDKLabels setObject:@"Autorretrato del cliente" forKey:@"selfie_customer_tab"];
        [currentSDKLabels setObject:@"Definir producto" forKey:@"define_product_tab"];
        [currentSDKLabels setObject:@"Captura de tarjeta" forKey:@"card_capture_tab"];
        [currentSDKLabels setObject:@"Captura inclinada" forKey:@"slant_capture_tab"];
        [currentSDKLabels setObject:@"Captura de tarjeta" forKey:@"generate_OTP_data_tab"];
        [currentSDKLabels setObject:@"Verificar" forKey:@"verify_OTP_data_tab"];
        [currentSDKLabels setObject:@"Captura de datos" forKey:@"data_captur_tab"];
        [currentSDKLabels setObject:@"Aplicación de prueba eVolv" forKey:@"evolve_test_application"];

        
        //Navigation drawer list
        [currentSDKLabels setObject:@"Configuracion de cuenta" forKey:@"account_setup"];
        [currentSDKLabels setObject:@"Flujo del proceso" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"Sobre nosotros" forKey:@"about_us"];
        [currentSDKLabels setObject:@"SDK Versión" forKey:@"sdk_version"];
        [currentSDKLabels setObject:@"Configuración de la cuenta" forKey:@"account_setting"];
        [currentSDKLabels setObject:@"Configuración de la cuenta" forKey:@"account_setting"];
        
        //Error Messages
        [currentSDKLabels setObject:@"Guardar los detalles de la primera cuenta" forKey:@"save_account_detail_error"];
        [currentSDKLabels setObject:@"Guardar los detalles de la primera cuenta" forKey:@"please_enter_url"];
        [currentSDKLabels setObject:@"Guardar configuración" forKey:@"id_capture_save_msg"];
        
        //common fields
        [currentSDKLabels setObject:@"Recapturar" forKey:@"re_capture"];
        [currentSDKLabels setObject:@"ID de validación" forKey:@"id_validation"];
        [currentSDKLabels setObject:@"Coincidencia del rostro" forKey:@"face_match"];
        [currentSDKLabels setObject:@"Imagen del proceso y coincidencia del rostro" forKey:@"id_validation_face_match"];
        [currentSDKLabels setObject:@"Proceso de imagen y video coincidente" forKey:@"id_validation_video_match"];
        [currentSDKLabels setObject:@"Detalles de identificación" forKey:@"id_details"];
        [currentSDKLabels setObject:@"Resultado" forKey:@"result"];
        [currentSDKLabels setObject:@"Solo imagen del proceso" forKey:@"process_image"];
        [currentSDKLabels setObject:@"Solo coincidencia del rostro" forKey:@"match_face"];
        [currentSDKLabels setObject:@"Imagen del proceso y coincidencia del rostro" forKey:@"process_image_and_match_face"];
        [currentSDKLabels setObject:@"Generar código de verificación" forKey:@"generate_otp"];
        [currentSDKLabels setObject:@"Verificar" forKey:@"verify_otp"];
        [currentSDKLabels setObject:@"Actualización del cliente" forKey:@"customer_update"];
        [currentSDKLabels setObject:@"Verificación del cliente" forKey:@"customer_verification_label"];
        [currentSDKLabels setObject:@"Coincidencia de direcciones" forKey:@"address_matching"];
        [currentSDKLabels setObject:@"Captura de POA" forKey:@"address_capture"];
        [currentSDKLabels setObject:@"Mostrar todos los datos sin procesar" forKey:@"show_result_raw_data"];
        [currentSDKLabels setObject:@"Datos sin procesar de la solicitud" forKey:@"raw_data_request"];
        [currentSDKLabels setObject:@"Datos sin procesar de la respuesta" forKey:@"raw_data_response"];
        [currentSDKLabels setObject:@"Borrar todos los datos y volver a la página principal" forKey:@"clear_data_back_main_page"];
        [currentSDKLabels setObject:@"Verificación de empleados" forKey:@"emp_verification"];
        [currentSDKLabels setObject:@"Inscripción del empleado (Face Match)" forKey:@"emp_enrollment"];
        [currentSDKLabels setObject:@"Atrás" forKey:@"back"];
        [currentSDKLabels setObject:@"Generar Token" forKey:@"generate_token"];
        [currentSDKLabels setObject:@"Descargar" forKey:@"download"];
        [currentSDKLabels setObject:@"Crear empleado (anular)" forKey:@"create_emp_override"];
        [currentSDKLabels setObject:@"Crear cliente (anular)" forKey:@"create_customer_override"];
        [currentSDKLabels setObject:@"Verificar empleado (Anular)" forKey:@"verify_emp_override"];
        [currentSDKLabels setObject:@"Verificar cliente (Anular)" forKey:@"verify_customer_override"];
        [currentSDKLabels setObject:@"ID de validación con la inscripción del cliente" forKey:@"id_validation_with_cus_enroll"];
        [currentSDKLabels setObject:@"ID de validación con la inscripción del cliente" forKey:@"id_validation_with_emp_enroll"];
        [currentSDKLabels setObject:@"ID y rostro con la inscripción del empleado" forKey:@"id_face_with_emp_enroll"];
        [currentSDKLabels setObject:@"ID y rostro con grabación de video" forKey:@"id_face_with_video_enroll"];
        [currentSDKLabels setObject:@"Inscripción del cliente con Biométricos FP" forKey:@"customer_fp_enrollment_title"];
        [currentSDKLabels setObject:@"Inscripción de huellas dactilares (cliente)" forKey:@"customer_fp_enrollment"];
        [currentSDKLabels setObject:@"Inscripción del empleado con Biométicos FP" forKey:@"employee_fp_enrollment_title"];
        [currentSDKLabels setObject:@"Inscripción de huellas dactilares (empleado)" forKey:@"employee_fp_enrollment"];
        [currentSDKLabels setObject:@"Actualización del empleado" forKey:@"employee_update"];
        [currentSDKLabels setObject:@"Personalizar producto" forKey:@"customize_product"];
        [currentSDKLabels setObject:@"Capturar" forKey:@"capture"];
        
        //Location
        [currentSDKLabels setObject:@"Ubicación" forKey:@"location"];
        [currentSDKLabels setObject:@"Latitud:" forKey:@"latitude"];
        [currentSDKLabels setObject:@"Longitud:" forKey:@"longitude"];
        
        //RequestResponse
        [currentSDKLabels setObject:@"Compartir  " forKey:@"share"];
        [currentSDKLabels setObject:@"Solicitud  " forKey:@"request"];
        [currentSDKLabels setObject:@"Respuesta  " forKey:@"response"];
        
        //Service Id & Descriptions
        [currentSDKLabels setObject:@"10 IDV + Coincidencia del rostro" forKey:@"idv_face_match"];
        [currentSDKLabels setObject:@"20 IDV solamente" forKey:@"idv_only"];
        [currentSDKLabels setObject:@"25 IDV solo con registro del cliente" forKey:@"idv_only_cust"];
        [currentSDKLabels setObject:@"30 IDV solo con registro del empleado" forKey:@"idv_only_emp"];
        [currentSDKLabels setObject:@"50 IDV + Coincidencia del rostro con registro de cliente" forKey:@"idv_face_match_cust"];
        [currentSDKLabels setObject:@"55 IDV + Coincidencia del rostro con registro de empleado" forKey:@"idv_face_match_emp"];
        [currentSDKLabels setObject:@"60 Coincidencia del rostro con registro de cliente" forKey:@"face_match_cus"];
        [currentSDKLabels setObject:@"65 Solo coincidencia del rostro" forKey:@"face_match_only"];
        [currentSDKLabels setObject:@"70 Actualización del cliente" forKey:@"customer_update_service"];
        [currentSDKLabels setObject:@"75 Actualización del empleado" forKey:@"employee_update_service"];
        [currentSDKLabels setObject:@"77 IDV + Coincidencia del rostro con registro de cliente" forKey:@"idv_face_match_cust_enroll_77"];
        [currentSDKLabels setObject:@"78 IDV + Coincidencia del rostro con registro de cliente" forKey:@"idv_face_match_cust_enroll_78"];
        [currentSDKLabels setObject:@"80 IDV+Face Match w/Cust Minor Enroll" forKey:@"idv_face_match_cust_minor"];
        [currentSDKLabels setObject:@"100 Verificación del cliente" forKey:@"customer_verification"];
        [currentSDKLabels setObject:@"105 Verificación del cliente" forKey:@"customer_verification_105"];
        [currentSDKLabels setObject:@"155 IDV + Coincidencia del video" forKey:@"idv_video_match"];
        [currentSDKLabels setObject:@"160 IDV + Coincidencia del video con registro del cliente" forKey:@"idv_video_match_cust"];
        [currentSDKLabels setObject:@"165 IDV + Coincidencia del video con registro del empleado" forKey:@"idv_video_match_emp"];
        [currentSDKLabels setObject:@"175 Registro del cliente con biometría" forKey:@"cust_enroll_biometrics"];
        [currentSDKLabels setObject:@"180 Registro del empleado con biometría" forKey:@"emp_enroll_biometrics"];
        [currentSDKLabels setObject:@"200 Procesamiento de direcciones" forKey:@"address_processing"];
        [currentSDKLabels setObject:@"300 Verificación del empleado" forKey:@"employee_verification"];
        [currentSDKLabels setObject:@"305 Verificación del empleado" forKey:@"employee_verification_305"];
        [currentSDKLabels setObject:@"310 Coincidencia del rostro con registro del empleado" forKey:@"face_match_only_emp"];
        [currentSDKLabels setObject:@"320 Crear cliente (Anular)" forKey:@"create_customer_override_service"];
        [currentSDKLabels setObject:@"330 Crear empleado (Anular)" forKey:@"create_employee_override_service"];
        [currentSDKLabels setObject:@"360 Validación de la identificación y coincidencia del rostro (ID principal)" forKey:@"id_validation_face_match_primary_id"];
        [currentSDKLabels setObject:@"361 Validación de la identificación y coincidencia del rostros (ID secundario)" forKey:@"id_validation_face_match_secondary_id"];
        [currentSDKLabels setObject:@"400 Generación del código de verificación" forKey:@"otp_generation"];
        [currentSDKLabels setObject:@"401 Generación del token" forKey:@"token_generation"];
        [currentSDKLabels setObject:@"410 Validar código de verificación" forKey:@"otp_verification"];
        [currentSDKLabels setObject:@"186 Búsqueda de clientes" forKey:@"customer_search"];
        [currentSDKLabels setObject:@"191 Búsqueda de empleados" forKey:@"employee_search"];
        [currentSDKLabels setObject:@"500 videoconferencia" forKey:@"video_conference_face_match"];
        [currentSDKLabels setObject:@"505 IDV+Videoconferencia" forKey:@"idv_video_conference_match"];
        [currentSDKLabels setObject:@"510 IDV+Videoconferencia Match+Inscripción de clientes" forKey:@"idv_video_conference_cust_enroll"];
        [currentSDKLabels setObject:@"515 IDV+Videoconferencia+Inscripción de empleados" forKey:@"idv_video_conference_emp_enroll"];
        [currentSDKLabels setObject:@"185 Identificar al cliente con biometría" forKey:@"identify_cus_with_biometrics"];
        [currentSDKLabels setObject:@"190 Identificar empleados con biometría" forKey:@"identify_emp_with_biometrics"];
        [currentSDKLabels setObject:@"660 Offline Live Face" forKey:@"offline_face_service"];
        
        [currentSDKLabels setObject:@"Capturar documento(s) de identificación, validarlos y extraer datos de él. Además, capture un autoretrato y compárelo con la foto de la identificación." forKey:@"idv_face_match_des"];
        [currentSDKLabels setObject:@"Capturar documento(s) de identificación, validarlos y extraer datos de él." forKey:@"idv_only_des"];
        [currentSDKLabels setObject:@"Capturar documento(s) de identificación para un cliente, validarlos y extraer datos de él. Además, se captura cualquier biométrico para inscribir al cliente." forKey:@"idv_only_cust_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación para un empleado, validarlos y extraer datos de él. Además, se captura cualquier biométrico para registrar al cliente." forKey:@"idv_only_emp_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, validarlos y extraer datos de él. Además, se captura un autorretrato del cliente y se compara con la foto en la identificación, luego se registra toda la biométrica capturada con el cliente si la coincidencia es positiva." forKey:@"idv_face_match_cust_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, validarlos y extraer datos de él. Además, capture un autorretrato del empleado y compárelo con la foto en la identificación, luego registre toda la biométrica capturada con el empleado si la coincidencia es positiva." forKey:@"idv_face_match_emp_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, además se captura un autorretrato del cliente y se compara con la foto en la identificación. Una vez verificado el cliente se registra." forKey:@"face_match_cus_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, además se captura un autorretrato del cliente y se compara con la foto en la identificación." forKey:@"face_match_only_des"];
        [currentSDKLabels setObject:@"Capturar cualquier información de un nuevo/actualizado cliente para actualizar el registro de cliente inscrito previamente." forKey:@"customer_update_service_des"];
        [currentSDKLabels setObject:@"Capturar cualquier nuevo/actualizado dato del empleado para actualizar el registro del empleado inscrito previamente." forKey:@"employee_update_service_des"];
        [currentSDKLabels setObject:@"Capturar los datos biométricos para verificar contra un cliente previamente inscrito." forKey:@"customer_verification_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, se validan y se extraen datos de él. Además, capturar un video y se utiliza para hacer coincidir el rostro con la identificación." forKey:@"idv_video_match_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación para un cliente, se validan y se extraen datos de él. Además, capturar un video y se utiliza para hacer coincidir el rostro con la identificación, luego se registran todos los datos biométricos capturados con el cliente." forKey:@"idv_video_match_cust_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación para un empleado, se validan y se extraen datos de él. Además, se captura un video y se utiliza para hacer coincidir el rostro con la identificación, luego inscriba todos los datos biométricos capturados con el empleado." forKey:@"idv_video_match_emp_des"];
        [currentSDKLabels setObject:@"Capturar datos del clientes y datos biométricos, y registrelos en la base de datos del clientes. No se capturan documentos de identificación." forKey:@"cust_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"Capturar datos del empleado y datos biométricos, y se registran en la base de datos del empleados. No se capturan documentos de identidad." forKey:@"emp_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"Coincidencia de la dirección / Verificación" forKey:@"address_processing_des"];
        [currentSDKLabels setObject:@"Capturar datos biométricos para verificar contra un empleado previamente inscrito." forKey:@"employee_verification_des"];
        [currentSDKLabels setObject:@"Capturar documento(s) de identificación, además se captura un autorretrato del empleado y se compara con la foto en la identificación. Una vez verificado el empleado se registra." forKey:@"face_match_only_emp_des"];
        [currentSDKLabels setObject:@"Crear cliente utilizando la función de anulación del agente, se requiere la verificación del empleado para la anulación." forKey:@"create_customer_override_service_des"];
        [currentSDKLabels setObject:@"Crear empleado usando la función de reemplazo de agente, se requiere la verificación del empleado para el reemplazo." forKey:@"create_employee_override_service_des"];
        [currentSDKLabels setObject:@"Capturar un documento de identificación primario, se valida y se extraen los datos de él. Además, se captura un autorretrato y se compara con la foto de la identificación." forKey:@"id_validation_face_match_primary_id_des"];
        [currentSDKLabels setObject:@"Capturar un documento de identificación primario, se valida y se extraen los datos de él. Además, se captura un autorretrato y se compara con la foto de la identificación." forKey:@"id_validation_face_match_secondary_id_des"];
        [currentSDKLabels setObject:@"Generar un PIN único para utilizalo en la verificación." forKey:@"otp_generation_des"];
        [currentSDKLabels setObject:@"Generación del número del Token" forKey:@"token_generation_des"];
        [currentSDKLabels setObject:@"Captura y verificación de un PIN único generado previamente." forKey:@"otp_verification_des"];
        [currentSDKLabels setObject:@"Capturar documentos de ID, validar ese ID y extraer datos de él. Además, capture una selfie del cliente y compárela con la foto en la identificación, luego inscriba toda la biométrica capturada con el cliente si la coincidencia es positiva." forKey:@"idv_face_match_cust_enroll_77_des"];
        [currentSDKLabels setObject:@"Capturar documentos de ID, validar ese ID y extraer datos de él. Además, capture una selfie del cliente y compárela con la foto en la identificación, luego inscriba toda la biométrica capturada con el cliente si la coincidencia es positiva." forKey:@"idv_face_match_cust_enroll_78_des"];
        [currentSDKLabels setObject:@"Capturar documentos de ID, validar ese ID y extraer datos de él. Además, capture un selfie de un cliente menor y compárelo con la foto en la identificación, luego inscriba todos los datos biométricos capturados con el cliente menor si el partido es positivo" forKey:@"idv_face_match_cust_minor_des"];
        [currentSDKLabels setObject:@"Búsqueda de clientes utilizando información no biométrica" forKey:@"customer_search_des"];
        [currentSDKLabels setObject:@"Búsqueda de empleados utilizando información no biométrica" forKey:@"employee_search_des"];
        [currentSDKLabels setObject:@"Inicie una sesión de videoconferencia con un operador de back office que se grabará con fines de auditoría." forKey:@"video_conference_facematch_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación, validar la identificación y extraer datos de ella. Además, inicie una sesión de videoconferencia con un operador de back office que se grabará con fines de auditoría. Se extraerá una imagen fotográfica de la videoconferencia y se usará para hacer coincidir la cara con la ID." forKey:@"idv_video_conference_match_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación para un cliente, validar la identificación y extraer datos de ella. Además, inicie una sesión de videoconferencia con un operador de back office que se grabará con fines de auditoría. Se extraerá una imagen fotográfica de la videoconferencia y se utilizará para hacer coincidir la cara con la ID, luego se inscribirán todos los datos biométricos capturados con el cliente." forKey:@"idv_video_conference_cust_enroll_des"];
        [currentSDKLabels setObject:@"Capturar documentos de identificación para un empleado, validar la identificación y extraer datos de ella. Además, inicie una sesión de videoconferencia con un operador de back office que se grabará con fines de auditoría. Se extraerá una imagen fotográfica de la videoconferencia y se usará para hacer coincidir la cara con la ID, luego se inscribirá toda la biometría capturada con el empleado." forKey:@"idv_video_conference_emp_enroll_des"];
        [currentSDKLabels setObject:@"Capture datos biométricos para un cliente (cara, huella digital, voz o iris) y busque en la base de datos del cliente para ver si ya está inscrito." forKey:@"identify_cus_with_biometrics_des"];
        [currentSDKLabels setObject:@"Capture datos biométricos para un Empleada (cara, huella digital, voz o iris) y busque en la base de datos del Empleada para ver si ya está inscrito." forKey:@"identify_emp_with_biometrics_des"];
        [currentSDKLabels setObject:@"Offline Live Face" forKey:@"offline_face_service_des"];
        
        [currentSDKLabels setObject:@"Parte superior" forKey:@"Top"];
        [currentSDKLabels setObject:@"Centrar" forKey:@"Center"];
        [currentSDKLabels setObject:@"Fondo" forKey:@"Bottom"];
        
        [currentSDKLabels setObject:@"Defecto" forKey:@"default"];
        [currentSDKLabels setObject:@"Helvética" forKey:@"helvetica"];
        [currentSDKLabels setObject:@"Helvetica Bold" forKey:@"helvetica_bold"];
        [currentSDKLabels setObject:@"Helvetica Bold Oblique" forKey:@"helvetica_bold_oblique"];
        [currentSDKLabels setObject:@"Helvetica Light" forKey:@"helvetica_light"];
        [currentSDKLabels setObject:@"Helvetica Light Oblicua" forKey:@"helvetica_light_oblique"];
        [currentSDKLabels setObject:@"Helvetica Neue" forKey:@"helvetica_neue"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold" forKey:@"helvetica_neue_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold Italic" forKey:@"helvetica_neue_bold_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Condensado Negro" forKey:@"helvetica_neue_condensed_black"];
        [currentSDKLabels setObject:@"Helvetica Neue Condensed Bold" forKey:@"helvetica_neue_condensed_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue Italic" forKey:@"helvetica_neue_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Light" forKey:@"helvetica_neue_light"];
        [currentSDKLabels setObject:@"Helvetica Neue Light Italic" forKey:@"helvetica_neue_light_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Medium" forKey:@"helvetica_neue_medium"];
        [currentSDKLabels setObject:@"Helvetica Neue Medium Italic" forKey:@"helvetica_neue_medium_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Thin" forKey:@"helvetica_neue_thin"];
        [currentSDKLabels setObject:@"Helvetica Neue Thin Italic" forKey:@"helvetica_neue_thin_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight" forKey:@"helvetica_neue_ultraLight"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight Italic" forKey:@"helvetica_neue_ultraLight_italic"];
        [currentSDKLabels setObject:@"Helvetica oblicua" forKey:@"helvetica_oblique"];
        
        [currentSDKLabels setObject:@"Gruesa" forKey:@"thick"];
        [currentSDKLabels setObject:@"delgada" forKey:@"thin"];
        
        [currentSDKLabels setObject:@"Ninguna" forKey:@"none"];
        [currentSDKLabels setObject:@"Imagen del título 1" forKey:@"title_image"];
        
        [currentSDKLabels setObject:@"Baja" forKey:@"low"];
        [currentSDKLabels setObject:@"Medio" forKey:@"medium"];
        [currentSDKLabels setObject:@"Cero" forKey:@"zero"];
        [currentSDKLabels setObject:@"Todas" forKey:@"all"];
        
        [currentSDKLabels setObject:@"CARA" forKey:@"face"];
        [currentSDKLabels setObject:@"CARA_PROCESADA" forKey:@"processed_face"];
        [currentSDKLabels setObject:@"CARA_OVALADA" forKey:@"oval_face"];
        
        [currentSDKLabels setObject:@"Pasaporte" forKey:@"PP"];
        [currentSDKLabels setObject:@"Identificación Nacional" forKey:@"NID"];
        [currentSDKLabels setObject:@"Tarjeta de Residencia" forKey:@"RID"];
        [currentSDKLabels setObject:@"Licencia de Conducir" forKey:@"DL"];
        [currentSDKLabels setObject:@"TARJETA DE IDENTIFICACION DE VOTANTE" forKey:@"VID"];
        [currentSDKLabels setObject:@"TARJETA DE IDENTIFICACIÓN DE IMPUESTOS" forKey:@"TID"];
        [currentSDKLabels setObject:@"PERMISO DE VISA DE TRABAJO" forKey:@"WV"];
        [currentSDKLabels setObject:@"PERMISO DE VISA DE ESTUDIANTE" forKey:@"SV"];
        [currentSDKLabels setObject:@"Tarjeta Militar/Policial/Gobierno" forKey:@"GID"];
        [currentSDKLabels setObject:@"TARJETA DE IDENTIFICACIÓN DE BARCO" forKey:@"BID"];
        [currentSDKLabels setObject:@"IDM" forKey:@"IDM"];
        [currentSDKLabels setObject:@"Cuenta de utilidades" forKey:@"UBL"];
        [currentSDKLabels setObject:@"OTRAS" forKey:@"OTH"];
        
        [currentSDKLabels setObject:@"por favor espera..." forKey:@"please_wait_msg"];
        
        [currentSDKLabels setObject:@"Escanee el código QR para completar los detalles de la cuenta" forKey:@"qr_button_title"];
        
        [currentSDKLabels setObject:@"Escanee el código QR desde la pantalla de descargas de mi eVolv para completar los detalles de su cuenta." forKey:@"qr_code_inst"];
        
        [currentSDKLabels setObject:@"Configuración de UI personalizada" forKey:@"customize_ui_config"];
        
        [currentSDKLabels setObject:@"Seleccione Configuración" forKey:@"select_config"];
        
        [currentSDKLabels setObject:@"Captura del frente de identificación" forKey:@"id_front_capture"];
        [currentSDKLabels setObject:@"Captura de la espalda" forKey:@"id_back_capture"];
        [currentSDKLabels setObject:@"Captura de fragmentos" forKey:@"snippet_capture"];
        [currentSDKLabels setObject:@"Captura autofoto" forKey:@"selfie_capture"];
        [currentSDKLabels setObject:@"Valor de etiqueta" forKey:@"label_value"];
        
        //Show Custom Overlay
        [currentSDKLabels setObject:@"Mostrar superposición personalizada" forKey:@"custom_overlay"];
        [currentSDKLabels setObject:@"Búsqueda de clientes" forKey:@"customer_search_label"];
        [currentSDKLabels setObject:@"Búsqueda de empleados" forKey:@"employee_search_label"];
        
        [currentSDKLabels setObject:@"Necesito respuesta inmediata" forKey:@"need_immediate_response"];
        
        [currentSDKLabels setObject:@"Detalles de escaneo de código de barras:" forKey:@"barcode_data"];
        
        [currentSDKLabels setObject:@"eleccione el tipo de identificación y extraiga los datos sin conexión" forKey:@"auto_fill_service_des"];
        
        [currentSDKLabels setObject:@"CÓDIGO DE BARRAS o MRZ no encontrado para la identificación seleccionada." forKey:@"barcode_mrz_not_found"];
        
        [currentSDKLabels setObject:@"Autocompletar" forKey:@"auto_fill_front_tab"];
        [currentSDKLabels setObject:@"Autocompletar" forKey:@"auto_fill_back_tab"];
        [currentSDKLabels setObject:@"Recuento de reintentos MRZ" forKey:@"mrz_retry_count"];
        [currentSDKLabels setObject:@"Recuento de reintentos MRZ y BARCODE" forKey:@"mrz_barcode_retry_count"];
        
        [currentSDKLabels setObject:@"Subir datos faciales" forKey:@"upload_face_data"];
        
    }else if([lang isEqualToString:@"my"]){
        //Account Setup
        [currentSDKLabels setObject:@"စမ္းသပ္ URL" forKey:@"test_url"];
        [currentSDKLabels setObject:@"Login ID" forKey:@"login_id"];
        [currentSDKLabels setObject:@"စကားဝွက္" forKey:@"password"];
        [currentSDKLabels setObject:@"Merchant ID" forKey:@"merchant_id"];
        [currentSDKLabels setObject:@"Product ID" forKey:@"product_id"];
        [currentSDKLabels setObject:@"ထုတ္ကုန္အမည္" forKey:@"product"];
        [currentSDKLabels setObject:@"ဘာသာစကား" forKey:@"language"];
        [currentSDKLabels setObject:@"စာရင္းကို သိမ္းဆည္းပါ" forKey:@"save_account"];
        [currentSDKLabels setObject:@"အေကာင့္ကို ျပင္ဆင္ပါ" forKey:@"edit_account"];
        [currentSDKLabels setObject:@"Debug Mode" forKey:@"debaug_mode"];
        [currentSDKLabels setObject:@"စတင္" forKey:@"initialize"];
        [currentSDKLabels setObject:@"URL ထည့္ပါ" forKey:@"enter_url"];
        [currentSDKLabels setObject:@"Login Id ထည့္ပါ" forKey:@"enter_login_id"];
        [currentSDKLabels setObject:@"စကားဝွက္ ျဖည့္ပါ" forKey:@"enter_password"];
        [currentSDKLabels setObject:@"Merchant ID ထည့္ပါ" forKey:@"enter_merchant_id"];
        [currentSDKLabels setObject:@"Product ID ထည့္ပါ" forKey:@"enter_product_id"];
        [currentSDKLabels setObject:@"ကုန္ပစၥည္းအမည္ ထည့္ပါ" forKey:@"enter_product_name"];
        [currentSDKLabels setObject:@"ပိတ္" forKey:@"off"];
        [currentSDKLabels setObject:@" ဖြင့္" forKey:@"on"];
        [currentSDKLabels setObject:@"ကင္မရာခြင့္ျပုခ်က္ေပးရန္ လိုအပ္ပါသည္။" forKey:@"camera_permission"];
        
        //Card Capture
        [currentSDKLabels setObject:@"ဓါတ္ပုံရိုက္" forKey:@"captute"];
        [currentSDKLabels setObject:@"<  ေနာက္သို့" forKey:@"back_capture"];
        [currentSDKLabels setObject:@"ေရွ့သို့ >" forKey:@"next_capture"];
        [currentSDKLabels setObject:@"ကတ္ အေသးစိတ္အခ်က္အလက္" forKey:@"card_details"];
        
        //ID Capture
        [currentSDKLabels setObject:@"ျပင္ဆင္သတ္မွတ္ျခင္း" forKey:@"configuration"];
        [currentSDKLabels setObject:@"Id အသားေပး အေရာင္" forKey:@"id_outline_color"];
        [currentSDKLabels setObject:@"ထင္သာျမင္သာရွိမႈ (၁ - ၁၀၀)" forKey:@"transparency"];
        [currentSDKLabels setObject:@"ရယူထားေသာ Id အေရာင္" forKey:@"detected_id_outline_color"];
        [currentSDKLabels setObject:@"အျပင္ဘက္ အသားေပး အေရာင္" forKey:@"color_outside_outline"];
        [currentSDKLabels setObject:@"ရယူထားေသာ အျပင္ဘက္ အသားေပး အေရာင္" forKey:@"detected_color_outside_outline"];
        [currentSDKLabels setObject:@"အလင္း အေမွာင္" forKey:@"light_threshold"];
        [currentSDKLabels setObject:@"အနည္းဆုံး အလင္းအေမွာင္" forKey:@"min_focus_threshold"];
        [currentSDKLabels setObject:@"အမ်ားဆုံး အလင္းအေမွာင္" forKey:@"max_focus_threshold"];
        [currentSDKLabels setObject:@"ေတာက္ပမႈ ပမာဏ" forKey:@"glare_percentage"];
        [currentSDKLabels setObject:@"ခလုတ္နွိပ္ရိုက္ယူသည့္ အခ်ိန္ (ဒုတိယ) ကို အသုံးျပဳမည္" forKey:@"enable_capture_button_time"];
        [currentSDKLabels setObject:@"အမ်ားဆုံး ပုံအရြယ္ (kb)" forKey:@"max_image_size"];
        [currentSDKLabels setObject:@"ပုံအျမင့္" forKey:@"image_height"];
        [currentSDKLabels setObject:@"ပုံအက်ယ္" forKey:@"image_width"];
        [currentSDKLabels setObject:@"ေခါင္းစီးစာသာအရြယ္" forKey:@"header_text_label_size"];
        [currentSDKLabels setObject:@"စာသား အရြယ္" forKey:@"text_label_size"];
        [currentSDKLabels setObject:@"စာသားပုံစံ" forKey:@"text_font_type"];//--
        [currentSDKLabels setObject:@"စာသားပုံစံစတိုင္" forKey:@"text_font_style"];
        [currentSDKLabels setObject:@"ေခါင္းစီးစာသား ပုံစံအမ်ိုးအစား" forKey:@"header_text_font_type"];//--
        [currentSDKLabels setObject:@"ေခါင္းစီးစာသား ပုံစံစတိုင္" forKey:@"header_text_font_style"];
        [currentSDKLabels setObject:@"စာသားအေရာင္" forKey:@"text_label_color"];
        [currentSDKLabels setObject:@"ေခါင္းစီးစာသား အေရာင္" forKey:@"header_text_label_color"];
        [currentSDKLabels setObject:@"ေနာက္သို့သြားရန္ ခလုတ္အေရာင္" forKey:@"back_button_color"];
        [currentSDKLabels setObject:@"ျပန္ၾကိုးစားပါ ခလုတ္အေရာင္" forKey:@"retry_button_color"];
        [currentSDKLabels setObject:@"ျပန္ၾကိုးစားပါ ခလုတ္အနားသတ္ အေရာင္" forKey:@"retry_button_border_color"];
        [currentSDKLabels setObject:@"အတည္ျပုပါ ခလုတ္အေရာင္" forKey:@"confirm_button_color"];
        [currentSDKLabels setObject:@"အတည္ျပုပါခလုတ္စတိုင္" forKey:@"confirm_button_style"];
        [currentSDKLabels setObject:@"ညြွန္ၾကားခ်က္ ခလုတ္ အေရာင္" forKey:@"instruction_button_color"];
        [currentSDKLabels setObject:@"ညြွန္ၾကားခ်က္ခလုတ္ စာသားအေရာင္" forKey:@"instruction_button_text_color"];
        [currentSDKLabels setObject:@"ID ရိုက္ယူျခင္း အနားသတ္" forKey:@"id_capture_border"];
        [currentSDKLabels setObject:@"ရယူသည့္ စာသားကို ျပပါ" forKey:@"show_capture_label"];
        [currentSDKLabels setObject:@"မဟုတ္" forKey:@"no"];
        [currentSDKLabels setObject:@"ဟုတ္" forKey:@"yes"];
        [currentSDKLabels setObject:@"ရယူသည့္ စာသားကို ထည့္သြင္းပါ" forKey:@"enter_capture_label"];
        [currentSDKLabels setObject:@"မူလပုံစံ အလွည့္အေျပာင္း" forKey:@"default_orientation"];
        [currentSDKLabels setObject:@"ေဒါင္လိုက္" forKey:@"portrait"];
        [currentSDKLabels setObject:@"ျမင္ကြင္းက်ယ္" forKey:@"landscape"];
        [currentSDKLabels setObject:@"Id ရယူထားသည့္ ေခါင္းစီး ခ်ိန္ညွိျခင္း" forKey:@"id_capture_title_alignment"];
        [currentSDKLabels setObject:@"Id ရယူထားသည့္ ေခါင္းစီးကို ေဖ်ာက္ပါ" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"Id ရယူထားသည့္ အၾကံေပးစာကို ခ်ိန္ညွိျခင္း" forKey:@"id_capture_hint_message_alignment"];
        //[currentSDKLabels setObject:@"Hide Id capture title" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"Id ရယူထားသည့္ အၾကံေပးစာကို ခ်ိန္ညွိျခင္း" forKey:@"id_capture_hint_message_alignment"];
        [currentSDKLabels setObject:@"Id အၾကံေပးစာကို ေဖ်ာက္ပါ" forKey:@"hide_id_hint_message"];
        [currentSDKLabels setObject:@"Id ရယူထားသည့္ ေခါင္းစီးပုံကို ခ်ိန္ညွိျခင္း" forKey:@"id_capture_title_image_alignment"];
        [currentSDKLabels setObject:@"Id ေခါင္းစီးပုံကို ေဖ်ာက္ပါ" forKey:@"hide_id_title_image"];
        [currentSDKLabels setObject:@"id ရယူထားသည့္ တံဆိပ္" forKey:@"id_capture_label"];
        [currentSDKLabels setObject:@"အဂၤလိပ္ အလံ" forKey:@"english_label"];
        [currentSDKLabels setObject:@"အလံပုံ ထည့္ရန္" forKey:@"add_label"];
        [currentSDKLabels setObject:@"သိမ္းဆည္းမည္" forKey:@"save"];
        [currentSDKLabels setObject:@"အစက ျပန္စမည္" forKey:@"reset"];
        [currentSDKLabels setObject:@"ညြွန္ျပခ်က္ကို ျပပါ" forKey:@"show_inst_screen"];
        [currentSDKLabels setObject:@"ေခါင္းစီးပုံကို ျပပါ" forKey:@"show_title_image"];
        [currentSDKLabels setObject:@"စပိန္ အလံ" forKey:@"spanish_label"];
        
        //4F Capture
        [currentSDKLabels setObject:@"အမ်ားဆုံး အလင္းအေမွာင္" forKey:@"focus_threshold"];
        [currentSDKLabels setObject:@"ေတာက္ပမႈ ပမာဏ" forKey:@"glare_threshold"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ ရွင္းလင္းျပတ္သားမႈ" forKey:@"finger_print_threshold"];
        [currentSDKLabels setObject:@"လက္ညွိုး (အနည္းဆုံး)" forKey:@"index_finger_min"];
        [currentSDKLabels setObject:@"လက္ညွိုး (အမ်ားဆုံး)" forKey:@"index_finger_max"];
        [currentSDKLabels setObject:@"လက္ခလယ္ (အနည္းဆုံး)" forKey:@"middle_finger_Max"];
        [currentSDKLabels setObject:@"လက္သန္းၾကြယ္ (အနည္းဆုံး)" forKey:@"ring_finger_min"];
        [currentSDKLabels setObject:@"လက္သန္းၾကြယ္ (အမ်ားဆုံး)" forKey:@"ring_finger_max"];
        [currentSDKLabels setObject:@"လက္သန္း (အနည္းဆုံး)" forKey:@"baby_finger_max"];
        [currentSDKLabels setObject:@"ပုံအက်ယ္ကို သိမ္းပါ" forKey:@"save_image_width"];
        [currentSDKLabels setObject:@"ၾကမ္းတမ္းသည့္ အခ်က္" forKey:@"aggresiveness_factor"];
        [currentSDKLabels setObject:@"အနိမ့္ဆုံး NFIQ တန္ဖိုး" forKey:@"minimum_NFIQ_value"];
        [currentSDKLabels setObject:@"စက္၏ Timeout" forKey:@"device_timeout"];
        [currentSDKLabels setObject:@"အမ်ားဆုံး ပုံအရြယ္ (kb)" forKey:@"image_size"];
        [currentSDKLabels setObject:@"လက္ေခ်ာင္း ေရြးပါ" forKey:@"select_finger"];
        [currentSDKLabels setObject:@"ဖယ္ရွားပါ" forKey:@"clear"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ အခ်က္အလက္ကို ဖယ္ရွားပါ" forKey:@"clear_fp_data"];
        [currentSDKLabels setObject:@"လက္ေခ်ာင္း အေရအတြက္ကို ထည့္သြင္းပါ" forKey:@"enter_finger_count"];
        [currentSDKLabels setObject:@"ေတာက္ပမႈ ပမာဏကို ျဖည့္ပါ" forKey:@"enter_glare_percentage"];
        [currentSDKLabels setObject:@"ျပတ္သားမႈ အလင္းအေမွာင္ကို ထည့္ပါ" forKey:@"enter_focus_threshold"];
        
        //Selfie Capture
        [currentSDKLabels setObject:@"မ်က္နွာပုံ အမ်ိုးအစား" forKey:@"face_image_type"];
        [currentSDKLabels setObject:@"အလင္း အေမွာင္" forKey:@"face_detection_threshold"];
        [currentSDKLabels setObject:@"အေရွ့ ကင္မရာကို ဖြင့္ပါ" forKey:@"launch_front_camera"];
        [currentSDKLabels setObject:@"ကင္မရာကို ေျပာင္းပါ" forKey:@"toggle_camera"];
        [currentSDKLabels setObject:@"အစမ္းျပကြက္ကို ျပပါ" forKey:@"show_preview_screen"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ေကာက္ေၾကာင္း အေရာင္" forKey:@"face_outline_color"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ ေကာက္ေၾကာင္း သိရွိမႈ အေရာင္" forKey:@"detect_face_outline_color"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ေကာက္ေၾကာင္း ျပင္ပ အေရာင္" forKey:@"outside_color_of_face_outLine"];
        [currentSDKLabels setObject:@"ရရွိသည့္ မ်က္နွာ္ျပင္ ျပင္ကေကာက္ေၾကာင္း အေရာင္" forKey:@"outside_detected_color_of_face_outline"];
        [currentSDKLabels setObject:@"မ်က္နွာ ေခါင္းစီး ခ်ိန္ညွိမႈ" forKey:@"face_title_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာ ေခါင္းစီကို ေဖ်ာက္ပါ" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ အၾကံျပဳ ရုပ္ပုံငယ္ကို ခ်ိန္ညွိျခင္း" forKey:@"face_hint_icon_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာဆိုင္ရာ အၾကံျပဳ ရုပ္ပုံငယ္ကို ေဖ်ာက္ပါ" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"မ်က္နွာပုံ ေခါင္းစီး ခ်ိန္ညွိမႈ" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာပုံ ေခါင္းစီးကို ေဖ်ာက္ပါ" forKey:@"hide_face_title_image"];//
        [currentSDKLabels setObject:@"မ်က္နွာ ေခါင္းစီး ခ်ိန္ညွိမႈ" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာ ေခါင္းစီကို ေဖ်ာက္ပါ" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ အၾကံျပဳ မက္ေဆ့ခ်္ ခ်ိန္ညွိမႈ" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ အၾကံျပဳ မက္ေဆ့ခ်္ကို ေဖ်ာက္ပါ" forKey:@"hide_face_hint_message"];
        [currentSDKLabels setObject:@"မ်က္နွာျပင္ အၾကံျပဳ ရုပ္ပုံငယ္ကို ခ်ိန္ညွိျခင္း" forKey:@"face_hint_icon_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာဆိုင္ရာ အၾကံျပဳ ရုပ္ပုံငယ္ကို ေဖ်ာက္ပါ" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"မ်က္နွာပုံ ေခါင္းစီး ခ်ိန္ညွိမႈ" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"မ်က္နွာပုံ ေခါင္းစီးကို ေဖ်ာက္ပါ" forKey:@"hide_face_title_image"];
        [currentSDKLabels setObject:@"မ်က္နွာ ရိုက္ယူရန္ စာသား" forKey:@"face_capture_label"];
        [currentSDKLabels setObject:@"စပိန္ အလံ" forKey:@"spanish_label"];
        [currentSDKLabels setObject:@"မ်က္ႏွာေကာက္ေၾကာင္း" forKey:@"face_contours"];
        [currentSDKLabels setObject:@"ေခါင္းစီပုံေရြးပါ" forKey:@"title_image"];
        [currentSDKLabels setObject:@"နောက်ခံအရောင်နောက်ခံအရောင်" forKey:@"instruction_preview_background_color"];
        
        //video Capture
        [currentSDKLabels setObject:@"ဗီဒီယို ရိုက္ကူးခ်ိန္ (စကၠန့္)" forKey:@"video_recording_time"];
        [currentSDKLabels setObject:@"စာသားအခ်က္အလက္ ျဖည့္ပါ" forKey:@"text_data"];
        
        //voice Capture
        [currentSDKLabels setObject:@"အသံသြင္းခ်ိန္ (စကၠန့္)" forKey:@"voice_recording_time"];
        [currentSDKLabels setObject:@"အခ်ိန္ထည့္ပါ" forKey:@"enter_time"];
        [currentSDKLabels setObject:@"အရောင် button ကို" forKey:@"voice_button_color"];
        [currentSDKLabels setObject:@"နောက်ခံအရောင်" forKey:@"voice_background_color"];
        [currentSDKLabels setObject:@"ထိပ်တန်းခေါင်းစဉ်တံဆိပ်" forKey:@"voice_title_label_on_top"];
        [currentSDKLabels setObject:@"UI Display အနေအထား" forKey:@"voice_display_position"];
        [currentSDKLabels setObject:@"အလိုအလျောက်ကစားခြင်း" forKey:@"voice_auto_play"];
        [currentSDKLabels setObject:@"စာသားတံဆိပ်အရောင်" forKey:@"voice_text_label_color"];
        [currentSDKLabels setObject:@"ခေါင်းစဉ်တံဆိပ်အရောင်" forKey:@"voice_title_label_color"];
        [currentSDKLabels setObject:@"ခေါင်းစဉ်တံဆိပ်အရွယ်အစား" forKey:@"voice_title_label_size"];
        [currentSDKLabels setObject:@"စာသားတံဆိပ်အရွယ်အစား" forKey:@"voice_text_label_size"];
        [currentSDKLabels setObject:@"တန်ပြန်တံဆိပ်အရွယ်အစား" forKey:@"voice_counter_label_size"];
        [currentSDKLabels setObject:@"အသံမှတ်တမ်းတင်တံဆိပ်" forKey:@"voice_recording_label"];
        
        //signature Capture
        [currentSDKLabels setObject:@"ပွင့်လင်းနောက်ခံ" forKey:@"transparent_background"];
        

        //Customize product
        [currentSDKLabels setObject:@"အဖြဲ့ကို ေရြးပါ" forKey:@"select_group"];
        [currentSDKLabels setObject:@"အဖြဲ့ အမည္ေပးပါ" forKey:@"enter_group_name"];
        [currentSDKLabels setObject:@"နယ္ပယ္အမည္ ေရြးပါ" forKey:@"select_field_name"];
        [currentSDKLabels setObject:@"နယ္ပယ္ အမည္ ေရးသြင္းပါ" forKey:@"enter_field_name"];
        [currentSDKLabels setObject:@"နယ္ပယ္ တန္ဖိုးေရြးပါ" forKey:@"select_field_value"];
        [currentSDKLabels setObject:@"နယ္ပယ္တန္ဖိုး ထည့္ပါ" forKey:@"enter_field_value"];
        [currentSDKLabels setObject:@"ထည့္ပါ" forKey:@"add"];
        [currentSDKLabels setObject:@"ထုတ္ကုန္ ျပင္ဆင္မႈ" forKey:@"product_config"];
        
        //Data Capture
        [currentSDKLabels setObject:@"ကိုယ္တိုင္ ဆန္းစစ္ရန္ လိုအပ္ပါသည္" forKey:@"manual_review_required"];
        [currentSDKLabels setObject:@"အသက္ အတည္ျပုျခင္းကို ေက်ာ္မည္" forKey:@"bypass_age_validation"];
        [currentSDKLabels setObject:@"အမည္စိစစ္ျခင္းကို ေက်ာ္မည္" forKey:@"bypass_name_matching"];
        [currentSDKLabels setObject:@"တူညီမႈ မရွိရန္ လိုအပ္ပါသည္" forKey:@"deduplication_required"];
        [currentSDKLabels setObject:@"မတူကြဲျပားသည့္ Customer နံပါတ္" forKey:@"unique_customer_number"];
        [currentSDKLabels setObject:@"Customer အမည္" forKey:@"customer_name"];
        [currentSDKLabels setObject:@"ဝန္ေဆာင္မွု ID" forKey:@"service_id"];
        [currentSDKLabels setObject:@"Customer အမ်ိုးအစား" forKey:@"customer_type"];
        [currentSDKLabels setObject:@"Customer ဖုန္း" forKey:@"customer_phone"];
        [currentSDKLabels setObject:@"Customer အီးေမးလ္" forKey:@"customer_email"];
        [currentSDKLabels setObject:@"Customer ထူးျခားမႈ" forKey:@"customer_attribute"];
        [currentSDKLabels setObject:@"မတူကြဲျပားသည့္ Merchant နံပါတ္" forKey:@"unique_merchant_number"];
        [currentSDKLabels setObject:@"မတူကြဲျပားသည့္  ဝန္ထမ္း နံပါတ္" forKey:@"unique_employee_number"];
        [currentSDKLabels setObject:@"မတူကြဲျပားသည့္  ဝန္ထမ္းကုတ္နံပါတ္" forKey:@"unique_employee_code"];
        [currentSDKLabels setObject:@"ယခင္ Customer နံပါတ္" forKey:@"old_client_customer_number"];
        [currentSDKLabels setObject:@"လိင္အမ်ိုးအစား" forKey:@"gender"];
        [currentSDKLabels setObject:@"လိပ္စာ - ၁" forKey:@"address_line_1"];
        [currentSDKLabels setObject:@"လိပ္စာ - ၂" forKey:@"address_line_2"];
        [currentSDKLabels setObject:@"တိုင္းျပည္" forKey:@"country"];
        [currentSDKLabels setObject:@"ျပည္နယ္" forKey:@"state"];
        [currentSDKLabels setObject:@"ျမို့" forKey:@"city"];
        [currentSDKLabels setObject:@"စာပို့သေကၤတ" forKey:@"postal_code"];
        [currentSDKLabels setObject:@"ယခင်ပုံစံ ID" forKey:@"previous_formid"];
        [currentSDKLabels setObject:@"ပုံစံ key ကို" forKey:@"form_key"];
        [currentSDKLabels setObject:@"ပုံစံတန်ဖိုး" forKey:@"form_value"];
        [currentSDKLabels setObject:@"Secondary Id ကိုဖမ်းယူပါ" forKey:@"capture_sec_id"];
        [currentSDKLabels setObject:@"Process ကို Secondary Id" forKey:@"process_sec_id"];
        
        //Document Capture
        [currentSDKLabels setObject:@"အေရွ့ဖက္ကို ရိုက္ယူ" forKey:@"capture_front"];
        [currentSDKLabels setObject:@"စာရြက္အမည္ ရိုက္ထည့္ပါ" forKey:@"enter_document_name"];
        
        //Employee Data
        [currentSDKLabels setObject:@"ဝန္ထမ္း ကုတ္နံပတ္" forKey:@"employee_code"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အမ်ိုးအစား" forKey:@"employee_type"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း Login Id" forKey:@"employee_login_id"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အီးေမးလ္" forKey:@"employee_email"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း ကုမၸဏီ Id" forKey:@"employee_company_id"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း တာဝန္ထမ္းေဆာင္သည့္ ဌာန" forKey:@"employee_department"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အမည္" forKey:@"employee_name"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း၏ မိုဘိုင္းဖုန္းနံပါတ္" forKey:@"employee_mobile_no"];
        [currentSDKLabels setObject:@"အိမ္ေထာင္ေရး အေျခအေန" forKey:@"marital_status"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း၏ နိုင္ငံ" forKey:@"employee_country"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း၏ လိပ္စာ ၁" forKey:@"employee_address_line_1"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း၏ လိပ္စာ ၂" forKey:@"employee_address_line_2"];
        [currentSDKLabels setObject:@"စာပို့သေကၤတ" forKey:@"zip_code"];
        [currentSDKLabels setObject:@"အိမ္ေထာင္ဖက္ အမည္" forKey:@"spouse_name"];
        [currentSDKLabels setObject:@"ကေလး အေရအတြက္" forKey:@"number_of_children"];
        
        //Final Steps
        [currentSDKLabels setObject:@"ေနာက္ဆုံးအဆင့္" forKey:@"final_step"];
        [currentSDKLabels setObject:@"အတည္ျပဳပါ" forKey:@"verify"];
        [currentSDKLabels setObject:@"ထုတ္ယူပါ" forKey:@"extract"];
        [currentSDKLabels setObject:@"ေနာက္ဆုံးပိတ္ တင္သြင္းပါ" forKey:@"final_submit"];
        [currentSDKLabels setObject:@"Form Key ကို ဖယ္ရွားပါ" forKey:@"clear_form_key"];
        
        //Generate OTP
        [currentSDKLabels setObject:@"အီးေမးလ္ Id ထည့္သြင္းပါ" forKey:@"enter_email_id"];
        [currentSDKLabels setObject:@"ဖုနး္နံပါတ္ ထည့္ပါ" forKey:@"enter_mobile_number"];
        [currentSDKLabels setObject:@"သတိေပးမႈ ပုံစံေရြးခ်ယ္ပါ" forKey:@"select_notification_type"];
        
        //Help Dialog
        [currentSDKLabels setObject:@"အကူအညီ" forKey:@"help"];
        [currentSDKLabels setObject:@"ေကာင္းျပီ" forKey:@"okay"];
        
        //Id Details
        [currentSDKLabels setObject:@"ID အမ်ိုးအစား ေရြးပါ" forKey:@"select_id_type"];
        [currentSDKLabels setObject:@"Secondary ID ကိုအမျိုးအစားကိုရွေးချယ်ပါ" forKey:@"select_id_type_sec"];
        [currentSDKLabels setObject:@"ID နိုင္ငံ ေရြးပါ " forKey:@"select_id_country"];
        [currentSDKLabels setObject:@"Secondary ID ကိုနိုင်ငံကိုရွေးချယ်ပါ" forKey:@"select_id_country_sec"];
        [currentSDKLabels setObject:@"အလယ်တန်း ID အသေးစိတ်" forKey:@"secondary_id_details"];
        [currentSDKLabels setObject:@"ပြည်နယ်နှစ်ခုစာတစ်စောင်က ISO ကုဒ်ရိုက်ထည့်ပါ" forKey:@"enter_iso_code"];
        [currentSDKLabels setObject:@"ID ကိုပြည်နယ်ကိုရွေးချယ်ပါ" forKey:@"select_id_state"];
        [currentSDKLabels setObject:@"Secondary ID ကိုပြည်နယ်ကိုရွေးချယ်ပါ" forKey:@"select_id_state_sec"];
        [currentSDKLabels setObject:@"id ပုံရိပ်အမျိုးအစား" forKey:@"id_image_type"];
        
        //POA Capture
        [currentSDKLabels setObject:@"လိပ္စာ - ၁" forKey:@"address_1"];
        [currentSDKLabels setObject:@"လိပ္စာ - ၂" forKey:@"address_2"];
        
        //Process flow
        [currentSDKLabels setObject:@"လုပ္ငန္းစဥ္ စီးဆင္းမႈ" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"ဝန္ေဆာင္မႈကို ေရြးပါ" forKey:@"select_service"];
        [currentSDKLabels setObject:@"ID အတည္ျပုျခင္းနွင့္ မ်က္နွာယွဥ္တြဲျခင္း - ဝန္ေဆာင္မႈ ID" forKey:@"id_validation_and_face_Match"];
        [currentSDKLabels setObject:@"ထပ္တိုးလုပ္ေဆာင္ခ်က္ေတြ လိုအပ္ပါသလား။" forKey:@"need_additional_features"];
        [currentSDKLabels setObject:@"လက္မွတ္ရယူျခင္း" forKey:@"signature_capture"];
        [currentSDKLabels setObject:@"စာရြက္ကို ဓါတ္ပုံရိုက္ယူ" forKey:@"document_capture"];
        [currentSDKLabels setObject:@"အသံ ရယူျခင္း" forKey:@"voice_capture"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ ရယူျခင္း" forKey:@"fingerprint_capture"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ ရယူျခင္း (4F)" forKey:@"fingerprint_capture_4F"];
        [currentSDKLabels setObject:@"secondary ID ကို Capture အတပ်ဦး" forKey:@"secondary_id_capture_front"];
        [currentSDKLabels setObject:@"secondary ID ကို Back ကို Capture" forKey:@"secondary_id_capture_back"];
        [currentSDKLabels setObject:@"အသံမှတ်တမ်းတင်ခြင်း" forKey:@"voice_recording"];
        [currentSDKLabels setObject:@"တည္ေနရာ/ GPS ရယူျခင္း" forKey:@"location_capture"];
        [currentSDKLabels setObject:@"ဗီဒီယို ရိုက္ျခင္း" forKey:@"video_capture"];
        [currentSDKLabels setObject:@"ရုပ္ပုံမွ OCR ျဖင့္ရယူျခင္း" forKey:@"image_snippet_OCR"];
        [currentSDKLabels setObject:@"Barcode ဖတ္ယူျခင္း" forKey:@"barcode_scan"];
        [currentSDKLabels setObject:@"ကတ္ကို ဓါတ္ပုံရိုက္ျခင္း" forKey:@"card_capture"];
        [currentSDKLabels setObject:@"secondary ID ကို Capture အ" forKey:@"secondary_id_capture"];
        [currentSDKLabels setObject:@"Slant ဖမ်းမိ" forKey:@"slant_capture"];
        [currentSDKLabels setObject:@"ဆက်လက်" forKey:@"continue_btn"];
        
        //Result View
        [currentSDKLabels setObject:@"ျပီးဆုံးပါျပီ" forKey:@"done"];
        
        //Splash screen
        [currentSDKLabels setObject:@"ရေပက် ဖန်သားပြင်" forKey:@"splash_screen"];
        [currentSDKLabels setObject:@"ဗားရွင္း" forKey:@"version"];
        
        //Snippet capture
        [currentSDKLabels setObject:@"နယ္ပယ္ ေပါင္းထည့္ျခင္း" forKey:@"add_field"];
        [currentSDKLabels setObject:@"ရယူမႈခလုတ္ကို ခြင့္ျပုပါ" forKey:@"enable_capture_button"];
        [currentSDKLabels setObject:@"ရယူသည့္ စာသားကို ထည့္သြင္းပါ" forKey:@"enable_capture_label"];
        [currentSDKLabels setObject:@"နယ္ပယ္မ်ား" forKey:@"fields"];
        [currentSDKLabels setObject:@"နယ္ပယ္အမည္ကို ခ်န္မထားပါနွင့္" forKey:@"field_name_blank"];
        [currentSDKLabels setObject:@"ေက်းဇူးျပဳ၍ နယ္ပယ္ေပါင္းထည့္ပါ" forKey:@"please_add_field"];
        
        //Verify OTP
        [currentSDKLabels setObject:@"OTP ျဖည့္ပါ" forKey:@"enter_otp"];
        
        //View Pager
        [currentSDKLabels setObject:@"ID အေရွ့ဘက္ကို ရယူပါ" forKey:@"capture_id_front_tab"];
        [currentSDKLabels setObject:@"ID ကို Back ကိုဖမ်းဆီးဖို့" forKey:@"capture_id_back_tab"];
        [currentSDKLabels setObject:@"Secondary ID Front ကိုဖမ်းယူပါ" forKey:@"secondary_id_front_tab"];
        [currentSDKLabels setObject:@"နောက်ကျော ID ကိုပြန်ဖမ်းယူ" forKey:@"secondary_id_back_tab"];
        [currentSDKLabels setObject:@"ဆယ္ဖီရိုက္" forKey:@"selfie_capture_tab"];
        [currentSDKLabels setObject:@"လက္မွတ္ရယူျခင္း" forKey:@"signature_capture_tab"];
        [currentSDKLabels setObject:@"စာရြက္ကို ဓါတ္ပုံရိုက္ယူ" forKey:@"document_capture_tab"];
        [currentSDKLabels setObject:@"အသံ ရယူျခင္း" forKey:@"voice_capture_tab"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ ရယူျခင္း" forKey:@"fingerprint_capture_tab"];
        [currentSDKLabels setObject:@"လက္ေဗြရာ ရယူျခင္း (4F)" forKey:@"fingerprint_capture_4f_tab"];
        [currentSDKLabels setObject:@"တည္ေနရာ/ GPS ရယူျခင္း" forKey:@"location_capture_tab"];
        [currentSDKLabels setObject:@"ဗီဒီယို ရိုက္ျခင္း" forKey:@"video_capture_tab"];
        [currentSDKLabels setObject:@"ရုပ္ပုံမွ OCR ျဖင့္ရယူျခင္း" forKey:@"image_snippet_OCR_tab"];
        [currentSDKLabels setObject:@"Barcode ဖတ္ယူျခင္း" forKey:@"barcode_scan_tab"];
        [currentSDKLabels setObject:@"POA ရယူပါ" forKey:@"poa_capture_tab"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း ဆယ္ဖီရိုက္ပါ" forKey:@"selfie_employee_tab"];
        [currentSDKLabels setObject:@"Customer ကို ဆယ္ဖီရိုက္ပါ" forKey:@"selfie_customer_tab"];
        [currentSDKLabels setObject:@"ထုတ္ကုန္ကို သတ္မွတ္ပါ" forKey:@"define_product_tab"];
        [currentSDKLabels setObject:@"ကတ္ကို ဓါတ္ပုံရိုက္ျခင္း" forKey:@"card_capture_tab"];
        [currentSDKLabels setObject:@"Slant ဖမ်းမိ" forKey:@"slant_capture_tab"];
        [currentSDKLabels setObject:@"OTP အခ်က္အလက္ ထုတ္ပါ" forKey:@"generate_OTP_data_tab"];
        [currentSDKLabels setObject:@"OTP အခ်က္အလက္ကို အတည္ျပဳပါ" forKey:@"verify_OTP_data_tab"];
        [currentSDKLabels setObject:@"အခ်က္အလက္ ရယူမႈ" forKey:@"data_captur_tab"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အခ်က္အလက္" forKey:@"employee_data_tab"];
        
        //Navigation drawer list
        [currentSDKLabels setObject:@"စာရင္းဖြင့္ ျပင္ဆင္ျခင္း" forKey:@"account_setup"];
        [currentSDKLabels setObject:@"လုပ္ငန္းစဥ္ စီးဆင္းမႈ" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"မိမိတို့ အေၾကာင္း" forKey:@"about_us"];
        [currentSDKLabels setObject:@"SDK ဗားရွင္း" forKey:@"sdk_version"];
        [currentSDKLabels setObject:@"အေကာင့္ ျပင္ဆင္မႈ" forKey:@"account_setting"];
        [currentSDKLabels setObject:@"အဆင့်ဆင့်ပြောင်းလဲဖြစ်ပေါ်လာစမ်းသပ်လျှောက်လွှာ" forKey:@"evolve_test_application"];
        
        //Error Messages
        [currentSDKLabels setObject:@"စာရင္းအခ်က္အလက္အေသးစိတ္ကို ဦးစြာ သိမ္းပါ" forKey:@"save_account_detail_error"];
        [currentSDKLabels setObject:@"စာရင္းအခ်က္အလက္အေသးစိတ္ကို ဦးစြာ သိမ္းပါ" forKey:@"please_enter_url"];
        [currentSDKLabels setObject:@"ျပင္ဆင္သတ္မွတ္မႈကို သိမ္းပါ" forKey:@"id_capture_save_msg"];
        
        //common fields
        [currentSDKLabels setObject:@"ျပန္လည္ ရယူပါ" forKey:@"re_capture"];
        [currentSDKLabels setObject:@"ID အတည္ျပဳျခင္း" forKey:@"id_validation"];
        [currentSDKLabels setObject:@"မ်က္နွာယွဥ္တြဲျခင္း" forKey:@"face_match"];
        [currentSDKLabels setObject:@"ပုံနွင့္ မ်က္နွာယွဥ္တြဲျခင္း လုပ္ေဆာင္ပါ" forKey:@"id_validation_face_match"];
        [currentSDKLabels setObject:@"ပုံနွင့္ ဗီဒီယို ယွဥ္တြဲျခင္း လုပ္ေဆာင္ပါ" forKey:@"id_validation_video_match"];
        [currentSDKLabels setObject:@"id အေသးစိတ္အခ်က္အလက္" forKey:@"id_details"];
        [currentSDKLabels setObject:@"ရလာဒ္" forKey:@"result"];
        [currentSDKLabels setObject:@"ပုံကိုသာ လုပ္ေဆာင္ျခင္း" forKey:@"process_image"];
        [currentSDKLabels setObject:@"မ်က္နွာသာ ယွဥ္တြဲျခင္း" forKey:@"match_face"];
        [currentSDKLabels setObject:@"ပုံနွင့္ မ်က္နွာယွဥ္တြဲျခင္း လုပ္ေဆာင္ပါ" forKey:@"process_image_and_match_face"];
        [currentSDKLabels setObject:@"OTP ထုတ္ပါ" forKey:@"generate_otp"];
        [currentSDKLabels setObject:@"OTP အတည္ျပဳပါ" forKey:@"verify_otp"];
        [currentSDKLabels setObject:@"Customer မြမ္းမံမႈ" forKey:@"customer_update"];
        [currentSDKLabels setObject:@"Customer အတည္ျပုျခင္း" forKey:@"customer_verification_label"];
        [currentSDKLabels setObject:@"လိပ္စာ တိုက္ဆိုင္စိစစ္ျခင္း" forKey:@"address_matching"];
        [currentSDKLabels setObject:@"POA ရယူပါ" forKey:@"address_capture"];
        [currentSDKLabels setObject:@"ပကတိအခ်က္အလက္အားလုံးကို ျပပါ" forKey:@"show_result_raw_data"];
        [currentSDKLabels setObject:@"ေတာင္းခံမႈမွ ပကတိ အခ်က္အလက္" forKey:@"raw_data_request"];
        [currentSDKLabels setObject:@"တုံ့ျပန္မႈမွ ပကတိအခ်က္အလက္" forKey:@"raw_data_response"];
        [currentSDKLabels setObject:@"အခ်က္အလက္အားလုံးကို ရွင္းလင္းျပီး ပင္မစာမ်က္နွာသို့ ျပန္သြားမည္" forKey:@"clear_data_back_main_page"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အတည္ျပုျခင္း" forKey:@"emp_verification"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း စာရင္းသြင္းျခင္း (မ်က္နွာ ယွဥ္တြဲျခင္း)" forKey:@"emp_enrollment"];
        [currentSDKLabels setObject:@"ေနာက္သို့" forKey:@"back"];
        [currentSDKLabels setObject:@"တိုကင္ ထုတ္ယူပါ" forKey:@"generate_token"];
        [currentSDKLabels setObject:@"ေဒါင္းလုတ္" forKey:@"download"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း ဖန္တီးပါ (Override ျပဳလုပ္၍)" forKey:@"create_emp_override"];
        [currentSDKLabels setObject:@"Customer ဖန္တီးပါ  (Override ျပဳလုပ္၍)" forKey:@"create_customer_override"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း အတည္ျပုပါ  (Override ျပဳလုပ္၍)" forKey:@"verify_emp_override"];
        [currentSDKLabels setObject:@"Customer အတည္ျပုပါ  (Override ျပဳလုပ္၍)" forKey:@"verify_customer_override"];
        [currentSDKLabels setObject:@"Customer စာရင္းသြင္းမႈနွင့္ ID အတည္ျပုျခင္း" forKey:@"id_validation_with_cus_enroll"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း စာရင္းသြင္းမႈနွင့္ ID အတည္ျပုျခင္း" forKey:@"id_validation_with_emp_enroll"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း စာရင္းသြင္းမႈ မ်က္နွာ နွင့္ ID အတည္ျပုျခင္း" forKey:@"id_face_with_emp_enroll"];
        [currentSDKLabels setObject:@"ဗီဒီယို မွတ္တမ္းတင္မႈ မ်က္နွာ နွင့္ ID အတည္ျပုျခင္း" forKey:@"id_face_with_video_enroll"];
        [currentSDKLabels setObject:@"Customer အား FP Biometrics ျဖင့္ စာရင္းသြင္းျခင္း" forKey:@"customer_fp_enrollment_title"];
        [currentSDKLabels setObject:@"လက္ေဗြရာျဖင့္ စာရင္းသြင္းျခင္း (Customer)" forKey:@"customer_fp_enrollment"];
        [currentSDKLabels setObject:@"ဝန္ထမ္းအား FP Biometrics ျဖင့္ စာရင္းသြင္းျခင္း" forKey:@"employee_fp_enrollment_title"];
        [currentSDKLabels setObject:@"လက္ေဗြရာျဖင့္ စာရင္းသြင္းျခင္း (ဝန္ထမ္း)" forKey:@"employee_fp_enrollment"];
        [currentSDKLabels setObject:@"ဝန္ထမ္းကို မြမ္းမံျခင္း" forKey:@"employee_update"];
        [currentSDKLabels setObject:@"ကုန္ပစၥည္း စိတ္ၾကိုက္ျပင္ဆင္ျခင္း" forKey:@"customize_product"];
        [currentSDKLabels setObject:@"ဓါတ္ပုံရိုက္" forKey:@"capture"];
        
        //Location
        [currentSDKLabels setObject:@"တည္ေနရာ" forKey:@"location"];//
        [currentSDKLabels setObject:@"လတၱီတြတ္:" forKey:@"latitude"];//
        [currentSDKLabels setObject:@"ေလာင္ဂ်ီက်ု:" forKey:@"longitude"];//
        
        //RequestResponse
        [currentSDKLabels setObject:@"ေဝမွ်ပါ  " forKey:@"share"];//
        [currentSDKLabels setObject:@"ေတာင္းခံပါ  " forKey:@"request"];//
        [currentSDKLabels setObject:@"တုံ့ျပန္ျခင္း  " forKey:@"response"];//
        
        //Service Id & Descriptions
        [currentSDKLabels setObject:@"10 IDV+မ်က္နွာယွဥ္တြဲျခင္း" forKey:@"idv_face_match"];
        [currentSDKLabels setObject:@"20 IDV သာ" forKey:@"idv_only"];
        [currentSDKLabels setObject:@"25 IDV Only w/Cust Enroll" forKey:@"idv_only_cust"];
        [currentSDKLabels setObject:@"30 IDV Only w/Emp Enroll" forKey:@"idv_only_emp"];
        [currentSDKLabels setObject:@"50 IDV+မ်က္နွာယွဥ္တြဲျခင္း w/Cust Enroll" forKey:@"idv_face_match_cust"];
        [currentSDKLabels setObject:@"55 IDV+မ်က္နွာယွဥ္တြဲျခင္း w/Emp Enroll" forKey:@"idv_face_match_emp"];
        [currentSDKLabels setObject:@"60 မ်က္နွာယွဥ္တြဲျခင္း သီးသန့္ w/Cust Enroll" forKey:@"face_match_cus"];
        [currentSDKLabels setObject:@"65 မ်က္နွာယွဥ္တြဲျခင္းသာ" forKey:@"face_match_only"];
        [currentSDKLabels setObject:@"70 Customer မြမ္းမံမႈ" forKey:@"customer_update_service"];
        [currentSDKLabels setObject:@"75 ဝန္ထမ္းကို မြမ္းမံျခင္း" forKey:@"employee_update_service"];
        [currentSDKLabels setObject:@"77 IDV+မ်က္နွာယွဥ္တြဲျခင္း w/Cust Enroll" forKey:@"idv_face_match_cust_enroll_77"];
        [currentSDKLabels setObject:@"78 IDV+မ်က္နွာယွဥ္တြဲျခင္း w/Cust Enroll" forKey:@"idv_face_match_cust_enroll_78"];
        [currentSDKLabels setObject:@"80 IDV+Face Match w/Cust Minor Enroll" forKey:@"idv_face_match_cust_minor"];
        [currentSDKLabels setObject:@"100 Customer အတည္ျပုျခင္း" forKey:@"customer_verification"];
        [currentSDKLabels setObject:@"105 Customer အတည္ျပုျခင္း" forKey:@"customer_verification_105"];
        [currentSDKLabels setObject:@"155 IDV+ဗီဒီယို တိုက္ဆိုင္စစ္ေဆးျခင္း" forKey:@"idv_video_match"];
        [currentSDKLabels setObject:@"160 IDV+ဗီဒီယို တိုက္ဆိုင္စစ္ေဆးျခင္း w/Cust Enroll" forKey:@"idv_video_match_cust"];
        [currentSDKLabels setObject:@"165 IDV+ဗီဒီယို တိုက္ဆိုင္စစ္ေဆးျခင္း w/Emp Enroll" forKey:@"idv_video_match_emp"];
        [currentSDKLabels setObject:@"175 Cust Enroll w/Biometrics" forKey:@"cust_enroll_biometrics"];
        [currentSDKLabels setObject:@"180 Emp Enroll w/Biometrics" forKey:@"emp_enroll_biometrics"];
        [currentSDKLabels setObject:@"200 လိပ္စာ လုပ္ေဆာင္ျခင္း" forKey:@"address_processing"];
        [currentSDKLabels setObject:@"300 ဝန္ထမ္း အတည္ျပုျခင္း" forKey:@"employee_verification"];
        [currentSDKLabels setObject:@"305 ဝန္ထမ္း အတည္ျပုျခင္း" forKey:@"employee_verification_305"];
        [currentSDKLabels setObject:@"310 မ်က္နွာယွဥ္တြဲျခင္း သီးသန့္  w/Emp Enroll" forKey:@"face_match_only_emp"];
        [currentSDKLabels setObject:@"320 Customer ဖန္တီးပါ  (Override ျပဳလုပ္၍)" forKey:@"create_customer_override_service"];
        [currentSDKLabels setObject:@"330 ဝန္ထမ္း ဖန္တီးပါ (Override ျပဳလုပ္၍)" forKey:@"create_employee_override_service"];
        [currentSDKLabels setObject:@"360 ID အတည္ျပုျခင္းနွင့္ မ်က္နွာယွဥ္တြဲျခင္း - (ပင္မ ID)" forKey:@"id_validation_face_match_primary_id"];
        [currentSDKLabels setObject:@"361 ID အတည္ျပုျခင္းနွင့္ မ်က္နွာယွဥ္တြဲျခင္း (ဒုတိယတန္း ID)" forKey:@"id_validation_face_match_secondary_id"];
        [currentSDKLabels setObject:@"400 OTP ထုတ္ယူျခင္း" forKey:@"otp_generation"];
        [currentSDKLabels setObject:@"401 တိုကင္ ထုတ္ယူျခင္း" forKey:@"token_generation"];
        [currentSDKLabels setObject:@"410  OTP အတည္ျပုျခင္း" forKey:@"otp_verification"];
        [currentSDKLabels setObject:@"186 ဖောက်သည်ရှာရန်" forKey:@"customer_search"];
        [currentSDKLabels setObject:@"191 ဝန်ထမ်းရှာရန်" forKey:@"employee_search"];
        [currentSDKLabels setObject:@"500 ဗီဒီယိုကွန်ဖရ" forKey:@"video_conference_face_match"];
        [currentSDKLabels setObject:@"505 IDV+ဗွီဒီယိုညီလာခံပွဲစဉ်" forKey:@"idv_video_conference_match"];
        [currentSDKLabels setObject:@"510 IDV+ဗွီဒီယိုညီလာခံပွဲစဉ် + ဖောက်သည်ကျောင်းအပ်" forKey:@"idv_video_conference_cust_enroll"];
        [currentSDKLabels setObject:@"515 IDV+ဗွီဒီယိုညီလာခံပွဲစဉ် + ထမ်းကျောင်းအပ်" forKey:@"idv_video_conference_emp_enroll"];
        [currentSDKLabels setObject:@"185 biometric နှင့်အတူဖောက်သည်ခွဲခြားသတ်မှတ်" forKey:@"identify_cus_with_biometrics"];
        [currentSDKLabels setObject:@"190 biometric နှင့်အတူန်ထမ်းကိုခွဲခြားသတ်မှတ်" forKey:@"identify_emp_with_biometrics"];
        [currentSDKLabels setObject:@"660 အော့ဖ်လိုင်းတိုက်ရိုက်မျက်နှာ" forKey:@"offline_face_service"];
        
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျခင္း" forKey:@"idv_face_match_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း" forKey:@"idv_only_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ customer စာရင္းသြင္းရန္ မည္သည့္ biometric ကို မဆိုရယူရမည္။" forKey:@"idv_only_cust_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ customer စာရင္းသြင္းရန္ မည္သည့္ biometric ကို မဆိုရယူရမည္။" forKey:@"idv_only_emp_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_face_match_cust_des"];
        [currentSDKLabels setObject:@"ID စာရြက္စာတမ္းမ်ား ရယူ၍ ID ကိုအတည္ျပုျပီး ၎မွ အခ်က္အလက္မ်ားကို ထုတ္နႈတ္ယူရမည္။ ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_face_match_emp_des"];
        [currentSDKLabels setObject:@"ID စာရြက္စာတမ္းမ်ား ရယူျပီး customer ကို ဆယ္ဖီျပီး  ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးပါ။ ကိုက္ညီပါက customer အား စာရင္းသြင္းပါ။" forKey:@"face_match_cus_des"];
        [currentSDKLabels setObject:@"ID စာရြက္စာတမ္းမ်ား ရယူျပီး customer ကို ဆယ္ဖီျပီး  ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးပါ။" forKey:@"face_match_only_des"];
        [currentSDKLabels setObject:@"ယခင္ စာရင္းသြင္းထားသည့္ customer မွတ္တမ္းကို မြမ္းမံရန္အတြက္ မည္သည့္ customer အခ်က္အလက္ အသစ္၊ မြမ္းမံမွုကိုမဆို ရယူရမည္။" forKey:@"customer_update_service_des"];
        [currentSDKLabels setObject:@"ယခင္ စာရင္းသြင္းထားသည့္ ဝန္ထမ္း၏ မွတ္တမ္းကို မြမ္းမံရန္အတြက္ မည္သည့္ ဝန္ထမ္း၏ အခ်က္အလက္ အသစ္၊ မြမ္းမံမွုကိုမဆို ရယူရမည္။" forKey:@"employee_update_service_des"];
        [currentSDKLabels setObject:@"ယခင္စာရင္းသြင္းထားသည့္ customer  နွင့္ တိုက္ဆိုင္စစ္ေဆးရန္ biometric အခ်က္အလက္ကို ရယူရမည္။" forKey:@"customer_verification_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဗီဒီယိုရိုက္ယူ၍ မ်က္နွာအား ID နွင့္ တိုက္ဆိုင္စစ္ေဆးရမည္။" forKey:@"idv_video_match_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဗီဒီယိုရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_video_match_cust_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဗီဒီယိုရိုက္ယူ၍ မ်က္နွာအား ID နွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_video_match_emp_des"];
        [currentSDKLabels setObject:@"Customer ၏ အခ်က္အလက္နွင့္ biometrics ကိုရယူ၍ customer database သို့ စာရင္းသြင္းရမည္။ မည္သည့္ ID စာရြက္စာတမ္းမ်ွ မရယူပါ။" forKey:@"cust_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"ဝန္ထမ္း၏ အခ်က္အလက္နွင့္ biometrics ကိုရယူ၍ ဝန္ထမ္း database သို့ စာရင္းသြင္းရမည္။ မည္သည့္ ID စာရြက္စာတမ္းမ်ွ မရယူပါ။" forKey:@"emp_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"လိပ္စာ တိုက္ဆိုင္စစ္ေဆးျခင္း/ အတည္ျပဳျခင္း" forKey:@"address_processing_des"];
        [currentSDKLabels setObject:@"ယခင္စာရင္းသြင္းထားသည့္ ဝန္ထမ္းနွင့္ တိုက္ဆိုင္စစ္ေဆးရန္ biometric အခ်က္အလက္ကို ရယူရမည္။" forKey:@"employee_verification_des"];
        [currentSDKLabels setObject:@"ID စာရြက္စာတမ္းမ်ား ရယူျပီး ဝန္ထမ္းကို ဆယ္ဖီရိုက္ျပီး  ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးပါ။ ကိုက္ညီပါက ဝန္ထမ္းအား စာရင္းသြင္းပါ။" forKey:@"face_match_only_emp_des"];
        [currentSDKLabels setObject:@"Agent Override လုပ္ေဆာင္ခ်က္ကို အသုံးျပဳ၍ customer ဖန္တီးျပီး၊ override ျပဳလုပ္ရန္အတြက္ ဝန္ထမ္း၏ အတည္ျပဳမႈ လိုအပ္ပါသည္။" forKey:@"create_customer_override_service_des"];
        [currentSDKLabels setObject:@"Agent Override လုပ္ေဆာင္ခ်က္ကို အသုံးျပဳ၍ ဝန္ထမ္းစာရင္း ဖန္တီးျပီး၊ override ျပဳလုပ္ရန္အတြက္ ဝန္ထမ္း၏ အတည္ျပဳမႈ လိုအပ္ပါသည္။" forKey:@"create_employee_override_service_des"];
        [currentSDKLabels setObject:@"မူလ စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျခင္း" forKey:@"id_validation_face_match_primary_id_des"];
        [currentSDKLabels setObject:@"မူလ စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျခင္း" forKey:@"id_validation_face_match_secondary_id_des"];
        [currentSDKLabels setObject:@"အတည္ျပဳရန္အတြက္ OTP နံပါတ္ ထုတ္ပါ။" forKey:@"otp_generation_des"];
        [currentSDKLabels setObject:@"တိုကင္နံပါတ္ထုတ္ျခင္း" forKey:@"token_generation_des"];
        [currentSDKLabels setObject:@"ယခင္ထုတ္ယူသည့္ OTP ကို ရယူ၍ အတည္ျပဳပါ။" forKey:@"otp_verification_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_face_match_cust_enroll_77_des"];
        [currentSDKLabels setObject:@"စာရြက္စာတမ္း ID ကို ရယူျခင္း၊ ID ကိုအတည္ျပုျခင္းနွင့္ ေန့စြဲရယူျခင္း ထို့အျပင္ ဆယ္ဖီရိုက္၍ ၎အား ID မွ ပုံနွင့္ တိုက္ဆိုင္စစ္ေဆးျပီး ကိုက္ညီပါက ရယူထားသည့္ biometrics မ်ားနွင့္အတူ customer အား စာရင္းသြင္းရမည္။" forKey:@"idv_face_match_cust_enroll_78_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate that ID and extract data from it. Additionally capture a selfie of a minor customer and match it against the photo on the ID, then enroll all captured biometrics with the minor customer if the match is positive." forKey:@"idv_face_match_cust_minor_des"];
        [currentSDKLabels setObject:@"မဟုတ်တဲ့ biometric သတင်းအချက်အလက်ကိုအသုံးပြုပြီးဖောက်သည်ရှာရန်" forKey:@"customer_search_des"];
        [currentSDKLabels setObject:@"မဟုတ်တဲ့ biometric ပြန်ကြားရေးသုံးပြီးဝန်ထမ်းရှာရန်" forKey:@"employee_search_des"];
        [currentSDKLabels setObject:@"စာရင်းစစ်ရည်ရွယ်ချက်များအတွက်မှတျတမျးတငျထားပါလိမ့်မည်တဲ့ကျောရုံးအော်ပရေတာနှင့်အတူဗွီဒီယိုတစ်ခုညီလာခံ session ကို Initiate ။" forKey:@"video_conference_facematch_des"];
        [currentSDKLabels setObject:@"ID ကိုစာရွက်စာတမ်း (s) ကိုဖမ်းယူခြင်း, ကကနေ ID နှင့်ထုတ်ယူ data တွေကိုမှန်ကန်ကြောင်းသက်သေပြ။ ထို့အပြင်စာရင်းစစ်ရည်ရွယ်ချက်များအတွက်မှတျတမျးတငျထားပါလိမ့်မည်တဲ့ကျောရုံးအော်ပရေတာနှင့်အတူဗွီဒီယိုတစ်ခုညီလာခံ session တစ်ခုစတင်ပါ။ ဗီဒီယိုကွန်ဖရထံမှတစ်ဦးကဓာတ်ပုံတစ်ပုံ image ကိုဖြည်နှင့် ID ကိုဆန့်ကျင်မျက်နှာကိုက်ညီစေရန်အသုံးပြုလိမ့်မည်။"forKey:@"idv_video_conference_match_des"];
        [currentSDKLabels setObject:@"ဖောက်သည်တစ်ဦးအဘို့အ ID ကိုစာရွက်စာတမ်း (s) ကိုဖမ်းယူခြင်း, ကကနေ ID နှင့်ထုတ်ယူ data တွေကိုမှန်ကန်ကြောင်းသက်သေပြ။ ထို့အပြင်စာရင်းစစ်ရည်ရွယ်ချက်များအတွက်မှတျတမျးတငျထားပါလိမ့်မည်တဲ့ကျောရုံးအော်ပရေတာနှင့်အတူဗွီဒီယိုတစ်ခုညီလာခံ session တစ်ခုစတင်ပါ။ ဗီဒီယိုကွန်ဖရထံမှတစ်ဦးကဓာတ်ပုံတစ်ပုံ image ကိုဖြည်နှင့် ID ကိုဆန့်ကျင်မျက်နှာကိုက်ညီစေရန်အသုံးပြု, ထို့နောက်ဖောက်သည်တွေနဲ့အားလုံးဖမ်းဆီးရမိ biometric စာရင်းသွင်းလိမ့်မည်။" forKey:@"idv_video_conference_cust_enroll_des"];
        [currentSDKLabels setObject:@"တစ်ဦးဝန်ထမ်းများအတွက် ID ကိုစာရွက်စာတမ်း (s) ကိုဖမ်းယူခြင်း, ကကနေ ID နှင့်ထုတ်ယူ data တွေကိုမှန်ကန်ကြောင်းသက်သေပြ။ ထို့အပြင်စာရင်းစစ်ရည်ရွယ်ချက်များအတွက်မှတျတမျးတငျထားပါလိမ့်မည်တဲ့ကျောရုံးအော်ပရေတာနှင့်အတူဗွီဒီယိုတစ်ခုညီလာခံ session တစ်ခုစတင်ပါ။ ဗီဒီယိုကွန်ဖရထံမှတစ်ဦးကဓာတ်ပုံတစ်ပုံ image ကိုဖြည်နှင့် ID ကိုဆန့်ကျင်မျက်နှာကိုက်ညီစေရန်အသုံးပြု, ထို့နောက်ဝန်ထမ်းနှင့်အတူအားလုံးဖမ်းဆီးရမိ biometric စာရင်းသွင်းလိမ့်မည်။" forKey:@"idv_video_conference_emp_enroll_des"];
        [currentSDKLabels setObject:@"တစ်ဦးဖောက်သည်များအတွက် biometric data တွေကို Capture (မျက်နှာ, လက်ဗွေ, အသံသို့မဟုတ်မျက်ဝန်း) နှင့်၎င်း၏ပြီးသားစာရင်းသွင်းလျှင်ကြည့်ရှုရန်ဖောက်သည် DB ရှာပါ။" forKey:@"identify_cus_with_biometrics_des"];
        [currentSDKLabels setObject:@"တစ်ထမ်း (မျက်နှာ, လက်ဗွေ, အသံသို့မဟုတ်မျက်ဝန်း) အတွက် biometric data တွေကို Capture နှင့်၎င်း၏ပြီးသားစာရင်းသွင်းလျှင်ကြည့်ရှုရန်ထမ်း DB ရှာပါ။" forKey:@"identify_emp_with_biometrics_des"];
        [currentSDKLabels setObject:@"အော့ဖ်လိုင်းတိုက်ရိုက်မျက်နှာ" forKey:@"offline_face_service_des"];
        
        [currentSDKLabels setObject:@"ထိပ်တန်း" forKey:@"Top"];
        [currentSDKLabels setObject:@"အလယ်ဗဟို" forKey:@"Center"];
        [currentSDKLabels setObject:@"အောကျခွေ" forKey:@"Bottom"];
        
        [currentSDKLabels setObject:@"ပျက်ကွက်" forKey:@"default"];
        [currentSDKLabels setObject:@"Helvetica" forKey:@"helvetica"];
        [currentSDKLabels setObject:@"Helvetica Bold" forKey:@"helvetica_bold"];
        [currentSDKLabels setObject:@"Helvetica Bold Oblique" forKey:@"helvetica_bold_oblique"];
        [currentSDKLabels setObject:@"Helvetica အလင်း" forKey:@"helvetica_light"];
        [currentSDKLabels setObject:@"Helvetica အလင်း Oblique" forKey:@"helvetica_light_oblique"];
        [currentSDKLabels setObject:@"Helvetica Neue" forKey:@"helvetica_neue"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold" forKey:@"helvetica_neue_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold စာလုံးစောင်း" forKey:@"helvetica_neue_bold_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue ဖိချုံ့က Black" forKey:@"helvetica_neue_condensed_black"];
        [currentSDKLabels setObject:@"Helvetica Neue ဖိချုံ့ Bold" forKey:@"helvetica_neue_condensed_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue စာလုံးစောင်း" forKey:@"helvetica_neue_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue အလင်း" forKey:@"helvetica_neue_light"];
        [currentSDKLabels setObject:@"Helvetica Neue အလင်းစာလုံးစောင်း" forKey:@"helvetica_neue_light_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue အလတ်စား" forKey:@"helvetica_neue_medium"];
        [currentSDKLabels setObject:@"Helvetica Neue အလတ်စားစာလုံးစောင်း" forKey:@"helvetica_neue_medium_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue ထူးအိမ်သင်" forKey:@"helvetica_neue_thin"];
        [currentSDKLabels setObject:@"Helvetica Neue ထူးအိမ်သင်စာလုံးစောင်း" forKey:@"helvetica_neue_thin_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight" forKey:@"helvetica_neue_ultraLight"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight စာလုံးစောင်း" forKey:@"helvetica_neue_ultraLight_italic"];
        [currentSDKLabels setObject:@"Helvetica Oblique" forKey:@"helvetica_oblique"];
        
        [currentSDKLabels setObject:@"ထူသော" forKey:@"thick"];
        [currentSDKLabels setObject:@"ပါးသော" forKey:@"thin"];
        
        [currentSDKLabels setObject:@"အဘယ်သူမျှမ" forKey:@"none"];
        [currentSDKLabels setObject:@"ခေါင်းစဉ် Image ကို 1" forKey:@"title_image"];
        
        [currentSDKLabels setObject:@"အနိမ့်" forKey:@"low"];
        [currentSDKLabels setObject:@"အလယ်အလတ်" forKey:@"medium"];
        [currentSDKLabels setObject:@"သုည" forKey:@"zero"];
        [currentSDKLabels setObject:@"အားလုံး" forKey:@"all"];
        
        [currentSDKLabels setObject:@"မျက်နှာ" forKey:@"face"];
        [currentSDKLabels setObject:@"လုပ်ငန်းများ၌မျက်နှာ" forKey:@"processed_face"];
        [currentSDKLabels setObject:@"ဘဲဥပုံမျက်နှာ" forKey:@"oval_face"];
        
        [currentSDKLabels setObject:@"နိုင်ငံကူးလက်မှတ်" forKey:@"PP"];
        [currentSDKLabels setObject:@"အမျိုးသားအိုင်ဒီ" forKey:@"NID"];
        [currentSDKLabels setObject:@"နေအိမ်သို့ကဒ်" forKey:@"RID"];
        [currentSDKLabels setObject:@"ယာဥ်မောင်းလိုင်စင်" forKey:@"DL"];
        [currentSDKLabels setObject:@"မဲဆန္ဒရှင်အိုင်ဒီကဒ်" forKey:@"VID"];
        [currentSDKLabels setObject:@"အခွန်အိုင်ဒီကဒ်" forKey:@"TID"];
        [currentSDKLabels setObject:@"အလုပ်မှာဗီဇာပါမစ်" forKey:@"WV"];
        [currentSDKLabels setObject:@"ကျောင်းသားဗီဇာပါမစ်" forKey:@"SV"];
        [currentSDKLabels setObject:@"စစ်ရဲအစိုးရ ID ကို" forKey:@"GID"];
        [currentSDKLabels setObject:@"လှေသင်္ဘောများ ID ကိုကဒ်" forKey:@"BID"];
        [currentSDKLabels setObject:@"IDM" forKey:@"IDM"];
        [currentSDKLabels setObject:@"utility ဘီလ်" forKey:@"UBL"];
        [currentSDKLabels setObject:@"အခြားသူတွေ" forKey:@"OTH"];
        
        [currentSDKLabels setObject:@"ကျေးဇူးပြုပြီးခဏစောင့်ပါ..." forKey:@"please_wait_msg"];
        
        [currentSDKLabels setObject:@"အကောင့်အသေးစိတ်ဖြည့်ရန်ဖို့အတွက် QR Code ကို scan" forKey:@"qr_button_title"];
        
        [currentSDKLabels setObject:@"သင့်ရဲ့အကောင့်ကိုအသေးစိတ် populate ငါ့အဆင့်ဆင့်ပြောင်းလဲဖြစ်ပေါ်လာ Downloads Screen ကနေဖို့အတွက် QR Code ကို scan လုပ်ပါ။" forKey:@"qr_code_inst"];
        
        [currentSDKLabels setObject:@"စိတ်ကြိုက် UI ကို Configuration" forKey:@"customize_ui_config"];
        
        [currentSDKLabels setObject:@"Configuration ကို Select လုပ်ပါ" forKey:@"select_config"];
        
        [currentSDKLabels setObject:@"id တပ်ဦးကိုဖမ်းယူ" forKey:@"id_front_capture"];
        [currentSDKLabels setObject:@"id သို့ပြန်သွားရန် Capture အ" forKey:@"id_back_capture"];
        [currentSDKLabels setObject:@"အတိုအထွာ Capture အ" forKey:@"snippet_capture"];
        [currentSDKLabels setObject:@"selfie Capture အ" forKey:@"selfie_capture"];
        [currentSDKLabels setObject:@"တံဆိပ် Value ကို" forKey:@"label_value"];
        
        //Show Custom Overlay
        [currentSDKLabels setObject:@"ထုံးစံ overlay ကိုပြရန်" forKey:@"custom_overlay"];
        
        [currentSDKLabels setObject:@"ဖောက်သည်ရှာရန်" forKey:@"customer_search_label"];
        [currentSDKLabels setObject:@"ဝန်ထမ်းရှာရန်" forKey:@"employee_search_label"];
        
        [currentSDKLabels setObject:@"ချက်ချင်းတုံ့ပြန်မှုမလိုအပ်" forKey:@"need_immediate_response"];
        
        [currentSDKLabels setObject:@"ဘားကုဒ် Scan အသေးစိတ်:" forKey:@"barcode_data"];
        
        [currentSDKLabels setObject:@"id type ကိုရွေးပြီး data offline ကို extract လုပ်ပါ" forKey:@"auto_fill_service_des"];
        
        [currentSDKLabels setObject:@"ရွေးချယ်ထားသည့် id အတွက် BARCODE သို့မဟုတ် MRZ ကိုရှာမတွေ့ပါ။" forKey:@"barcode_mrz_not_found"];
        
        [currentSDKLabels setObject:@"အလိုအလျောက်ဖြည့်ပါ" forKey:@"auto_fill_front_tab"];
        [currentSDKLabels setObject:@"အလိုအလျောက်ဖြည့်ပါ" forKey:@"auto_fill_back_tab"];
        [currentSDKLabels setObject:@"ရေတွက် MRZ" forKey:@"mrz_retry_count"];
        [currentSDKLabels setObject:@"MRZ နှင့် BARCODE မှရေတွက်ပါ" forKey:@"mrz_barcode_retry_count"];
        
        [currentSDKLabels setObject:@"မျက်နှာဒေတာတင်ပါ" forKey:@"upload_face_data"];
        
    }else{
        //Account Setup
        // [currentSDKLabels setObject:@"Account Setup" forKey:@"account_setup"];
        [currentSDKLabels setObject:@"Test URL" forKey:@"test_url"];
        [currentSDKLabels setObject:@"Login ID" forKey:@"login_id"];
        [currentSDKLabels setObject:@"Password" forKey:@"password"];
        [currentSDKLabels setObject:@"Merchant ID" forKey:@"merchant_id"];
        [currentSDKLabels setObject:@"Product ID" forKey:@"product_id"];
        [currentSDKLabels setObject:@"Product Name" forKey:@"product"];
        [currentSDKLabels setObject:@"Language" forKey:@"language"];
        [currentSDKLabels setObject:@"Save Account" forKey:@"save_account"];
        [currentSDKLabels setObject:@"Edit Account" forKey:@"edit_account"];
        [currentSDKLabels setObject:@"Debug Mode" forKey:@"debaug_mode"];
        [currentSDKLabels setObject:@"INITIALIZE" forKey:@"initialize"];
        [currentSDKLabels setObject:@"Enter URL" forKey:@"enter_url"];
        [currentSDKLabels setObject:@"Enter Login Id" forKey:@"enter_login_id"];
        [currentSDKLabels setObject:@"Enter Password" forKey:@"enter_password"];
        [currentSDKLabels setObject:@"Enter Merchant ID" forKey:@"enter_merchant_id"];
        [currentSDKLabels setObject:@"Enter Product ID" forKey:@"enter_product_id"];
        [currentSDKLabels setObject:@"Enter Product Name" forKey:@"enter_product_name"];
        [currentSDKLabels setObject:@"Off" forKey:@"off"];
        [currentSDKLabels setObject:@" On" forKey:@"on"];
        [currentSDKLabels setObject:@"Need to enable CAMERA permission." forKey:@"camera_permission"];
        
        //Card Capture
        [currentSDKLabels setObject:@"Capture" forKey:@"captute"];
        [currentSDKLabels setObject:@"<  Back" forKey:@"back_capture"];
        [currentSDKLabels setObject:@"Next >" forKey:@"next_capture"];
        [currentSDKLabels setObject:@"Card Details" forKey:@"card_details"];
        
        //ID Capture
        [currentSDKLabels setObject:@"CONFIGURATION" forKey:@"configuration"];
        [currentSDKLabels setObject:@"Id Outline Color" forKey:@"id_outline_color"];
        [currentSDKLabels setObject:@"Transparency(1-100)" forKey:@"transparency"];
        [currentSDKLabels setObject:@"Detected Id Outline Color" forKey:@"detected_id_outline_color"];
        [currentSDKLabels setObject:@"Color Outside Outline" forKey:@"color_outside_outline"];
        [currentSDKLabels setObject:@"Detected Color Outside Outline" forKey:@"detected_color_outside_outline"];
        [currentSDKLabels setObject:@"Light Threshold" forKey:@"light_threshold"];
        [currentSDKLabels setObject:@"Min.Focus Threshold" forKey:@"min_focus_threshold"];
        [currentSDKLabels setObject:@"Max.Focus Threshold" forKey:@"max_focus_threshold"];
        [currentSDKLabels setObject:@"Glare Percentage" forKey:@"glare_percentage"];
        [currentSDKLabels setObject:@"Enable Capture Button Time(Second)" forKey:@"enable_capture_button_time"];
        [currentSDKLabels setObject:@"Max Image Size(kb)" forKey:@"max_image_size"];
        [currentSDKLabels setObject:@"Image Height" forKey:@"image_height"];
        [currentSDKLabels setObject:@"Image Width" forKey:@"image_width"];
        [currentSDKLabels setObject:@"Header Text Label Size" forKey:@"header_text_label_size"];
        [currentSDKLabels setObject:@"Text Label Size" forKey:@"text_label_size"];
        [currentSDKLabels setObject:@"Text Font Type" forKey:@"text_font_type"];//--
        [currentSDKLabels setObject:@"Text Font Style" forKey:@"text_font_style"];
        [currentSDKLabels setObject:@"Header Text Font Type" forKey:@"header_text_font_type"];//--
        [currentSDKLabels setObject:@"Header Text Font Style" forKey:@"header_text_font_style"];
        [currentSDKLabels setObject:@"Text Label Color" forKey:@"text_label_color"];
        [currentSDKLabels setObject:@"Header Text Label Color" forKey:@"header_text_label_color"];
        [currentSDKLabels setObject:@"Back Button Color" forKey:@"back_button_color"];
        [currentSDKLabels setObject:@"Retry Button Color" forKey:@"retry_button_color"];
        [currentSDKLabels setObject:@"Retry Button Border Color" forKey:@"retry_button_border_color"];
        [currentSDKLabels setObject:@"Confirm Button Color" forKey:@"confirm_button_color"];
        [currentSDKLabels setObject:@"Confirm Button Style" forKey:@"confirm_button_style"];
        [currentSDKLabels setObject:@"Instruction Button Color" forKey:@"instruction_button_color"];
        [currentSDKLabels setObject:@"Instruction Button Text Color" forKey:@"instruction_button_text_color"];
        [currentSDKLabels setObject:@"ID Capture Border" forKey:@"id_capture_border"];
        [currentSDKLabels setObject:@"Show Capture Label" forKey:@"show_capture_label"];
        [currentSDKLabels setObject:@"No" forKey:@"no"];
        [currentSDKLabels setObject:@"Yes" forKey:@"yes"];
        [currentSDKLabels setObject:@"Enter Capture Label" forKey:@"enter_capture_label"];
        [currentSDKLabels setObject:@"Default Orientation" forKey:@"default_orientation"];
        [currentSDKLabels setObject:@"Portrait" forKey:@"portrait"];
        [currentSDKLabels setObject:@"Landscape" forKey:@"landscape"];
        [currentSDKLabels setObject:@"Id capture title alignment" forKey:@"id_capture_title_alignment"];
        [currentSDKLabels setObject:@"Hide Id capture title" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"Id capture hint message alignment" forKey:@"id_capture_hint_message_alignment"];
        //[currentSDKLabels setObject:@"Hide Id capture title" forKey:@"hide_id_capture_title"];
        [currentSDKLabels setObject:@"Id capture hint message alignment" forKey:@"id_capture_hint_message_alignment"];
        [currentSDKLabels setObject:@"Hide Id hint message" forKey:@"hide_id_hint_message"];
        [currentSDKLabels setObject:@"Id capture title image alignment" forKey:@"id_capture_title_image_alignment"];
        [currentSDKLabels setObject:@"Hide Id title image" forKey:@"hide_id_title_image"];
        [currentSDKLabels setObject:@"Id capture label" forKey:@"id_capture_label"];
        [currentSDKLabels setObject:@"English Label" forKey:@"english_label"];
        [currentSDKLabels setObject:@"Add Label" forKey:@"add_label"];
        [currentSDKLabels setObject:@"Save" forKey:@"save"];
        [currentSDKLabels setObject:@"Reset" forKey:@"reset"];
        [currentSDKLabels setObject:@"Show Instruction Screen" forKey:@"show_inst_screen"];
        [currentSDKLabels setObject:@"Show Title Image" forKey:@"show_title_image"];
        [currentSDKLabels setObject:@"Spanish Label" forKey:@"spanish_label"];
        
        //4F Capture
        [currentSDKLabels setObject:@"Focus Threshold" forKey:@"focus_threshold"];
        [currentSDKLabels setObject:@"Glare Threshold" forKey:@"glare_threshold"];
        [currentSDKLabels setObject:@"FingerPrint Threshold" forKey:@"finger_print_threshold"];
        [currentSDKLabels setObject:@"Index Finger(Min)" forKey:@"index_finger_min"];
        [currentSDKLabels setObject:@"Index Finger(Max)" forKey:@"index_finger_max"];
        [currentSDKLabels setObject:@"Middle Finger(Min)" forKey:@"middle_finger_Max"];
        [currentSDKLabels setObject:@"Ring Finger(Min)" forKey:@"ring_finger_min"];
        [currentSDKLabels setObject:@"Ring Finger(Max)" forKey:@"ring_finger_max"];
        [currentSDKLabels setObject:@"Baby Finger(Min)" forKey:@"baby_finger_max"];
        [currentSDKLabels setObject:@"Save Image Width" forKey:@"save_image_width"];
        [currentSDKLabels setObject:@"Aggresiveness Factor" forKey:@"aggresiveness_factor"];
        [currentSDKLabels setObject:@"Minimum NFIQ Value" forKey:@"minimum_NFIQ_value"];
        [currentSDKLabels setObject:@"Device Timeout" forKey:@"device_timeout"];
        [currentSDKLabels setObject:@"Image Size(KB)" forKey:@"image_size"];
        [currentSDKLabels setObject:@"Select Finger" forKey:@"select_finger"];
        [currentSDKLabels setObject:@"Clear" forKey:@"clear"];
        [currentSDKLabels setObject:@"Clear Fingerprint Data" forKey:@"clear_fp_data"];
        [currentSDKLabels setObject:@"Please enter finger count" forKey:@"enter_finger_count"];
        [currentSDKLabels setObject:@"Please enter glare percentage" forKey:@"enter_glare_percentage"];
        [currentSDKLabels setObject:@"Please enter focus threshold" forKey:@"enter_focus_threshold"];
        
        //Selfie Capture
        [currentSDKLabels setObject:@"Face Image Type" forKey:@"face_image_type"];
        [currentSDKLabels setObject:@"Face Detection Threshold" forKey:@"face_detection_threshold"];
        [currentSDKLabels setObject:@"Launch Front Camera" forKey:@"launch_front_camera"];
        [currentSDKLabels setObject:@"Toggle Camera" forKey:@"toggle_camera"];
        [currentSDKLabels setObject:@"Show Preview Screen" forKey:@"show_preview_screen"];
        [currentSDKLabels setObject:@"Face Outline Color" forKey:@"face_outline_color"];
        [currentSDKLabels setObject:@"Detect Face Outline Color" forKey:@"detect_face_outline_color"];
        [currentSDKLabels setObject:@"Outside Color of Face OutLine" forKey:@"outside_color_of_face_outLine"];
        [currentSDKLabels setObject:@"Outside Detected Color of Face Outline" forKey:@"outside_detected_color_of_face_outline"];
        [currentSDKLabels setObject:@"Face title alignment" forKey:@"face_title_alignment"];
        [currentSDKLabels setObject:@"Hide face title" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"Face hint icon alignment" forKey:@"face_hint_icon_alignment"];
        [currentSDKLabels setObject:@"Hide face hint icon" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"Face title image alignment" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"Hide face title Image" forKey:@"hide_face_title_image"];//
        [currentSDKLabels setObject:@"Face title alignment" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"Hide face title" forKey:@"hide_face_title"];
        [currentSDKLabels setObject:@"Face hint message alignment" forKey:@"face_hint_message_alignment"];
        [currentSDKLabels setObject:@"Hide face hint message" forKey:@"hide_face_hint_message"];
        [currentSDKLabels setObject:@"Face hint icon alignment" forKey:@"face_hint_icon_alignment"];
        [currentSDKLabels setObject:@"Hide face hint icon" forKey:@"hide_face_hint_icon"];
        [currentSDKLabels setObject:@"Face title image alignment" forKey:@"face_title_image_alignment"];
        [currentSDKLabels setObject:@"Hide face title image" forKey:@"hide_face_title_image"];
        [currentSDKLabels setObject:@"Face capture label" forKey:@"face_capture_label"];
        [currentSDKLabels setObject:@"Spanish Label" forKey:@"spanish_label"];
        [currentSDKLabels setObject:@"Face contours" forKey:@"face_contours"];
        [currentSDKLabels setObject:@"Select Title Image" forKey:@"title_image"];
        [currentSDKLabels setObject:@"Instruction Preview Background Color" forKey:@"instruction_preview_background_color"];
        [currentSDKLabels setObject:@"Face Detection Method" forKey:@"face_detection_method"];
        [currentSDKLabels setObject:@"Active" forKey:@"active"];
        [currentSDKLabels setObject:@"Passive" forKey:@"passive"];
        
        //video Capture
        [currentSDKLabels setObject:@"Video Recording Time(Second)" forKey:@"video_recording_time"];
        [currentSDKLabels setObject:@"Enter Text Data" forKey:@"text_data"];
        
        //voice Capture
        [currentSDKLabels setObject:@"Voice Recording Time(Second)" forKey:@"voice_recording_time"];
        [currentSDKLabels setObject:@"Please enter time" forKey:@"enter_time"];
        [currentSDKLabels setObject:@"Voice Button Color" forKey:@"voice_button_color"];
        [currentSDKLabels setObject:@"Background Color" forKey:@"voice_background_color"];
        [currentSDKLabels setObject:@"Title Label On Top" forKey:@"voice_title_label_on_top"];
        [currentSDKLabels setObject:@"UI Display Position" forKey:@"voice_display_position"];
        [currentSDKLabels setObject:@"Auto Play" forKey:@"voice_auto_play"];
        [currentSDKLabels setObject:@"Text Label Color" forKey:@"voice_text_label_color"];
        [currentSDKLabels setObject:@"Title Label Color" forKey:@"voice_title_label_color"];
        [currentSDKLabels setObject:@"Title Label Size" forKey:@"voice_title_label_size"];
        [currentSDKLabels setObject:@"Text Label Size" forKey:@"voice_text_label_size"];
        [currentSDKLabels setObject:@"Counter Label Size" forKey:@"voice_counter_label_size"];
        [currentSDKLabels setObject:@"Voice Recording Label" forKey:@"voice_recording_label"];
        
        //signature Capture
        [currentSDKLabels setObject:@"Transparent Background" forKey:@"transparent_background"];
        
        //Customize product
        [currentSDKLabels setObject:@"Select Group" forKey:@"select_group"];
        [currentSDKLabels setObject:@"Enter Group Name" forKey:@"enter_group_name"];
        [currentSDKLabels setObject:@"Select Field Name" forKey:@"select_field_name"];
        [currentSDKLabels setObject:@"Enter Field Name" forKey:@"enter_field_name"];
        [currentSDKLabels setObject:@"Select Field Value" forKey:@"select_field_value"];
        [currentSDKLabels setObject:@"Enter Field Value" forKey:@"enter_field_value"];
        [currentSDKLabels setObject:@"Add" forKey:@"add"];
        [currentSDKLabels setObject:@"Product Config" forKey:@"product_config"];
        
        //Data Capture
        [currentSDKLabels setObject:@"Manual Review Required" forKey:@"manual_review_required"];
        [currentSDKLabels setObject:@"Bypass Age Validation" forKey:@"bypass_age_validation"];
        [currentSDKLabels setObject:@"Bypass Name Matching" forKey:@"bypass_name_matching"];
        [currentSDKLabels setObject:@"Deduplication Required" forKey:@"deduplication_required"];
        [currentSDKLabels setObject:@"Unique Customer Number" forKey:@"unique_customer_number"];
        [currentSDKLabels setObject:@"Customer Name" forKey:@"customer_name"];
        [currentSDKLabels setObject:@"Service ID" forKey:@"service_id"];
        [currentSDKLabels setObject:@"Customer Type" forKey:@"customer_type"];
        [currentSDKLabels setObject:@"Customer Phone" forKey:@"customer_phone"];
        [currentSDKLabels setObject:@"Customer Email" forKey:@"customer_email"];
        [currentSDKLabels setObject:@"Customer Attribute" forKey:@"customer_attribute"];
        [currentSDKLabels setObject:@"Unique Merchant Number" forKey:@"unique_merchant_number"];
        [currentSDKLabels setObject:@"Unique Employee Number" forKey:@"unique_employee_number"];
        [currentSDKLabels setObject:@"Unique Employee Code" forKey:@"unique_employee_code"];
        [currentSDKLabels setObject:@"Old Client Customer Number" forKey:@"old_client_customer_number"];
        [currentSDKLabels setObject:@"Gender" forKey:@"gender"];
        [currentSDKLabels setObject:@"Address Line 1" forKey:@"address_line_1"];
        [currentSDKLabels setObject:@"Address Line 2" forKey:@"address_line_2"];
        [currentSDKLabels setObject:@"Country" forKey:@"country"];
        [currentSDKLabels setObject:@"State" forKey:@"state"];
        [currentSDKLabels setObject:@"City" forKey:@"city"];
        [currentSDKLabels setObject:@"Postal Code" forKey:@"postal_code"];
        [currentSDKLabels setObject:@"Previous Form ID" forKey:@"previous_formid"];
        [currentSDKLabels setObject:@"Form Key" forKey:@"form_key"];
        [currentSDKLabels setObject:@"Form Value" forKey:@"form_value"];
        [currentSDKLabels setObject:@"Capture Secondary Id" forKey:@"capture_sec_id"];
        [currentSDKLabels setObject:@"Process Secondary Id" forKey:@"process_sec_id"];

        //Document Capture
        [currentSDKLabels setObject:@"Capture Front" forKey:@"capture_front"];
        [currentSDKLabels setObject:@"Enter Document Name" forKey:@"enter_document_name"];
        
        //Employee Data
        [currentSDKLabels setObject:@"Employee Code" forKey:@"employee_code"];
        [currentSDKLabels setObject:@"Employee Type" forKey:@"employee_type"];
        [currentSDKLabels setObject:@"Employee Login Id" forKey:@"employee_login_id"];
        [currentSDKLabels setObject:@"Employee Email" forKey:@"employee_email"];
        [currentSDKLabels setObject:@"Employee Company Id" forKey:@"employee_company_id"];
        [currentSDKLabels setObject:@"Employee Department" forKey:@"employee_department"];
        [currentSDKLabels setObject:@"Employee Name" forKey:@"employee_name"];
        [currentSDKLabels setObject:@"Employee Mobile No" forKey:@"employee_mobile_no"];
        [currentSDKLabels setObject:@"Marital Status" forKey:@"marital_status"];
        [currentSDKLabels setObject:@"Employee Country" forKey:@"employee_country"];
        [currentSDKLabels setObject:@"Employee Address Line 1" forKey:@"employee_address_line_1"];
        [currentSDKLabels setObject:@"Employee Address Line 2" forKey:@"employee_address_line_2"];
        [currentSDKLabels setObject:@"ZipCode" forKey:@"zip_code"];
        [currentSDKLabels setObject:@"Spouse Name" forKey:@"spouse_name"];
        [currentSDKLabels setObject:@"Number of Children" forKey:@"number_of_children"];
        
        //Final Steps
        [currentSDKLabels setObject:@"Final Step" forKey:@"final_step"];
        [currentSDKLabels setObject:@"Verify" forKey:@"verify"];
        [currentSDKLabels setObject:@"Extract" forKey:@"extract"];
        [currentSDKLabels setObject:@"Final Submit" forKey:@"final_submit"];
        [currentSDKLabels setObject:@"Clear Form Key" forKey:@"clear_form_key"];
        
        //Generate OTP
        [currentSDKLabels setObject:@"Enter Email Id" forKey:@"enter_email_id"];
        [currentSDKLabels setObject:@"Enter Mobile Number" forKey:@"enter_mobile_number"];
        [currentSDKLabels setObject:@"Select Notification Type" forKey:@"select_notification_type"];
        
        //Help Dialog
        [currentSDKLabels setObject:@"HELP" forKey:@"help"];
        [currentSDKLabels setObject:@"OKAY" forKey:@"okay"];
        
        //Id Details
        [currentSDKLabels setObject:@"Select ID Type" forKey:@"select_id_type"];
        [currentSDKLabels setObject:@"Select Secondary ID Type" forKey:@"select_id_type_sec"];
        [currentSDKLabels setObject:@"Select ID Country " forKey:@"select_id_country"];
        [currentSDKLabels setObject:@"Select Secondary ID Country " forKey:@"select_id_country_sec"];
        [currentSDKLabels setObject:@"Secondary ID Details" forKey:@"secondary_id_details"];
        [currentSDKLabels setObject:@"Enter two letter ISO code for State" forKey:@"enter_iso_code"];
        [currentSDKLabels setObject:@"Select ID State" forKey:@"select_id_state"];
        [currentSDKLabels setObject:@"Select Secondary ID State" forKey:@"select_id_state_sec"];
        [currentSDKLabels setObject:@"Id Image Type" forKey:@"id_image_type"];
        
        //POA Capture
        [currentSDKLabels setObject:@"Address 1" forKey:@"address_1"];
        [currentSDKLabels setObject:@"Address 2" forKey:@"address_2"];
        
        //Process flow
        [currentSDKLabels setObject:@"Process Flow" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"Select Service" forKey:@"select_service"];
        [currentSDKLabels setObject:@"ID Validation and Face Match: Service ID" forKey:@"id_validation_and_face_Match"];
        [currentSDKLabels setObject:@"Need Additional features?" forKey:@"need_additional_features"];
        [currentSDKLabels setObject:@"Signature Capture" forKey:@"signature_capture"];
        [currentSDKLabels setObject:@"Document Capture" forKey:@"document_capture"];
        [currentSDKLabels setObject:@"Voice Capture" forKey:@"voice_capture"];
        [currentSDKLabels setObject:@"Fingerprint Capture" forKey:@"fingerprint_capture"];
        [currentSDKLabels setObject:@"Fingerprint Capture(4F)" forKey:@"fingerprint_capture_4F"];
        [currentSDKLabels setObject:@"Secondary ID Capture Front" forKey:@"secondary_id_capture_front"];
        [currentSDKLabels setObject:@"Secondary ID Capture Back" forKey:@"secondary_id_capture_back"];
        [currentSDKLabels setObject:@"Voice Recording" forKey:@"voice_recording"];
        [currentSDKLabels setObject:@"Location/GPS Capture" forKey:@"location_capture"];
        [currentSDKLabels setObject:@"Video Capture" forKey:@"video_capture"];
        [currentSDKLabels setObject:@"Image Snippet OCR" forKey:@"image_snippet_OCR"];
        [currentSDKLabels setObject:@"Barcode Scan" forKey:@"barcode_scan"];
        [currentSDKLabels setObject:@"Video Conference" forKey:@"video_conference"];
        [currentSDKLabels setObject:@"Card Capture" forKey:@"card_capture"];
        [currentSDKLabels setObject:@"Capture Secondary ID" forKey:@"secondary_id_capture"];
        [currentSDKLabels setObject:@"Slant ID Capture" forKey:@"slant_capture"];
        [currentSDKLabels setObject:@"CONTINUE" forKey:@"continue_btn"];
        
        //Result View
        [currentSDKLabels setObject:@"Done" forKey:@"done"];
        
        //Splash screen
        [currentSDKLabels setObject:@"Splash Screen" forKey:@"splash_screen"];
        [currentSDKLabels setObject:@"Version" forKey:@"version"];
        
        //Snippet capture
        [currentSDKLabels setObject:@"Add Field" forKey:@"add_field"];
        [currentSDKLabels setObject:@"Enable Capture Button" forKey:@"enable_capture_button"];
        [currentSDKLabels setObject:@"Enter Capture Label" forKey:@"enable_capture_label"];
        [currentSDKLabels setObject:@"Fields" forKey:@"fields"];
        [currentSDKLabels setObject:@"Field name should not be blank" forKey:@"field_name_blank"];
        [currentSDKLabels setObject:@"Please Add Field" forKey:@"please_add_field"];
        
        //Verify OTP
        [currentSDKLabels setObject:@"Enter OTP" forKey:@"enter_otp"];
        
        //View Pager
        [currentSDKLabels setObject:@"Capture ID Front" forKey:@"capture_id_front_tab"];
        [currentSDKLabels setObject:@"Capture ID Back" forKey:@"capture_id_back_tab"];
        [currentSDKLabels setObject:@"Capture Secondary ID Front" forKey:@"secondary_id_front_tab"];
        [currentSDKLabels setObject:@"Capture Secondary ID Back" forKey:@"secondary_id_back_tab"];
        [currentSDKLabels setObject:@"Selfie Capture" forKey:@"selfie_capture_tab"];
        [currentSDKLabels setObject:@"Signature Capture" forKey:@"signature_capture_tab"];
        [currentSDKLabels setObject:@"Document Capture" forKey:@"document_capture_tab"];
        [currentSDKLabels setObject:@"Voice Capture" forKey:@"voice_capture_tab"];
        [currentSDKLabels setObject:@"Fingerprint Capture" forKey:@"fingerprint_capture_tab"];
        [currentSDKLabels setObject:@"Fingerprint Capture(4F)" forKey:@"fingerprint_capture_4f_tab"];
        [currentSDKLabels setObject:@"Location/GPS Capture" forKey:@"location_capture_tab"];
        [currentSDKLabels setObject:@"Video Capture" forKey:@"video_capture_tab"];
        [currentSDKLabels setObject:@"Image Snippet OCR" forKey:@"image_snippet_OCR_tab"];
        [currentSDKLabels setObject:@"Barcode Scan" forKey:@"barcode_scan_tab"];
        [currentSDKLabels setObject:@"Video Conference" forKey:@"video_conference_tab"];
        [currentSDKLabels setObject:@"POA Capture" forKey:@"poa_capture_tab"];
        [currentSDKLabels setObject:@"Selfie Employee" forKey:@"selfie_employee_tab"];
        [currentSDKLabels setObject:@"Selfie Customer" forKey:@"selfie_customer_tab"];
        [currentSDKLabels setObject:@"Define Product" forKey:@"define_product_tab"];
        [currentSDKLabels setObject:@"Card Capture" forKey:@"card_capture_tab"];
        [currentSDKLabels setObject:@"Slant ID Capture" forKey:@"slant_capture_tab"];
        [currentSDKLabels setObject:@"Generate OTP Data" forKey:@"generate_OTP_data_tab"];
        [currentSDKLabels setObject:@"Verify OTP Data" forKey:@"verify_OTP_data_tab"];
        [currentSDKLabels setObject:@"Data Capture" forKey:@"data_captur_tab"];
        [currentSDKLabels setObject:@"Employee Data" forKey:@"employee_data_tab"];
        
        //Navigation drawer list
        [currentSDKLabels setObject:@"Account Setup" forKey:@"account_setup"];
        [currentSDKLabels setObject:@"Process Flow" forKey:@"process_flow"];
        [currentSDKLabels setObject:@"About us" forKey:@"about_us"];
        [currentSDKLabels setObject:@"SDK Version" forKey:@"sdk_version"];
        [currentSDKLabels setObject:@"Account Setting" forKey:@"account_setting"];
        [currentSDKLabels setObject:@"eVolv Application" forKey:@"evolve_test_application"];
        
        //Error Messages
        [currentSDKLabels setObject:@"Save account details first" forKey:@"save_account_detail_error"];
        [currentSDKLabels setObject:@"Save account details first" forKey:@"please_enter_url"];
        [currentSDKLabels setObject:@"Save configuration" forKey:@"id_capture_save_msg"];
        
        //common fields
        [currentSDKLabels setObject:@"Recapture" forKey:@"re_capture"];
        [currentSDKLabels setObject:@"ID Validation" forKey:@"id_validation"];
        [currentSDKLabels setObject:@"Face Match" forKey:@"face_match"];
        [currentSDKLabels setObject:@"Process Image and Face Match" forKey:@"id_validation_face_match"];
        [currentSDKLabels setObject:@"Process Image and Video Match" forKey:@"id_validation_video_match"];
        [currentSDKLabels setObject:@"ID Details" forKey:@"id_details"];
        [currentSDKLabels setObject:@"Result" forKey:@"result"];
        [currentSDKLabels setObject:@"Process Image Only" forKey:@"process_image"];
        [currentSDKLabels setObject:@"Match Face Only" forKey:@"match_face"];
        [currentSDKLabels setObject:@"Process Image and Match Face" forKey:@"process_image_and_match_face"];
        [currentSDKLabels setObject:@"Generate OTP" forKey:@"generate_otp"];
        [currentSDKLabels setObject:@"Verify OTP" forKey:@"verify_otp"];
        [currentSDKLabels setObject:@"Customer Update" forKey:@"customer_update"];
        [currentSDKLabels setObject:@"Customer Verification" forKey:@"customer_verification_label"];
        [currentSDKLabels setObject:@"Address Matching" forKey:@"address_matching"];
        [currentSDKLabels setObject:@"POA Capture" forKey:@"address_capture"];
        [currentSDKLabels setObject:@"Show All Raw Data" forKey:@"show_result_raw_data"];
        [currentSDKLabels setObject:@"Raw Data from Request" forKey:@"raw_data_request"];
        [currentSDKLabels setObject:@"Raw Data from Response" forKey:@"raw_data_response"];
        [currentSDKLabels setObject:@"Clear All Data and Back to Main Page" forKey:@"clear_data_back_main_page"];
        [currentSDKLabels setObject:@"Employee Verification" forKey:@"emp_verification"];
        [currentSDKLabels setObject:@"Employee Enrollment(Face Match)" forKey:@"emp_enrollment"];
        [currentSDKLabels setObject:@"Back" forKey:@"back"];
        [currentSDKLabels setObject:@"Generate Token" forKey:@"generate_token"];
        [currentSDKLabels setObject:@"Download" forKey:@"download"];
        [currentSDKLabels setObject:@"Create Employee(Override)" forKey:@"create_emp_override"];
        [currentSDKLabels setObject:@"Create Customer(Override)" forKey:@"create_customer_override"];
        [currentSDKLabels setObject:@"Verify Employee(Override)" forKey:@"verify_emp_override"];
        [currentSDKLabels setObject:@"Verify Customer(Override)" forKey:@"verify_customer_override"];
        [currentSDKLabels setObject:@"ID Validation with customer enrollment" forKey:@"id_validation_with_cus_enroll"];
        [currentSDKLabels setObject:@"ID Validation with employee enrollment" forKey:@"id_validation_with_emp_enroll"];
        [currentSDKLabels setObject:@"ID and Face with employee enrollment" forKey:@"id_face_with_emp_enroll"];
        [currentSDKLabels setObject:@"ID and Face with video recording" forKey:@"id_face_with_video_enroll"];
        [currentSDKLabels setObject:@"Customer enrollment with FP Biometrics" forKey:@"customer_fp_enrollment_title"];
        [currentSDKLabels setObject:@"Fingerprint Enrollment(Customer)" forKey:@"customer_fp_enrollment"];
        [currentSDKLabels setObject:@"Employee enrollment with FP Biometrics" forKey:@"employee_fp_enrollment_title"];
        [currentSDKLabels setObject:@"Fingerprint Enrollment(Employee)" forKey:@"employee_fp_enrollment"];
        [currentSDKLabels setObject:@"Employee Update" forKey:@"employee_update"];
        [currentSDKLabels setObject:@"Customize Product" forKey:@"customize_product"];
        [currentSDKLabels setObject:@"Capture" forKey:@"capture"];
        
        //Location
        [currentSDKLabels setObject:@"Location" forKey:@"location"];//
        [currentSDKLabels setObject:@"Latitude:" forKey:@"latitude"];//
        [currentSDKLabels setObject:@"Longitude:" forKey:@"longitude"];//
        
        //RequestResponse
        [currentSDKLabels setObject:@"Share  " forKey:@"share"];//
        [currentSDKLabels setObject:@"Request  " forKey:@"request"];//
        [currentSDKLabels setObject:@"Response  " forKey:@"response"];//
        
        //Service Id & Descriptions
        [currentSDKLabels setObject:@"10 IDV+Face Match" forKey:@"idv_face_match"];
        [currentSDKLabels setObject:@"20 IDV Only" forKey:@"idv_only"];
        [currentSDKLabels setObject:@"25 IDV Only w/Cust Enroll" forKey:@"idv_only_cust"];
        [currentSDKLabels setObject:@"30 IDV Only w/Emp Enroll" forKey:@"idv_only_emp"];
        [currentSDKLabels setObject:@"50 IDV+Face Match w/Cust Enroll" forKey:@"idv_face_match_cust"];
        [currentSDKLabels setObject:@"55 IDV+Face Match w/Emp Enroll" forKey:@"idv_face_match_emp"];
        [currentSDKLabels setObject:@"60 Face Match Only w/Cust Enroll" forKey:@"face_match_cus"];
        [currentSDKLabels setObject:@"65 Face Match Only" forKey:@"face_match_only"];
        [currentSDKLabels setObject:@"70 Customer Update" forKey:@"customer_update_service"];
        [currentSDKLabels setObject:@"75 Employee Update" forKey:@"employee_update_service"];
        [currentSDKLabels setObject:@"77 IDV+Face Match w/Cust Enroll" forKey:@"idv_face_match_cust_enroll_77"];
        [currentSDKLabels setObject:@"78 IDV+Face Match w/Cust Enroll" forKey:@"idv_face_match_cust_enroll_78"];
        [currentSDKLabels setObject:@"80 IDV+Face Match w/Cust Minor Enroll" forKey:@"idv_face_match_cust_minor"];
        [currentSDKLabels setObject:@"100 Customer Verification" forKey:@"customer_verification"];
        [currentSDKLabels setObject:@"105 Customer Verification" forKey:@"customer_verification_105"];
        [currentSDKLabels setObject:@"155 IDV+Video Match" forKey:@"idv_video_match"];
        [currentSDKLabels setObject:@"160 IDV+Video Match w/Cust Enroll" forKey:@"idv_video_match_cust"];
        [currentSDKLabels setObject:@"165 IDV+Video Match w/Emp Enroll" forKey:@"idv_video_match_emp"];
        [currentSDKLabels setObject:@"175 Cust Enroll w/Biometrics" forKey:@"cust_enroll_biometrics"];
        [currentSDKLabels setObject:@"180 Emp Enroll w/Biometrics" forKey:@"emp_enroll_biometrics"];
        [currentSDKLabels setObject:@"200 Address Processing" forKey:@"address_processing"];
        [currentSDKLabels setObject:@"300 Employee Verification" forKey:@"employee_verification"];
        [currentSDKLabels setObject:@"305 Employee Verification" forKey:@"employee_verification_305"];
        [currentSDKLabels setObject:@"310 Face Match Only w/Emp Enroll" forKey:@"face_match_only_emp"];
        [currentSDKLabels setObject:@"320 Create Customer(Override)" forKey:@"create_customer_override_service"];
        [currentSDKLabels setObject:@"330 Create Employee(Override)" forKey:@"create_employee_override_service"];
        [currentSDKLabels setObject:@"360 Id Validation & Face Match(Primary ID)" forKey:@"id_validation_face_match_primary_id"];
        [currentSDKLabels setObject:@"361 Id Validation & Face Match(Secondary ID)" forKey:@"id_validation_face_match_secondary_id"];
        [currentSDKLabels setObject:@"400 OTP Generation" forKey:@"otp_generation"];
        [currentSDKLabels setObject:@"401 Token Generation" forKey:@"token_generation"];
        [currentSDKLabels setObject:@"410 OTP Verification" forKey:@"otp_verification"];
        [currentSDKLabels setObject:@"186 Customer Search" forKey:@"customer_search"];
        [currentSDKLabels setObject:@"191 Employee Search" forKey:@"employee_search"];
        [currentSDKLabels setObject:@"500 Video Conference Face Match" forKey:@"video_conference_face_match"];
        [currentSDKLabels setObject:@"505 IDV+Video Conference Match" forKey:@"idv_video_conference_match"];
        [currentSDKLabels setObject:@"510 IDV+Video Conference Match w/Cust Enrollment" forKey:@"idv_video_conference_cust_enroll"];
        [currentSDKLabels setObject:@"515 IDV+Video Conference Match w/Emp Enrollment" forKey:@"idv_video_conference_emp_enroll"];
        [currentSDKLabels setObject:@"185 Identify Customer with Biometrics" forKey:@"identify_cus_with_biometrics"];
        [currentSDKLabels setObject:@"190 Identify Employee with Biometrics" forKey:@"identify_emp_with_biometrics"];
          [currentSDKLabels setObject:@"660 Offline Live Face" forKey:@"offline_face_service"];
        
        [currentSDKLabels setObject:@"Capturing ID document(s), validate the ID and extract data from it. Additionally capture a selfie and match it against the photo on the ID." forKey:@"idv_face_match_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate the ID and extract data from it." forKey:@"idv_only_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for a customer, validate the ID and extract data from it. Additionally any biometric is captured to enroll the customer." forKey:@"idv_only_cust_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for an employee, validate the ID and extract data from it. Additionally any biometric is captured to enroll the customer." forKey:@"idv_only_emp_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate that ID and extract data from it. Additionally capture a selfie of the customer and match it against the photo on the ID, then enroll all captured biometrics with the customer if the match is positive." forKey:@"idv_face_match_cust_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate the ID and extract data from it.Additionally capture a selfie of the employee and match it against the photo on the ID, then enroll all captured biometrics with the employee if the match is positive." forKey:@"idv_face_match_emp_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), additionally capture a selfie of the customer and match it against the photo on the ID. Once verified the customer is enrolled." forKey:@"face_match_cus_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), additionally capture a selfie of the customer and match it against the photo on the ID." forKey:@"face_match_only_des"];
        [currentSDKLabels setObject:@"Capture of any new/updated customer data to update the previously enrolled customer record." forKey:@"customer_update_service_des"];
        [currentSDKLabels setObject:@"Capture of any new/updated employee data to update the previously enrolled employee record." forKey:@"employee_update_service_des"];
        [currentSDKLabels setObject:@"Capture of biometric data to verify against a previously enrolled customer." forKey:@"customer_verification_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate the ID and extract data from it. Additionally capture a video stream and use it to match the face against the ID." forKey:@"idv_video_match_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for a customer, validate the ID and extract data from it. Additionally capture a video stream and use it to match the face against the ID, then enroll all captured biometrics with the customer." forKey:@"idv_video_match_cust_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for an employee, validate the ID and extract data from it. Additionally capture a video stream and use it to match the face against the ID, then enroll all captured biometrics with the employee." forKey:@"idv_video_match_emp_des"];
        [currentSDKLabels setObject:@"Capture customer data and biometrics and enroll into the customer database. No ID documents are captured." forKey:@"cust_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"Capture employee data and biometrics and enroll into the employee database. No ID documents are captured." forKey:@"emp_enroll_biometrics_des"];
        [currentSDKLabels setObject:@"Address Matching / Verification" forKey:@"address_processing_des"];
        [currentSDKLabels setObject:@"Capture of biometric data to verify against a previously enrolled employee." forKey:@"employee_verification_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), additionally capture a selfie of the employee and match it against the photo on the ID. Once verified the employee is enrolled" forKey:@"face_match_only_emp_des"];
        [currentSDKLabels setObject:@"Create Customer using Agent Override feature, employee verification is required for the override." forKey:@"create_customer_override_service_des"];
        [currentSDKLabels setObject:@"Create Employee using Agent Override feature, employee verification is required for the override." forKey:@"create_employee_override_service_des"];
        [currentSDKLabels setObject:@"Capturing a primary ID document(s), validate the ID and extract data from it. Additionally capture a selfie and match it against the photo on the ID." forKey:@"id_validation_face_match_primary_id_des"];
        [currentSDKLabels setObject:@"Capturing a primary ID document(s), validate the ID and extract data from it. Additionally capture a selfie and match it against the photo on the ID." forKey:@"id_validation_face_match_secondary_id_des"];
        [currentSDKLabels setObject:@"Generate a One Time PIN to be used for verification." forKey:@"otp_generation_des"];
        [currentSDKLabels setObject:@"Token Number Generation" forKey:@"token_generation_des"];
        [currentSDKLabels setObject:@"Capture and Verification of a previously generated One Time PIN." forKey:@"otp_verification_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate that ID and extract data from it. Additionally capture a selfie of the customer and match it against the photo on the ID, then enroll all captured biometrics with the customer if the match is positive." forKey:@"idv_face_match_cust_enroll_77_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate that ID and extract data from it. Additionally capture a selfie of the customer and match it against the photo on the ID, then enroll all captured biometrics with the customer if the match is positive." forKey:@"idv_face_match_cust_enroll_78_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate that ID and extract data from it. Additionally capture a selfie of a minor customer and match it against the photo on the ID, then enroll all captured biometrics with the minor customer if the match is positive." forKey:@"idv_face_match_cust_minor_des"];
        [currentSDKLabels setObject:@"Customer Search using non biometric Information" forKey:@"customer_search_des"];
        [currentSDKLabels setObject:@"Employee Search using non biometric Information" forKey:@"employee_search_des"];
        [currentSDKLabels setObject:@"Initiate a video conference session with a back office operator that will be recorded for audit purposes." forKey:@"video_conference_facematch_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s), validate the ID and extract data from it. Additionally initiate a video conference session with a back office operator that will be recorded for audit purposes. A photo image from the video conference will be extracted and used to match the face against the ID." forKey:@"idv_video_conference_match_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for a customer, validate the ID and extract data from it. Additionally initiate a video conference session with a back office operator that will be recorded for audit purposes. A photo image from the video conference will be extracted and used to match the face against the ID, then enroll all captured biometrics with the customer." forKey:@"idv_video_conference_cust_enroll_des"];
        [currentSDKLabels setObject:@"Capturing ID document(s) for an employee, validate the ID and extract data from it. Additionally initiate a video conference session with a back office operator that will be recorded for audit purposes. A photo image from the video conference will be extracted and used to match the face against the ID, then enroll all captured biometrics with the employee." forKey:@"idv_video_conference_emp_enroll_des"];
        [currentSDKLabels setObject:@"Capture biometric data for a Customer (face, fingerprint, voice or iris) and search the customer DB to see if its already enrolled." forKey:@"identify_cus_with_biometrics_des"];
        [currentSDKLabels setObject:@"Capture biometric data for a Employee (face, fingerprint, voice or iris) and search the Employee DB to see if its already enrolled." forKey:@"identify_emp_with_biometrics_des"];
        [currentSDKLabels setObject:@"Offline Live Face" forKey:@"offline_face_service_des"];
        
        [currentSDKLabels setObject:@"Top" forKey:@"Top"];
        [currentSDKLabels setObject:@"Center" forKey:@"Center"];
        [currentSDKLabels setObject:@"Bottom" forKey:@"Bottom"];
        
        [currentSDKLabels setObject:@"Default" forKey:@"default"];
        [currentSDKLabels setObject:@"Helvetica" forKey:@"helvetica"];
        [currentSDKLabels setObject:@"Helvetica Bold" forKey:@"helvetica_bold"];
        [currentSDKLabels setObject:@"Helvetica Bold Oblique" forKey:@"helvetica_bold_oblique"];
        [currentSDKLabels setObject:@"Helvetica Light" forKey:@"helvetica_light"];
        [currentSDKLabels setObject:@"Helvetica Light Oblique" forKey:@"helvetica_light_oblique"];
        [currentSDKLabels setObject:@"Helvetica Neue" forKey:@"helvetica_neue"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold" forKey:@"helvetica_neue_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue Bold Italic" forKey:@"helvetica_neue_bold_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Condensed Black" forKey:@"helvetica_neue_condensed_black"];
        [currentSDKLabels setObject:@"Helvetica Neue Condensed Bold" forKey:@"helvetica_neue_condensed_bold"];
        [currentSDKLabels setObject:@"Helvetica Neue Italic" forKey:@"helvetica_neue_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Light" forKey:@"helvetica_neue_light"];
        [currentSDKLabels setObject:@"Helvetica Neue Light Italic" forKey:@"helvetica_neue_light_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Medium" forKey:@"helvetica_neue_medium"];
        [currentSDKLabels setObject:@"Helvetica Neue Medium Italic" forKey:@"helvetica_neue_medium_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue Thin" forKey:@"helvetica_neue_thin"];
        [currentSDKLabels setObject:@"Helvetica Neue Thin Italic" forKey:@"helvetica_neue_thin_italic"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight" forKey:@"helvetica_neue_ultraLight"];
        [currentSDKLabels setObject:@"Helvetica Neue UltraLight Italic" forKey:@"helvetica_neue_ultraLight_italic"];
        [currentSDKLabels setObject:@"Helvetica Oblique" forKey:@"helvetica_oblique"];
        
        [currentSDKLabels setObject:@"Thick" forKey:@"thick"];
        [currentSDKLabels setObject:@"Thin" forKey:@"thin"];
        
        [currentSDKLabels setObject:@"None" forKey:@"none"];
        [currentSDKLabels setObject:@"Title Image 1" forKey:@"title_image"];
        
        [currentSDKLabels setObject:@"Low" forKey:@"low"];
        [currentSDKLabels setObject:@"Medium" forKey:@"medium"];
        [currentSDKLabels setObject:@"Zero" forKey:@"zero"];
        [currentSDKLabels setObject:@"All" forKey:@"all"];
        
        [currentSDKLabels setObject:@"FACE_IMAGE" forKey:@"face"];
        [currentSDKLabels setObject:@"PROCESSED_FACE" forKey:@"processed_face"];
        [currentSDKLabels setObject:@"OVAL_FACE" forKey:@"oval_face"];
        
        [currentSDKLabels setObject:@"PASSPORT" forKey:@"PP"];
        [currentSDKLabels setObject:@"NATIONAL_ID" forKey:@"NID"];
        [currentSDKLabels setObject:@"RESIDENCE_CARD" forKey:@"RID"];
        [currentSDKLabels setObject:@"DRIVERS_LICENSE" forKey:@"DL"];
        [currentSDKLabels setObject:@"VOTER_ID_CARD" forKey:@"VID"];
        [currentSDKLabels setObject:@"TAX_ID_CARD" forKey:@"TID"];
        [currentSDKLabels setObject:@"WORK_VISA_PERMIT" forKey:@"WV"];
        [currentSDKLabels setObject:@"STUDENT_VISA_PERMIT" forKey:@"SV"];
        [currentSDKLabels setObject:@"MILITARY_POLICE_GOVERNMENT_ID" forKey:@"GID"];
        [currentSDKLabels setObject:@"BOAT_SHIP_ID_CARD" forKey:@"BID"];
        [currentSDKLabels setObject:@"IDM" forKey:@"IDM"];
        [currentSDKLabels setObject:@"UTILITY_BILL" forKey:@"UBL"];
        [currentSDKLabels setObject:@"OTHERS" forKey:@"OTH"];
        
        [currentSDKLabels setObject:@"Please wait..." forKey:@"please_wait_msg"];
        [currentSDKLabels setObject:@"Scan QR Code to Fill Account Details" forKey:@"qr_button_title"];
        [currentSDKLabels setObject:@"Scan QR Code from My eVolv Downloads Screen to populate your Account Details." forKey:@"qr_code_inst"];
        
        [currentSDKLabels setObject:@"Customized UI Configuration" forKey:@"customize_ui_config"];
        
        [currentSDKLabels setObject:@"Select Configuration" forKey:@"select_config"];
        
        [currentSDKLabels setObject:@"Id Front Capture" forKey:@"id_front_capture"];
        [currentSDKLabels setObject:@"Id Back Capture" forKey:@"id_back_capture"];
        [currentSDKLabels setObject:@"Snippet Capture" forKey:@"snippet_capture"];
        [currentSDKLabels setObject:@"Selfie Capture" forKey:@"selfie_capture"];
        [currentSDKLabels setObject:@"Label Value" forKey:@"label_value"];
        
        //Show Custom Overlay
        [currentSDKLabels setObject:@"Show custom overlay" forKey:@"custom_overlay"];
        
        [currentSDKLabels setObject:@"Customer Search" forKey:@"customer_search_label"];
        [currentSDKLabels setObject:@"Employee Search" forKey:@"employee_search_label"];
        [currentSDKLabels setObject:@"Need Immediate Response" forKey:@"need_immediate_response"];
        
        [currentSDKLabels setObject:@"Barcode Scan Details:" forKey:@"barcode_data"];
        
        [currentSDKLabels setObject:@"Select the id type and extract data offline" forKey:@"auto_fill_service_des"];
        
        [currentSDKLabels setObject:@"BARCODE or MRZ not found for the selected id." forKey:@"barcode_mrz_not_found"];
        
        [currentSDKLabels setObject:@"Capture Front(Autofill)" forKey:@"auto_fill_front_tab"];
        [currentSDKLabels setObject:@"Capture Back(Autofill)" forKey:@"auto_fill_back_tab"];
        [currentSDKLabels setObject:@"MRZ retry count" forKey:@"mrz_retry_count"];
        [currentSDKLabels setObject:@"MRZ and BARCODE retry count" forKey:@"mrz_barcode_retry_count"];
        
        [currentSDKLabels setObject:@"Upload face data" forKey:@"upload_face_data"];
    }
}

+(BOOL)isLanguageSupported:(NSString*)language{
    language = [language lowercaseString];
    if([language isEqualToString:@"en"]){
        return true;
    }
    
    if([language isEqualToString:@"my"]){
        return true;
    }
    
    if([language isEqualToString:@"es"]){
        return true;
    }
    return false;
}
@end
