//
//  CustomCell.h
//  EllisNYC
//
//  Created by Vladyslav Gusakov on 4/22/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *agency;
@property (strong, nonatomic) IBOutlet UILabel *borough;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *age;

@end
