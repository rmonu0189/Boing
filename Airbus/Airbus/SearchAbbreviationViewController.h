//
//  SearchAbbreviationViewController.h
//  Airbus
//
//  Created by Oxilo on 09/09/14.
//  Copyright (c) 2014 OCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSVParser.h"

@interface SearchAbbreviationViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate, UIGestureRecognizerDelegate>
{
   NSMutableDictionary* csvDict;
    NSMutableDictionary* csvDict1;
    NSArray* fetchedData;
    NSMutableArray* filteredSearch;
    BOOL isKeyboardUp;
    CGFloat animatedDistance;
}
@property (strong, nonatomic) IBOutlet UITextField *typeSearchTextField;

@property (strong, nonatomic) IBOutlet UITextView *getAbbTextField;
- (IBAction)shortSearchButtonAction:(id)sender;
- (IBAction)longSearchButtonSpecification:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *shortSearchButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *longSearchButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *tableCellLabel;
@property (weak, nonatomic) IBOutlet UITableView *searchAbbrTable;

@end
