#tag Window
Begin Window ObserverLogWin Implements ALCalendarObserver,ALCalendarEventObserver,ALCalendarTaskObserver
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   300
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1314372812
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   4
   Resizeable      =   True
   Title           =   "Change Observer"
   Visible         =   True
   Width           =   300
   Begin TextArea logField
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      BackColor       =   16777215
      BehaviorIndex   =   0
      Bold            =   ""
      Border          =   True
      ControlOrder    =   0
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   266
      HelpTag         =   ""
      Index           =   2147483648
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
      Password        =   ""
      ReadOnly        =   True
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   ""
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      Top             =   14
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   260
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  store.removeCalendarObserver( self )
		  store.removeEventObserver( self )
		  store.removeTaskObserver( self )
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  store.addCalendarObserver( self )
		  store.addEventObserver( self )
		  store.addTaskObserver( self )
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			close()
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Sub AddLine(line as string)
		  logField.appendText( line + endOfLine )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarAdded(store as ALCalendarStore, uid as string)
		  addLine( "Calendar added" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarChanged(store as ALCalendarStore, uid as string)
		  addLine( "Calendar changed" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalendarDeleted(store as ALCalendarStore, uid as string)
		  addLine( "Calendar deleted" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(store as ALCalendarStore)
		  self.store = store
		  
		  // Calling the overridden superclass constructor.
		  super.window()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventAdded(store as ALCalendarStore, uid as string)
		  addLine( "Event added" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventChanged(store as ALCalendarStore, uid as string)
		  addLine( "Event changed" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventDeleted(store as ALCalendarStore, uid as string)
		  addLine( "Event deleted" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TaskAdded(store as ALCalendarStore, uid as string)
		  addLine( "task added" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TaskChanged(store as ALCalendarStore, uid as string)
		  addLine( "task changed" )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TaskDeleted(store as ALCalendarStore, uid as string)
		  addLine( "task deleted" )
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		store As ALCalendarStore
	#tag EndProperty


#tag EndWindowCode

