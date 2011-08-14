#tag Class
Protected Class ALLeopardCalendarStore
Inherits ALCalendarStore
	#tag Method, Flags = &h0
		Function Calendars() As ALCalendar()
		  declare function CalCalendarStore_calendars lib kObjCLib selector "calendars" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim results() as ALLeopardCalendar
		  
		  for each obj as ALPrivateObjCObject in ALPrivateCocoaUtils.NSArrayToArray( CalCalendarStore_calendars( handle ) )
		    results.append( ALLeopardCalendar._createCalendar( obj, self ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalendarWithUID(uid as string) As ALCalendar
		  declare function CalCalendarStore_calendarWithUID lib kObjCLib selector "calendarWithUID:" ( handle as integer, uid as CFStringRef ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim obj as ALPrivateObjCObject = CalCalendarStore_calendarWithUID( handle, uid )
		  return ALLeopardCalendar._createCalendar( obj, self )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // On Leopard there is only one calendar store. Use the DefaultStore function to get it.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateCalendar() As ALCalendar
		  declare function CalCalendar_calendar lib kObjCLib selector "calendar" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  dim obj as ALPrivateObjCObject = CalCalendar_calendar( ALPrivateObjCObject.getClass( "CalCalendar" ) )
		  return ALLeopardCalendar._createCalendar( obj, self )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DefaultStore() As ALLeopardCalendarStore
		  declare function CalCalendarStore_defaultCalendarStore lib kObjCLib selector "defaultCalendarStore" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  static defaultStore as ALLeopardCalendarStore
		  
		  if defaultStore = nil then
		    defaultStore = new ALLeopardCalendarStore()
		    defaultStore.mHandle = CalCalendarStore_defaultCalendarStore( ALPrivateObjCObject.getClass( "CalCalendarStore" ) )
		  end if
		  
		  return defaultStore
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date) As ALCalendarEvent()
		  dim cals() as ALLeopardCalendar
		  return events( startDate, endDate, cals )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date, calendars() as ALLeopardCalendar) As ALLeopardCalendarEvent()
		  //! Gets a list of all events occuring in `calendars` between `startDate` and `endDate`.
		  //! If there are no calendars in the array, all calendars are searched.
		  
		  declare function NSPredicate_eventPredicateWithStartDateEndDateCalendars lib kObjCLib selector "eventPredicateWithStartDate:endDate:calendars:" ( handle as integer, _
		  startDate as integer, endDate as integer, calendars as integer ) as integer
		  declare function CalCalendarStore_eventsWithPredicate lib kObjCLib selector "eventsWithPredicate:" ( handle as integer, predicate as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim calArrayObj as ALPrivateObjCObject = NSArrayFromCalendars( calendars )
		  dim predicate as ALPrivateObjCObject = NSPredicate_eventPredicateWithStartDateEndDateCalendars( ALPrivateObjCObject.getClass( "CalCalendarStore" ), _
		  ALPrivateCocoaUtils.DateToNSDate( startDate ), ALPrivateCocoaUtils.DateToNSDate( endDate ), calArrayObj )
		  dim arr as ALPrivateObjCObject = CalCalendarStore_eventsWithPredicate( handle, predicate )
		  dim results() as ALLeopardCalendarEvent
		  
		  for each item as ALPrivateObjCObject in ALPrivateCocoaUtils.NSArrayToArray( arr )
		    results.append( ALLeopardCalendarEvent._createEvent( item, self ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EventWithUID(uid as string, occurrence as Date) As ALCalendarEvent
		  declare function CalCalendarStore_eventWithUID lib kObjCLib selector "eventWithUID:occurrence:" ( handle as integer, uid as CFStringRef, occurrence as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim obj as ALPrivateObjCObject
		  if occurrence = nil then
		    obj = CalCalendarStore_eventWithUID( handle, uid, 0 )
		  else
		    obj = CalCalendarStore_eventWithUID( handle, uid, ALPrivateCocoaUtils.DateToNSDate( occurrence ) )
		  end if
		  
		  return ALLeopardCalendarEvent._createEvent( obj, self )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetStringConstant(name as string) As string
		  declare function dlsym lib "System" ( handle as integer, name as CString ) as ptr
		  declare sub NSString_retain lib kObjCLib selector "retain" ( handle as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim p as ptr = dlsym( mFrameworkHandle, name )
		  if p = nil then raise new FunctionNotFoundException() // close enough...
		  
		  dim result as CFStringRef = p.CFStringRef
		  NSString_retain( result )
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub Initialize()
		  declare function dlopen lib "System" ( file as CString, mode as integer ) as integer
		  
		  // set up Cocoa
		  ALPrivateCocoaUtils.init()
		  
		  // since ALCalendarStore.framework isn't loaded by default, we need to load it ourselves
		  mFrameworkHandle = dlopen( "/System/Library/Frameworks/CalendarStore.framework/CalendarStore", 0 )
		  
		  // set ourself up to get notifications
		  registerForNotifications()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub NotificationCallback(center as integer, obs as ptr, name as CFStringRef, obj as integer, userInfo as integer)
		  declare function NSDictionary_objectForKey lib kObjCLib selector "objectForKey:" ( handle as integer, value as CFStringRef ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  // arrays of NSString (the UID that changed), you can use description to get the value
		  dim updatedItems() as ALPrivateObjCObject = ALPrivateCocoaUtils.NSArrayToArray( NSDictionary_objectForKey(userInfo, CalUpdatedRecordsKey ) )
		  dim insertedItems() as ALPrivateObjCObject = ALPrivateCocoaUtils.NSArrayToArray( NSDictionary_objectForKey( userInfo, CalInsertedRecordsKey ) )
		  dim removedItems() as ALPrivateObjCObject = ALPrivateCocoaUtils.NSArrayToArray( NSDictionary_objectForKey( userInfo, CalDeletedRecordsKey ) )
		  
		  if name = CalCalendarsChangedExternallyNotification or name = CalCalendarsChangedNotification then
		    for each uid as ALPrivateObjCObject in insertedItems
		      defaultStore.notifyCalendarAdded( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in updatedItems
		      defaultStore.notifyCalendarChanged( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in removedItems
		      defaultStore.notifyCalendarDeleted( uid.description )
		    next
		    
		    
		  elseif name = CalEventsChangedExternallyNotification or name = CalEventsChangedNotification then
		    for each uid as ALPrivateObjCObject in insertedItems
		      defaultStore.notifyEventAdded( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in updatedItems
		      defaultStore.notifyEventChanged( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in removedItems
		      defaultStore.notifyEventDeleted( uid.description )
		    next
		    
		    
		  elseif name = CalTasksChangedExternallyNotification or name = CalTasksChangedNotification then
		    for each uid as ALPrivateObjCObject in insertedItems
		      defaultStore.notifyTaskAdded( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in updatedItems
		      defaultStore.notifyTaskChanged( uid.description )
		    next
		    
		    for each uid as ALPrivateObjCObject in removedItems
		      defaultStore.notifyTaskDeleted( uid.description )
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NSArrayFromCalendars(calendars() as ALLeopardCalendar) As ALPrivateObjCObject
		  declare function CalCalendarStore_calendars lib kObjCLib selector "calendars" ( handle as integer ) as integer
		  declare function NSArray_arrayWithObjects lib kObjCLib selector "arrayWithObjects:count:" ( handle as integer, objects as ptr, count as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  if calendars.ubound >= 0 then
		    // convert our calendars array to an NSArray
		    // note that we can't use ArrayToNSArray because a ALLeopardCalendar isn't a ALPrivateObjCObject
		    dim m as new MemoryBlock( ( calendars.ubound + 1 ) * 4 )
		    m.littleEndian = targetLittleEndian
		    
		    for i as integer = 0 to calendars.ubound
		      m.int32Value( i * 4 ) = calendars( i ).handle
		    next
		    
		    return NSArray_arrayWithObjects( ALPrivateObjCObject.getClass( "NSArray" ), m, calendars.ubound + 1)
		  else
		    return CalCalendarStore_calendars( handle )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub RegisterForNotifications()
		  declare function CFNotificationCenterGetLocalCenter lib "CoreFoundation" () as integer
		  declare sub CFNotificationCenterAddObserver lib "CoreFoundation" ( center as integer, observer as integer, callBack as ptr, name as CFStringRef, obj as integer, suspensionBehavior as integer )
		  
		  const CFNotificationSuspensionBehaviorDeliverImmediately = 4
		  dim supportedNotifications() as string = array( CalCalendarsChangedExternallyNotification, CalCalendarsChangedNotification, CalEventsChangedExternallyNotification, _
		  CalEventsChangedNotification, CalTasksChangedExternallyNotification, CalTasksChangedNotification )
		  
		  for each notif as string in supportedNotifications
		    CFNotificationCenterAddObserver( CFNotificationCenterGetLocalCenter(), 0, addressOf NotificationCallback, notif, 0, CFNotificationSuspensionBehaviorDeliverImmediately )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tasks() As ALCalendarTask()
		  dim cals() as ALLeopardCalendar
		  return tasks( cals )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tasks(calendars() as ALLeopardCalendar) As ALLeopardCalendarTask()
		  //! Gets a list of all tasks occuring in `calendars`.
		  //! If there are no calendars in the array, all calendars are searched.
		  
		  declare function NSPredicate_taskPredicateWithCalendars lib kObjCLib selector "taskPredicateWithCalendars:" ( handle as integer, calendars as integer ) as integer
		  declare function CalCalendarStore_tasksWithPredicate lib kObjCLib selector "tasksWithPredicate:" ( handle as integer, predicate as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim calArrayObj as ALPrivateObjCObject = NSArrayFromCalendars( calendars )
		  dim predicate as ALPrivateObjCObject = NSPredicate_taskPredicateWithCalendars( ALPrivateObjCObject.getClass( "CalCalendarStore" ), calArrayObj )
		  dim arr as ALPrivateObjCObject = CalCalendarStore_tasksWithPredicate( handle, predicate )
		  dim results() as ALLeopardCalendarTask
		  
		  for each item as ALPrivateObjCObject in ALPrivateCocoaUtils.NSArrayToArray( arr )
		    results.append( ALLeopardCalendarTask._createTask( item, self ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskWithUID(uid as string) As ALCalendarTask
		  declare function CalCalendarStore_taskWithUID lib kObjCLib selector "eventWithUID:" ( handle as integer, uid as CFStringRef ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  
		  dim obj as ALPrivateObjCObject = CalCalendarStore_taskWithUID( handle, uid )
		  return ALLeopardCalendarTask._createTask( obj, self )
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalCalendarsChangedExternallyNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalCalendarsChangedExternallyNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalCalendarsChangedNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalCalendarsChangedNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalDeletedRecordsKey" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalDeletedRecordsKey As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalEventsChangedExternallyNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalEventsChangedExternallyNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalEventsChangedNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalEventsChangedNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalInsertedRecordsKey" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalInsertedRecordsKey As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalTasksChangedExternallyNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalTasksChangedExternallyNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalTasksChangedNotification" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalTasksChangedNotification As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static result as string = getStringConstant( "CalUpdatedRecordsKey" )
			  return result
			End Get
		#tag EndGetter
		Private Shared CalUpdatedRecordsKey As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHandle
			End Get
		#tag EndGetter
		handle As ALPrivateObjCObject
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared mFrameworkHandle As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHandle As ALPrivateObjCObject
	#tag EndProperty


	#tag Constant, Name = kObjCLib, Type = String, Dynamic = False, Default = \"Cocoa", Scope = Protected
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
End Class
#tag EndClass
