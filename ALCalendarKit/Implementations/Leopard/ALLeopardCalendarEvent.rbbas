#tag Class
Protected Class ALLeopardCalendarEvent
Inherits ALCalendarEvent
	#tag Method, Flags = &h0
		Sub Delete()
		  declare function CalCalendarStore_removeEvent lib kObjCLib selector "removeEvent:span:error:" ( handle as integer, evt as integer, span as integer, byref error as ptr ) as boolean
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  dim span as integer // FIXME!!!
		  dim err as ptr
		  if not CalCalendarStore_removeEvent( ALLeopardCalendarStore( store ).handle, handle, span, err ) then
		    break
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCalendar() As ALCalendar
		  declare function CalCalendarItem_calendar lib kObjCLib selector "calendar" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALLeopardCalendar._createCalendar( CalCalendarItem_calendar( handle ), store )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetEndDate() As Date
		  declare function CalEvent_endDate lib kObjCLib selector "endDate" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalEvent_endDate( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsAllDay() As boolean
		  declare function CalEvent_isAllDay lib kObjCLib selector "isAllDay" ( handle as integer ) as boolean
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return CalEvent_isAllDay( handle )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLocation() As string
		  declare function CalEvent_location lib kObjCLib selector "location" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalEvent_location( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetModificationDate() As Date
		  declare function CalCalendarItem_dateStamp lib kObjCLib selector "dateStamp" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalCalendarItem_dateStamp( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNotes() As string
		  declare function CalCalendarItem_notes lib kObjCLib selector "notes" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalCalendarItem_notes( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetOccurrence() As Date
		  declare function CalEvent_occurrence lib kObjCLib selector "occurrence" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalEvent_occurrence( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetStartDate() As Date
		  declare function CalEvent_startDate lib kObjCLib selector "startDate" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalEvent_startDate( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  declare function CalCalendarItem_title lib kObjCLib selector "title" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalCalendarItem_title( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  declare function CalCalendarItem_uid lib kObjCLib selector "uid" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalCalendarItem_uid( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetURL() As string
		  declare function CalCalendarItem_url lib kObjCLib selector "url" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSURLToString( CalCalendarItem_url( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  declare function CalCalendarStore_saveEvent lib kObjCLib selector "saveEvent:span:error:" ( handle as integer, evt as integer, span as integer, byref error as ptr ) as boolean
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  dim span as integer // FIXME!!!
		  dim err as ptr
		  if not CalCalendarStore_saveEvent( ALLeopardCalendarStore( store ).handle, handle, span, err ) then
		    break
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCalendar(cal as ALCalendar)
		  declare sub CalCalendarItem_setCalendar lib kObjCLib selector "setCalendar:" ( handle as integer, cal as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalCalendarItem_setCalendar( handle, ALLeopardCalendar( cal ).handle )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetEndDate(value as Date)
		  declare sub CalEvent_setEndDate lib kObjCLib selector "setEndDate:" ( handle as integer, date as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setEndDate( handle, ALPrivateCocoaUtils.DateToNSDate( value ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetIsAllDay(value as boolean)
		  declare sub CalEvent_setIsAllDay lib kObjCLib selector "setIsAllDay:" ( handle as integer, value as boolean )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setIsAllDay( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetLocation(value as string)
		  declare sub CalEvent_setLocation lib kObjCLib selector "setLocation:" ( handle as integer, value as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setLocation( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetNotes(value as string)
		  declare sub CalEvent_setNotes lib kObjCLib selector "setNotes:" ( handle as integer, value as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setNotes( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetStartDate(value as Date)
		  declare sub CalEvent_setStartDate lib kObjCLib selector "setStartDate:" ( handle as integer, date as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setStartDate( handle, ALPrivateCocoaUtils.DateToNSDate( value ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  declare sub CalEvent_setTitle lib kObjCLib selector "setTitle:" ( handle as integer, value as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalEvent_setTitle( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetURL(value as string)
		  declare sub CalCalendarItem_setURL lib kObjCLib selector "setUrl:" ( handle as integer, value as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalCalendarItem_setURL( handle, ALPrivateCocoaUtils.stringToNSURL( value ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  //FIXME: how does this handle events that haven't been saved yet?
		  mHandle = ALLeopardCalendarEvent( store.eventWithUID( uid, occurrence ) ).handle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function _CreateEvent(handle as ALPrivateObjCObject, store as ALCalendarStore) As ALLeopardCalendarEvent
		  if handle = nil then return nil
		  
		  dim result as new ALLeopardCalendarEvent()
		  result.mHandle = handle
		  result.mStore = store
		  
		  return result
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHandle
			End Get
		#tag EndGetter
		handle As ALPrivateObjCObject
	#tag EndComputedProperty

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
			Name="isAllDay"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="ALCalendarEvent"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="location"
			Group="Behavior"
			Type="string"
			InheritedFrom="ALCalendarEvent"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="notes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uid"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="url"
			Group="Behavior"
			Type="string"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
