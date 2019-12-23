# ArcInterpolator

### Description
The 'ArcInterpolator' component is an Interpolator for an Animation component which can be used to translate a node in a smooth arc defined by three points.
To utilize this tool,
 - Add an ArcInterpolator to your normal Animation component like you would a Vector2dFieldInterpolator. 
 - Make sure your `fieldToInterp` is a translation field.
 - Assign Vector2Ds to the interpolator's `start`, `middle`, and `end` fields.
 - Ignore both the `key` and `keyValue` fields as those are not used by the `ArcInterpolator`. 

### Usage
| Field | Type | Default | Options | Required | AccessPermission | Description
| fieldToInterp | string | "" | | true | READ_WRITE | Inherited field from the Vector2DFieldInterpolator component. Specifies the field to interpolate. The string should contain the ID of a node in the scene and the name of a field of that node, separated by a dot ".". In this case the field must be "translation". |
| key | array of float's | [ ] | | false | READ_WRITE | Inherited field from the Vector2DFieldInterpolator component. This field is ignored. |
| keyValue | array of float's | [ ] | | false| READ_WRITE | Inherited field from the Vector2DFieldInterpolator component. This field is ignored. |
| fraction | float | 0.0 | | false | READ_WRITE | Specifies the percentage to be used to compute a value for the field |
| reverse | boolean | false | true, false | false |  READ_WRITE | Enables animation to be played in reverse. |
| start | vector2d | [ ] | | true | READ_WRITE | The start point of the animation. Similar to `keyValue[0]` on other interpolators. |
| middle | vector2d | [ ] | | true | READ_WRITE | A point through which the animation will pass on the way from start to end. |
| end | vector2d | [ ] | | true | READ_WRITE | The end point of the animation. |