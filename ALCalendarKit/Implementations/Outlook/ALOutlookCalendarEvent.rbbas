#tag Class
Protected Class ALOutlookCalendarEvent
Inherits ALCalendarEvent
	#tag Method, Flags = &h0
		Sub Constructor(handle as OLEObject, store as ALCalendarStore)
		  me.handle = handle
		  mStore = store
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  handle.invoke( "Delete" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCalendar() As ALCalendar
		  if mNewParent = nil then
		    return new ALOutlookCalendar( handle.value( "Parent" ), store )
		  else
		    return mNewParent
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetEndDate() As Date
		  dim result as new Date()
		  result.totalSeconds = handle.value( "End" )
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsAllDay() As boolean
		  return handle.value( "AllDayEvent" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetModificationDate() As Date
		  dim result as new Date()
		  result.totalSeconds = handle.value( "LastModificationTime" )
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNotes() As string
		  return handle.value( "Body" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetStartDate() As Date
		  dim result as new Date()
		  result.totalSeconds = handle.value( "Start" )
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  return handle.value( "Subject" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  return handle.value( "EntryID" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  handle.invoke( "Save" )
		  
		  // move the item if we need to
		  if mNewParent <> nil then handle.Move( mNewParent )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCalendar(cal as ALCalendar)
		  // if we .Move to the same calendar, we get an exception... so prevent assigning to the same calendar
		  if cal = calendar then exit sub
		  
		  // .Move() applies immediately, even if we haven't created this item!
		  mNewParent = ALOutlookCalendar( cal ).handle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetEndDate(value as Date)
		  handle.value( "End" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetIsAllDay(value as boolean)
		  handle.value( "AllDayEvent" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetNotes(value as string)
		  handle.value( "Body" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetStartDate(value as Date)
		  handle.value( "Start" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  handle.value( "Subject" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  dim newSelf as ALOutlookCalendarEvent = ALOutlookCalendarEvent( store.eventWithUID( uid ) )
		  handle = newSelf.handle
		  mNewParent = nil
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return handle.value( "GlobalAppointmentID" )
			End Get
		#tag EndGetter
		globalAppointmentID As string
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		handle As OLEObject
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewParent As OLEObject
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="notes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarItem"
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
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="location"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendarEvent"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
