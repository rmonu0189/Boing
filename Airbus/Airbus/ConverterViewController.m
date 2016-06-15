//
//  ConverterViewController.m
//  Airbus
//
//  Created by Oxilo on 06/09/14.
//  Copyright (c) 2014 OCS. All rights reserved.
//

#import "ConverterViewController.h"

@interface ConverterViewController ()

@end

@implementation ConverterViewController
@synthesize _convertListTextField,_fromTextField,_toValueTextField,converterTableView,converterArray,_fromKeysTextField,_toKeysTextField,_fromKeysTableView;
@synthesize _toKeysTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectedKeyMainDict = @"Temperature";
    converterArray = [[NSMutableArray alloc]initWithObjects:@"Length",@"Temperature",@"Weight", @"Pressure", @"Force", @"Speed", @"Volume", nil];
    
    _lengthKeys = [[NSMutableArray alloc]initWithObjects:@"Km",@"m", @"Nm", @"ft", nil];
    
    _tempKeys = [[NSMutableArray alloc]initWithObjects:@"°C",@"°F", nil];
    
    _weightKey = [[NSMutableArray alloc]initWithObjects:@"lb", @"g", @"oz", @"kg", nil];
    
    _pressureKey = [[NSMutableArray alloc]initWithObjects:@"bar",@"psi", nil];
    
    _forceKey = [[NSMutableArray alloc]initWithObjects:@"N",@"lb", nil];
    
    _speedKey = [[NSMutableArray alloc]initWithObjects:@"Kmh", @"Kt", @"m/s", nil];
    
    _volumeKey = [[NSMutableArray alloc]initWithObjects:@"Liter",@"US Gallons", nil];
    
    _fuelWeightKeys = [[NSMutableArray alloc]initWithObjects:@"kg", @"US Gallons", @"Liter", @"lb",nil];
    
    mainDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_lengthKeys,@"Length",_tempKeys,@"Temperature",_weightKey,@"Weight", _pressureKey, @"Pressure",_forceKey, @"Force",_speedKey,@"Speed", _volumeKey,@"Volume",nil];
    
    
    
    float val = 0.0;
    NSLog(@"val %f",val);
    
    NSString *string = [NSString stringWithFormat:@"%0.2f", val];
    
    converterTableView.delegate = self;
    converterTableView.dataSource = self;
    
    _fromKeysTableView.delegate = self;
    _fromKeysTableView.dataSource = self;
    
    _toKeysTableView.delegate = self;
    _toKeysTableView.dataSource = self;
    
    _convertListTextField.delegate = self;
    _fromTextField.delegate = self;
    _toValueTextField.delegate = self;
    
   
    
    _fromKeysTextField.delegate = self;
    _toKeysTextField.delegate = self;
    
    _fromTextField.delegate = self;
    _toValueTextField.delegate = self;
    
    _convertListTextField.text = _selectedKeyMainDict;
    _fromTextField.text = string;
    _toValueTextField.text = string;
    
    _fromKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:0];
    _toKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:1];
    
    
    
    _toggleCoverterDropdownButton = false;
    converterTableView.hidden = TRUE;
    
    _toggleFromKeysDropDownButton = false;
    _fromKeysTableView.hidden = TRUE;
    
    _toggleToKeysDropDownButton = false;
    _toKeysTableView.hidden = TRUE;
    
  
    UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tapHandler:)];
    tapper.cancelsTouchesInView = NO;
    [tapper setDelegate:self];
    [self.view addGestureRecognizer:tapper];
    
    converterTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _fromKeysTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _toKeysTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSString*)convertValue:(NSString*)value fromParam:(NSString*)fromParam toParam:(NSString*)toParam{
    
    
    HHUnitConverter *converter = [HHUnitConverter new];
    // weight
    [converter letUnit:@"kg" convertToUnit:@"g" byMultiplyingBy:100];
    [converter letUnit:@"kg" convertToUnit:@"lb" byMultiplyingBy:2.2046];
    [converter letUnit:@"kg" convertToUnit:@"oz" byMultiplyingBy:35.274];
    [converter letUnit:@"oz" convertToUnit:@"kg" byMultiplyingBy:0.0283];
    [converter letUnit:@"oz" convertToUnit:@"g" byMultiplyingBy:28.34];
    [converter letUnit:@"oz" convertToUnit:@"lb" byMultiplyingBy:0.0625];
    [converter letUnit:@"g" convertToUnit:@"kg" byMultiplyingBy:0.0001];
    [converter letUnit:@"g" convertToUnit:@"oz" byMultiplyingBy:0.0352];
    [converter letUnit:@"g" convertToUnit:@"lb" byMultiplyingBy:0.0022];
    [converter letUnit:@"lb" convertToUnit:@"kg" byMultiplyingBy:0.4535];
    [converter letUnit:@"lb" convertToUnit:@"oz" byMultiplyingBy:16];
    [converter letUnit:@"lb" convertToUnit:@"g" byMultiplyingBy:453.592];
    
    // length
    [converter letUnit:@"Km" convertToUnit:@"m" byMultiplyingBy:1000];
    [converter letUnit:@"m" convertToUnit:@"cm" byMultiplyingBy:100];
    [converter letUnit:@"Km" convertToUnit:@"Nm" byMultiplyingBy:0.5399];
    [converter letUnit:@"Km" convertToUnit:@"ft" byMultiplyingBy:3280.00];
    [converter letUnit:@"Km" convertToUnit:@"mm" byMultiplyingBy:1000000];
    [converter letUnit:@"Km" convertToUnit:@"in" byMultiplyingBy:39370.10];
    [converter letUnit:@"m" convertToUnit:@"Km" byMultiplyingBy:0.0001];
    [converter letUnit:@"m" convertToUnit:@"Nm" byMultiplyingBy:0.000539];
    [converter letUnit:@"m" convertToUnit:@"ft" byMultiplyingBy:3.280];
    [converter letUnit:@"m" convertToUnit:@"mm" byMultiplyingBy:100];
    [converter letUnit:@"m" convertToUnit:@"in" byMultiplyingBy:39.37];
    [converter letUnit:@"Nm" convertToUnit:@"Km" byMultiplyingBy:1.852];
    [converter letUnit:@"Nm" convertToUnit:@"m" byMultiplyingBy:1852];
    [converter letUnit:@"Nm" convertToUnit:@"mm" byMultiplyingBy:(1.852*1000000)];
    [converter letUnit:@"Nm" convertToUnit:@"in" byMultiplyingBy:72913.4];
    [converter letUnit:@"Nm" convertToUnit:@"ft" byMultiplyingBy:6076.12];
    [converter letUnit:@"mm" convertToUnit:@"Km" byMultiplyingBy:0.0000001];
    [converter letUnit:@"mm" convertToUnit:@"m" byMultiplyingBy:0.001];
    [converter letUnit:@"mm" convertToUnit:@"Nm" byMultiplyingBy:0.00000054];
    [converter letUnit:@"mm" convertToUnit:@"ft" byMultiplyingBy:0.0032];
    [converter letUnit:@"mm" convertToUnit:@"in" byMultiplyingBy:0.0393];
    [converter letUnit:@"ft" convertToUnit:@"Km" byMultiplyingBy:0.0003];
    [converter letUnit:@"ft" convertToUnit:@"m" byMultiplyingBy:0.3048];
    [converter letUnit:@"ft" convertToUnit:@"Nm" byMultiplyingBy:0.00016];
    [converter letUnit:@"ft" convertToUnit:@"mm" byMultiplyingBy:304.8];
    [converter letUnit:@"ft" convertToUnit:@"in" byMultiplyingBy:12];
    [converter letUnit:@"in" convertToUnit:@"Km" byMultiplyingBy:0.0000254];
    [converter letUnit:@"in" convertToUnit:@"m" byMultiplyingBy:0.0254];
    [converter letUnit:@"in" convertToUnit:@"Nm" byMultiplyingBy:0.000014];
    [converter letUnit:@"in" convertToUnit:@"ft" byMultiplyingBy:0.0833];
    [converter letUnit:@"in" convertToUnit:@"mm" byMultiplyingBy:25.4];
    
    
    //Pressure
    [converter letUnit:@"bar" convertToUnit:@"psi" byMultiplyingBy:14.503];
    [converter letUnit:@"psi" convertToUnit:@"bar" byMultiplyingBy:0.0689];
    
    // temperature
    [converter letUnit:@"°C" convertToUnit:@"°F" byMultiplyingBy:1.80 andAdding:32];
    [converter letUnit:@"°F" convertToUnit:@"°C" byMultiplyingBy:0.56 andAdding:-32];
    
    // Force
    [converter letUnit:@"N" convertToUnit:@"lb" byMultiplyingBy:0.2248];
    [converter letUnit:@"lb" convertToUnit:@"N" byMultiplyingBy:4.448];
    
    //Speed
    [converter letUnit:@"Kmh" convertToUnit:@"Kt" byMultiplyingBy:0.540];
    [converter letUnit:@"Kmh" convertToUnit:@"m/s" byMultiplyingBy:0.277778];
    [converter letUnit:@"Kt" convertToUnit:@"m/s" byMultiplyingBy:0.514444444];
    [converter letUnit:@"m/s" convertToUnit:@"kt" byMultiplyingBy:1.94384449];
    [converter letUnit:@"m/s" convertToUnit:@"km/h" byMultiplyingBy:3.600000];
    [converter letUnit:@"Kt" convertToUnit:@"Kmh" byMultiplyingBy:1.852];
    [converter letUnit:@"m/s" convertToUnit:@"Kmh" byMultiplyingBy:1.852];
    
    //Volume
    [converter letUnit:@"Liter" convertToUnit:@"US Gallons" byMultiplyingBy:0.264];
    [converter letUnit:@"US Gallons" convertToUnit:@"Liter" byMultiplyingBy:3.785];
    
    //Fuel Weight
    [converter letUnit:@"US Gallons" convertToUnit:@"kg" byMultiplyingBy:3.785];
    [converter letUnit:@"US Gallons" convertToUnit:@"lb" byMultiplyingBy:8.345];
    [converter letUnit:@"kg" convertToUnit:@"US Gallons" byMultiplyingBy:0.264];
    [converter letUnit:@"kg" convertToUnit:@"Liter" byMultiplyingBy:1];
    [converter letUnit:@"kg" convertToUnit:@"lb" byMultiplyingBy:2.204];
    [converter letUnit:@"Liter" convertToUnit:@"kg" byMultiplyingBy:1];
    [converter letUnit:@"Liter" convertToUnit:@"lb" byMultiplyingBy:2.204];
    [converter letUnit:@"lb" convertToUnit:@"US Gallons" byMultiplyingBy:0.119];
    [converter letUnit:@"lb" convertToUnit:@"kg" byMultiplyingBy:0.453];
    [converter letUnit:@"lb" convertToUnit:@"Liter" byMultiplyingBy:0.453];
    
    // time
    [converter letUnit:@"h" convertToUnit:@"min" byMultiplyingBy:60];
    [converter letUnit:@"min" convertToUnit:@"s" byMultiplyingBy:60];
    [converter letUnit:@"s" convertToUnit:@"ms" byMultiplyingBy:1000];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
    if ([fromParam isEqualToString:@"kg"] && [toParam isEqualToString:@"g"]) {
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*1000)]];
        return theString;
    }else if ([fromParam isEqualToString:@"g"] && [toParam isEqualToString:@"kg"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*0.001)]];
        return theString;
    }else if ([fromParam isEqualToString:@"Km"] && [toParam isEqualToString:@"m"]) {
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*1000)]];
        return theString;
    }else if ([fromParam isEqualToString:@"m"] && [toParam isEqualToString:@"Km"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*0.001)]];
        return theString;
    }else if ([fromParam isEqualToString:@"°C"] && [toParam isEqualToString:@"°F"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:((([value floatValue]*9/5))+32)]];
        return theString;
    }else if ([fromParam isEqualToString:@"°F"] && [toParam isEqualToString:@"°C"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:((([value floatValue]-32)*5)/9)]];
        return theString;
    }
    else if ([fromParam isEqualToString:@"Kmh"] && [toParam isEqualToString:@"m/s"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*0.27777778)]];
        return theString;
    } else if ([fromParam isEqualToString:@"Kt"] && [toParam isEqualToString:@"m/s"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*0.51444444)]];
        return theString;
    } else if ([fromParam isEqualToString:@"m/s"] && [toParam isEqualToString:@"Kt"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*1.943844)]];
        return theString;
    } else if ([fromParam isEqualToString:@"m/s"] && [toParam isEqualToString:@"Kmh"]){
        NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:([value floatValue]*3.600000)]];
        return theString;
    }
    NSNumber* result = [converter value:[value floatValue] convertedFromUnit:fromParam toUnit:toParam];
    NSLog(@"from : %@ ::: to : %@ :::: val : %d ::: result : %@", fromParam, toParam, [value intValue], result);
    NSString *resultStr = [NSString stringWithFormat:@"%0.2f", [result floatValue]];
    NSLog(@"result is %@", resultStr);
    NSString *theString = [numberFormatter stringFromNumber:result];
    return theString;
}

