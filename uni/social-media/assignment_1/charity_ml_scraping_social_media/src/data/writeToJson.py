import json
from src.common.util import *

def writeToJson(
    data,
    overwrite = False
    ):

    # Read the data from the file
    with open('data.json') as data_file:    
        old_data = json.load(data_file)

    # check it's not duplicate data:
    # we could update this to compare a row of ids if this becomes too expensive
    if (old_data != data):
        # Then append data to the old data:
        data = old_data + data
    
        # Then rewrite the whole file
        with open('data.json', 'w') as outfile:
            json.dump(data, outfile, indent=4)
