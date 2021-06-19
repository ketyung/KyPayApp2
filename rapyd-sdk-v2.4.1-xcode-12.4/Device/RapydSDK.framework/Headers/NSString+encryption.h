//
//  NSString+NSString_encryption.h
//  RapydSDK
//
//  Created by Sagi Ittah on 19/09/2017.
//  Copyright © 2017 Rapyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encryption)
+ (NSString*) hash:(NSString *)clear;
+ (NSString *) hmac256ByKey:(NSString *) key andData:(NSString *) data;
@end
