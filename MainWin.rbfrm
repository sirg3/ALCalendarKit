#tag Window
Begin Window MainWin Implements ALCalendarEventObserver
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   466
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1314372812
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   True
   Title           =   "Events This Year"
   Visible         =   True
   Width           =   561
   Begin PushButton viewLogButton
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "View Log"
      Default         =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   265
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   ""
      LockRight       =   True
      LockTop         =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   426
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton addEventButton
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Add Event"
      Default         =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   455
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   ""
      LockRight       =   True
      LockTop         =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   426
      Underline       =   ""
      Visible         =   True
      Width           =   86
   End
   Begin TextArea eventsField
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   16777215
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   400
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   20
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   ""
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   521
   End
   Begin PushButton addTaskButton
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Add Task"
      Default         =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   357
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   ""
      LockRight       =   True
      LockTop         =   ""
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   426
      Underline       =   ""
      Visible         =   True
      Width           =   86
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  store.removeEventObserver( self )
		  
		  quit()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  ALCalendarKit.initialize()
		  store = ALCalendarKit.systemStore
		  
		  store.addEventObserver( self )
		  reloadEvents()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			close()
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Sub AddLine(text as string)
		  eventsField.appendText( text + endOfLine )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CompleteUpdate(store as ALCalendarStore)
		  reloadEvents()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventAdded(store as ALCalendarStore, uid as string)
		  reloadEvents()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventChanged(store as ALCalendarStore, uid as string)
		  reloadEvents()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventDeleted(store as ALCalendarStore, uid as string)
		  reloadEvents()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ReloadEvents()
		  // set the start date to the first day of the year
		  dim startDate as new Date()
		  startDate.month = 1
		  startDate.day = 1
		  
		  // set the end date to a year after the start date
		  dim endDate as new Date( startDate )
		  endDate.year = endDate.year + 1
		  
		  eventsField.text = ""
		  for each evt as ALCalendarEvent in store.events( startDate, endDate )
		    addLine( evt.startDate.sqlDate + " -> " + evt.title + " (" + evt.uid +")" )
		  next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		store As ALCalendarStore
	#tag EndProperty


#tag EndWindowCode

#tag Events viewLogButton
	#tag Event
		Sub Action()
		  dim logWin as new ObserverLogWin( store )
		  logWin.show()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events addEventButton
	#tag Event
		Sub Action()
		  dim w as new AddEventWin( store )
		  w.showWithin( self )
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events addTaskButton
	#tag Event
		Sub Action()
		  dim w as new AddTaskWin( store )
		  w.showWithin( self )
		End Sub
	#tag EndEvent
#tag EndEvents
