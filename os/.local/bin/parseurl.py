#!/usr/bin/env python3

"""Parse url for human read
"""

import json
from urllib.parse import parse_qsl, urlparse

import clipboard


def main():
    url = str(clipboard.paste())
    parse = urlparse(url)
    query = dict(parse_qsl(parse.query, True))
    print('Url: %s' % url)
    print('\nProtocol: %s' % parse.scheme)
    print('Host: %s' % parse.netloc)
    print('Port: %s' % (parse.port or 80))
    print('Path: %s' % parse.path)
    print('Query: ')
    print(json.dumps(query, indent=' ' * 4, sort_keys=True))


if __name__ == '__main__':
    main()
