#tag Class
Protected Class ALLeopardCalendar
Inherits ALCalendar
	#tag Method, Flags = &h0
		Function CreateEvent() As ALCalendarEvent
		  declare function CalEvent_event lib kObjCLib selector "event" ( handle as integer ) as integer
		  
		  dim obj as ALPrivateObjCObject = CalEvent_event( ALPrivateObjCObject.getClass( "CalEvent" ) )
		  dim result as ALLeopardCalendarEvent = ALLeopardCalendarEvent._createEvent( obj, store )
		  result.calendar = self
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTask() As ALCalendarTask
		  declare function CalTask_task lib kObjCLib selector "task" ( handle as integer ) as integer
		  
		  dim obj as ALPrivateObjCObject = CalTask_task( ALPrivateObjCObject.getClass( "CalTask" ) )
		  dim result as ALLeopardCalendarTask = ALLeopardCalendarTask._createTask( obj, store )
		  result.calendar = self
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  declare function CalCalendarStore_removeCalendar lib kObjCLib selector "removeCalendar:error:" ( handle as integer, calendar as integer, byref error as ptr ) as boolean
		  
		  dim err as ptr
		  if not CalCalendarStore_removeCalendar( ALLeopardCalendarStore( store ).handle, handle, err ) then
		    break
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date) As ALCalendarEvent()
		  return ALLeopardCalendarStore( store ).events( startDate, endDate, array( self ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsEditable() As boolean
		  declare function CalCalendar_isEditable lib kObjCLib selector "isEditable" ( handle as integer ) as boolean
		  
		  return CalCalendar_isEditable( handle )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  declare function CalCalendar_title lib kObjCLib selector "title" ( handle as integer ) as integer
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalCalendar_title( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  declare function CalCalendar_uid lib kObjCLib selector "uid" ( handle as integer ) as integer
		  
		  return ALPrivateCocoaUtils.NSStringToString( CalCalendar_uid( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  declare function CalCalendarStore_saveCalendar lib kObjCLib selector "saveCalendar:error:" ( handle as integer, calendar as integer, byref error as ptr ) as boolean
		  
		  dim err as ptr
		  if not CalCalendarStore_saveCalendar( ALLeopardCalendarStore( store ).handle, handle, err ) then
		    break
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  declare sub CalCalendar_setTitle lib kObjCLib selector "setTitle:" ( handle as integer, value as CFStringRef )
		  
		  CalCalendar_setTitle( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tasks() As ALCalendarTask()
		  return ALLeopardCalendarStore( store ).tasks( array( self ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  declare function CalCalendarStore_calendarWithUID lib kObjCLib selector "calendarWithUID:" ( handle as integer, uid as CFStringRef ) as integer
		  
		  mHandle = CalCalendarStore_calendarWithUID( ALLeopardCalendarStore( store ).handle, uid )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function _CreateCalendar(handle as ALPrivateObjCObject, store as ALCalendarStore) As ALLeopardCalendar
		  if handle = nil then return nil
		  
		  dim result as new ALLeopardCalendar()
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
			Name="isEditable"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="ALCalendar"
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
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendar"
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
			InheritedFrom="ALCalendar"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
