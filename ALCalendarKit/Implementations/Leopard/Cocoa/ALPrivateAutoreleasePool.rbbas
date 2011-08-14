#tag Class
Protected Class ALPrivateAutoreleasePool
	#tag Method, Flags = &h0
		Sub Constructor()
		  'declare function objc_getClass lib kObjCLib ( name as CString ) as integer
		  'declare function NSAutoreleasePool_alloc lib kObjCLib selector "alloc" ( handle as integer ) as integer
		  'declare function NSAutoreleasePool_init lib kObjCLib selector "init" ( handle as integer ) as integer
		  '
		  'mHandle = NSAutoreleasePool_init( NSAutoreleasePool_alloc( objc_getClass( "NSAutoreleasePool" ) ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  'declare sub NSAutoreleasePool_release lib kObjCLib selector "release" ( handle as integer )
		  '
		  'NSAutoreleasePool_release( mHandle )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHandle As integer
	#tag EndProperty


	#tag Constant, Name = kObjCLib, Type = String, Dynamic = False, Default = \"Cocoa", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
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
