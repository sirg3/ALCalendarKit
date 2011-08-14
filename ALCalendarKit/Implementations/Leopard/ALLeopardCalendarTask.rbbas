#tag Class
Protected Class ALLeopardCalendarTask
Inherits ALCalendarTask
	#tag Method, Flags = &h0
		Sub Delete()
		  declare function CalCalendarStore_removeTask lib kObjCLib selector "removeTask:error:" ( handle as integer, task as integer, byref error as ptr ) as boolean
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  dim err as ptr
		  if not CalCalendarStore_removeTask( ALLeopardCalendarStore( store ).handle, handle, err ) then
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
		Protected Function GetCompletionDate() As Date
		  declare function CalTask_completedDate lib kObjCLib selector "completedDate" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalTask_completedDate( handle ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDueDate() As Date
		  declare function CalTask_dueDate lib kObjCLib selector "dueDate" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return ALPrivateCocoaUtils.NSDateToDate( CalTask_dueDate( handle ) )
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
		Protected Function GetPriority() As integer
		  declare function CalTask_priority lib kObjCLib selector "priority" ( handle as integer ) as integer
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  return CalTask_priority( handle )
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
		  declare function CalCalendarStore_saveTask lib kObjCLib selector "saveTask:error:" ( handle as integer, task as integer, byref error as ptr ) as boolean
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  dim err as ptr
		  if not CalCalendarStore_saveTask( ALLeopardCalendarStore( store ).handle, handle, err ) then
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
		Protected Sub SetCompletionDate(value as Date)
		  declare sub CalTask_setCompletedDate lib kObjCLib selector "setCompletedDate:" ( handle as integer, date as integer )
		  
		  CalTask_setCompletedDate( handle, ALPrivateCocoaUtils.DateToNSDate( value ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetDueDate(value as Date)
		  declare sub CalTask_setDueDate lib kObjCLib selector "setDueDate:" ( handle as integer, date as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalTask_setDueDate( handle, ALPrivateCocoaUtils.DateToNSDate( value ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetNotes(value as string)
		  declare sub CalCalendarItem_setNotes lib kObjCLib selector "setNotes:" ( handle as integer, value as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalCalendarItem_setNotes( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetPriority(value as integer)
		  declare sub CalTask_setPriority lib kObjCLib selector "setPriority:" ( handle as integer, value as integer )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalTask_setPriority( handle, value )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  declare sub CalCalendarItem_setTitle lib kObjCLib selector "setTitle:" ( handle as integer, value as CFStringRef )
		  dim _pool as new ALPrivateAutoreleasePool()
		  
		  CalCalendarItem_setTitle( handle, value )
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
		 Shared Function _CreateTask(handle as ALPrivateObjCObject, store as ALCalendarStore) As ALLeopardCalendarTask
		  if handle = nil then return nil
		  
		  dim result as new ALLeopardCalendarTask()
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
			Name="isCompleted"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="ALCalendarTask"
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
			Name="notes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="priority"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			InheritedFrom="ALCalendarTask"
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
