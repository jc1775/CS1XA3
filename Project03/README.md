# CS 1XA3 Project03 - calarcoj
---
---

## Index

- [General Usage/Startup](#general-usage/startup)
- [Objective 01: Complete Login and SignUp Pages ](#objective-01)
- [Objective 02: Adding User Profile and Interests](#objective-02)
- [Objective 03: Account Settings Page](#objective-03)
- [Objective 04: Displaying People List](#objective-04)
- [Objective 05: Sending Friend Requests](#objective-05)
- [Objective 06: Accepting / Declining Friend Requests](#objective-06)
- [Objective 07: Displaying Friends](#objective-07)
- [Objective 08: Submitting Posts](#objective-08)
- [Objective 09: Displaying Post List](#objective-09)
- [Objective 10: Liking Posts (and Displaying Like Count)](#objective-10)
- [Objective 11: Test Database](#objective-11)
---
---
## General Usage/Startup

Activate the Conda Enviroment:

    conda activate djangoenv

From Project03 root folder run locally with -- When server is ran locally the login page can be accessed at http://localhost:8000/e/calarcoj/

    python manage.py runserver localhost:8000

From Project03 root folder run on mac1xa3.ca with -- When the server is ran from mac1xa3.ca the login page can be accessed at http://mac1xa3.ca/e/calarcoj

    python manage.py runserver localhost:10014

A test user is setup with login information

    username: MrRoboto
    password: 1234




- this feature is displayed in something.djhtml which is rendered by
some_view
- it makes a POST Request to from something.js to /e/macid/something_post
which is handled by someting_post_view

---
---

## Objective 01

##### Complete Login and SignUp Pages


#### Description:

**Displayed in:**

- *Project03/login/templates/login.djhtml* 
for the immediate login/account creation selection page

&

- *Project03/login/templates/signup.djhtml*
for the account creation page


**Rendered By:**


*login_view*
- GET: Returns the neccessary information to render *login.djhtml*
- POST: Authenticates the user based on username and password entered and returns a redirect to messages_view upon success, staying on login_view if failed.

- Form/s Used: AuthenticationForm with inputs for username and password

& 

*signup_view*

- GET: Returns the neccessary information to render *signup.djhtml*
- POST: If the form is filled out correctly a new UserInfo object is created using the supplied username and password, the new user is then authenticated and logged in, returning a redirect to messages_view
- Form/s Used: UserCreationForm with inputs for username and password

#### Code Examples:

Sign Up:

    if form.is_valid():
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password1')
        models.UserInfo.objects.create_user_info(username=username,password=password)

Sign In:

     if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request,user)

#### Usage

Upon loading into /e/calarcoj/ the user is met with a log in page, where they can either choose to 'Login' with an existing account, or 'Create an Account' by entering the appropriate data in respective fields. If the user chooses to 'Create an Account' they will be redirected to /e/calarcoj/signup/. Upon sucessful completion of either page forms the user is redirected to /e/calarcoj/social/messages/

## Objective 02

##### Adding User Profile and Interests

#### Description:

**Displayed in:**

- *Project03/social/templates/social_base.djhtml* 
for the use of *messages.djhtml*, *people.djhtml* and *account.djhtml* to render the left column

#### Code Examples:

Displaying Interests: Looping through list of users interests adding a new interest element for each one

    {% for interest in interests %}
            <span class="w3-tag w3-small w3-theme-d5"> {{ interest }} </span>
    {% endfor %}



#### Usage

This feature has no direct usage and simply acts as the base for which many other pages render the logged in user's information (Username, Employment, Birthday, Interests, Location)

---
---

## Objective 03

##### Account Settings Page


#### Description:

**Displayed in:**

- *Project03/social/templates/account.djhtml* 

**Rendered By:**

*account_view*
- GET: Returns the neccessary information to render *account.djhtml*
- Form/s Used: PasswordChangeForm with inputs for old password and new password, UserInfoChangeForm, a custom form with inputs for Employment, Birthday, Location, and adding a new interest

*passchange_view*
- POST: If the form is filled out this view will check if the neccessary parameters are correct (non all numeric, valid length, mathcing 1st and 2nd password etc.) and then set the users password as the new password, returning a redirect to login_view. If incorrect it simply returns a redirect to the same page
-Form/s Used: PasswordChangeForm

*userchange_view*
- POST: If the form is filled out this view checks which for the fields which are not blank (allowing individual user info elements to be changed at a time), and then updates the UserInfo object accordingly, one interest can be added at a time, which both adds a new Interest object, and adds that Interest object to the UserInfo object. Upon success it redirects to the same page.

#### Code Examples:

Adding New Interests: Makes use of multiple exec functions in order to set the name of the Interest Object to a name similar to that of the interest ie. 'Playing Sports' would be 'PlayingSports'

     if request.POST['newInterest'] not in interestList and request.POST['newInterest'] != '':
        interestName = str(request.POST['newInterest'])
        cleanName = ''
        for char in interestName.replace(" ", ""):
            if char not in punctuation:
                cleanName += char
        
        exec(cleanName + " = models.Interest(label='" + interestName + "')")
        exec(cleanName + ".save()")
        exec("user_info.interests.add(" + cleanName + ")")



#### Usage

To use this feature simply input information into its proper respected fields, and press the corresponding buttons.

---
---

## Objective 04

##### Displaying People List

#### Description:

**Displayed in:**

- *Project03/social/templates/people.djhtml* 

**Rendered By:**

*people_view*
- GET: Returns the neccessary information to render *people.djhtml* including a session variable *num_ppl* which is created if it does not already exist and incremented by 1 in *more_ppl_view*

#### Code Examples:

Creating List of People who are not friends: Compares a list of friends to the list of all UserInfo objects and appends those who are not friends to a list

    friend_people =[]
        for person in user_info.friends.all():
            friend_people.append(person)
        all_people = []
        for person in models.UserInfo.objects.all():
            if person not in friend_people and person != user_info:
                all_people.append(person)

Displaying people who are not friends: Within a for loop, this portion of the feature checks to see if the iteration count *forloop.counter* is greater than the session variable *num_ppl* if it is not greater, a new element containing information regarding the unfriended person is displayed. More elements based on the increment amount of *num_ppl* is added each time the More button is pressed.

    {% for person in all_people %}
        {% if forloop.counter > num_ppl  %}
            {#...#}
        {% else %}
            <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
                {% load static %}
                <img src="{% static 'avatar.png'  %}" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
                <h4> {{ person.user.get_username }} </h4><br>
                <hr class="w3-clear">
                <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> {{ person.employment }} </p>
                <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> {{ person.location }} </p>
                <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> {{ person.birthday }} </p>
                {% if person.user.get_username in friend_requests %}
                <button type="button" id={{ "fr-"|add:person.user.get_username }} class="w3-button w3-theme-d1 w3-margin-bottom fr-button" disabled style="pointer-events:none">Friend Request</button>
                {% else %}
                <button type="button" id={{ "fr-"|add:person.user.get_username }} class="w3-button w3-theme-d1 w3-margin-bottom fr-button">Friend Request</button>
                {% endif %}
            </div>
        {% endif %}
    {% endfor %}



#### Usage

This feature simply starts as soon as the user loads into /e/calarcoj/social/people/ and pressing the More button will show one more person each time.


---
---

## Objective 05

##### Sending Friend Requests


#### Description:

**Displayed in:**

- *Project03/social/templates/people.djhtml* 

**Rendered By:**

*friend_request_view*
- POST: A POST request is returned from the friendRequest function in *people.js* containing a frID variable, upon a valid frID being posted (not None) the frID is used to send a friend request.


#### Code Examples:

POST function for frID variable:

    function friendRequest(event) {
        let frID = event.target.id;
        let json_data = { 'frID' : frID };
        let url_path = friend_request_url;

        // AJAX post
        $.post(url_path,
            json_data,
            frResponse);
    }
Function which creates a list of requested friends (in order to disable button): 

    def friendreqPopulate(userinfo):
    list = []
    for requested in models.FriendRequest.objects.all():
        if requested.from_user == userinfo and requested.to_user.user.get_username() not in list:
            list.append(requested.to_user.user.get_username())
    return list



#### Usage

This feature is used simply by pressing the 'Send Friend Request' buttons, where it will then reload the page, removing the requested person from available people 

---
---

## Objective 06

##### Accepting / Declining Friend Requests


#### Description:

**Displayed in:**

- *Project03/social/templates/people.djhtml* 

**Rendered By:**

*accept_decline_view*
- POST: A POST request is returned from the acceptDeclineRequest function in *people.js* containing an ID variable formatted as *acc-username* for accept or *dec-username* for decline, upon valid ID being posted (not None) the id is parsed for the first 3 characters (decision) and the users friend request at the username given is either accepted or declined.


#### Code Examples:

POST function for ID variable:

    function acceptDeclineRequest(event) {
        let ID = event.target.id;
        let json_data = { 'ID' : ID };
        let url_path = accept_decline_url;

        // AJAX post
        $.post(url_path,
            json_data,
            frResponse);
    }
Accept/Decline Buttons with *acc-username* and *dec-username* respectively: 

    <div class="w3-half">
        <button id={{ "acc-"|add:name }} class="w3-button w3-block w3-green w3-section acceptdecline-button" title="Accept">
            <i class="fa fa-check" style="pointer-events:none"></i></button>
    </div>
    <div class="w3-half">
        <button id={{ "dec-"|add:name }} class="w3-button w3-block w3-red w3-section acceptdecline-button" title="Decline">
            <i class="fa fa-remove" style="pointer-events:none"></i></button>
    </div>



#### Usage

This feature is used simply by selecting the 'X' or the checkmark on the intended users friend request element to either accept or decline their request, the page is then reloaded.


---
---

## Objective 07

##### Displaying Friends


#### Description:

**Displayed in:**

- *Project03/social/templates/messages.djhtml* 

**Rendered By:**

*messages_view*
- GET: This feature adds user_info.friends.all() to the contect list that is given to the returned render function, allowing for a list of the users friends to be shown.


#### Code Examples:

Loop in Django Template to display friends:

    {% for friend in friends %}
        <div class="w3-card w3-round w3-white w3-center">
            <div class="w3-container">
            <p>Friend</p>
            {% load static %}
            <img src="{% static 'avatar.png'  %}" alt="Avatar" style="width:50%"><br>
            <span>{{ friend.user.get_username }}</span>
            </div>
        </div>
        <br>
    {% endfor %}


#### Usage

This feature is ran as soon as the messages page loads and requires nothing from the user.

---
---

## Objective 08

##### Submitting Posts


#### Description:

**Displayed in:**

- *Project03/social/templates/messages.djhtml* 

**Rendered By:**

*post_submit_view*
- POST: When the 'Post' button is pressed a POST request is returned from the submitPost function in *messages.js* containing the text inputted into the textbox next to it. A new Post object is then created with the owner set as the current user, and the content as the text from the POST request.


#### Code Examples:

Creating new Post object:

        if postContent is not None:
            if request.user.is_authenticated:
                user_info = models.UserInfo.objects.get(user=request.user)
                newEntry = models.Post(owner=user_info,content=postContent)
                newEntry.save()


POST request containing text from the textbox: 

    function submitPost(event) {
        let post_text = document.getElementById('post-text').innerText
        let json_data = { 'post_text' : post_text };
        let url_path = post_submit_url;
        if ( post_text != '' && post_text.trim() != '' ) {
            $.post(url_path,
                json_data,
                postSubmitResponse);
        }  
    }



#### Usage

This feature is used by selecting the "Post" button, a Post object is then created and the page is reloaded. Note that if the post is blank or is a string of empty spaces, a post is not made.


---
---

## Objective 09

##### Displaying Post List


#### Description:

**Displayed in:**

- *Project03/social/templates/messages.djhtml* 

**Rendered By:**

*messages_view*
- GET: A variable is added to the context list which is returned by the render function called 'posts' which is a list of all posts ordered by their time-stamp in decending order from newest-oldest
- Other: A new session variable named num_posts is created and set to 1 which will be used to telling the django template how many posts to display, this is incremented each time the 'More' button is pressed. Note that if there are no more posts to display the session variable is not incremented. 


#### Code Examples:

Creation of ordered list of Posts:

    posts = models.Post.objects.all().order_by('-timestamp')
    

Creation and Incrementation of session variable:

    if request.session.get('num_posts') == None:
            request.session['num_posts'] = 1

    posts = models.Post.objects.all()
    if request.user.is_authenticated:
        if request.session.get('num_posts') <= len(posts):
            request.session['num_posts'] += 1




#### Usage

This feature displays posts as soon as the messages page is loaded, upon pressing the 'More' button the page is reloaded and another post is displayed.



---
---

## Objective 10

##### Liking Posts (and Displaying Like Count)

#### Description:

**Displayed in:**

- *Project03/social/templates/messages.djhtml* 

**Rendered By:**

*like_view*
- POST: Upon pressing the like button a POST request is returned by the submitLike function in *messages.js* containing a varialbe 'postID which is formatted as 'post-ID' where ID is the Post objects ID (Post.id). The current users UserInfo object is then added to the list of likes under the post matching that ID. The Django template uses the length of the like list to display the number of likes
-Other: A seperate function called *likedPostsPopulate* is used to get a list of currently liked posts by the user in order to disable the like button on those posts


#### Code Examples:

Adding the user to list of likes:

    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        postID = postIDReq[5:]
        if request.user.is_authenticated:
            user_info = models.UserInfo.objects.get(user=request.user)
            post = models.Post.objects.get(id=postID)
            post.likes.add(user_info)
    

Getting list of posts liked by the user:

    def likedPostsPopulate(userinfo):
        list = []
        for post in models.Post.objects.all():
            if userinfo in post.likes.all() and post.id not in list:
                list.append(post.id)
        #print(list)
        return list




#### Usage

The feature is used by pressing the 'Like' button next to a post on the messages page, upon pressing that button the page is reloaded and the button will be disabled and the like will be added.



---
---

## Objective 11

##### Create a Test Database


##### Description

The test Database is populated using a *test* function in *social/views.py*. It contains 7 usable test users ('MrRoboto','TestUser1','TestUser2','TestUser3','TestUser4','TestUser5','TestUser6') as well as a couple hundred users generated from a CSV file with randomly generated passwords (just for the fun of it)

##### Usage

The 7 users with UserNames - 'MrRoboto','TestUser1','TestUser2','TestUser3','TestUser4','TestUser5','TestUser6' - are already created, all with their password set to '1234','12345','123456, etc. respectively ie. Username: MrRoboto Password: 1234 , Username TestUser1 Password: 12345
