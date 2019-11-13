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
    else if m.top.createNextPanelIndex = 2 then
        m.top.nextPanel = createObject("roSGNode", "StyledListTwoListPanelExample")
    else if m.top.createNextPanelIndex = 3 then
        m.top.nextPanel = createObject("roSGNode", "StyledListThreeListPanelExample")
    end if
end sub