sub init()
    m.grid = m.top.findNode("grid")
    m.grid.numColumns = 5
    ' setup readonly fields
    m.grid.observeField("itemUnfocused", "readOnlyFieldChanged")
    m.grid.observeField("itemSelected", "readOnlyFieldChanged")
    m.grid.observeField("itemFocused", "readOnlyFieldChanged")
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

sub setInnerField(event as object)
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

sub setHeight(event as object)
    value = event.getData()
    m.grid.rowHeights = [value]
end sub