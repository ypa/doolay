#!/usr/bin/env python

from os.path import dirname, abspath, join
import csv
import time
import requests
from bs4 import BeautifulSoup


SEARCH_URL_TMPL = 'https://www.dica.gov.mm/en/company-search?company={}'
DATA_DIR = join(dirname(abspath(__file__)), '..', 'data')


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
    return SEARCH_URL_TMPL.format(search_term)

def get_page_num(pagenator):
    return int(pagenator.attrs['href'].split('&page=')[-1])


def write_to_csv(file_path, rows):
    with open(file_path, 'w', newline='', encoding='utf-8') as csv_file:
        writer = csv.writer(csv_file, delimiter='|')
        writer.writerows(rows)


def get_rows(bs):
    rows = parse_rows(bs.html.body.table)
    for row in rows:
        yield list(map(capitalize, parse_columns(row)))


def construct_search_result_urls(search_url, last_page_num):

    yield search_url

    for page_num in range(1, last_page_num +1):
        yield '{}&page={}'.format(search_url, page_num)


def capitalize(title):
    return ' '.join(s.capitalize() for s in title.split(' '))


def fetch_search_results(search_term):
    search_url = get_search_url(search_term)
    search_content = get_content(search_url)
    search_bs = BeautifulSoup(search_content)
    last_pagenator = get_last_pagenator(search_bs.html.body.main)
    last_page_num = get_page_num(last_pagenator)
    result_urls = construct_search_result_urls(search_url, last_page_num)


    for url in result_urls:
        print('Fetching results for {}'.format(url))
        content = get_content(url)
        bs = BeautifulSoup(content)

        for row in get_rows(bs):
            yield row

        time.sleep(1)


def main():
    search_term = 'tour'
    out_file_path = join(DATA_DIR, '{}.csv'.format(search_term))
    results = fetch_search_results(search_term)
    write_to_csv(out_file_path, results)

if __name__ == '__main__':
    main()

