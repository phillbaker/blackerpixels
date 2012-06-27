//
//  blackerpixelsView.h
//  blackerpixels
//
//  Created by phill on 5/2/12.
//  Copyright (c) 2012 Phillip Baker. All rights reserved.
// 
//  Released under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//

#import <IOKit/IOKitLib.h>
#import <ScreenSaver/ScreenSaver.h>
#import <IOKit/graphics/IOGraphicsLib.h>
#import <ApplicationServices/ApplicationServices.h>

@interface blackerpixelsView : ScreenSaverView {
    //float origBrightness;
    NSMutableArray *origBrightness;
}

- (int) dimDisplayNow;
- (int) storeBrightness;
- (int) setDisplaysBrightness:(NSMutableArray*)array;

@end
