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


import csv

def import_patients (set):
    "Import patient data from the csv files"
    proteomics = csv.DictReader(open("Data\\alignments_and_proteomics.csv"), delimiter=',', quotechar='"')
    prot = []
    for entry in proteomics:
        prot.append(entry)

    

    if set == 'TEST':
        csvData = csv.DictReader(open("Data\\test_data.csv"), delimiter=',', quotechar='"')
    elif set == 'TRAIN':
        csvData = csv.DictReader(open("Data\\training_data.csv"), delimiter=',', quotechar='"')
    else:
        raise Exception, 'Set is not recognised'

        
    data = []
    for entry in csvData:
        data.append(entry)

    
    #Add proteomics data to entries
    patientList = []
    for entry in data:
        patient = entry
        protEntries = [protEntry for protEntry in prot if \
                    protEntry['patient_id'] == patient['PatientID'] and \
                    protEntry['instance_type'] == set]
        for protEntry in protEntries:   
            if protEntry['molecule_type'] == 'pr':
                for key, value in protEntry.items():
                    #print key
                    key = "pr_%s" % key
                    patient[key] = value
            elif protEntry['molecule_type'] == 'rt':
                for key, value in protEntry.items():
                    key = "rt_%s" % key
                    patient[key] = value
            else:
                raise Exception, 'Unrecognised molecule type'

        patientList.append(patient)

    return patientList

