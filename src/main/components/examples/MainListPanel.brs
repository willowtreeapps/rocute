sub init()
    list = m.top.findNode("componentList")
    m.top.list = list
    m.top.observeField("createNextPanelIndex", "createNextPanel")
end sub

sub createNextPanel(event as object)
    index = event.getData()
    if index = 0 then
        m.top.nextPanel = createObject("roSGNode", "ArcInterpolatorExample")
    else if index = 1 then
        m.top.nextPanel = createObject("roSGNode", "BounceEffectExampleComponent")
    else if index = 2 then
        m.top.nextPanel = createObject("roSGNode", "CardRotatorExampleComponent")
    else if index = 3 then
        m.top.nextPanel = createObject("roSGNode", "CardZoomDiagonalExampleComponent")
    else if index = 4 then
        m.top.nextPanel = createObject("roSGNode", "CardZoomRotaryExampleComponent")
    else if index = 5 then
        m.top.nextPanel = createObject("roSGNode", "CircularImageClipExampleComponent")
    else if index = 6 then
        m.top.nextPanel = createObject("roSGNode", "ClockExample")
    else if index = 7 then
        m.top.nextPanel = createObject("roSGNode", "DatePickerExample")
    else if index = 8 then
        m.top.nextPanel = createObject("roSGNode", "DisappearingLogoExample")
    else if index = 9 then
        m.top.nextPanel = createObject("roSGNode", "DisappearingNavExample")
    else if index = 10 then
        m.top.nextPanel = createObject("roSGNode", "HorizontalCardRotatorExampleComponent")
    else if index = 11 then
        m.top.nextPanel = createObject("roSGNode", "NavBarExample")
    else if index = 12 then
        m.top.nextPanel = createObject("roSGNode", "LiveIconExample")
    else if index = 13 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredFontListListPanelExample")
    else if index = 14 then
        m.top.nextPanel = createObject("roSGNode", "RandomColoredListListPanelExample")
    else if index = 15 then
        m.top.nextPanel = createObject("roSGNode", "RatingIconExample")
    else if index = 16 then
        m.top.nextPanel = createObject("roSGNode", "ResizeListListPanelExample")
    else if index = 17 then
        m.top.nextPanel = createObject("roSGNode", "TickerExample")
    else if index = 18 then
        m.top.nextPanel = createObject("roSGNode", "TiledBackgroundExample")
    else if index = 19 then
        m.top.nextPanel = createObject("roSGNode", "TriangularCornerClipExampleComponent")
    else if index = 20 then
        m.top.nextPanel = createObject("roSGNode", "TriangularImageClipExampleComponent")
        ' else if index = NUMBERHERE then
        '     m.top.nextPanel = createObject("roSGNode", "NextExampleComponent")
    end if
end sub