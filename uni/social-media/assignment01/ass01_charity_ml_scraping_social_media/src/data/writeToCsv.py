import csv

def writeToCsv(tweet, full_text):
    """
    @summary: Write short and full_text version of tweet to csv file.
    @author:  Phil S phil@tgrrr.com

    @param    tweet: Text extracted from `tweet`.
    @type:    string

    @param    full_text: Extracted tweets `full_text`.
    @type:    string

    @return:  Description of returned object.
    @rtype:   array
    
    
    """
    
    
    csv_file_name = 'charity_machine_learningtweets.csv'

    csvFile = open(
        'charity_machine_learningtweets.csv', 
        'a',
        newline='', 
        encoding='utf-8'
        )
    csvWriter = csv.writer(csvFile)

    outputFormat = [
        full_text, 
        # tweet.text.encode('utf-8'), 
        tweet.created_at,
        tweet.user.id,
        # tweet.user.screen_name,
        # tweet.user.friends_count,
        # tweet.user.followers_count,
    ]

    # csvWriter.writerow(outputFormat)


    with open(
        csv_file_name, 
        'w', 
        newline='', 
        encoding='utf-8') as csv_file:
        
        writer = csv.writer(csv_file, delimiter=';')
        writer.writerow(outputFormat)

