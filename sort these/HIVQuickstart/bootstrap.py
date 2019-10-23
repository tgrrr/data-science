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

import random
import numpy

class Bootstrap:

    def __init__ (self, method):
        "Setup"

        #Register method
        self.method = __import__(method)

        #Import data
        self.data = Patients.import_patients("TRAIN")

    def split_data (self):
        "Split the training data into two parts"
        trainset = []
        testset = []
        for patient in self.data:
            if random.randint(0,1) == 1:
                trainset.append(patient)
            else:
                testset.append(patient)
        return {'train':trainset, 'test':testset}

    def run (self, repeats = 50):
        "Run multiple tests with different random partitions of the data"
        results = []
        for i in range(repeats):
            split_data = self.split_data()
            test_method = self.method.Method()
            test_method.train(split_data['train'])
            prediction = test_method.test(split_data['test'])
            score = self.calc_score(prediction)
            results.append(score)
            
        self.disp_results(results)

    def disp_results(self, data):
        results = numpy.array(data)
        print "Mean score: ", numpy.mean(results)
        print "Standard deviation: ", numpy.std(results)
        print "Maximum: ", numpy.max(results)
        print "Minimum: ", numpy.min(results)

    def calc_score (self, data):
        "Calculate the score for the method on the test data"
        correct = 0
        incorrect = 0
        for patient in data:
            if int(patient['Resp']) == int(patient['predictedResp']):
                correct += 1
            else:
                incorrect += 1
        mer = float(incorrect) / (float(correct) + float(incorrect))
        score = float(1) - mer
        return score

