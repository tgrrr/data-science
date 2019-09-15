import collections.abc

def isString(obj):
    # is not string:
    if isinstance(obj, collections.abc.Sequence) and not isinstance(obj, str):
        # "obj is a sequence (list, tuple, etc) but not a string")
        return False
    else:
        return True
