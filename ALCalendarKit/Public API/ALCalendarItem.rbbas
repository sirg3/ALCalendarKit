#tag Class
Protected Class ALCalendarItem
	#tag Method, Flags = &h0
		Sub Save()
		  //! Saves all changes to this item.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  //! Deletes this calendar item.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetNotes() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetNotes(value as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetModificationDate() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCalendar(cal as ALCalendar)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCalendar() As ALCalendar
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(item as ALCalendarItem) As integer
		  //! Determines the equality of two calendar items.
		  
		  if item is nil then return 1
		  
		  //FIXME: this is incorrect, but will do until we support more than one store per platform
		  return strcomp( uid, item.uid, 0 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  //! Updates this item to the version in the store.
		  //! Note that this has the side effect of reverting any changes made to this item.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetURL() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetURL(value as string)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Note
			The title of this item.
		#tag EndNote
		#tag Getter
			Get
			return getTitle()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setTitle( value )
			End Set
		#tag EndSetter
		title As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			Any user-defined notes this item may have.
		#tag EndNote
		#tag Getter
			Get
			return getNotes()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setNotes( value )
			End Set
		#tag EndSetter
		notes As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The unique identifier of this item. Note that this is unique only per calendar store.
		#tag EndNote
		#tag Getter
			Get
			return getUID()
			End Get
		#tag EndGetter
		uid As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The date this item was last modified.
		#tag EndNote
		#tag Getter
			Get
			return getModificationDate()
			End Get
		#tag EndGetter
		modificationDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The calendar this item belongs to. Note that assigning a calendar from one store to another is currently unsupported.
		#tag EndNote
		#tag Getter
			Get
			return getCalendar()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setCalendar( value )
			End Set
		#tag EndSetter
		calendar As ALCalendar
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mStore As ALCalendarStore
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The calendr store that this item belongs to.
		#tag EndNote
		#tag Getter
			Get
			return mStore
			End Get
		#tag EndGetter
		store As ALCalendarStore
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The url related to this item.
		#tag EndNote
		#tag Getter
			Get
			return getURL()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setURL( value )
			End Set
		#tag EndSetter
		url As string
	#tag EndComputedProperty


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
		#tag EndViewProperty
		#tag ViewProperty
			Name="notes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uid"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="url"
			Group="Behavior"
			Type="string"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
