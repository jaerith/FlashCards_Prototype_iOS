//
//  PrototypeTwoDeckChoiceController.m
//  BNFCPrototype
//
//  Created by mac on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeTwoController.h"
#import "PrototypeTwoDeckChoiceController.h"
#import "PrototypeTwoCardsController.h"
#import "PrototypeTwoQuestionController.h"
#import "PrototypeTwoOptionsController.h"

@implementation PrototypeTwoDeckChoiceController

@synthesize parentController;
@synthesize currentCategory;
@synthesize currentDeckNames;
@synthesize	chosenDeck;

 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	 
	 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		 // Custom initialization
	 }
	 
	 parentController = nil;
	 currentCategory  = nil;
	 currentDeckNames = nil;
	 
	 return self;
 }

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.title = @"Decks";
	
	NSMutableArray      *array     = [[NSMutableArray alloc] init];
	NSMutableDictionary *deckNames = nil;
	
	if (parentController != nil) {
		
		deckNames = [parentController retrieveCategoryDeckNames];
		
		if (self.currentDeckNames == nil) {
			self.currentDeckNames = [[NSMutableDictionary alloc] init];
		}
		
		[self.currentDeckNames removeAllObjects];
		
		NSArray *unsortedSelection = [deckNames allKeys];	
		NSArray *selection         = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

		for (id key in selection) {
			
			NSString *tmpDeckName = key;
			NSString *tmpDeckType = [deckNames valueForKey:tmpDeckName];
			
			[self.currentDeckNames setValue:tmpDeckType forKey:tmpDeckName];
		}		
		
		// [self.currentDeckNames setDictionary:deckNames];

		/*
		NSArray *unsortedSelection = [self.deckTypes allKeys];
		NSArray *selection         = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		for (id tmpDN in selection) {
			
			NSString *tmpDeckName = tmpDN;
			NSString *tmpDeckType = [selection valueForKey:tmpDN];
			

			NSString* deckEntry = 
		// [NSString stringWithFormat:@"%@ (%@)", name, type];
		[NSString stringWithFormat:@"%@", name];
		
		cell.text = deckListEntry;
		*/
	}

	// Navigate to results button
	UIBarButtonItem *optionsButton = 
		[[UIBarButtonItem alloc] initWithTitle:@"Options"
								 style:UIBarButtonItemStyleBordered 
								 target:self 
								 action:@selector(showOptions)];
	
	self.navigationItem.rightBarButtonItem = optionsButton;

	[optionsButton release];

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
	// [controllers release];
    [super dealloc];
}

- (void) assignCurrentCategory:(NSMutableString*) targetCategory {
	
	currentCategory = targetCategory;
}

- (void) showOptions {
	
	BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	PrototypeTwoOptionsController *optionsController = 
		[[PrototypeTwoOptionsController alloc] init];
	
	[optionsController setParent:self.parentController];
	
	optionsController.title = @"Configuration Options";
	
	[delegate.navController pushViewController:optionsController animated:YES];		
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger) tableView:(UITableView*)tableView
  numberOfRowsInSection:(NSInteger)section {
	
	return [self.currentDeckNames count];	
}

- (UITableViewCell*) tableView:(UITableView*)tableView
		 cellForRowAtIndexPath:(NSIndexPath*)indexPath{
	
	static NSString *PrototypeTwoDeckChoiceControllerCell = @"PrototypeTwoDeckChoiceControllerCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PrototypeTwoDeckChoiceControllerCell];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
				 initWithFrame:CGRectZero reuseIdentifier:PrototypeTwoDeckChoiceControllerCell] autorelease];
	}
	
	NSArray *unsortedSelection = [self.currentDeckNames allKeys];	
	NSArray *selection         = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	// Configure the cell
	NSUInteger row          = [indexPath row];
	NSString   *tmpDeckName = [selection objectAtIndex:row];
	
	cell.text = 
		[NSString stringWithFormat:@"%@ (%@)", tmpDeckName, [self.currentDeckNames valueForKey:tmpDeckName]];
	
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

	PrototypeTwoCardsController *cardsController =
		[[PrototypeTwoCardsController alloc] init];

	BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	/*
	NSArray *unsortedSelection = [parentController.deckTypes allKeys];	
	NSArray *selection         = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSString *name  = [selection objectAtIndex:row];
	
	self.currentCategory = [[NSMutableString alloc] initWithString:name];
	*/
		
	cardsController.parentController = self.parentController;
	
	self.parentController.cardsController = cardsController;
	
	if ([self.currentCategory isEqualToString:@"Shakespeare"]) {
		if (row == 0) {
			self.chosenDeck = 
				[[NSMutableString alloc] initWithString:@"Shakespeare"];
		}
		else{
			NSString *tmpChosenDeck =
				[NSString stringWithFormat:@"Shakespeare%d", (row+1)];
			
			self.chosenDeck = 
				[[NSMutableString alloc] initWithString:tmpChosenDeck];			
		}
	}
	else {
		self.chosenDeck = 
			[[NSMutableString alloc] initWithString:self.currentCategory];		
	}
	
	[self.parentController setCurrentDeck:self.chosenDeck];
	
	[delegate.navController pushViewController:cardsController animated:YES];	
	
	/*
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
	*/
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
