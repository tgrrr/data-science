"""This file is part of a package created for the 'Predict HIV Progression'
competition (http://kaggle.com/hivprogression)

More information on this package is available at:
    http://jonathanstreet.com/blog/kaggle-predict-hiv-progression

The MIT License

Copyright (c) 2010 Jonathan Street

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE."""

class Method:

    def __init__ (self):
        "Setup"
        pass

    def train (self, data):
        "Train the method"
        pass

    def test (self, data):
        "Predict response"
        patientList = []
        for patient in data:
            patient['predictedResp'] = 0
            patientList.append(patient)
        return patientList


