//
//  ViewController.m
//  Airbus
//
//  Created by Oxilo on 05/09/14.
//  Copyright (c) 2014 OCS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchAbbButtonOutlet,converterButtonOutlet,aboutUsButtonOutlet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   // searchAbbButtonOutlet.titleLabel.font = [UIFont fontWithName:@"ufonts.com_gotham-bold-italic" size:22.0];
    
    UIFont *fontCustom = [UIFont fontWithName:@"ufonts.com_gotham-bold-italic" size:14];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
