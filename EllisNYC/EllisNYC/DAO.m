//
//  DAO.m
//  EllisNYC
//
//  Created by Vladyslav Gusakov on 4/22/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import "DAO.h"
#import "AppDelegate.h"

@interface DAO() {
    NSUserDefaults *defaults;
}

@property (nonatomic) NSMutableArray *result;
@property (nonatomic) NSData *returnData;

@end

@implementation DAO

+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        defaults = [NSUserDefaults standardUserDefaults];
        
        self.programsList = [NSMutableArray new];
        self.sortedProgramsList = [NSMutableArray new];
        self.boroughList = [[NSMutableArray alloc] initWithArray:@[@"Manhattan", @"Brooklyn", @"Queens", @"Staten Island", @"Bronx"]];
        
        self.activeBoroughs = [[NSMutableArray alloc] initWithArray:@[@NO, @NO, @NO, @NO, @NO]];
        
        [self fetchFromAPI];
        
    }
    return self;
}

-(void) fetchFromAPI {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://data.cityofnewyork.us/resource/btx2-u66x.json"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                self.returnData = data;
                
                [self parseJson];
            }
            
        });
        
    }] resume];
}

-(void)parseJson
{
    NSError *errorJson;
    self.result = [NSJSONSerialization JSONObjectWithData:self.returnData options:0 error:&errorJson];
    
    for (id object in self.result) {
        Program *program = [Program new];
        
        program.borough = [object valueForKey:@"borough_community"];
        program.agency = [object valueForKey:@"agency"];
        program.number = [object valueForKey:@"contact_number"];
        program.age_group = [object valueForKey:@"grade_level_age_group"];
        program.address = [object valueForKey:@"location_1_location"];
        program.zip = [object valueForKey:@"location_1_zip"];
        NSArray *location_1_coordinates = [object valueForKeyPath:@"location_1.coordinates"];
        program.latitude = location_1_coordinates.firstObject;
        program.longitude = location_1_coordinates.lastObject;
        program.type = [object valueForKey:@"program_type"];
        
//        if (![self.boroughList containsObject: program.borough]) {
//            [self.boroughList addObject:program.borough];
//
//        }
        [self.programsList addObject:program];
        
    }
    self.sortedProgramsList = [NSMutableArray arrayWithArray:self.programsList];
    
    [self sortPrograms];
    
//    [self.delegate MainTableViewReloadData];
}

-(void) sortPrograms {
    
    
    NSLog(@"dao manhattan: %@", [defaults objectForKey:@"Manhattan"]);
    NSLog(@"dao brooklyn: %@", [defaults objectForKey:@"Brooklyn"]);
    NSLog(@"dao Queens: %@", [defaults objectForKey:@"Queens"]);
    NSLog(@"dao Staten Island: %@", [defaults objectForKey:@"Staten Island"]);
    NSLog(@"dao Bronx: %@", [defaults objectForKey:@"Bronx"]);
    
    for (int i = 0; i < 5; i++) {
        if ([[defaults objectForKey:self.boroughList[i]] isEqual:@(YES)]) {
            self.activeBoroughs[i] = @YES;
        }
        else {
            self.activeBoroughs[i] = @NO;
        }
    }
    
    NSLog (@"%@", self.activeBoroughs);
    
    NSMutableArray *predicatesArr = [NSMutableArray new];
    for (int i = 0; i < self.activeBoroughs.count; i++ ) {
        
        if ([self.activeBoroughs[i]  isEqual: @YES]) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"borough = '%@'", self.boroughList[i]]];
            [predicatesArr addObject:predicate];
            NSLog(@"predicate: %@", predicate);
        }
        
    }
    
    NSPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicatesArr];

    self.sortedProgramsList = [NSMutableArray arrayWithArray:
                               [self.programsList filteredArrayUsingPredicate: compoundPredicate]];
    
    [self.delegate MainTableViewReloadData];
    
    //[self displayImmigrationServices];

}

-(void) displayImmigrationServices {
    
    NSArray *services = [[NSArray alloc] initWithObjects:@"Immigration Services",@"Immigrant Support Services", @"Immigrant Youth", @"Immigrant/Refugee Assistance", @"Immigrant", @"Literacy", @"NDA Programs",@"NDA Immigrants", nil];
    
    for (Program *program in self.programsList) {
        
        NSString *type = program.type;
        
        for (NSString *service in services) {
            if ([type rangeOfString:service].location == NSNotFound) {
                //                NSLog(@"string does not contain an immigration service");
            } else {
                NSLog(@"string contains service");
                // create a property that returns and set value to true that it involves immigration services
                return;
                
            }
            
        }
        
    }
    
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
