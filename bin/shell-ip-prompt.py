#!/usr/bin/env python

import netifaces

EXCLUDE_IP = {'127.0.0.1', 'localhost'}


def main():
    IPADDRS = []
    for v in netifaces.interfaces():
        addresses = netifaces.ifaddresses(v)
        addr = addresses.get(netifaces.AF_INET)
        if addr:
            ips = {i['addr'] for i in addr}
            ips -= EXCLUDE_IP
            ips and IPADDRS.append((v, ' '.join(ips)))
    output = ['{}={}'.format(*v) for v in sorted(IPADDRS, key=lambda x: x[1])]
    print('  '.join(output))


if __name__ == '__main__':
    main()
