sub init()
    list = m.top.findNode("componentList")
    m.top.list = list
    m.top.observeField("createNextPanelIndex", "createNextPanel")
end sub

sub createNextPanel(event as object)
    index = event.getData()
    if index = 0 then
        m.top.nextPanel = createObject("roSGNode", "TiledBackgroundExample")
    else if index = 1 then
        m.top.nextPanel = createObject("roSGNode", "ArcInterpolatorExample")
    else if index = 2 then
        m.top.nextPanel = createObject("roSGNode", "ResizeListListPanelExample")
    else if index = 3 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredListListPanelExample")
    else if index = 4 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredFontListListPanelExample")
    else if index = 5 then
        m.top.nextPanel = createObject("roSGNode", "NavBarExample")
    else if index = 6 then
        m.top.nextPanel = createObject("roSGNode", "DisappearingLogoExample")
        ' else if index = NUMBERHERE then
        '     m.top.nextPanel = createObject("roSGNode", "NextExampleComponent")
    end if
end sub