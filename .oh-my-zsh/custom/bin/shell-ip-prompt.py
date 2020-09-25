import netifaces

EXCLUDE_IP = {'127.0.0.1', 'localhost'}


def main():
    IPADDRS = []
    for v in netifaces.interfaces():
        addrs = netifaces.ifaddresses(v)
        addr = addrs.get(netifaces.AF_INET)
        if addr:
            ips = {i['addr'] for i in addr}
            ips -= EXCLUDE_IP
            ips and IPADDRS.append((v, ' '.join(ips)))
    ipaddrs = ['{}={}'.format(*v) for v in sorted(IPADDRS, key=lambda x: x[1])]
    print('  '.join(ipaddrs))


if __name__ == '__main__':
    main()
