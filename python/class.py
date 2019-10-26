
trying to reload modules:

convert_csv_to_json()

# from src.common import convert_csv_to_json # fetchTweets
# 
# convert_csv_to_json.convert_csv_to_json()

importlib.reload(src.util)

convert_csv_to_json.convert_csv_to_json()

# 

import importlib
# # import src.common.util
from src.common import util # fetchTweets

util.convert_csv_to_json()

importlib.reload(util)

util.convert_csv_to_json()


---------------------------------

how a class should look

# class Convert:
#     def __init__(self, name):
#         self.name = name
# 
#     def csv_to_json(self):
#         print('Csv to json')
#         print(self.name + " is swimming.")
# 
#     def json_to_csv(self):
#         print('Json to CSV')
#         print(self.name + " is being awesome.")
# 
# 
# def main():
#     # Set name of Shark object
#     convert = Convert(name)
#     convert.csv_to_json('foo')
#     convert.json_to_csv('bar')
# 
# if __name__ == "__main__":
#     main()
