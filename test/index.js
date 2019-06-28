const { execSync } = require('child_process')

exports.handler = async (event) => {
  execSync('gm version', { encoding: 'utf8', stdio: 'inherit' })

  execSync('gm convert -list formats', { encoding: 'utf8', stdio: 'inherit' })

  execSync('gm convert -list fonts', { encoding: 'utf8', stdio: 'inherit' })

  execSync('gm convert -font Courier -fill white -draw "rotate 20 text 10,10 Hello-World" image1.jpg /tmp/gm-test-output.jpg', { encoding: 'utf8', stdio: 'inherit' })
}
