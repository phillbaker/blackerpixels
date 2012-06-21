//
//  blackerpixelsView.h
//  blackerpixels
//
//  Created by phill on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <IOKit/IOKitLib.h>
#import <ScreenSaver/ScreenSaver.h>
#import <IOKit/graphics/IOGraphicsLib.h>
#import <ApplicationServices/ApplicationServices.h>

@interface blackerpixelsView : ScreenSaverView

- (int) dimDisplayNow;
- (int) turnOffDisplayNow;

@end
