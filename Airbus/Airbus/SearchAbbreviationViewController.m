//
//  SearchAbbreviationViewController.m
//  Airbus
//
//  Created by Oxilo on 09/09/14.
//  Copyright (c) 2014 OCS. All rights reserved.
//

#import "SearchAbbreviationViewController.h"

@interface SearchAbbreviationViewController ()

@end

@implementation SearchAbbreviationViewController
@synthesize typeSearchTextField,getAbbTextField,shortSearchButtonOutlet,longSearchButtonOutlet;

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
    
    typeSearchTextField.delegate = self;
    getAbbTextField.delegate = self;
    
    csvDict = [[NSMutableDictionary alloc]init];
    csvDict1 = [[NSMutableDictionary alloc]init];
    
    [shortSearchButtonOutlet setSelected:TRUE];
    [longSearchButtonOutlet setSelected:FALSE];
    
    NSString *resourceFileName = @"AirbusAbbreviations";
    NSString *pathToFile =[[NSBundle mainBundle] pathForResource: resourceFileName ofType: @"csv"];
    
    NSError *error;
    
    NSString *fileString = [NSString stringWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:&error];
    CSVParser *parser = [[CSVParser alloc]initWithString:fileString separator:@"," hasHeader:YES fieldNames:[NSArray arrayWithObjects:nil]];
    fetchedData = [[parser arrayOfParsedRows] copy];
    
    
    for (NSDictionary* dict in fetchedData) {
        [csvDict setValue:[dict valueForKey:@"Term"] forKey:[ dict valueForKey:@"Abbreviation"]];
        [csvDict1 setValue:[dict valueForKey:@"Abbreviation"] forKey:[ dict valueForKey:@"Term"]];
    }
    NSLog(@" csv %@",[fetchedData objectAtIndex:2]);
    
    UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tapHandler:)];
    tapper.cancelsTouchesInView = NO;
    [tapper setDelegate:self];
    [self.view addGestureRecognizer:tapper];
    
    [_searchAbbrTable setHidden:YES];
    [typeSearchTextField addTarget:self
                         action:@selector(editingChanged:)
               forControlEvents:UIControlEventEditingChanged];
    _searchAbbrTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isKeyboardShowing:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isKeyboardShowing:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) isKeyboardShowing:(NSNotification*)noti{
    if ([noti.name isEqualToString:@"UIKeyboardDidShowNotification"]) {
        isKeyboardUp = YES;
    }else
        isKeyboardUp = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_searchAbbrTable]){
        return NO;
    }
    return YES;
}

- (void)tapHandler:(UITapGestureRecognizer *) sender
{
    if (isKeyboardUp)
        [self.view endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
   [getAbbTextField setText:@""];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    if( shortSearchButtonOutlet.selected == TRUE)
    {
        if ([typeSearchTextField.text length]>0)
            [getAbbTextField setText:[csvDict valueForKey:typeSearchTextField.text]];
        if ([getAbbTextField.text length]==0)
            [getAbbTextField setText:@"No term found for this Abbreviation"];
    }
    
    if( longSearchButtonOutlet.selected == TRUE )
    {
        if ([typeSearchTextField.text length]>0)
            [getAbbTextField setText:[csvDict1 valueForKey:typeSearchTextField.text]];
        if ([getAbbTextField.text length]==0)
            [getAbbTextField setText:@"No Abbreviation found for this Term"];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    //[ self showAbbreviation ];
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)shortSearchButtonAction:(id)sender {
    [getAbbTextField setText:@""];
    [typeSearchTextField setText:@""];
    [shortSearchButtonOutlet setSelected:TRUE];
    [longSearchButtonOutlet setSelected:FALSE];
}

- (IBAction)longSearchButtonSpecification:(id)sender {
    [getAbbTextField setText:@""];
    [typeSearchTextField setText:@""];
    [shortSearchButtonOutlet setSelected:FALSE];
    [longSearchButtonOutlet setSelected:TRUE];
}

#pragma mark TableView Delegates and Datasource
-(void) editingChanged:(id)sender {
    NSString *searchText = typeSearchTextField.text;
    if ([searchText length]==0) {
        [filteredSearch removeAllObjects];
    }else{
        [filteredSearch removeAllObjects];
        [_searchAbbrTable reloadData];
        [_searchAbbrTable setHidden:NO];
        [self filterContentForSearchText:searchText scope:nil];
    }
}

-(void) filterContentForSearchText:(NSString *)searchText scope:(NSString *) scope
{
    [filteredSearch removeAllObjects];
    NSArray *result;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@", searchText];
    if ([shortSearchButtonOutlet isSelected]) {
        result = [[csvDict allKeys] filteredArrayUsingPredicate:predicate];
    }else{
        result = [[csvDict1 allKeys] filteredArrayUsingPredicate:predicate];
    }
    filteredSearch = [result mutableCopy];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"length"
                                                  ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    [filteredSearch sortUsingDescriptors:sortDescriptors];
    [_searchAbbrTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filteredSearch count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"SEARCHCELL";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    UIFont *myFont = [UIFont fontWithName: @"Helvetica Neue" size: 15.0];
    cell.textLabel.font  = myFont;
    [cell.textLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor colorWithRed: 68.0/255.0 green: 125.0/255.0 blue: 190.0/255.0 alpha: 0.9];
    cell.textLabel.text = [filteredSearch objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [typeSearchTextField setText:[filteredSearch objectAtIndex:indexPath.row]];
    if ([shortSearchButtonOutlet isSelected]) {
        [getAbbTextField setText:[csvDict valueForKey:[filteredSearch objectAtIndex:indexPath.row]]];
    }else
        [getAbbTextField setText:[csvDict1 valueForKey:[filteredSearch objectAtIndex:indexPath.row]]];
    [_searchAbbrTable setHidden:YES];
    [filteredSearch removeAllObjects];
    [_searchAbbrTable reloadData];
    [self.view endEditing:YES];
}

#pragma mark -
@end
