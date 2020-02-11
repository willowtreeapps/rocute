' Sets m.fieldName equal to the value in the roSGNodeEvent. Useful for TestLayer components, so that you can use this as the onChange function for m.top.fieldName.
' @param event a roSGNodeEvent
sub setFieldOnM(event as object)
    fieldName = event.getField()
    m[fieldName] = event.getData()
end sub

' Similar to setFieldOnM, but specifically for datetime fields. The data in the event should be in seconds (m.top.fieldName), but the value set will be a roDateTime (m.fieldName)
' @param event a roSGNodeEvent
sub setDateTimeFieldOnM(event as object)
    fieldName = event.getField()
    timeInSeconds = event.getData()
    dateTimeObj = createObject("roDateTime")
    dateTimeObj.fromSeconds(timeInSeconds)
    m[fieldName] = dateTimeObj
end sub