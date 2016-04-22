//
//  FilterViewController.m
//  EllisNYC
//
//  Created by Vladyslav Gusakov on 4/22/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import "FilterViewController.h"
#import "DAO.h"

@interface FilterViewController () {
    NSUserDefaults *defaults;
    BOOL isManhattan;
    BOOL isBrooklyn;
    BOOL isQueens;
    BOOL isStaten;
    BOOL isBronx;
    DAO *dao;
}
@property (weak, nonatomic) IBOutlet UIButton *manhattan;
@property (weak, nonatomic) IBOutlet UIButton *brooklyn;
@property (weak, nonatomic) IBOutlet UIButton *queens;
@property (weak, nonatomic) IBOutlet UIButton *statenIsland;
@property (weak, nonatomic) IBOutlet UIButton *bronx;

- (IBAction)manhattanToggle:(id)sender;
- (IBAction)brooklynToggle:(id)sender;
- (IBAction)queensToggle:(id)sender;
- (IBAction)statenIslandToggle:(id)sender;
- (IBAction)bronxToggle:(id)sender;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     isManhattan = NO;
     isBrooklyn = NO;
     isQueens = NO;
     isStaten = NO;
     isBronx = NO;
    
    defaults = [NSUserDefaults standardUserDefaults];
    dao = [DAO sharedManager];
    
    if ([[defaults objectForKey:@"Manhattan"] isEqual:@YES]) {
        isManhattan = YES;
        self.manhattan.backgroundColor = [UIColor grayColor];
    }
    else {
        self.manhattan.backgroundColor = [UIColor whiteColor];

    }
    if ([[defaults objectForKey:@"Brooklyn"] isEqual:@YES]) {
        isBrooklyn = YES;
        self.brooklyn.backgroundColor = [UIColor grayColor];
    }
    else {
        self.brooklyn.backgroundColor = [UIColor whiteColor];
        
    }
    if ([[defaults objectForKey:@"Queens"] isEqual:@YES]) {
        isQueens = YES;
        self.queens.backgroundColor = [UIColor grayColor];
    }
    else {
        self.queens.backgroundColor = [UIColor whiteColor];
        
    }
    if ([[defaults objectForKey:@"Staten Island"] isEqual:@YES]) {
        isStaten = YES;
        self.statenIsland.backgroundColor = [UIColor grayColor];
    }
    else {
        self.statenIsland.backgroundColor = [UIColor whiteColor];
        
    }
    if ([[defaults objectForKey:@"Bronx"] isEqual:@YES]) {
        isBronx = YES;
        self.bronx.backgroundColor = [UIColor grayColor];
    }
    else {
        self.bronx.backgroundColor = [UIColor whiteColor];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)manhattanToggle:(UIButton *)sender {
    
    if ([sender.backgroundColor isEqual: [UIColor whiteColor]]) {
        sender.backgroundColor = [UIColor grayColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
    
    isManhattan = !isManhattan;
    
    [defaults setObject:@(isManhattan) forKey:@"Manhattan"];
    [defaults synchronize];
}

- (IBAction)brooklynToggle:(UIButton *)sender {
    if ([sender.backgroundColor isEqual: [UIColor whiteColor]]) {
        sender.backgroundColor = [UIColor grayColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
    isBrooklyn = !isBrooklyn;
    
    [defaults setObject:@(isBrooklyn) forKey:@"Brooklyn"];
    [defaults synchronize];
}

- (IBAction)queensToggle:(UIButton *)sender {
    if ([sender.backgroundColor isEqual: [UIColor whiteColor]]) {
        sender.backgroundColor = [UIColor grayColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
    isQueens = !isQueens;
    [defaults setObject:@(isQueens) forKey:@"Queens"];
    [defaults synchronize];
}

- (IBAction)statenIslandToggle:(UIButton *)sender {
    if ([sender.backgroundColor isEqual: [UIColor whiteColor]]) {
        sender.backgroundColor = [UIColor grayColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
    isStaten = !isStaten;
    [defaults setObject:@(isStaten) forKey:@"Staten Island"];
    [defaults synchronize];
}

- (IBAction)bronxToggle:(UIButton *)sender {
    if ([sender.backgroundColor isEqual: [UIColor whiteColor]]) {
        sender.backgroundColor = [UIColor grayColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
    isBronx = !isBronx;
    [defaults setObject:@(isBronx) forKey:@"Bronx"];
    [defaults synchronize];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%i,%i,%i,%i,%i", isManhattan,isBrooklyn,isQueens,isStaten,isBronx);
    
    [dao sortPrograms];
    
}

@end
