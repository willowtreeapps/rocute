sub init()
    m.navBar = m.top.findNode("navBar")
    m.container = m.top.findNode("container")
    ' set focus when we enter this panel
    m.top.observeField("focusedChild", "setDefaultFocus")
    m.navBar.observeField("createNextPanelIndex", "setPanel")
    ' show a default panel
    m.panel = createObject("roSGNode", "ExamplePanel")
    m.panel.text = "HOME"
    m.container.appendChild(m.panel)
end sub

sub setDefaultFocus(event as object)
    print event.getField()
    print event.getData()
    if m.top.isInFocusChain() = true and m.panel.isInFocusChain() = false and m.navBar.isInFocusChain() = false then
        m.panel.setFocus(true)
    end if
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
    m.container.replaceChild(m.panel, 0)
    m.panel.setFocus(true)
end sub

function defaultData() as integer
    return 0
end function

sub onKeyEvent(key as string, press as boolean)
    if m.panel.isInFocusChain() = true and key = "up" and press = true then
        m.navBar.setFocus(true)
    else if m.navBar.isInFocusChain() = true and (key = "down" or key = "OK") and press = true then
        m.panel.setFocus(true)
    end if
 end sub