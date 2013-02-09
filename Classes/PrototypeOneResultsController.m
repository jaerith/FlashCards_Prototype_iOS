//
//  PrototypeOneResultsController.m
//  BNFCPrototype
//
//  Created by mac on 3/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeOneResultsController.h"

@implementation PrototypeOneResultsController

@synthesize parentController;

@synthesize results;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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
	
	[self retrieveData];
	
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
	
	[results release];
	
    [super dealloc];
}

- (void) retrieveData {

	/*
	NSMutableArray *resultsData = 
	    [self.parentController getResultsData];

	[self.results removeAllObjects];
	[self.results addObjectsFromArray:resultsData];
	*/
	
	self.results = [self.parentController getResultsData];
}

- (void) setParent:(PrototypeOneController*)tmpParentController {
	
	self.parentController = tmpParentController;
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger) tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
	
	return [results count];
}

- (UITableViewCell*) tableView:(UITableView*)tableView
		 cellForRowAtIndexPath:(NSIndexPath*)indexPath{
	
	static NSString* PORCellIdentifier = @"PORCellIdentifier";
	
	UITableViewCell *cell = 
	    [tableView dequeueReusableCellWithIdentifier:PORCellIdentifier];
	
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
									   reuseIdentifier:PORCellIdentifier] autorelease];
	}
	else {
		UILabel *topLabel = [cell.contentView.subviews objectAtIndex:0];
		UILabel *middleLabel = [cell.contentView.subviews objectAtIndex:1];
		UILabel *bottomLabel = [cell.contentView.subviews objectAtIndex:2];
		
		[topLabel removeFromSuperview];
		[middleLabel removeFromSuperview];
		[bottomLabel removeFromSuperview];
	}
	
	NSUInteger row = [indexPath row];
	NSString *rowString = [results objectAtIndex:row];

	NSArray *rowData = [rowString componentsSeparatedByString:@"|"];
	
	NSString* deckField = [rowData objectAtIndex:0];
	NSString* timesField = [rowData objectAtIndex:1];
	NSString* statsField = [rowData objectAtIndex:2];
	
	CGRect deckRect = CGRectMake(5.0, 0.0, 240, 25);
	UILabel *deckView = [[UILabel alloc] initWithFrame:deckRect];
	deckView.text = deckField;
	deckView.numberOfLines = 2;
	// deckView.textColor = [UIColor greenColor];
	//deckView.textColor = [UIColor colorWithRed:50.0 green:255.0 blue:100.0 alpha:1.0];
	deckView.textColor = [UIColor blackColor];
	deckView.font = [UIFont boldSystemFontOfSize:12];
	[cell.contentView addSubview:deckView];
	
	CGRect timesRect = CGRectMake(5.0, 26.0, 240, 25);
	UILabel *timesView = [[UILabel alloc] initWithFrame:timesRect];
	timesView.text = timesField;
	timesView.numberOfLines = 1;
	timesView.textColor = [UIColor darkGrayColor];
	timesView.font = [UIFont boldSystemFontOfSize:12];
	[cell.contentView addSubview:timesView];
	
	CGRect statsRect = CGRectMake(5.0, 51.0, 240, 25);
	UILabel *statsView = [[UILabel alloc] initWithFrame:statsRect];
	statsView.text = statsField;
	statsView.numberOfLines = 1;
	statsView.textColor = [UIColor orangeColor];
	statsView.font = [UIFont boldSystemFontOfSize:12];
	[cell.contentView addSubview:statsView];	
	
	// [bookView release];
	// [songView release];
	
	return cell;
}

/*
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
 
 return 1;
 }
 
 - (NSArray*) sectionIndexTitlesForTableView:(UITableView*)tableView {
 
 return keys;
 }
 */

#pragma mark -
#pragma mark Table Delegate Methods
- (CGFloat) tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath {
	
	return 75;	 
}

- (UITableViewCellAccessoryType) tableView:(UITableView*)tableView
		  accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath{
	
	// return UITableViewCellAccessoryDetailDisclosureButton;
	return UITableViewCellAccessoryNone;
}

- (void) tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	
	/*
	 
	 NSUInteger row = [indexPath row];
	 NSString* selected = [list objectAtIndex:row];
	 
	 BiblioPhileAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	 
	 if (row == kByBook) {
	 siblByBookController.title = selected;
	 [delegate.navController pushViewController:siblByBookController animated:YES];
	 }
	 else {
	 siblByPerformerController.title = selected;
	 [delegate.navController pushViewController:siblByPerformerController animated:YES];
	 }
	 */
}

@end
