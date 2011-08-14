#tag Module
Protected Module ALPrivateOLEUtils
	#tag Method, Flags = &h1
		Protected Function ArrayValue(obj as OLEObject, name as string) As OLEObject()
		  dim results() as OLEObject
		  if obj = nil then return results
		  
		  dim container as OLEObject = obj.value( name )
		  for i as integer = 1 to container.count
		    results.append( container.item( i ) )
		  next
		  
		  return results
		End Function
	#tag EndMethod


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
