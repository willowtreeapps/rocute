sub init()
    ' Scene Generation
    CardRotatorList = m.top.findNode("CardRotatorList")
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    CardRotatorList.focusedTargetSet = focusedTargetSet
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 200, height: 100 },
        { x: 200, y: 200, width: 200, height: 100 },
        { x: 0, y: 400, width: 200, height: 100 },
    ]
    CardRotatorList.targetSet = focusedTargetSet
    CardRotatorList.showTargetRects = false
    ' Content Generation
    CardRotatorList.itemComponentName = "CardRotatorItem"
    dataModel = setUpDataModel()
    CardRotatorList.content = dataModel
    ' Focus Control
    m.CardRotatorList = m.top.findNode("CardRotatorList")
    m.CardRotatorList.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

function setUpDataModel()
    ' generate content
    contentRoot = createObject("roSGNode", "ContentNode")
    for i = 0 to 5
        child = contentRoot.createChild("ContentNode")
        child.title = "Item " + i.tostr()
    end for
    return contentRoot
end function

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.CardRotatorList.setFocus(true)
    end if
end sub