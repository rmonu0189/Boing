//
//  ConverterViewController.h
//  Airbus
//
//  Created by Oxilo on 06/09/14.
//  Copyright (c) 2014 OCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHUnitConverter.h"

@interface ConverterViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>
{
    BOOL _toggleCoverterDropdownButton;
    BOOL _toggleFromKeysDropDownButton;
    BOOL _toggleToKeysDropDownButton;
    
    NSMutableDictionary* _lengthDict;
    NSMutableDictionary* _tempDict;
    NSMutableDictionary* _weightDict;
    
    NSMutableDictionary* mainDict;
    
    NSMutableArray* _lengthKeys;
    NSMutableArray* _tempKeys;
    NSMutableArray* _weightKey;
    NSMutableArray* _pressureKey;
    NSMutableArray* _forceKey;
    NSMutableArray* _speedKey;
    NSMutableArray* _volumeKey;
    NSMutableArray* _fuelWeightKeys;
    
    NSString* _selectedKeyMainDict;
    
    int _selectedFromKeyIndex;

    
    int tableViewCount;
    
    NSString *selected_Key;
    
//    HHUnitConverter *converter;
    
  
}
- (IBAction)_listDropDownACtionButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *_convertListTextField;
@property (strong, nonatomic) IBOutlet UITextField *_fromTextField;
@property (strong, nonatomic) IBOutlet UITextField *_toValueTextField;
@property (strong, nonatomic) IBOutlet UITableView *converterTableView;
@property(strong,nonatomic)NSMutableArray* converterArray;
@property (strong, nonatomic) IBOutlet UITextField *_fromKeysTextField;
@property (strong, nonatomic) IBOutlet UITextField *_toKeysTextField;
@property (strong, nonatomic) IBOutlet UITableView *_fromKeysTableView;
- (IBAction)fromKeyDropDownButtonAction:(id)sender;
- (IBAction)toKeyDropDownButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *_toKeysTableView;





@end
