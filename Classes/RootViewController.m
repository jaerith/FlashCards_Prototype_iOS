//
//  RootViewController.m
//  BiblioPhile
//
//  Created by mac on 5/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "RootViewController.h"
#import "SecondLevelViewController.h"
#import "PrototypeOneController.h"
#import "PrototypeTwoController.h"

@implementation RootViewController
@synthesize controllers;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"B&N Flash Cards";
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	// First Prototype
	PrototypeOneController *prototypeOneController = 
	    [[PrototypeOneController alloc] init];
	
	prototypeOneController.title = @"Prototype #1";
	// prototypeOneController.rowImage = nil;
	
	[array addObject:prototypeOneController];
	[prototypeOneController release];
	
	// Second Prototype
	PrototypeTwoController *prototypeTwoController = 
		[[PrototypeTwoController alloc] init];
	
	prototypeTwoController.title = @"Prototype #2";
	// prototypeOneController.rowImage = nil;
	
	[array addObject:prototypeTwoController];
	[prototypeTwoController release];	
		
	// Finishing touches
	self.controllers = array;
	[array release];
    [super viewDidLoad];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[controllers release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger) tableView:(UITableView*)tableView
  numberOfRowsInSection:(NSInteger)section {
	return [self.controllers count];	
}

- (UITableViewCell*) tableView:(UITableView*)tableView
		 cellForRowAtIndexPath:(NSIndexPath*)indexPath{
	
	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
				 initWithFrame:CGRectZero reuseIdentifier:RootViewControllerCell] autorelease];
	}
	
	// Configure the cell
	NSUInteger row = [indexPath row];
	UIViewController *controller = [controllers objectAtIndex:row];
	
	cell.text = controller.title;
	// cell.image = controller.rowImage;
	
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (UITableViewCellAccessoryType) tableView:(UITableView*)tableView
		  accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath {
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void) tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	NSUInteger row = [indexPath row];

	if (row == kPrototypeOne) {
		
		PrototypeOneController *nextController = 
			[self.controllers objectAtIndex:row];
		
		BNFlashCardPrototypeAppDelegate *delegate = 
	        (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
		
		[delegate.navController pushViewController:nextController animated:YES];	
	}
	else if (row == kPrototypeTwo) {
		
		PrototypeTwoController *nextController = 
			[self.controllers objectAtIndex:row];
		
		BNFlashCardPrototypeAppDelegate *delegate = 
			(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
		
		[delegate.navController pushViewController:nextController animated:YES];	
	}
	/*
	else {
		
		SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
		
		BiblioPhileAppDelegate *delegate = 
		(BiblioPhileAppDelegate*) [[UIApplication sharedApplication] delegate];
		
		[delegate.navController pushViewController:nextController animated:YES];
	}
	*/	
}

@end