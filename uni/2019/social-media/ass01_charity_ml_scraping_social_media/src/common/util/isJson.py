import json

def is_json(myjson):
    print(myjson)
    try:
        json_object = json.loads(myjson)
        return True
    except ValueError as e:
        return False
    return True