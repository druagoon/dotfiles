#!/usr/bin/env python

"""删除 RabbitMQ 队列
"""

from typing import List

import click
import pika


@click.command(help='删除 RabbitMQ 队列')
@click.option('-q', '--queue', multiple=True, help='queue name')
def main(queue: List[str]):
    params = pika.URLParameters('amqp://mmb:mmb@mq.mmbang.me:15673/mmb')
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    for q in queue:
        channel.queue_delete(queue=q)
    connection.close()


if __name__ == '__main__':
    main()
