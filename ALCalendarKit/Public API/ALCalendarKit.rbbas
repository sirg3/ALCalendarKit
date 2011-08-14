#tag Module
Protected Module ALCalendarKit
	#tag Method, Flags = &h1
		Protected Sub Initialize()
		  //! Performs any required initialization. You must call this function before using any other of the Calendar classes or functions.
		  
		  // protect ourselves from being initialized more than once
		  static isInitialized as boolean
		  if isInitialized then exit sub
		  isInitialized = true
		  
		  #if targetMacOS
		    // while the CalendarStore framework exists on 10.4, it's a private framework and we're not going to use it
		    if isLeopardOrGreater() then
		      ALLeopardCalendarStore.initialize()
		      systemStore = ALLeopardCalendarStore.defaultStore
		    end if
		  #elseif targetWin32
		    ALOutlookCalendarStore.initialize()
		    systemStore = ALOutlookCalendarStore.defaultStore
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsLeopardOrGreater() As boolean
		  //! Determines if this computer is running Mac OS 10.5 or greater.
		  //! On non-Mac platforms, it always returns false.
		  
		  #if targetMacOS
		    dim sysVersion as integer
		    return System.gestalt( "sysv", sysVersion ) and sysVersion >= &h1050
		  #else
		    return false
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		#tag Note
			The operating system's calendar store, or nil if the operating system doesn't have any built in support for calendars.
		#tag EndNote
		Protected systemStore As ALCalendarStore
	#tag EndProperty


	#tag Constant, Name = kVersion, Type = Double, Dynamic = False, Default = \"2.0", Scope = Protected
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
End Module
#tag EndModule
