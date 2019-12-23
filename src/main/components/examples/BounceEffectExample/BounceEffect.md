# BounceEffect

### Description
A customizable bounce which can be applied to any image.
To utilize this tool,
 - Ensure the BounceEffect directory is in your code.
 - Provide a BounceEffect component the required props.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| imageUri | uri | none | any file path | true | READ_WRITE | The image path. |
| startPoint | intarray | [0, 0] | any array of two ints | false | READ_WRITE | The translation point at which the image will begin. |
| maxHeight | int | 50 | any int | false | READ_WRITE | The maximum height a bounce will reach |
| bounceType | string | descending | ascending, descending, steady | false | READ_WRITE | The type of pattern the bounce will follow. |
| totalBounces | int | 3 | any int | false | READ_WRITE | The total number of bounces to occur. |
| duration | int | 3 | any int | false | READ_WRITE | How long the total animation will take. |
| repeat | boolean | false | true, false | false | READ_WRITE | Wether or not the animation will repeat. |