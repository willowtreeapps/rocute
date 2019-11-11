sub init()
    list = m.top.findNode("componentList")
    m.top.list = list
    m.top.observeField("createNextPanelIndex", "createNextPanel")
end sub

sub createNextPanel()
    if m.top.createNextPanelIndex = 0 then
        m.top.nextPanel = createObject("roSGNode", "TiledBackgroundExample")
    end if
end sub