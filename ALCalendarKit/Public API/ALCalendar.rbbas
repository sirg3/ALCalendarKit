#tag Class
Protected Class ALCalendar
	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date) As ALCalendarEvent()
		  //! Returns all of the events in the calendar that occur in a certain time range.
		  //! Note that only spans less than four years are supported. If you specify a range of more than four years,
		  //! your results WILL only span four years.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  //! Saves all changes made to this Calendar.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  //! Deletes this calendar and all of its items.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTitle() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetUID() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsEditable() As boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetTitle(value as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateEvent() As ALCalendarEvent
		  //! Creates a new event in this calendar.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  //! Updates this calendar to the version in the store.
		  //! Note that this has the side effect of reverting any changes made to this calendar.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(cal as ALCalendar) As integer
		  //! Determines the equality of two calendars.
		  
		  if cal is nil then return 1
		  
		  //FIXME: this is incorrect, but will do until we support more than one store per platform
		  return strcomp( uid, cal.uid, 0 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTask() As ALCalendarTask
		  //! Creates a new task in this calendar.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tasks() As ALCalendarTask()
		  //! Returns all tasks on this calendar.
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Note
			The calendar's name.
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
			Determines if this calendar is editable. The behavior when editing a read-only calendar is undefined.
		#tag EndNote
		#tag Getter
			Get
			return getIsEditable()
			End Get
		#tag EndGetter
		isEditable As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			A unique identifier for this calendar. Note that this is only unique per calendar store.
		#tag EndNote
		#tag Getter
			Get
			return getUID()
			End Get
		#tag EndGetter
		uid As string
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mStore As ALCalendarStore
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The store that this calendar belongs to.
		#tag EndNote
		#tag Getter
			Get
			return mStore
			End Get
		#tag EndGetter
		store As ALCalendarStore
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
			Name="isEditable"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uid"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
