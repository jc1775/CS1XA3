from django.test import TestCase
from . import models

def test():
    usernames = ['a','b','c','d']
    for username in usernames:
        models.UserInfo.objects.create_user_info(username=username,password='1234')
    for person in models.UserInfo.objects.all():
            if person.username != 'calarcoj':
                person.location = "ELSEWHERE"
                person.employment = "Tesla"
                person.birthday = '1900-01-05'
                
            