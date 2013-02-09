//
//  PrototypeTwoOptionsController.m
//  BNFCPrototype
//
//  Created by mac on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeTwoOptionsController.h"

@implementation PrototypeTwoOptionsController

@synthesize parentController;
@synthesize leitnerSwitch;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	NSBundle *mainBundle = [NSBundle mainBundle];
	
	if (self = [super initWithNibName:@"PrototypeTwoOptions" bundle:mainBundle]) {
		// Custom initialization
	}
	
    return self;
}

 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
	 
	 int x = 0;
	 
	 [super loadView];
 }

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	BOOL tmpSwitchValue = [parentController isLeitnerModeOn];
	
	[leitnerSwitch setOn:tmpSwitchValue	animated:NO];
	
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
	
    [super dealloc];
}

- (IBAction) leitnerModeChanged:(id)sender {
	
	if (leitnerSwitch.on) {
		
		[parentController setLeitnerMode:YES];
	}
	else {
		
		[parentController setLeitnerMode:NO];
	}
}

- (void) setParent:(PrototypeTwoController*)tmpParentController {
	
	self.parentController = tmpParentController;
}

@end
