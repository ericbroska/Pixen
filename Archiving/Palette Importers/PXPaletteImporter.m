//
//  PXPaletteImporter.m
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PXPaletteImporter.h"

#import "GPLReader.h"
#import "OSPALReader.h"
#import "OSJASCPALReader.h"
#import "OSACTReader.h"
#import "PathUtilities.h"
#import "PXPalette.h"

@implementation PXPaletteImporter

- (void)importPaletteAtPath:(NSString *)path
{
	id reader = nil;
	
	if ([[path pathExtension] isEqualToString:MicrosoftPaletteSuffix])
	{
		NSData *data = [NSData dataWithContentsOfFile:path];
		
		if (!data)
		{
			[NSException raise:@"OSFileError" format:@"Couldn't open %@ for reading", path];
			return;
		}
		
		// We have to determine now if it's a JASC palette or a Microsoft palette. JASC palettes start with "JASC-PAL", so we check against that.
		const unsigned char *bytes = [data bytes];
		
		if (bytes[0] == 'J' && bytes[1] == 'A' && bytes[2] == 'S' && bytes[3] == 'C' && bytes[4] == '-' && bytes[5] == 'P' && bytes[6] == 'A' && bytes[7] == 'L')
			reader = [OSJASCPALReader sharedJASCPALReader];
		else
			reader = [OSPALReader sharedPALReader];
	}
	else if ([[path pathExtension] isEqualToString:AdobePaletteSuffix])
	{
		reader = [OSACTReader sharedACTReader];
	}
	else if ([[path pathExtension] isEqualToString:GimpPaletteSuffix])
	{
		reader = [GPLReader sharedGPLReader];
	}
	
	NSString *name = [[path lastPathComponent] stringByDeletingPathExtension];
	NSString *base = [NSString stringWithString:name];
	int i = 2;
	
	NSArray *systemPalettes = [PXPalette systemPalettes];
	NSMutableArray *names = [NSMutableArray array];
	
	for (PXPalette *palette in systemPalettes)
	{
		[names addObject:palette.name];
	}
	
	// First make the name not conflict with system palettes
	while ([names containsObject:name])
	{
		name = [base stringByAppendingFormat:@" %d", i];
		i++;
	}
	
	// Then user palettes.
	while ([[NSFileManager defaultManager] fileExistsAtPath:[[GetPixenPaletteDirectory() stringByAppendingPathComponent:name] stringByAppendingPathExtension:PXPaletteSuffix]])
	{
		name = [base stringByAppendingFormat:@" %d", i];
		i++;
	}
	
	NSString *finalPath = [[GetPixenPaletteDirectory() stringByAppendingPathComponent:name] stringByAppendingPathExtension:PXPaletteSuffix];
	PXPalette *newPal = nil;
	
	if (reader) // If we've got a reader, we've got to import the format first.
	{
		newPal = [reader paletteWithData:[NSData dataWithContentsOfFile:path]];
	}
	else // It must be a pxpalette.
	{
		newPal = [[PXPalette alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
	}
	
	newPal.name = name;
	newPal.isSystemPalette = NO;
	newPal.canSave = YES;
	
	[NSKeyedArchiver archiveRootObject:[newPal dictForArchiving] toFile:finalPath];
}

- (void)panelDidEndWithReturnCode:(NSInteger)code modalSheet:(BOOL)modalSheet
{
	if (code == NSFileHandlingPanelCancelButton) {
		if (modalSheet) [NSApp stopModal];
		return;
	}
	
	for (NSURL *current in [_openPanel URLs]) {
		[self importPaletteAtPath:[current path]];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PXUserPalettesChangedNotificationName
														object:self];
	
	if (modalSheet) [NSApp stopModal];
	else {
		NSString *message = [NSString stringWithFormat:NSLocalizedString(@"%ld palette(s) were imported.", @"Palettes were imported alert message"), [[_openPanel URLs] count]];
		NSRunAlertPanel(NSLocalizedString(@"Success", @"Palettes Were Imported Alert Title"),
                        message,
                        @"OK", nil, nil);
	}
}

- (void)runInWindow:(NSWindow *)window
{
	_openPanel = [NSOpenPanel openPanel];
	[_openPanel setAllowsMultipleSelection:YES];
	[_openPanel setCanChooseDirectories:NO];
	[_openPanel setPrompt:NSLocalizedString(@"Install", @"Install")];
	[_openPanel setTitle:NSLocalizedString(@"Install", @"Install")];
	[_openPanel setAllowedFileTypes:[NSArray arrayWithObjects:PXPaletteSuffix, MicrosoftPaletteSuffix, AdobePaletteSuffix, GimpPaletteSuffix, nil]];
	
	if (window) {
		[_openPanel beginSheetModalForWindow:window
						   completionHandler:^(NSInteger result) {
							   [self panelDidEndWithReturnCode:result modalSheet:YES];
						   }];
		
		[NSApp runModalForWindow:_openPanel];
	}
	else {
		NSInteger result = [_openPanel runModal];
		[self panelDidEndWithReturnCode:result modalSheet:NO];
	}
}

@end
