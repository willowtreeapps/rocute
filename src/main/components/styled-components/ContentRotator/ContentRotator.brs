sub init()
    ' Scene Generation
    ContentRotatorList = m.top.findNode("ContentRotatorList")
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    ContentRotatorList.focusedTargetSet = focusedTargetSet
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 200, height: 100 },
        { x: 200, y: 200, width: 200, height: 100 },
        { x: 0, y: 400, width: 200, height: 100 },
    ]
    ContentRotatorList.targetSet = focusedTargetSet
    ContentRotatorList.showTargetRects = false
    ' Content Generation
    ContentRotatorList.itemComponentName = "ContentRotatorItem"
    dataModel = setUpDataModel()
    ContentRotatorList.content = dataModel
    ' Focus Control
    m.ContentRotatorList = m.top.findNode("ContentRotatorList")
    m.ContentRotatorList.setFocus(true)
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
        m.ContentRotatorList.setFocus(true)
    end if
end sub