#tag Class
Protected Class ALOutlookCalendar
Inherits ALCalendar
	#tag Method, Flags = &h0
		Sub Constructor(handle as OLEObject, store as ALCalendarStore)
		  me.handle = handle
		  mStore = store
		  mEvents = new ALOutlookObservingList( OLEObject( handle.value( "Items" ) ) )
		  mEvents.itemAddedCallback = addressOf store.notifyEventAdded
		  mEvents.itemChangedCallback = addressOf store.notifyEventChanged
		  mEvents.itemRemovedCallback = addressOf store.notifyEventDeleted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateEvent() As ALCalendarEvent
		  const olAppointmentItem = 1
		  
		  dim app as new OLEObject( "Outlook.Application" )
		  dim result as new ALOutlookCalendarEvent( app.CreateItem( olAppointmentItem ), store )
		  result.calendar = self
		  result.handle.value( "ReminderSet" ) = false
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTask() As ALCalendarTask
		  const olTaskItem = 3
		  
		  dim app as new OLEObject( "Outlook.Application" )
		  dim result as new ALOutlookCalendarTask( app.CreateItem( olTaskItem ), store )
		  result.calendar = self
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  handle.Delete()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date) As ALCalendarEvent()
		  const kFourYearsInSeconds = 126227704
		  
		  // clip the request range to four years, as per the documentation
		  if endDate.totalSeconds - startDate.totalSeconds > kFourYearsInSeconds then
		    endDate = new Date()
		    endDate.totalSeconds = startDate.totalSeconds + kFourYearsInSeconds
		  end if
		  
		  dim results() as ALCalendarEvent
		  for each item as OLEObject in mEvents.items
		    dim evt as new ALOutlookCalendarEvent( item, store )
		    
		    // restrict the results to our range...
		    //FIXME: there's some edge cases here that I need to compare to the OS X side
		    if evt.startDate > startDate and evt.startDate < endDate then _
		    results.append( evt )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsEditable() As boolean
		  //FIXME
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  return handle.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  return handle.EntryID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  handle.Name = value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		handle As OLEObject
	#tag EndProperty

	#tag Property, Flags = &h0
		mEvents As ALOutlookObservingList
	#tag EndProperty


	#tag ViewBehavior
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
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="ALCalendar"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isEditable"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="ALCalendar"
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
