/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */
  function postSubmitResponse(data,status) {
    if (status == 'success') {
        location.reload();
    }
    else {
        alert('failed to create post ' + status);
    }
}

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
 
/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */

function submitLike(event) {
    let postID = event.target.id;
    let json_data = { 'postID' : postID };
    let url_path = '../like/';
    $.post(url_path,
        json_data,
        postSubmitResponse);
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data,status) {
    if (status == 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function submitMore(event) {
    // submit empty data
    let json_data = { };
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
           json_data,
           moreResponse);
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
});
