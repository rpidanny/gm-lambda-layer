# gm-lambda-layer

AWS Lambda layer with GraphicsMagick binaries.

## Usage

Click on Layers and choose `Add a layer`, and `Provide a layer version ARN` and enter the following ARN (replace eu-west-1 with the region of your Lambda):

```
arn:aws:lambda:eu-west-1:175033217214:layer:graphicsmagick:1
```

![Provide layer ARN](img/usage.png "Provide layer ARN screenshot")

## Version ARNs

| GraphicsMagick version | ARN |
| --- | --- |
| 1.3.31 | `arn:aws:lambda:<region>:175033217214:layer:graphicsmagick:1` |
