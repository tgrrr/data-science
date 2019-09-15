import csv

def writeToCsv(_tweet, _full_text):
    csv_file_name = 'charity_machine_learning_tweets.csv'

    csvFile = open(
        'charity_machine_learning_tweets.csv', 
        'a',
        newline='', 
        encoding='utf-8'
        )
    csvWriter = csv.writer(csvFile)

    outputFormat = [
        _full_text, 
        # tweet.text.encode('utf-8'), 
        _tweet.created_at,
        _tweet.user.id,
        # _tweet.user.screen_name,
        # _tweet.user.friends_count,
        # _tweet.user.followers_count,
    ]

    # csvWriter.writerow(outputFormat)


    with open(
        csv_file_name, 
        'w', 
        newline='', 
        encoding='utf-8') as csv_file:
        
        writer = csv.writer(csv_file, delimiter=';')
        writer.writerow(outputFormat)

