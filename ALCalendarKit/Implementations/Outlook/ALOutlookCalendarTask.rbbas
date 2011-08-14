#tag Class
Protected Class ALOutlookCalendarTask
Inherits ALCalendarTask
	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  return handle.value( "Subject" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNotes() As string
		  return handle.value( "Body" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCompletionDate() As Date
		  return handle.value( "DateCompleted" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDueDate() As Date
		  return handle.value( "DueDate" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  return handle.value( "EntryID" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  handle.invoke( "Delete" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  handle.invoke( "Save" )
		  
		  // move the item if we need to
		  if mNewParent <> nil then handle.Move( mNewParent )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetPriority(value as integer)
		  dim importance as integer
		  
		  // since Outlook doesn't use the 0-9 priority levels that iCalendar and iCal do, we need to translate them
		  if value = kPriorityNone then
		    importance = olImportanceNormal
		  elseif value >= kPriorityHigh and value < kPriorityMedium then
		    importance = olImportanceHigh
		  elseif value >= kPriorityMedium and value < kPriorityLow then
		    importance = olImportanceNormal
		  else
		    importance = olImportanceLow
		  end if
		  
		  handle.value( "Importance" ) = importance
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetPriority() As integer
		  dim importance as integer = handle.value( "Importance" )
		  
		  if importance = olImportanceLow then
		    return kPriorityLow
		  elseif importance = olImportanceNormal then
		    return kPriorityNone
		  else
		    return kPriorityHigh
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetDueDate(value as Date)
		  handle.value( "DueDate" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCompletionDate(value as Date)
		  handle.value( "DateCompleted" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetModificationDate() As Date
		  return handle.value( "LastModificationTime" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetNotes(value as string)
		  handle.value( "Body" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  handle.value( "Subject" ) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(handle as OLEObject, store as ALCalendarStore)
		  me.handle = handle
		  mStore = store
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCalendar(cal as ALCalendar)
		  // .Move() applies immediately, even if we haven't created this item!
		  mNewParent = ALOutlookCalendar( cal ).handle
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

	#tag Method, Flags = &h0
		Sub Update()
		  dim newSelf as ALOutlookCalendarTask = ALOutlookCalendarTask( store.taskWithUID( uid ) )
		  handle = newSelf.handle
		  mNewParent = nil
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private handle As OLEObject
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewParent As OLEObject
	#tag EndProperty


	#tag Constant, Name = olImportanceHigh, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = olImportanceLow, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = olImportanceNormal, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
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
			Name="priority"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			InheritedFrom="ALCalendarTask"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isCompleted"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="ALCalendarTask"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
