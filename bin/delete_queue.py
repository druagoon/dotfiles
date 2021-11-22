#!/usr/bin/env python

"""Delete RabbitMQ Queue
"""

from typing import List

import click
import pika


@click.command(help='Delete RabbitMQ Queue')
@click.option('-n', '--name', multiple=True, help='queue name')
def main(name: List[str]):
    params = pika.URLParameters('amqp://mmb:mmb@mq.mmbang.me:15673/mmb')
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    for q in name:
        channel.queue_delete(queue=q)
    connection.close()


if __name__ == '__main__':
    main()
