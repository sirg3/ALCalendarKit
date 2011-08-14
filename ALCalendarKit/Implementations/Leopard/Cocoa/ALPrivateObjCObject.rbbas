#tag Class
Protected Class ALPrivateObjCObject
	#tag Method, Flags = &h1
		Protected Sub Retain()
		  declare function NSObjectRetain lib kObjCLib selector "retain" ( obj as integer ) as integer
		  mHandle = NSObjectRetain( handle )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Release()
		  declare sub NSObjectRelease lib kObjCLib selector "release" ( obj as integer )
		  NSObjectRelease( handle )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(obj as ALPrivateObjCObject) As Integer
		  if obj is nil and handle = 0 then return 0
		  if obj is nil and handle <> 0 then return 1
		  
		  if handle > obj.handle then return 1
		  if handle = obj.handle then return 0
		  if handle < obj.handle then return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(handle as integer, retain as boolean = true)
		  mHandle = handle
		  
		  '#if debugBuild
		  'if handle = 0 then break
		  '#endif
		  
		  if retain then _
		  retain()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  release()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(handle as integer)
		  constructor( handle )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As integer
		  return handle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // can't create a new Obj-C object directly, you must call ObjCClass.alloc}
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Alloc(name as string) As integer
		  declare function ClassAlloc lib kObjCLib selector "alloc" ( handle as integer ) as integer
		  
		  return ClassAlloc( getClass( name ) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetClass(name as string) As integer
		  declare function objc_getClass lib kObjCLib ( name as CString ) as integer
		  
		  return objc_getClass( name )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Null() As ALPrivateObjCObject
		  static nullObject as ALPrivateObjCObject = new ALPrivateObjCObject( 0 )
		  return nullObject
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHandle As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			declare function NSObjectDescription lib kObjCLib selector "description" ( obj as integer ) as CFStringRef
			declare sub NSString_retain lib kObjCLib selector "retain" ( s as CFStringRef )
			
			dim result as CFStringRef = NSObjectDescription( handle )
			NSString_retain( result )
			
			return result
			End Get
		#tag EndGetter
		description As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			return mHandle
			End Get
		#tag EndGetter
		handle As Integer
	#tag EndComputedProperty


	#tag Constant, Name = kObjCLib, Type = String, Dynamic = False, Default = \"Cocoa", Scope = Private
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
		#tag ViewProperty
			Name="description"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="handle"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
