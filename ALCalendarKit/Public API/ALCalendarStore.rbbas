#tag Class
Protected Class ALCalendarStore
	#tag Method, Flags = &h0
		Sub AddCalendarObserver(observer as ALCalendarObserver)
		  //! Adds an object to the list of observers for calendar change notifications.
		  
		  mCalendarObservers.append( observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddEventObserver(observer as ALCalendarEventObserver)
		  //! Adds an object to the list of observers for event change notifications.
		  
		  mEventObservers.append( observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTaskObserver(observer as ALCalendarTaskObserver)
		  //! Adds an object to the list of observers for task change notifications.
		  
		  mTaskObservers.append( observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Calendars() As ALCalendar()
		  //! Returns all of this store's calendars.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CalendarWithUID(uid as string) As ALCalendar
		  //! Gets a calendar by it's unique identifier. Returns nil if there is no calendar with that ID.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CopyCalendar(cal as ALCalendar) As ALCalendar
		  //! Creates a copy of the calendar which belongs to this store.
		  
		  //FIXME: this is needed when we support more than one store per OS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CopyEvent(theEvent as ALCalendarEvent) As ALCalendarEvent
		  //! Creates a copy of the calendar event which belongs to this store.
		  
		  //FIXME: this is needed when we support more than one store per OS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateCalendar() As ALCalendar
		  //! Creates a new calendar in this store.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Events(startDate as Date, endDate as Date) As ALCalendarEvent()
		  //! Returns all of the events in all the calendars that occur in a certain time range.
		  //! Note that only spans less than four years are supported. If you specify a range of more than four years,
		  //! your results WILL only span four years.
		  
		  // we're going to have a naive default implementation that just grabs all the events in every calendar
		  // subclasses can offer a more optimized version if they'd like
		  dim results() as ALCalendarEvent
		  for each cal as ALCalendar in calendars
		    for each evt as ALCalendarEvent in cal.events( startDate, endDate )
		      results.append( evt )
		    next
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EventWithUID(uid as string, occurrence as Date = nil) As ALCalendarEvent
		  //! Gets an event by it's unique identifier. Returns nil if there is no event with that ID.
		  //! Occurrence should only be passed if the event is recurring.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyCalendarAdded(uid as string)
		  for each observer as ALCalendarObserver in mCalendarObservers
		    observer.calendarAdded( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyCalendarChanged(uid as string)
		  for each observer as ALCalendarObserver in mCalendarObservers
		    observer.calendarChanged( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyCalendarDeleted(uid as string)
		  for each observer as ALCalendarObserver in mCalendarObservers
		    observer.calendarDeleted( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyEventAdded(uid as string)
		  for each observer as ALCalendarEventObserver in mEventObservers
		    observer.eventAdded( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyEventChanged(uid as string)
		  for each observer as ALCalendarEventObserver in mEventObservers
		    observer.eventChanged( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyEventDeleted(uid as string)
		  for each observer as ALCalendarEventObserver in mEventObservers
		    observer.eventDeleted( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyTaskAdded(uid as string)
		  for each observer as ALCalendarTaskObserver in mTaskObservers
		    observer.taskAdded( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyTaskChanged(uid as string)
		  for each observer as ALCalendarTaskObserver in mTaskObservers
		    observer.taskChanged( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NotifyTaskDeleted(uid as string)
		  for each observer as ALCalendarTaskObserver in mTaskObservers
		    observer.taskDeleted( self, uid )
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCalendarObserver(observer as ALCalendarObserver)
		  //! Removes an object to the list of observers for calendar change notifications.
		  
		  tryRemoveObject( mCalendarObservers, observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveEventObserver(observer as ALCalendarEventObserver)
		  //! Removes an object to the list of observers for event change notifications.
		  
		  tryRemoveObject( mEventObservers, observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTaskObserver(observer as ALCalendarTaskObserver)
		  //! Removes an object to the list of observers for task change notifications.
		  
		  tryRemoveObject( mTaskObservers, observer )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tasks() As ALCalendarTask()
		  //! Returns all tasks on all calendars.
		  
		  // we're going to have a naive default implementation that just grabs all the tasks in every calendar
		  // subclasses can offer a more optimized version if they'd like
		  dim results() as ALCalendarTask
		  for each cal as ALCalendar in calendars
		    for each task as ALCalendarTask in cal.tasks
		      results.append( task )
		    next
		  next
		  
		  return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskWithUID(uid as string) As ALCalendarTask
		  //! Gets a task by it's unique identifier. Returns nil if there is no task with that ID.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TryRemoveObject(arr() as Object, obj as Object)
		  //! Removes an object from an array if it is in the array.
		  //! This is so we don't raise an exception if it isn't actually in the array when we try to remove it.
		  
		  dim idx as integer = arr.indexOf( obj )
		  if idx >= 0 and idx <= arr.ubound then arr.remove( idx )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCalendarObservers() As ALCalendarObserver
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEventObservers() As ALCalendarEventObserver
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTaskObservers() As ALCalendarTaskObserver
	#tag EndProperty


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
End Class
#tag EndClass
