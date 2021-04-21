#!/bin/bash

### Beyond Compare 试用期重置 ###

APP_DIR="/Applications/Beyond Compare.app/Contents/MacOS"

cd "$APP_DIR" || exit
mv BCompare BCompare.bak
cat >>BCompare <<EOF
#!/bin/bash
rm "\$HOME/Library/Application Support/Beyond Compare/registry.dat"
"\`dirname "\$0"\`"/BCompare.bak \$@
EOF
chmod +x BCompare
