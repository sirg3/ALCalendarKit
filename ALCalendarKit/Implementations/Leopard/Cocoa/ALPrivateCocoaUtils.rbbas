#tag Module
Protected Module ALPrivateCocoaUtils
	#tag Method, Flags = &h1
		Protected Function ArrayToNSArray(arr() as ALPrivateObjCObject) As ALPrivateObjCObject
		  declare function NSArray_arrayWithObjects lib kObjCLib selector "arrayWithObjects:count:" ( handle as integer, objects as ptr, count as integer ) as integer
		  
		  dim m as new MemoryBlock( ( arr.ubound + 1 ) * 4 )
		  m.littleEndian = targetLittleEndian
		  
		  for i as integer = 0 to arr.ubound
		    m.int32Value( i * 4 ) = arr( i ).handle
		  next
		  
		  return NSArray_arrayWithObjects( ALPrivateObjCObject.getClass( "NSArray" ), m, arr.ubound + 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ColorToNSColor(value as color) As ALPrivateObjCObject
		  declare function NSColor_colorWithDeviceRedGreenBlue lib kObjCLib selector "colorWithDeviceRed:green:blue:alpha:" ( handle as integer, _
		  red as double, green as double, blue as double, alpha as double ) as integer
		  
		  return NSColor_colorWithDeviceRedGreenBlue( ALPrivateObjCObject.getClass( "NSColor" ), value.red, value.green, value.blue, 1 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DateToNSDate(d as Date) As ALPrivateObjCObject
		  declare function NSDate_dateWithTimeIntervalSinceReferenceDate lib kObjCLib selector "dateWithTimeIntervalSinceReferenceDate:" ( handle as integer, seconds as double ) as integer
		  declare function CFCalendarCopyCurrent lib "CoreFoundation" () as ptr
		  declare function CFCalendarComposeAbsoluteTime lib "CoreFoundation" ( cal as ptr, byref val as double, format as CString, _
		  year as integer, month as integer, day as integer, hour as integer, minute as integer, second as integer ) as boolean
		  declare sub CFRelease lib "CoreFoundation" ( p as ptr )
		  
		  dim calendar as ptr = CFCalendarCopyCurrent()
		  dim val as double
		  dim success as boolean = CFCalendarComposeAbsoluteTime( calendar, val, "yMdHms", d.year, d.month, d.day, d.hour, d.minute, d.second )
		  CFRelease( calendar )
		  
		  return NSDate_dateWithTimeIntervalSinceReferenceDate( ALPrivateObjCObject.getClass( "NSDate" ), val )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  'declare sub NSSetUncaughtExceptionHandler lib kCocoaLib ( handler as ptr )
		  '
		  'NSSetUncaughtExceptionHandler( addressOf ExceptionHandler )
		  
		  setupThreadSafety()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSArrayToArray(arr as ALPrivateObjCObject) As ALPrivateObjCObject()
		  declare function NSArray_count lib kObjCLib selector "count" ( handle as integer ) as integer
		  declare function NSArray_objectAtIndex lib kObjCLib selector "objectAtIndex:" ( handle as integer, index as integer ) as integer
		  
		  dim count as integer = NSArray_count( arr )
		  dim results() as ALPrivateObjCObject
		  
		  for i as integer = 0 to count - 1
		    results.append( NSArray_objectAtIndex( arr, i ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSColorToColor(obj as ALPrivateObjCObject) As color
		  declare function NSColor_redComponent lib kObjCLib selector "redComponent" ( handle as integer ) as double
		  declare function NSColor_greenComponent lib kObjCLib selector "greenComponent" ( handle as integer ) as double
		  declare function NSColor_blueComponent lib kObjCLib selector "blueComponent" ( handle as integer ) as double
		  
		  return rgb( NSColor_redComponent( obj ) * 255, NSColor_greenComponent( obj ) * 255, NSColor_blueComponent( obj ) * 255 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSDateToDate(obj as ALPrivateObjCObject) As Date
		  declare function NSDate_timeIntervalSinceReferenceDate lib kObjCLib selector "timeIntervalSinceReferenceDate" ( handle as integer ) as double
		  
		  // total seconds from 1904 (RB's epoch) to 2001 (Cocoa's epoch)
		  const kEpochDifference = 3061152000.0
		  
		  if obj = nil then return nil
		  
		  dim secondsSince2001 as double = NSDate_timeIntervalSinceReferenceDate( obj )
		  dim secondsSince1904 as double = secondsSince2001 + kEpochDifference
		  
		  dim result as new Date()
		  result.gmtOffset = 0
		  result.totalSeconds = secondsSince1904
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSStringToString(obj as ALPrivateObjCObject) As string
		  return obj.description
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSURLToString(obj as ALPrivateObjCObject) As string
		  declare function NSURL_absoluteString lib kObjCLib selector "absoluteString" ( handle as integer ) as integer
		  
		  return  NSStringToString( NSURL_absoluteString( obj ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupThreadSafety()
		  //! Sets up Cocoa to be "thread safe".
		  //! Basically to do this we have to create a new NSThread that just exits... See the NSThread documentation for details.
		  declare sub NSThread_detachNewThreadSelector lib kCocoaLib selector "detachNewThreadSelector:toTarget:withObject:" ( handle as integer, sel as integer, target as integer, obj as integer )
		  declare function sel_registerName lib kObjCLib ( sel as CString ) as integer
		  dim pool as new ALPrivateAutoreleasePool()
		  
		  NSThread_detachNewThreadSelector( ALPrivateObjCObject.getClass( "NSThread" ), sel_registerName( "self" ), ALPrivateObjCObject.getClass( "NSObject" ), 0 )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StringToNSURL(value as string) As ALPrivateObjCObject
		  declare function NSURL_URLWithString lib kObjCLib selector "URLWithString:" ( handle as integer, str as CFStringRef ) as integer
		  
		  return NSURL_URLWithString( ALPrivateObjCObject.getClass( "NSURL" ), value )
		End Function
	#tag EndMethod


	#tag Constant, Name = kCocoaLib, Type = String, Dynamic = False, Default = \"Cocoa", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kObjCLib, Type = String, Dynamic = False, Default = \"Cocoa", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
