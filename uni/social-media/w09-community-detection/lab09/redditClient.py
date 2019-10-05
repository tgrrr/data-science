#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2018
#


import sys
import praw


def redditClient():
    """
        Setup Reedit API authentication.
        Replace username, secrets and passwords with your own.

        @returns: praw Reedit object
    """

    try:
        clientId = "tzPVikVOQFkdbg"
        clientSecret = "ob9b8ZA7neL-JLMccYtLMVU63ns"
        password = "pjmcgUfRmjMqb9r48x"
        userName = "tgrrrcom"
        userAgents = 'scrapey'

        redditClient = praw.Reddit(client_id = clientId,
                                   client_secret = clientSecret,
                                   password = password,
                                   username = userName,
                                   user_agent = userAgents)
    except KeyError:
        sys.stderr.write("Key or secret token are invalid.\n")
        sys.exit(1)


    return redditClient
