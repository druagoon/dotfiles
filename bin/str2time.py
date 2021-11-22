#!/usr/bin/env python

"""Parse date string to timestamp
"""

import datetime
import sys
import time

import clipboard

FORMAT = ['%Y-%m-%d %H:%M:%S', '%Y%m%d%H%M%S', '%Y-%m-%d', '%Y%m%d']


def main():
    for v in sys.argv[1:]:
        dt = None
        for fmt in FORMAT:
            try:
                dt = datetime.datetime.strptime(v, fmt)
            except:
                pass
            else:
                break
        if dt:
            timestamp = int(time.mktime(dt.timetuple()))
            clipboard.copy(str(timestamp))
            print('{} -> {}'.format(v, timestamp))


if __name__ == '__main__':
    main()
