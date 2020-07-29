//
//  KeyValue.m
//  CustomTableView
//
//  Created by Monu Verma on 24/01/20.
//  Copyright © 2020 Monu Verma. All rights reserved.
//

#import "KeyValue.h"

@implementation KeyValue

@synthesize key;
@synthesize value;

-(id)initWithCode:(NSString *)key_
value:(NSString *)value_
{
    self = [super init];
    if (self) {
        self.key = key_;
        self.value = value_;
    }
    return self;
}

@end
