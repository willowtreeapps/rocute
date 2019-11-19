sub init()
    m.navBar = m.top.findNode("navBar")
    m.panelSet = m.top.findNode("panelSet")
    m.navBar.observeField("createNextPanelIndex", "setPanel")
    ' show a default panel
    event = createObject("roAssociativeArray")
    event.getData = defaultData
    setPanel(event)
end sub

sub setPanel(event as object)
    index = event.getData()
    m.panel = createObject("roSGNode", "ExamplePanel")
    if index = 0 then
        m.panel.text="HOME"        
    else if index = 1 then
        m.panel.text="MOVIES"
    else if index = 2 then
        m.panel.text="TELEVISION"
    else if index = 3 then
        m.panel.text="SETTINGS"
    else if index = 4 then
        m.panel.text="ACCOUNT"
    end if
    if m.panelSet.getChildCount() > 0 then
        m.panelSet.replaceChild(m.panel, 0)
    else
        m.panelSet.appendChild(m.panel)
    end if
    m.panel.setFocus(true)
end sub

function defaultData() as integer
    return 0
end function

sub onKeyEvent(key as string, press as boolean)
    if m.panel <> invalid and m.panel.hasFocus() = true and key = "up" and press = true then
        print "Set focus on m.navBar"
        m.navBar.setFocus(true)
    else if m.panel <> invalid and m.navBar.isInFocusChain() = true and (key = "down" or key = "OK") and press = true then
        m.panel.setFocus(true)
    end if
 end sub