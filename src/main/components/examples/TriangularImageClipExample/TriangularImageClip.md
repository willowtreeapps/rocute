# TriangularImageClip

### Description
TriangularImageClip is a way to clip an image to fit in a triangle. As opposed to TriangularCornerClip, 
this triangular clip component will stretch to your image and remain centric on the images center.
To utilize this tool,
 - Ensure the TriangularImageClip directory is in your code.
 - Provide a TriangularImageClip component the required props.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| imageUri | uri | none | any uri | true | READ_WRITE | The uri of an image. |
| height | int | 0 | any int | false | READ_WRITE | The height of the image |
| width | int | 0 | any int | false | READ_WRITE | The width of the image |
| translation | intarray | [0, 0] | any array of two ints | false | READ_WRITE | The location of the iamge on the screen. |