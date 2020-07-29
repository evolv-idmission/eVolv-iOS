//
//  KeyValue.h
//  CustomTableView
//
//  Created by Monu Verma on 24/01/20.
//  Copyright © 2020 Monu Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValue : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

-(id)initWithCode:(NSString *)key_
value:(NSString *)value_;

@end
