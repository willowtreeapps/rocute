sub init()
    list = m.top.findNode("componentList")
    m.top.list = list
    m.top.observeField("createNextPanelIndex", "createNextPanel")
end sub

sub createNextPanel()
    if m.top.createNextPanelIndex = 0 then
        m.top.nextPanel = createObject("roSGNode", "TiledBackgroundExample")
    else if m.top.createNextPanelIndex = 1 then
        m.top.nextPanel = createObject("roSGNode", "ArcInterpolatorExample")
    else if m.top.createNextPanelIndex = 2 then
        m.top.nextPanel = createObject("roSGNode", "ResizeListListPanelExample")
    else if m.top.createNextPanelIndex = 3 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredListListPanelExample")
    else if m.top.createNextPanelIndex = 4 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredFontListListPanelExample")
    end if
end sub