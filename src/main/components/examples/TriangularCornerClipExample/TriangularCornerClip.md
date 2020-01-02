# TriangularCornerClip

### Description
TriangularCornerClip is a way to clip an image to fit into the bounds of a right triangle. In the event you 
want to clip the corner of a scene or image with another image, or want to have an image shown as a right 
triangle programmatically, this component fits the use case.
 - Ensure the TriangularCornerClip directory is in your code.
 - Provide a TriangularCornerClip component the required props.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| imageUri | uri | none | any uri | true | READ_WRITE | The uri of an image. |
| rightAnglePosition | string | topRight | topRight, topLeft, bottomLeft, bottomRight | false | READ_WRITE | The positioning of the right angle of the triangle. |
| height | int | 0 | any int | false | READ_WRITE | The height of the image |
| width | int | 0 | any int | false | READ_WRITE | The width of the image |
| translation | intarray | [0, 0] | any array of two ints | false | READ_WRITE | The location of the image on the screen. |