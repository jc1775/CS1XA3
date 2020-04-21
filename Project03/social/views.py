from django.http import HttpResponse,HttpResponseNotFound
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from . import models


def interstPopulate(userinfo):
    list = []
    for interest in userinfo.interests.values():
        if interest['label'] not in list:
            list.append(interest['label'])
    return list

def friendreqPopulate(userinfo):
    list = []
    for requested in models.FriendRequest.objects.all():
        if requested.from_user == userinfo and requested.to_user.user.get_username() not in list:
            list.append(requested.to_user.user.get_username())
    return list

def friendreqToPopulate(userinfo):
    list = []
    for requested in models.FriendRequest.objects.all():
        if requested.to_user == userinfo and requested.from_user.user.get_username() not in list:
            list.append(requested.from_user.user.get_username())
    return list

def likedPostsPopulate(userinfo):
    list = []
    for post in models.Post.objects.all():
        if userinfo in post.likes.all() and post.id not in list:
            list.append(post.id)
    print(list)
    return list


def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    

    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        if request.session.get('num_posts') == None:
            request.session['num_posts'] = 1
        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)
        posts = models.Post.objects.all().order_by('-timestamp')
 

        # TODO Objective 10: check if user has like post, attach as a new attribute to each post

        request.session['likedPosts'] = likedPostsPopulate(user_info)
        request.session['interestList'] = interstPopulate(user_info)
        request.session['friend_requests'] = friendreqPopulate(user_info)
        request.session['friend_requests_to'] = friendreqToPopulate(user_info)
        context = { 'user_info' : user_info
                  , 'posts' : posts 
                  , 'username' : request.user.username
                  , 'employment' : user_info.employment
                  , 'location' : user_info.location
                  , 'birthday' : user_info.birthday
                  , 'likedPosts': request.session.get('likedPosts')
                  , 'interests': request.session.get('interestList')
                  , 'friends' : user_info.friends.all()
                  , 'num_posts': request.session.get('num_posts')
                  }

        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        form1 = PasswordChangeForm(request.POST)
        form2 = models.UserInfoChangeForm()
        interestList = []
        for interest in user_info.interests.values():
            interestList.append(interest['label'])
        if request.method == 'GET':
            context = { 'user_info' : user_info
                        ,'passwordchangeform' : form1
                        ,'userinfochangeform' : form2
                        , 'username' : request.user.username
                        , 'employment' : user_info.employment
                        , 'location' : user_info.location
                        , 'birthday' : user_info.birthday
                        , 'interests' : interestList
                        , 'friends' : user_info.friends
                        }
            return render(request,'account.djhtml',context)
    else:
        request.session['failed'] = True
        return redirect('login:login_view')

def passchange_view(request):
    form1 = PasswordChangeForm(request.POST)
    if request.user.is_authenticated:
        if request.method == 'POST': 
            if request.user.check_password(request.POST['old_password']):
                if request.POST['old_password'] != request.POST['new_password1'] and request.POST['new_password2'] == request.POST['new_password1'] and len(request.POST['new_password1']) >= 8:
                    try:
                        int(request.POST['new_password1'])
                        print('Password is entirely numeric')
                        return redirect('social:account_view')
                    except:
                        print("IS VALID")
                        request.user.set_password(request.POST['new_password1'])
                        request.user.save()
                        return redirect('login:login_view')
                else:
                    print('Errors',form1.errors)
                    print("Password parameters not met")
                    return redirect('social:account_view')
            else:
                print('Errors:',form1.errors)
                print("Old Password not matched")
                return redirect('social:account_view')

def userchange_view(request):
    user_info = models.UserInfo.objects.get(user=request.user)
    form2 = models.UserInfoChangeForm()
    interestList = []
    for interest in user_info.interests.values():
        interestList.append(interest['label'])
    if request.user.is_authenticated:
        if request.method == 'POST':
            if request.POST['employment'] != user_info.employment and request.POST['employment'] != '' :
                user_info.employment = request.POST['employment']
            if request.POST['location'] != user_info.location and request.POST['location'] != '':
                user_info.location = request.POST['location']
            if request.POST['newInterest'] not in interestList and request.POST['newInterest'] != '':
                interestName = request.POST['newInterest']
                cleanName = interestName.replace(" ", "")
                exec(cleanName + " = models.Interest(label='" + interestName + "')")
                exec(cleanName + ".save()")
                exec("user_info.interests.add(" + cleanName + ")")

            birthday = request.POST['birthday_year'] + "-" + request.POST['birthday_month'] + "-" +  request.POST['birthday_day']
            if birthday != user_info.birthday and birthday != '' and len(birthday) in [8,9,10]:
                try:
                    user_info.birthday = birthday
                except:
                    print("Invalid Format")
            user_info.save()
            return redirect('social:account_view')
    
