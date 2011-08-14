#tag Class
Protected Class ALCalendarTask
Inherits ALCalendarItem
	#tag Method, Flags = &h1
		Protected Function GetDueDate() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCompletionDate() As Date
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetPriority() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetDueDate(value as Date)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetCompletionDate(value as Date)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetPriority(value as integer)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			return getPriority()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setPriority( value )
			End Set
		#tag EndSetter
		priority As integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			return getDueDate()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setDueDate( value )
			End Set
		#tag EndSetter
		dueDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			return getCompletionDate()
			End Get
		#tag EndGetter
		#tag Setter
			Set
			setCompletionDate( value )
			End Set
		#tag EndSetter
		completionDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			return dueDate <> nil
			End Get
		#tag EndGetter
		#tag Setter
			Set
			if dueDate = nil then _
			dueDate = new Date()
			End Set
		#tag EndSetter
		isCompleted As boolean
	#tag EndComputedProperty


	#tag Constant, Name = kPriorityHigh, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPriorityMedium, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPriorityLow, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPriorityNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="isCompleted"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
