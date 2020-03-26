#!/usr/bin/env python

from datetime import date, datetime

def datetimeConvertToString(obj):
    """
    Converts a datetime object into a string
    """
    
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    raise TypeError ('Type %s is not serialisable' % type(obj))