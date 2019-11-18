sub init()
    m.grid = m.top.findNode("grid")
    m.grid.numColumns = 5
    'm.grid.rowSpacings = [0]
    ' setup readonly fields
    m.grid.observeField("itemUnfocused", "readOnlyFieldChanged")
    m.grid.observeField("itemSelected", "readOnlyFieldChanged")
    m.grid.observeField("itemFocused", "readOnlyFieldChanged")
    'm.grid.observeField("createNextPanelIndex", "readOnlyFieldChanged")
    m.grid.setFocus(true)
    m.top.observeField("focusedChild", "focusChanged")
end sub

sub focusChanged(event as object)
    if m.top.hasFocus() = true then
        m.grid.setFocus(true)
    end if
end sub

sub readOnlyFieldChanged(event as object)
    fieldName = event.getField()
    value = event.getData()
    m.top[fieldName] = value
    if fieldName="itemFocused" and m.top.createNextPanelOnItemFocus = true then
        m.top.createNextPanelIndex = value
    else if fieldName="itemSelected" and m.top.createNextPanelOnItemSelect = true then
        m.top.createNextPanelIndex = value
    end if
end sub

sub showPanel(event as Object)
    if m.top.createNextPanelOnItemFocus = false and m.top.createNextPanelOnItemSelect = false then return
    panel = event.getData()
    if m.panelSet = invalid then
        m.panelSet = createObject("roSGNode", "PanelSet")
        m.top.appendChild(m.panelSet)
    end if
    m.panelSet.appendChild(panel)
end sub

sub setInnerField(event as Object)
    fieldName = event.getField()
    value = event.getData()
    if fieldName = "numItems" then
        fieldName = "numColumns"
    else if fieldName = "itemWidths" then
        fieldName = "columnWidths"
    else if fieldName = "itemSpacings" then
        fieldName = "columnSpacings"
    end if
    m.grid[fieldName] = value
end sub

sub setHeight(event as Object)
    value = event.getData()
    m.grid.rowHeights = [value]
end sub