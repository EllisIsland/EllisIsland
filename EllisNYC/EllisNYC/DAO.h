//
//  DAO.h
//  EllisNYC
//
//  Created by Vladyslav Gusakov on 4/22/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"

@protocol DAODelegate <NSObject>

-(void) MainTableViewReloadData;

@end

@interface DAO : NSObject

@property (nullable, nonatomic, strong) NSMutableArray <Program*> *programsList;
@property (nullable, nonatomic, strong) NSMutableArray <Program*> *sortedProgramsList;

@property (nullable, nonatomic, strong) NSMutableArray *boroughList;
@property (nullable, nonatomic, strong) NSMutableArray *activeBoroughs;


+ (id)sharedManager;

@property (nonatomic, strong) id delegate;
-(void) sortPrograms;

@end
