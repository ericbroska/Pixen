//
//  Constants.m
//  Pixen
//
//  Copyright 2005-2012 Pixen Project. All rights reserved.
//

#import "Constants.h"

NSString *PXLayerRowPboardType = @"PXLayerRowPasteType";
NSString *PXLayerPboardType = @"PXLayer";
NSString *PXCelPboardType = @"PXCel";
NSString *PXNSImagePboardType = @"NSImage";
NSString *PXBackgroundTemplatePboardType = @"PXBackgroundTemplatePasteType";
NSString *PXBackgroundNewTemplatePboardType = @"PXBackgroundNewTemplateNamePasteType";
NSString *PXBackgroundNamePboardType = @"PXBackgroundNamePasteType";
NSString *PXBackgroundTypePboardType = @"PXBackgroundTypePasteType";
NSString *PXBackgroundNoDeletePboardType = @"PXBackgroundNoDeletePasteType";
NSString *PXPatternPboardType = @"PXPatternPboardType";
NSString *PXSelectionOriginPboardType = @"PXSelectionOriginPboardType";

//these get localized in PXBackground.m's +initialize.
NSString *PXMainBackgroundType = @"Main Background";
NSString *PXAlternateBackgroundType = @"Alternate Background";

NSString *PXCanvasDocumentToolbarIdentifier = @"PXDocumentToolbar";

NSString *PXChangedRectKey = @"changedRect";

NSString *PXNewToolKey = @"newTool";

NSString *PXBackgroundPathKey = @"PXBackgroundPath";
NSString *PXPoofLocationKey = @"PXPoofLocation";

NSString *PXInfinityDescription = @"inf";
NSString *PXNanDescription = @"nan";

NSString *PXLastSavedFileType = @"PXLastSavedFileType";
NSString *PXLastSavedAnimationFileType = @"PXLastSavedAnimationFileType";

NSString *PixenImageFileType = @"com.Pixen.pxim";
NSString *PixenImageFileTypeOld = @"com.opensword.pxim";
NSString *PixenAnimationFileType = @"com.Pixen.pxan";
NSString *PixenAnimationFileTypeOld = @"com.opensword.pxan";

//these get localized in PXPaletteExporter.m's -types.
NSString *PixenPaletteType = @"Pixen Palette Format (.pxpalette)";
NSString *MicrosoftPaletteType = @"Microsoft RAW Palette Format (.pal)";
NSString *JascPaletteType = @"Jasc Paint Shop Pro Palette Format (.pal)";
NSString *AdobePaletteType = @"Adobe Color Table (.act)";
NSString *GimpPaletteType = @"Gimp Palette Format (.gpl)";

NSString *CFBundleShortVersionKey = @"CFBundleShortVersionString";
NSString *CFBundleNameKey = @"CFBundleName";
NSString *CFBundleDocumentTypesKey = @"CFBundleDocumentTypes";
NSString *CFBundleTypeExtensionsKey = @"CFBundleTypeExtensions";
NSString *CFBundleVersionKey = @"CFBundleVersion";

NSString *PXBackgroundSuffix = @"pxbgnd";
NSString *PXISuffix = @"pxi";
NSString *PXASuffix = @"pxa";
NSString *PXPatternSuffix = @"pxpattern";
NSString *PXPaletteSuffix = @"pxpalette";
NSString *MicrosoftPaletteSuffix = @"pal";
NSString *AdobePaletteSuffix = @"act";
NSString *GimpPaletteSuffix = @"gpl";

NSString *PXActiveLayerKey = @"activeLayer";

NSString *PXMergeLayersKey = @"PXMergeLayers";

NSString *PXLayerImageKey = @"PXLayerImage";
NSString *PXLayerOpacityKey = @"PXLayerOpacity";
NSString *PXLayerNameKey = @"PXLayerName";

NSString *PXLayerKey = @"layer";
NSString *PXLayerIndexKey = @"layerIndex";

NSString *PXSourceIndexKey = @"sourceIndex";
NSString *PXTargetIndexKey = @"targetIndex";

NSString *PXPalettePanelFrameKey = @"PXPalettePanelFrame";
NSString *PXPalettePanelPaletteViewSizeKey = @"PXPalettePanelPaletteViewSize";
NSString *PXPalettePanelIsSystemPaletteKey = @"PXPalettePanelIsSystemPalette";
NSString *PXPalettePanelPaletteIndexKey = @"PXPalettePanelPaletteIndex";
