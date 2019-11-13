sub init()
    list = m.top.findNode("componentList")
    m.top.list = list
    m.top.observeField("createNextPanelIndex", "createNextPanel")
end sub

sub createNextPanel()
    if m.top.createNextPanelIndex = 0 then
        m.top.nextPanel = createObject("roSGNode", "TiledBackgroundExample")
    else if m.top.createNextPanelIndex = 1 then
        m.top.nextPanel = createObject("roSGNode", "StyledListOneListPanelExample")
    end if
end sub