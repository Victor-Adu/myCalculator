//
//  ViewController.m
//  myCalculator
//
//  Created by Victor  Adu on 4/21/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    valueString = @"";    //We need to initialize our string variable first before we can change it. Here we start with null.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tappedClear:(id)sender;
{
    total = 0;
    valueString = @"";
    label.text = @"0";

}
- (IBAction)tappedNumber:(UIButton*)btn;
{
    int num = btn.tag;
    
    /* 'if' basically says if the number we input FIRST is '0' and by default total = '0', return.
    Basically don't run the rest of the code in this function. */
    if (num == 0 && total == 0) {
        return;
    }
    
    // So basically if'lastButtonWasMode' is NO (i.e. No longer '+' or '-' via setMode ftn, or a number had been entered after '+' or '-'), preserve old inputted values but clear screen to receive new values.['valueString = @"";'] does the clear screen.
    if (lastButtonWasMode) {
        lastButtonWasMode = NO;
        valueString = @"";
    }
    
    NSString *numAsString = [NSString stringWithFormat:@"%i", num];
    valueString = [valueString stringByAppendingString:numAsString];
    
    //The NSNumberFormatter formats our values.
    NSNumberFormatter *formatter = [NSNumberFormatter new];    // We create and initialize a number formatter.
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];  //Set NSNumber Format Style (values show with commas).
    NSNumber *n = [formatter numberFromString:valueString];    // Create a complex number to get numbers from string.
    label.text = [formatter stringFromNumber: n];              //Format and show values in formatted form
    
    //label.text = valueString; Not needed after we formatted our values.
    
    /*By default total == 0 till we change it. So basically the 'if' below is saying take whatever string value we
    provide and convert it back to an integer. */
    if (total == 0) {
        total = [valueString intValue];
    }

}
- (IBAction)tappedPlus:(id)sender;
{
    [self setMode:1];

}
- (IBAction)tappedMinus:(id)sender;
{
    [self setMode:-1];

}

- (IBAction)tappedMultiply:(id)sender;
{
    [self setMode: 2]; 
}

- (IBAction)tappedDivide:(id)sender;
{
    [self setMode: -2];
}

- (IBAction)tappedEquals:(id)sender;
{
    if (mode == 0) {
        return;
    }
    
      //short hand operator for adding or subtracting to an existing value '+=' or '-='. Remember we already set 'total' in setMode (total = [valueString intValue];)So we telling our program to take any already inputted value from before we hit mode ('+' or '-'), and add it to whatever value we entered after the '+' or '-' symbol.
    if (mode == 1) {
        total += [valueString intValue];
    }
    if (mode == -1) {
        total -= [valueString intValue];
    }
    
    if (mode == 2) {
        total *= [valueString intValue];
    }
    
    if (mode == -2) {
        total /= [valueString intValue];
    }
    
    valueString = [NSString stringWithFormat:@"%i",total];
    
    //The NSNumberFormatter formats our values.
    NSNumberFormatter *formatter = [NSNumberFormatter new];    // We create and initialize a number formatter.
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];  //Set NSNumber Format Style (values show with commas).
    NSNumber *n = [formatter numberFromString:valueString];    // Create a complex number to get numbers from string.
    label.text = [formatter stringFromNumber: n];              //Format and show values in formatted form
    
    // label.text = valueString; Not needed after formatting.
    mode = 0;

}



-(void) setMode: (int)m;
{
    //The 'if' is saying, If the '+' or '-' is hit first, nothing should happen. Don't run rest of the code.
    if (total == 0) {
        return;
    }
    //Here, 'mode' will take a ('+' or '-') integer. And if ('+' or '-') was pressed, obviously 'lastButtonWasMode =('YES'), convert string to integer value and preserve.
    mode = m;
    lastButtonWasMode = YES;
    total = [valueString intValue];


}

@end
