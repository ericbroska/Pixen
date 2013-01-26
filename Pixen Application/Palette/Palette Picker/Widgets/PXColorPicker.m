//
//  PXColorPicker.m
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PXColorPicker.h"

#import "PXPaletteView.h"
#import "PXPaletteViewController.h"

int kPXColorPickerMode = 23421337;

@implementation PXColorPicker

// NSColorPicker overrides
- (void)alphaControlAddedOrRemoved:(id)sender {}
- (void)attachColorList:(NSColorList *)colorList {}
- (void)detachColorList:(NSColorList *)colorList {}
- (void)setColor:(NSColor *)aColor {}
- (void)setMode:(NSColorPanelMode)mode {}

- (NSImage *)provideNewButtonImage
{
	return _icon;
}

- (BOOL)supportsMode:(NSColorPanelMode)mode
{
	return kPXColorPickerMode == mode;
}

- (NSColorPanelMode)currentMode
{
	return kPXColorPickerMode;
}

- (void)viewSizeChanged:(id)sender
{
	[_vc.view setFrameOrigin:NSZeroPoint];
}

- (NSString *)buttonToolTip
{
	return NSLocalizedString(@"Pixen Colors", @"Color Picker Button Tooltip");
}

- (void)insertNewButtonImage:(NSImage *)newButtonImage in:(NSButtonCell *)buttonCell
{
	[buttonCell setImage:newButtonImage];
}

- (NSView *)provideNewView:(BOOL)initialRequest
{
	[_vc reloadData];
	
	return _vc.view;
}

- (id)initWithPickerMask:(NSUInteger)mask colorPanel:(NSColorPanel *)owningColorPanel
{
	if (!(mask & NSColorPanelRGBModeMask))
		return nil; // We only support RGB mode.
	
	self = [super initWithPickerMask:mask colorPanel:owningColorPanel];
	
	_icon = [NSImage imageNamed:@"colorpalette"];
	
	_vc = [[PXPaletteViewController alloc] init];
	[_vc loadView];
	[_vc paletteView].delegate = self;
	
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	
	if ([defs objectForKey:PXColorPickerPaletteViewSizeKey] == nil)
		[defs setInteger:NSRegularControlSize forKey:PXColorPickerPaletteViewSizeKey];

	[_vc setColorControlSize:[defs integerForKey:PXColorPickerPaletteViewSizeKey]];
	
	return self;
}

- (void)useColorAtIndex:(NSUInteger)index
{
	PXPalette *palette = [_vc.paletteView palette];
	[[self colorPanel] setShowsAlpha:YES];
	[[self colorPanel] setColor:PXColorToNSColor([palette colorAtIndex:index])];
}

- (void)paletteView:(PXPaletteView *)pv modifyColorAtIndex:(NSUInteger)index
{
	[_vc showColorModificationInfo];
}

@end
