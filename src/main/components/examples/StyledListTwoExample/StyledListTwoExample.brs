sub init()
    ' Setup
    list = m.top.findNode("StyledListTwoExample")
    ' Generate content for list
    content = createObject("RoSGNode", "ContentNode")
    itemOne = content.createChild("ContentNode")
    itemOne.title = "Item 1"
    itemTwo = content.createChild("ContentNode")
    itemTwo.title = "Item 2"
    itemThree = content.createChild("ContentNode")
    itemThree.title = "Item 3"
    itemFour = content.createChild("ContentNode")
    itemFour.title = "Item 4"
    itemFive = content.createChild("ContentNode")
    itemFive.title = "Item 5"
    ' Set content
    list.content = content
    m.top.list = list
end sub