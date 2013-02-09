//
//  PrototypeOneDeckController.m
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeOneController.h"
#import "PrototypeOneDeckController.h"

@implementation PrototypeOneDeckController

@synthesize deckPicker;

@synthesize leitnerSwitch;

@synthesize parentController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
		
	NSBundle *mainBundle = [NSBundle mainBundle];

	if (self = [super initWithNibName:@"PrototypeOneDecks" bundle:mainBundle]) {
		// Custom initialization
	}
	
    return self;
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	BNFlashCardPrototypeAppDelegate *delegate = 
	    (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
		
	[deckPicker selectRow:0 inComponent:kMathDeck animated:YES];
	
	/*
	// Warning
	NSString *warningMsg = 
	[NSString stringWithFormat:@"Center on an interesting location and then hit the search button to bring results.  (NOTE: In order for the GoogleMap controller to work properly, you must have an iPhone or be near an open Wi-Fi port.  If nothing is presented initially, pinch and unpinch to access cached map data."];
	
	UIAlertView *alert = 
	    [[UIAlertView alloc] initWithTitle:@"Info" 
							 message:warningMsg delegate:nil 
					         cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	
	[alert show];
	[alert release];	
	*/
	
	[leitnerSwitch setOn:NO	animated:NO];
	
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
	    return YES;
	}
	else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		return YES;
	}
	else {
		return NO;
	}
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
		
	[deckPicker release];
	
    [super dealloc];
}

-(id)initWithTabBar:(NSString*)viewType {
	
	BNFlashCardPrototypeAppDelegate *delegate = 
	    (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	if ([self init]) {
		
		//this is the label on the tab button itself
		self.title = viewType;
			
		// UIImage* imageClassic = [UIImage imageNamed:@"parthenon_icon.png"];
		// self.tabBarItem.image = imageClassic;
			
		//use whatever image you want and add it to your project
		self.tabBarItem.image = [UIImage imageNamed:@"DeckIcon.png"];
			
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=viewType;
	}
	
	return self;	
}

- (void) setParent:(PrototypeOneController*)tmpParentController {
	
	self.parentController = tmpParentController;
}

#pragma mark -
#pragma mark Interface Handlers
- (IBAction) selectDeck {

	/*
	BNFlashCardPrototypeAppDelegate *delegate = 
	    (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	// [delegate.navController pushViewController:etwSearchResultsController animated:YES];
	*/
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView*) pickerView {
	
	return 1;
}

- (NSInteger) pickerView:(UIPickerView*) pickerView
 numberOfRowsInComponent:(NSInteger) component {
		
	return 4;
}

#pragma mark Picker Delegate Methods
- (NSString*) pickerView:(UIPickerView*) pickerView
			  titleForRow:(NSInteger) row
			  forComponent:(NSInteger) component {
	
	if (row == kMathDeck) {
	    return @"Math Cards (F)";
	}
	else if (row == kHistoryDeck) {
		return @"History Cards (F)";
	}
	else if (row == kScienceDeck) {
		return @"Science Cards (F)";
	}
	else if (row == kShakespeareDeck) {
		return @"Shakespeare Cards (N)";
	}
	
	return @"Unknown Cards";
}

- (void) pickerView:(UIPickerView*) pickerView
	     didSelectRow:(NSInteger) row
		 inComponent:(NSInteger) component {
	
	NSMutableString *chosenDeck;
	
	BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	if (row == kMathDeck) {
	    chosenDeck = [[NSMutableString alloc] initWithString:@"Math"];
	}
	else if (row == kHistoryDeck) {
	    chosenDeck = [[NSMutableString alloc] initWithString:@"History"];
	}
	else if (row == kScienceDeck) {
		chosenDeck = [[NSMutableString alloc] initWithString:@"Science"];
	}
	else if (row == kShakespeareDeck) {
		chosenDeck = [[NSMutableString alloc] initWithString:@"Shakespeare"];
	}	
	else {
		chosenDeck = [[NSMutableString alloc] initWithString:@"Unknown"];
	}
	
	[self.parentController setCurrentDeck:chosenDeck];	
}

- (IBAction) gotoDeck {
	[self.parentController tabToCardView];
}

@end