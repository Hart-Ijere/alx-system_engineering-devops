#!/usr/bin/env python3
"""
Query the Reddit API and prints the titles of the first 10 hot posts
listed for a given subreddit. If the subreddit is invalid, prints None.
"""

import requests

def top_ten(subreddit):
    """
    Fetch the top 10 hot posts from a given subreddit and prints their titles.
    
    Parameters:
    subreddit (str): The subreddit to query.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {'User-Agent': 'Mozilla/5.0'}

    response = requests.get(url, headers=headers, allow_redirects=False)
    
    if response.status_code != 200:
        print(None)
        return

    try:
        data = response.json()
        posts = data['data']['children']
        for post in posts[:10]:
            print(post['data']['title'])
    except KeyError:
        print(None)
