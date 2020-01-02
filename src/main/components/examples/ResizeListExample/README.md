# ResizeList

### Description
ResizeList is a LabelList component that will resize so the currently selected element 
takes up more space.
To utilize this tool,
 - Ensure the ResizeList directory is in your code.
 - Provide a ResizeList component the required props.
 - Programmatically provide the contents of the list to the component as outlined in 
 ResizeListExample.brs.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| expandedHeight | int | none | any int | false | READ_WRITE | The height the selected field will expand to. |