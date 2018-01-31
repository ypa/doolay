#!/usr/bin/env python

import time
import requests
from bs4 import BeautifulSoup

def get_content(url):
    response = requests.get(url)
    response.raise_for_status()
    return response.text

def parse_rows(table):
    return table.tbody.find_all('tr')

def parse_columns(row):
    columns = row.find_all('td')
    for col in columns:
        col_text = col.get_text()
        yield col_text.strip()

def get_last_pagenator(body_main):
    pager_ul = body_main.find('ul', {'class': 'pager'})
    pagenators = pager_ul.find_all('a')
    return pagenators[-1]


def get_search_url(search_term):
    return 'https://www.dica.gov.mm/en/company-search?company={}'.format(search_term)

def get_page_num(pagenator):
    return int(pagenator.attrs['href'].split('&page=')[-1])


def construct_search_result_urls(search_url, last_page_num):

    yield search_url

    for page_num in range(1, last_page_num +1):
        yield '{}&page={}'.format(search_url, page_num)

def main():
    search_url = get_search_url('tour')
    search_content = get_content(search_url)
    search_bs = BeautifulSoup(search_content)
    last_pagenator = get_last_pagenator(search_bs.html.body.main)
    last_page_num = get_page_num(last_pagenator)
    result_urls = construct_search_result_urls(search_url, last_page_num)
    for url in result_urls:
        print(url)




    # print_rows(search_bs)


def print_rows(bs):

    rows = parse_rows(bs.html.body.table)
    for row in rows:
        columns = parse_columns(row)
        print(' '.join(col for col in columns))

if __name__ == '__main__':
    main()