- (void)tapHandler:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
    [converterTableView setHidden:YES];
    [_fromKeysTableView setHidden:YES];
    [_toKeysTableView setHidden:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:converterTableView] || [touch.view isDescendantOfView:_fromKeysTableView] || [touch.view isDescendantOfView:_toKeysTableView] || [touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField == _convertListTextField )
    {
        [textField resignFirstResponder];
   
        return NO;
    }
    if( textField == _fromKeysTextField)
    {
        [textField resignFirstResponder];
       
        return NO;
    }
    
    if(textField ==  _toKeysTextField )
    {
        [textField resignFirstResponder];
      
        return NO;
    }
    
    if( textField == _toValueTextField)
    {
        [textField resignFirstResponder];
        
        return YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    
    if ([textfield isEqual:_fromTextField]) {
        
        [_toValueTextField setText:[self convertValue:_fromTextField.text fromParam:_fromKeysTextField.text toParam:_toKeysTextField.text]];
    }else if ([textfield isEqual:_toValueTextField]){
        [_fromTextField setText:[self convertValue:_toValueTextField.text fromParam:_toKeysTextField.text toParam:_fromKeysTextField.text]];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    BOOL valid;
    NSCharacterSet *validCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:textField.text];
    valid = [validCharacterSet isSupersetOfSet:inStringSet];

    
   if (!valid)
   {
       UIAlertView *alerts  = [[UIAlertView alloc]initWithTitle:@"Invalid Value Entered" message:@"please enter only numeric of decimal numbers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       [alerts show];
       textField.text = nil;
   }
    
    [textField resignFirstResponder];
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if( [tableView isEqual:converterTableView ])
    {
        tableViewCount = [[mainDict allKeys]count];
    }
    if ( [ tableView isEqual:_fromKeysTableView])
    {
        tableViewCount =   [[mainDict valueForKey:_selectedKeyMainDict]count];
    }
    if ( [ tableView isEqual:_toKeysTableView])
    {
        tableViewCount =   [[mainDict valueForKey:_selectedKeyMainDict]count];
    }
    return tableViewCount;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ConverterCell";
   
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    UIFont *myFont = [UIFont fontWithName: @"Arial" size: 15.0 ];
    cell.textLabel.font  = myFont;
    [cell.textLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor colorWithRed: 68.0/255.0 green: 125.0/255.0 blue: 190.0/255.0 alpha: 0.9];
    if( [tableView isEqual:converterTableView])
    {
        cell.textLabel.text = [[mainDict allKeys]objectAtIndex:indexPath.row];
        selected_Key = cell.textLabel.text;
    }
    if ([tableView isEqual:_fromKeysTableView])
    {
          cell.textLabel.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:indexPath.row];
    }
    if ([tableView isEqual:_toKeysTableView])
    {
        cell.textLabel.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if ([tableView isEqual:converterTableView]) {
        converterTableView.hidden = YES;
        _toggleCoverterDropdownButton = NO;
        
        _selectedKeyMainDict = [[mainDict allKeys]objectAtIndex:indexPath.row];
        
        _fromKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:0];
        _toKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:1];
        _convertListTextField.text = _selectedKeyMainDict;
        [_fromKeysTableView reloadData];
        [_toKeysTableView reloadData];
        [_toValueTextField setText:[self convertValue:_fromTextField.text fromParam:_fromKeysTextField.text toParam:_toKeysTextField.text]];
    }else if ([tableView isEqual:_fromKeysTableView]){
        _selectedFromKeyIndex = indexPath.row;
        _fromKeysTableView.hidden = YES;
        _toggleFromKeysDropDownButton = NO;
        _fromKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:indexPath.row];
        [_fromTextField setText:[self convertValue:_toValueTextField.text fromParam:_toKeysTextField.text toParam:_fromKeysTextField.text]];
    }else{
        _selectedFromKeyIndex = indexPath.row;
        _fromKeysTableView.hidden = YES;
        _toggleFromKeysDropDownButton = NO;
        
        _toKeysTableView.hidden = YES;
        _toggleToKeysDropDownButton = NO;
        _toKeysTextField.text = [[mainDict valueForKey:_selectedKeyMainDict]objectAtIndex:indexPath.row];
        [_toValueTextField setText:[self convertValue:_fromTextField.text fromParam:_fromKeysTextField.text toParam:_toKeysTextField.text]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)_listDropDownACtionButton:(id)sender {
    
    if( _toggleCoverterDropdownButton == false)
    {
        converterTableView.hidden = false;
        _toggleCoverterDropdownButton = true;
        
        _fromKeysTableView.hidden = TRUE;
        _toggleFromKeysDropDownButton = false;
        
        _toKeysTableView.hidden = TRUE;
        _toggleToKeysDropDownButton = false;
        
       
    }
    else
    {
        converterTableView.hidden = TRUE;
        _toggleCoverterDropdownButton = false;
    }
}
- (IBAction)fromKeyDropDownButtonAction:(id)sender {
    
    if( _toggleFromKeysDropDownButton == false)
    {
        _fromKeysTableView.hidden = false;
        _toggleFromKeysDropDownButton = true;
        
        converterTableView.hidden = TRUE;
        _toggleCoverterDropdownButton = false;
        
        _toKeysTableView.hidden = TRUE;
        _toggleToKeysDropDownButton = false;
    }
    else
    {
        _fromKeysTableView.hidden = TRUE;
        _toggleFromKeysDropDownButton = false;
    }
}

- (IBAction)toKeyDropDownButtonAction:(id)sender {
    
    if( _toggleToKeysDropDownButton == false)
    {
        _toKeysTableView.hidden = false;
        _toggleToKeysDropDownButton = true;
        
        converterTableView.hidden = TRUE;
        _toggleCoverterDropdownButton = false;
        
        _fromKeysTableView.hidden = TRUE;
        _toggleFromKeysDropDownButton = false;
    }
    else
    {
        _toKeysTableView.hidden = TRUE;
        _toggleToKeysDropDownButton = false;
    }
}
@end
