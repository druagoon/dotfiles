# -*- coding: utf-8 -*-

import os
import sys

PY3 = sys.version_info.major == 3


if PY3:
    string_types = str,
    text_type = str
    binary_type = bytes
else:
    reload(sys)
    sys.setdefaultencoding('utf-8')

    string_types = basestring,
    text_type = unicode
    binary_type = str

TRUE_VALUES = ['1', 'ON', 'TRUE']


def is_true(value):
    # type: (string_types) -> bool
    value = str(value)
    return value.upper() in TRUE_VALUES


def echo(s, end=None):
    # type: (str, str) -> None
    if end is None:
        end = os.linesep
    sys.stdout.write(s + end)
    sys.stdout.flush()


def ensure_text(s, encoding='utf-8', errors='strict'):
    """Coerce *s* to six.text_type.

    For Python 2:
      - `unicode` -> `unicode`
      - `str` -> `unicode`

    For Python 3:
      - `str` -> `str`
      - `bytes` -> decoded to `str`
    """
    if isinstance(s, binary_type):
        return s.decode(encoding, errors)
    elif isinstance(s, text_type):
        return s
    else:
        raise TypeError("not expecting type '%s'" % type(s))
