#tag Interface
Protected Interface ALCalendarTaskObserver
	#tag Method, Flags = &h0
		Sub TaskAdded(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TaskChanged(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TaskDeleted(store as ALCalendarStore, uid as string)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
