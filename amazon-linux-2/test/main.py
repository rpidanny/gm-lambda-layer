import os

def handler (event, context):
  os.system("gm version")
  os.system("gm convert -list formats")
  os.system("gm convert -list fonts")
  return os.system('gm convert -font Courier -fill white -draw "rotate 20 text 10,10 Hello-World" image1.jpg /tmp/gm-test-output.jpg')
