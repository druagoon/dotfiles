#!/usr/bin/env python

"""复利计算(表格形式输出)

Usage: compound-interest.py -p 1000000 -i 5 -c 12 -n 30
"""

import click
from tabulate import tabulate

headers = ['年数', '现值', '年利率', '计息期数', '终值', '收益', '总收益', '总收益比']


def percent(value: float, fmt: str = '.2f') -> str:
    value = float(value)
    # rv = f'{value: {fmt}}'.rstrip('0').rstrip('.')
    rv = f'{value: {fmt}}'
    return f'{rv}%'


def calc_compound_interest(present: float, interest: float, periods: int = 1, n: int = 1) -> float:
    tables = []
    principal = present
    for j in range(1, n + 1):
        future = present * pow(1 + interest / 100.0 / periods, periods)
        earnings = future - present
        total_earnings = future - principal
        total_earnings_rate = round((total_earnings / principal) * 100, 2)
        row = [
            j,
            present,
            f'{percent(interest)}',
            periods,
            future,
            earnings,
            total_earnings,
            f'{percent(total_earnings_rate)}',
        ]
        tables.append(row)
        present = future
    return tabulate(tables, headers=headers, floatfmt='.2f', tablefmt='grid')


@click.command(help='复利计算')
@click.option('-p', '--present', type=float, help='现值')
@click.option('-i', '--interest', type=float, help='年利率(百分比)')
@click.option('-c', '--periods', type=int, default=1, help='计息期数')
@click.option('-n', type=int, default=1, help='年数')
def main(present: float, interest: float, periods: int, n: int):
    output = calc_compound_interest(present, interest, periods, n)
    print(output)


if __name__ == '__main__':
    main()
