' Initialization method for the NavBarExample component
sub init()
    m.navBar = m.top.findNode("navBar")
    m.container = m.top.findNode("container")
    ' set focus when we enter this panel
    m.top.observeField("focusedChild", "setDefaultFocus")
    ' create and show the displayed node when navigation changes
    m.navBar.observeField("createNextPanelIndex", "setPanel")
    ' show a default node
    m.displayedNode = createObject("roSGNode", "ExampleNode")
    m.displayedNode.text = "HOME"
    m.container.appendChild(m.displayedNode)
end sub

' Method to set focus on the content when the NavBarExample panel gets focus. 
'
' @param event a roSGNodeEvent
sub setDefaultFocus(event as object)
    if m.top.isInFocusChain() = true and m.displayedNode.isInFocusChain() = false and m.navBar.isInFocusChain() = false then
        m.displayedNode.setFocus(true)
    end if
end sub

' A method to set the correct content when a different item in the nav bar is selected. It is called when the createNextPanelIndex field of the HorizontalNavBar component changes.
'
' @param event a roSGNodeEvent
sub setPanel(event as object)
    index = event.getData()
    m.displayedNode = createObject("roSGNode", "ExampleNode")
    if index = 0 then
        m.displayedNode.text="HOME"        
    else if index = 1 then
        m.displayedNode.text="MOVIES"
    else if index = 2 then
        m.displayedNode.text="TELEVISION"
    else if index = 3 then
        m.displayedNode.text="SETTINGS"
    else if index = 4 then
        m.displayedNode.text="ACCOUNT"
    end if
    m.container.replaceChild(m.displayedNode, 0)
    m.displayedNode.setFocus(true)
end sub

' Method to handle key events inside of the NavBarExample component. This determines when to focus on the navBar and when to focus on the content.
'
' @param key the key which was pressed
' @param press true if the key was depressed and false if it was released
sub onKeyEvent(key as string, press as boolean)
    if m.displayedNode.isInFocusChain() = true and key = "up" and press = true then
        m.navBar.setFocus(true)
    else if m.navBar.isInFocusChain() = true and (key = "down" or key = "OK") and press = true then
        m.displayedNode.setFocus(true)
    end if
 end sub