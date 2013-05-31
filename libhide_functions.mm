#include <dlfcn.h>
#include <Foundation/Foundation.h>

//*All functions taken from the original libhide sample included with libhide by BigBoss. (The original name of this file is hide-sample.c)*/
//SOME MODIFICATIONS HAVE BEEN MADE.

//This file doesn't work "out-of-the-box". The return type of all dlsym calls needs to be casted to the function pointer signature. If this is not done,
//it won't compile due to invalid conversion errors.

//------------------------------------------------------------------------------

// PlistPath is the full path to the app's Info.plist file for example:
// /Applications/MobileSafari.app/Info.plist
//
// There are exceptions allowed for camera and photos. You should use these:
// /Applications/Camera.app/Info.plist
// /Applications/Photos.app/Info.plist
//
//*************************************************************************************************
// IsIconHidden - Determines if the icon passed in is already hidden or not. 
//                PlistPath is the full path to the Info.plist for the app.
//*************************************************************************************************
BOOL IsIconHidden(NSString* PlistPath)
{
	BOOL Hidden = NO;
		
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	if(libHandle != NULL) 
	{
		BOOL (*IsIconHidden)(NSString* Plist) = (BOOL (*)(NSString*))dlsym(libHandle, "IsIconHidden");
		if(IsIconHidden != NULL)
		{
			Hidden = IsIconHidden(PlistPath);
		}
		dlclose(libHandle);
	}
	
	return Hidden;
}

//*************************************************************************************************
// IsIconHidden - Determines if the icon passed in is already hidden or not via the display identifier 
//                BundleId is the bundle identifier out of the Info.plist for the app.
//*************************************************************************************************
BOOL IsIconHiddenDisplay(NSString* BundleId)
{
	BOOL Hidden = NO;
		
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	if(libHandle != NULL) 
	{
		BOOL (*IsIconHiddenDisplayId)(NSString* Plist) = (BOOL (*)(NSString *))dlsym(libHandle, "IsIconHiddenDisplayId");
		if(IsIconHiddenDisplayId != NULL)
		{
			Hidden = IsIconHiddenDisplayId(BundleId);
		}
		dlclose(libHandle);
	}
	
	return Hidden;
}

//*************************************************************************************************
// HideIcon - Hides the icon at the path passed in.
//            PlistPath is the full path to the Info.plist for the app.
//*************************************************************************************************
BOOL HideIcon(NSString* PlistPath)
{
	NSLog(@"Hiding %@\n", PlistPath);
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	BOOL DeletedSomething = NO;
	
	if(libHandle != NULL) 
	{
		BOOL (*LibHideIcon)(NSString* Plist) = (BOOL (*)(NSString *))dlsym(libHandle, "HideIcon");
		if(LibHideIcon != NULL)
		{
			// PlistPath is the full path to the plist like "/Applications/BossPrefs.app/Info.plist"
			DeletedSomething = LibHideIcon(PlistPath);
		}
		dlclose(libHandle);
	}
	
	return DeletedSomething;
}

//*************************************************************************************************
// HideIconViaDisplayId - Hides the icon using the bundle ID passed in.
//                        BundleId is the bundle identifier out of the Info.plist for the app.
//*************************************************************************************************
BOOL HideIconViaDisplayId(NSString* BundleId)
{
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	BOOL DeletedSomething = NO;
	
	if(libHandle != NULL) 
	{
		BOOL (*LibHideIcon)(NSString* Plist) = (BOOL (*)(NSString *))dlsym(libHandle, "HideIconViaDisplayId");
		if(LibHideIcon != NULL)
		{
			DeletedSomething = LibHideIcon(BundleId);
		}
		dlclose(libHandle);
	}
	
	return DeletedSomething;
}

//*************************************************************************************************
// UnHideIcon - Removes a hidden icon from the plist. Returns TRUE  if something was done, FALSE ir not.
//              PlistPath is the full path to the Info.plist for the app.
//*************************************************************************************************
BOOL UnHideIcon(NSString* Path)
{
	BOOL SomethingDone = NO;
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	if(libHandle != NULL) 
	{
		BOOL (* LibUnHideIcon)(NSString* Plist) = (BOOL (*)(NSString *))dlsym(libHandle, "UnHideIcon");
		if(LibUnHideIcon != NULL)
		{
			SomethingDone = LibUnHideIcon(Path);
		}
		dlclose(libHandle);
	}
	
	return SomethingDone;
}

//*************************************************************************************************
// UnHideIconViaDisplayId - Removes a hidden icon from the plist. Returns TRUE  if something was done, FALSE ir not.
//                          BundleId is the bundle identifier out of the Info.plist for the app.
//*************************************************************************************************
BOOL UnHideIconViaDisplayId(NSString* BundleId)
{
	BOOL SomethingDone = NO;
	void* libHandle = dlopen("/usr/lib/hide.dylib", RTLD_LAZY);
	
	if(libHandle != NULL) 
	{
		BOOL (* LibUnHideIcon)(NSString* BundleId) = (BOOL (*)(NSString *))dlsym(libHandle, "UnHideIconViaDisplayId");
		if(LibUnHideIcon != NULL)
		{
			SomethingDone = LibUnHideIcon(BundleId);
		}
		dlclose(libHandle);
	}
	
	return SomethingDone;
}

//*************************************************************************************************
// Cause changes to take effect without respring (v2.0.6 or newer only)
// just issue notify_post (may need to #include <notify.h>
// notify_post("com.libhide.hiddeniconschanged);
//*************************************************************************************************

