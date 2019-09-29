import csv
import json
import os
os.chdir('/Users/phil/code/data-science-next/uni/social-media/ass01_charity_ml_scraping_social_media')

def convert_csv_to_json(
    file,
    fieldnames
    # out = 'data_from_csv.json'
    ):

    csvfile = open(file +'.csv', 'r')
    jsonfile = open(file + '.json', 'w')
    
    # fieldnames = ("FirstName","LastName","IDNumber","Message")
    reader = csv.DictReader( csvfile, fieldnames)
    for row in reader:
        json.dump(row, jsonfile)
        jsonfile.write('\n')

    print('Convert csv to json')

    # FIXME: this doesn't create/load valid json.
    # To create valid json:
    # - There are no commas on the end 
    # - It needs to be wrapped in []
    # eg.
    # [{
      # "full_text": "foo",
      # "date": "2019-08-30 13:44:05",
      # "id": "17704559"
    # }, {
      # "full_text": "bar",
      # "date": "2019-08-30 13:44:03",
      # "id": "783064063"
    # }]