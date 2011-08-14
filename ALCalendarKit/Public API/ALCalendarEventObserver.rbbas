#tag Interface
Protected Interface ALCalendarEventObserver
	#tag Method, Flags = &h0
		Sub EventChanged(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EventAdded(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EventDeleted(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
