#tag Class
Protected Class ALOutlookObservingList
Inherits OLEObject
	#tag Event
		Function EventTriggered(eventName as string, parameters() as variant) As variant
		  select case eventName
		  case "ItemAdd"
		    dim item as OLEObject = parameters( 1 )
		    itemAddedCallback.invoke( item.value( UUIDKey ) )
		    
		    // Keep our state up to date (see ItemRemove for details).
		    mCachedUIDs.append( item.value( UUIDKey ) )
		  case "ItemChange"
		    dim item as OLEObject = parameters( 1 )
		    itemChangedCallback.invoke( item.value( UUIDKey ) )
		  case "ItemRemove"
		    // Bah. Outlook doesn't bother giving us the item that was removed. So, we keep
		    // a list of all of the UIDs contained in this folder. When the remove event is triggered,
		    // we compare the list of what we have to the list that currently exist. Anything missing
		    // in Outlook's list has been removed.
		    
		    // Use a dictionary to store our current state, which should be reasonably fast
		    dim currentUIDs as new Dictionary()
		    for each item as OLEObject in items
		      currentUIDs.value( item.value( UUIDKey ) ) = true
		    next
		    
		    for each id as variant in mCachedUIDs
		      if not currentUIDs.hasKey( id ) then
		        // item has been removed!
		        itemRemovedCallback.invoke( id )
		      end if
		    next
		    
		    mCachedUIDs = currentUIDs.keys
		  end select
		End Function
	#tag EndEvent


	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub CallbackFunc(uid as string)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(objToCopy As OLEObject)
		  super.constructor( objToCopy )
		  
		  for each item as OLEObject in items
		    mCachedUIDs.append( item.value( UUIDKey ) )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Items() As OLEObject()
		  dim results() as OLEObject
		  
		  for i as integer = 1 to self.count
		    results.append( self.item( i ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		itemAddedCallback As CallbackFunc
	#tag EndProperty

	#tag Property, Flags = &h0
		itemChangedCallback As CallbackFunc
	#tag EndProperty

	#tag Property, Flags = &h0
		itemRemovedCallback As CallbackFunc
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCachedUIDs() As variant
	#tag EndProperty


	#tag Constant, Name = UUIDKey, Type = String, Dynamic = False, Default = \"GlobalAppointmentID", Scope = Protected
	#tag EndConstant


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
	#tag EndViewBehavior
End Class
#tag EndClass
