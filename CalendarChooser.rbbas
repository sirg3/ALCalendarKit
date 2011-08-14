#tag Class
Protected Class CalendarChooser
Inherits PopupMenu
Implements ALCalendarObserver
	#tag Event
		Sub Close()
		  removeObservers()
		  
		  close()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub ReloadCalendars()
		  //! Reload the calendars menu, while attempting to preserve selection.
		  dim selectedCal as ALCalendar = value
		  deleteAllRows()
		  
		  for each cal as ALCalendar in store.calendars
		    // if the calendar is read-only and we aren't showing read-only calendars don't add it to the menu
		    if not showReadOnlyCalendars and not cal.isEditable then continue
		    
		    // add the calendar
		    addRow( cal.title )
		    mLoadedCalendars.append( cal )
		    
		    // try to restore the selection
		    if cal = selectedCal then listIndex = listCount - 1
		  next
		  
		  // if we had no previous selection, then set our selection to the first item
		  if selectedCal = nil then listIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarAdded(store as ALCalendarStore, uid as string)
		  reloadCalendars()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarChanged(store as ALCalendarStore, uid as string)
		  reloadCalendars()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarDeleted(store as ALCalendarStore, uid as string)
		  reloadCalendars()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RemoveObservers()
		  if mStore <> nil then mStore.removeCalendarObserver( self )
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Note
			Gets or sets the calendar that's selected in this menu.
		#tag EndNote
		#tag Getter
			Get
			//! Gets the calendar that's selected in the calendars menu.
			if listIndex = -1 then return nil
			
			return mLoadedCalendars( listIndex )
			End Get
		#tag EndGetter
		#tag Setter
			Set
			for i as integer = 0 to mLoadedCalendars.ubound
			if mLoadedCalendars( i ) = value then
			listIndex = i
			exit sub
			end if
			next
			End Set
		#tag EndSetter
		value As ALCalendar
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mLoadedCalendars() As ALCalendar
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStore As ALCalendarStore
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			The store this chooser will take its calendars from.
		#tag EndNote
		#tag Getter
			Get
			return mStore
			End Get
		#tag EndGetter
		#tag Setter
			Set
			removeObservers()
			
			mStore = value
			mStore.addCalendarObserver( self )
			
			reloadCalendars()
			End Set
		#tag EndSetter
		store As ALCalendarStore
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		showReadOnlyCalendars As boolean = false
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="80"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="20"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ListIndex"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataSource"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataField"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Database Binding"
			InheritedFrom="PopupMenu"
		#tag EndViewProperty
		#tag ViewProperty
			Name="showReadOnlyCalendars"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
