//
//  PathUtilities.m
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "PathUtilities.h"

#import "Constants.h"

NSString *GetApplicationSupportDirectory()
{
	NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	
	if (![urls count]) {
		[NSException raise:@"Directory Error" format:@"Surprisingly, there was no Application Support directory."];
		return nil;
	}
	
	return [[urls objectAtIndex:0] path];
}

NSString *GetPixenSupportDirectory()
{
	return [GetApplicationSupportDirectory() stringByAppendingPathComponent:@"Pixen"];
}

NSString *GetPixenPaletteDirectory()
{
	return [GetPixenSupportDirectory() stringByAppendingPathComponent:@"Palettes"];
}

NSString *GetPixenBackgroundsDirectory()
{
	return [GetPixenSupportDirectory() stringByAppendingPathComponent:@"Backgrounds"];
}

NSString *GetBackgroundPresetsDirectory()
{
	return [GetPixenBackgroundsDirectory() stringByAppendingPathComponent:@"Presets"];
}

NSString *GetBackgroundImagesDirectory()
{
	return [GetPixenBackgroundsDirectory() stringByAppendingPathComponent:@"Images"];
}

NSString *GetPathForBackgroundNamed(NSString *name)
{
	return [GetBackgroundPresetsDirectory() stringByAppendingPathComponent:[name stringByAppendingPathExtension:PXBackgroundSuffix]];
}

NSString *GetPixenPatternFile()
{
	return [GetPixenSupportDirectory() stringByAppendingPathComponent:@"Patterns.pxpatternarchive"];
}

NSString *GetDescriptionForDocumentType(NSString *uti)
{
	CFStringRef cfUTI = (__bridge CFStringRef) uti;
	
	if (UTTypeEqual(cfUTI, CFSTR("com.Pixen.pxim"))) {
		return NSLocalizedString(@"Pixen image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.Pixen.pxan"))) {
		return NSLocalizedString(@"Pixen animation", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.opensword.pxim"))) {
		return NSLocalizedString(@"Pixen image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.opensword.pxan"))) {
		return NSLocalizedString(@"Pixen animation", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.compuserve.gif"))) {
		return NSLocalizedString(@"GIF image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("public.jpeg"))) {
		return NSLocalizedString(@"JPEG image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("public.png"))) {
		return NSLocalizedString(@"PNG image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("public.tiff"))) {
		return NSLocalizedString(@"TIFF image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.microsoft.bmp"))) {
		return NSLocalizedString(@"BMP image", nil);
	}
	else if (UTTypeEqual(cfUTI, CFSTR("com.microsoft.ico"))) {
		return NSLocalizedString(@"ICO image", nil);
	}
	
	@throw [NSException exceptionWithName:NSGenericException
								   reason:[NSString stringWithFormat:@"Invalid type (%@)", uti]
								 userInfo:nil];
	
	return nil;
}
