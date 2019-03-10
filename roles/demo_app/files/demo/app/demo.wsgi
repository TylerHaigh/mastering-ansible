activate_this = '/var/www/demo/venv34/bin/activate_this.py'

# Removed in python 3
# execfile(activate_this, dict(__file__=activate_this))
exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))


import os
os.environ['DATABASE_URI'] = 'mysql://tyler:tylerlocalhost@192.168.60.6/demo'

import sys
sys.path.insert(0, '/var/www/demo')

from demo import app as application
