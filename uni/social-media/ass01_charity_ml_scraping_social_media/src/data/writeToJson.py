import json
from src.common.util import *

def writeToJson(
    data,
    overwrite = False
    ):
    """
    @summary: Write short and full_text version of tweet to json file `data.json`.
    @author:  Phil S phil@tgrrr.com
    
    @param    data: Description of parameter `data`.
    @type:    dict

    @param    If True, it will clear and `overwrite` the data_file.
    @type:    bool

    @return:  None

    """

    with open('data.json', 'w') as outfile:
        json.dump(data, outfile, indent=4)

    # FIXME: allow custom filename
    # FIXME: error handling
    # FIXME: create new data file

    # FIXME: check for empty data.json file
    # # Read the data from the file
    # with open('data.json') as data_file:
    #     old_data = json.load(data_file)
    # 
    # # check it's not duplicate data:
    # # we could update this to compare a row of ids if this becomes too expensive
    # if (old_data != data):
    #     # Then append data to the old data:
    #     data = old_data + data
    #     print('data' + data)
    
        # # Then rewrite the whole file
        # with open('data.json', 'w') as outfile:
        #     json.dump(data, outfile, indent=4)