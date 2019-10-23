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

import Patients

class Submission:

    def __init__ (self, method):
        #Register method
        imported = __import__(method)
        self.method = imported.Method()

        #Import data
        self.trainingdata = Patients.import_patients("TRAIN")
        self.testingdata = Patients.import_patients("TEST")

    def train (self, data):
        "Fetch patient data and pass to the method train function"
        self.method.train(data)

    def test (self, data):
        "Fetch patient data, pass to method test function and return prediction"
        return self.method.test(data)

    def run (self, filename):
        "Generates a file for submission"
        self.train(self.trainingdata)
        results = self.test(self.testingdata)

        fileWriter = open(filename, 'w')
        
        fileWriter.write('"PatientID", "Resp"')
        fileWriter.write("\n")

        for result in results:
            fileWriter.write(str(result['PatientID']) + ", " + str(result['predictedResp']) + "\n")

        fileWriter.close()

