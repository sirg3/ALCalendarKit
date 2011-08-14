#tag Class
Protected Class ALOutlookCalendarStore
Inherits ALCalendarStore
	#tag Method, Flags = &h0
		Function Calendars() As ALCalendar()
		  // grab all the OLEObjects for the calendars
		  dim calendars() as OLEObject
		  calendars.append( calendarsFolder )
		  
		  loadObjectsFromContainer( calendarsFolder.value( "Folders" ), calendars )
		  
		  // now convert them to ALOutlookCalendars
		  dim results() as ALOutlookCalendar
		  for each cal as OLEObject in calendars
		    results.append( new ALOutlookCalendar( cal , self) )
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalendarsFolder() As OLEObject
		  const olFolderCalendar = 9
		  
		  dim app as new OLEObject( "Outlook.Application" )
		  dim theNamespace as OLEObject = app.GetNamespace( "MAPI" )
		  
		  return theNamespace.GetDefaultFolder( olFolderCalendar )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // You can't create new instances of this class directly.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateCalendar() As ALCalendar
		  return new ALOutlookCalendar( calendarsFolder.Add( "Untitled Folder" ), self )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DefaultStore() As ALOutlookCalendarStore
		  static defaultStore as new ALOutlookCalendarStore()
		  return defaultStore
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EventWithUID(uid as string, occurrence as Date = nil) As ALCalendarEvent
		  dim app as new OLEObject( "Outlook.Application" )
		  dim theNamespace as OLEObject = app.GetNamespace( "MAPI" )
		  
		  return new ALOutlookCalendarEvent( theNamespace.GetItemFromID( uid ), self )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadObjectsFromContainer(container as OLEObject, outputArray() as OLEObject)
		  for i as integer = 1 to container.count
		    dim item as OLEObject = container.item( i )
		    
		    outputArray.append( item )
		    loadObjectsFromContainer( item.value( "Folders" ), outputArray )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskWithUID(uid as string) As ALCalendarTask
		  const olFolderTasks = 13
		  
		  dim app as new OLEObject( "Outlook.Application" )
		  dim theNamespace as OLEObject = app.GetNamespace( "MAPI" )
		  dim tasksFolder as OLEObject = theNamespace.GetDefaultFolder( olFolderTasks )
		  
		  return new ALOutlookCalendarTask( theNamespace.GetItemFromID( uid, tasksFolder.Value( "StoreID" ) ), self )
		End Function
	#tag EndMethod


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
