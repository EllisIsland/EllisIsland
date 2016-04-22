//
//  Program.h
//  EllisNYC
//
//  Created by Vladyslav Gusakov on 4/22/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject

@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *borough;
@property (nullable, nonatomic, retain) NSString *agency;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *age_group;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *zip;


@end
