sub init()
    m.navBar = m.top.findNode("navBar")
    'm.panelSet = m.top.findNode("panelSet")
    'm.navBar.panelSet = panelSet
    'm.navBar.observeField("itemSelected_RDO", "setPanel")
    content = createObject("roSGNode", "navBarItem")
    m.navBar.content = content
end sub

sub setPanel(event as object)
    index = event.getData()
    if index = 0 then
        m.panel = createObject("examplePanel")
        m.panel.text="HOME"
        m.navBar.nextPanel=m.panel
    else if index = 1 then
        m.panel = createObject("examplePanel")
        m.panel.text="MOVIES"
        m.navBar.nextPanel=m.panel
    else if index = 2 then
        m.panel = createObject("examplePanel")
        m.panel.text="TELEVISION"
        m.navBar.nextPanel=m.panel
    else if index = 3 then
        m.panel = createObject("examplePanel")
        m.panel.text="SETTINGS"
        m.navBar.nextPanel=m.panel
    else if index = 4 then
        m.panel = createObject("examplePanel")
        m.panel.text="ACCOUNT"
        m.navBar.nextPanel=m.panel
    end if
end sub