def test():
    usernames = ['a','b','c','d']
    for username in usernames:
        models.UserInfo.objects.create_user_info(username=username,password='1234')
    for person in models.UserInfo.objects.all():
            if person.user.get_username() != 'calarcoj':
                person.location = "ELSEWHERE"
                person.employment = "Tesla"
                person.birthday = '1900-01-05'
                person.save()

def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        
        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        
        friend_people =[]
        for person in user_info.friends.all():
            friend_people.append(person)
        all_people = []

        for person in models.UserInfo.objects.all():
            if person not in friend_people and person != user_info:
                all_people.append(person)
                #person.delete()
        if request.session.get('num_ppl') == None:
            request.session['num_ppl'] = 1
        request.session['interestList'] = interstPopulate(user_info)
        request.session['friend_requests'] = friendreqPopulate(user_info)
        request.session['friend_requests_to'] = friendreqToPopulate(user_info)
        context = { 'user_info' : user_info,
                    'all_people' : all_people,
                    'num_ppl': request.session.get('num_ppl'),
                    'username': user_info.user.get_username(),
                    'employment': user_info.employment,
                    'location': user_info.location,
                    'birthday': user_info.birthday,
                    'interests': request.session.get('interestList'),
                    'friend_requests' : request.session.get('friend_requests'),
                    'friend_requests_to' : request.session.get('friend_requests_to') }

        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        postID = postIDReq[5:]
        if request.user.is_authenticated:
            user_info = models.UserInfo.objects.get(user=request.user)
            # TODO Objective 10: update Post model entry to add user to likes field
            post = models.Post.objects.get(id=postID)
            post.likes.add(user_info)
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('post_text')
    if postContent is not None:

        if request.user.is_authenticated:
            user_info = models.UserInfo.objects.get(user=request.user)
            newEntry = models.Post(owner=user_info,content=postContent)
            newEntry.save()
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    posts = models.Post.objects.all()
    if request.user.is_authenticated:
        if request.session.get('num_posts') <= len(posts):
            request.session['num_posts'] += 1
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')


def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        friend_people =[]
        for person in user_info.friends.all():
            friend_people.append(person)
        all_people = []
        for person in models.UserInfo.objects.all():
            if person not in friend_people and person != user_info:
                all_people.append(person)
        if request.method == 'POST':
            if request.session.get('num_ppl') <= len(all_people):
                request.session['num_ppl'] += 1
            # return status='success'
            return HttpResponse()

    return redirect('login:login_view')


def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]
        user_info = models.UserInfo.objects.get(user=request.user)
        if request.user.is_authenticated:
            # TODO Objective 5: add new entry to FriendRequest
            for person in models.UserInfo.objects.all():
                if person.user.get_username() == username:
                    #friend_requests.append(username)
                    newRequest = models.FriendRequest(to_user=person, from_user=user_info)
                    newRequest.save()
                    
            # return status='success'
            #newRequest = models.FriendRequest(fromuser=username)
            return HttpResponse(username)
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    user_info = models.UserInfo.objects.get(user=request.user)
    data = request.POST.get('ID')
    if data is not None:
        # TODO Objective 6: parse decision from data
        decision = data[:3]
        username = data[4:]
        print(username)
        if request.user.is_authenticated:
            for reqs in models.FriendRequest.objects.all():
                if reqs.to_user == user_info and reqs.from_user.user.get_username() == username:
                    if decision == 'acc':
                        user_info.friends.add(reqs.from_user)
                        reqs.from_user.friends.add(user_info)
                        reqs.delete()
                    elif decision == 'dec':
                        reqs.delete()
            # TODO Objective 6: delete FriendRequest entry and update friends in both Users

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')

