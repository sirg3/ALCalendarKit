#tag Class
Protected Class ALCalendarEvent
Inherits ALCalendarItem
	#tag Method, Flags = &h1
		Protected Function GetEndDate() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetIsAllDay() As boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLocation() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetOccurrence() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetStartDate() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetEndDate(value as Date)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetIsAllDay(value as boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetLocation(value as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetStartDate(value as Date)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Note
			The day that this event ends.
		#tag EndNote
		#tag Getter
			Get
			  return getEndDate()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  setEndDate( value )
			End Set
		#tag EndSetter
		endDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			Does this event last all day?
		#tag EndNote
		#tag Getter
			Get
			  return getIsAllDay()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  setIsAllDay( value )
			  
			  if endDate = nil and value then _
			  endDate = startDate
			End Set
		#tag EndSetter
		isAllDay As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The location this event takes place.
		#tag EndNote
		#tag Getter
			Get
			  return getLocation()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  setLocation( value )
			End Set
		#tag EndSetter
		location As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The specific occurrence of this event. This is used for recurring events.
		#tag EndNote
		#tag Getter
			Get
			  return getOccurrence()
			End Get
		#tag EndGetter
		occurrence As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The day this event starts on.
		#tag EndNote
		#tag Getter
			Get
			  return getStartDate()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  setStartDate( value )
			End Set
		#tag EndSetter
		startDate As Date
	#tag EndComputedProperty


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
		#tag EndViewProperty
		#tag ViewProperty
			Name="location"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
