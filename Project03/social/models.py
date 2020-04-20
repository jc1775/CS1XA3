from django.db import models
from django.contrib.auth.models import User
from django import forms
from datetime import date



class Interest(models.Model):
    label = models.CharField(max_length=30,primary_key=True)

class UserInfoManager(models.Manager):
    def create_user_info(self, username, password):
        user = User.objects.create_user(username=username,
                                    password=password)
        userinfo = self.create(user=user)
        return userinfo

class UserInfo(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True)
    objects = UserInfoManager()
    employment = models.CharField(max_length=30,default='Unspecified')
    location = models.CharField(max_length=50,default='Unspecified')
    birthday = models.DateField(null=True,blank=True)
    interests = models.ManyToManyField(Interest)
    friends = models.ManyToManyField('self')

class Post(models.Model):
    owner = models.ForeignKey(UserInfo,
                              on_delete=models.CASCADE)
    content = models.CharField(max_length=280)
    timestamp = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(UserInfo,
                                   related_name='likes')

class FriendRequest(models.Model):
    to_user = models.ForeignKey(UserInfo,
                                on_delete=models.CASCADE,
                                related_name='to_users')
    from_user = models.ForeignKey(UserInfo,
                                  on_delete=models.CASCADE,
                                  related_name='from_users')

class UserInfoChange(models.Model):
    employment = models.CharField(max_length=30,blank=True)
    location = models.CharField(max_length=50,blank=True)
    birthday = models.DateField(null=True,blank=True)
    newInterest = models.CharField(max_length=30,blank=True)

class UserInfoChangeForm(forms.ModelForm):

    class Meta:
        model = UserInfoChange
        labels = { 'birthday': "Birthday (YYYY-MM-DD)", 'newInterest': 'New Interest'}
        fields = ['employment','location', 'newInterest', 'birthday']
        widgets = { 'birthday': forms.SelectDateWidget(empty_label=('', '', ''), years=(range( date.today().year - 115 , date.today().year))) }
 