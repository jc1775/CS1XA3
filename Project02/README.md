# CS 1XA3 Project02 - calarcoj

## Index:
- [Overview](#overview)
- [Webpage Sections](#webpage-sections)
  - [About Me](#about-me)
  - [Projects](#projects)
  - [Contact Me](#contact-me)
- [Custom Javascript Code](#custom-javascript-code)
  - [Project Card Generator](#project-card-generator)
  - [Project Card Sorter](#project-card-sorter)
  - [Popup Handlers](#popup-handlers)
  - [Minimizer/Maximizer](#minimizer/maximizer)
  - [Minimizer/Maximizer ALL](#minimizer/maximizer-all)
  - [Random Gear Shifter](#random-gear-shifter)
  - [Title Typewriter](#title-typewriter)
  - [General Animations and Features](#general-animations-and-Features)
    - [Background Resizer](#background-resizer)
    - [Page Scrollers](#page-scrollers)
    - [Elements Hide/Fade](#elements-hide/fade)
    - [Top Checker](#top-checker)
    - [Menu Toggler](#menu-toggler)
    - [Scaler](#scaler)
- [References](#references)
  - [Github Calendar](#github-calendar)
___ 
___

## Overview:

This webpage is Joseph Calarco's (my) custom CV. It contains information regarding all experiences, projects, and skills applicable to a computer science student's never-ending hunt for Co-Op placements. The page has three main sections, [About Me](#about-me), [Projects](#projects), and [Contact Me](#contact-me). Each section respectively has, information regarding myself, an interactive list of all projects I have done, my contact information. Animations are kept to a minimum to keep things professional, excluding the page header (which is interactive, click on the gears!), just to make the site a bit more 'lively'.
___
___

## Webpage Sections
___

### About Me

This section of the page contains all information regarding my skills and experiences, as well as a quick overview of any highlights. 

This section has no unique javascript elements.
___

### Projects

This section of the page contains an interactive list of all projects I have worked on. Each project 'card' is clickable on the 'View Me!' button, which then displays a popup with information on the project.

Javascript was heavily used in this section to save from having to manually add 'cards' for every project, which I suspect would come in handy in the future. Therefore I coded the [Project Card Generator](#project-card-generator), aswell as the [Project Card Sorter](#project-card-sorter) feature in order to sort through the projects by type.

___

### Contact Me

This section of the page contains all of the necessary information to contact me over find me on social media. Including links to Github and LinkedIn. There is a QR code which can be scanned to add me (Name, E-Mail, Website) to a phones contact list. Also included is a [Github Calendar](#github-calendar)

There is no unique javascript in this section other than the [Github Calendar](#github-calendar).
___
___

## Custom Javascript Code
___

### Project Card Generator

***Purpose:***

The purpose of this feature is to save the time of manually editting HTML each time one seeks to add a new project.  

***Implmentation:***

cardMaker:

This feature generates 'project cards' based on an array of project files. This is achieved by iterating over the array, and reading the HTML contained within each file using .get(). The feature searches within the file using .filter() for three elements: div.type, div.title, div.pic. The text within each of these elements is used to provide a name for the card, a type for the project (necessary for [Project Card Sorter](#project-card-sorter)), and a picture to show up within the card. The feature then creates a variable named 'card' that is a new 'postBox' element with all of the aquired information in the correct location. Lastly, the card is appended projects section of the site. 


***Code:***

    function cardMaker() {
        files.forEach(function (item) {
            $.get(item, null, function (data) {
                var result = $(data);
                var type = ((result.filter("div.type"))[0].innerText)
                var title = ((result.filter("div.title"))[0].innerText)
                var pic = ((result.filter("div.pic"))[0].innerText)
                var card = $('<div id="' + type + item + '" class="postBox"> <div class="title">' + title + '</div><div class="content" style="background-image: url(' + pic + ')" ></div><div data-link="' + item + '" class="btnView">View me!</div></div>');
                $("#projectItems").append(card);
                $("div.btnView").on('click', overlayShow)
            });
        })
    }

***Trigger:*** Page load

___

### Project Card Sorter

***Purpose:***

The purpse of this feature is to sort through all projects, listing only the ones of a selected type.

***Implmentation:***

projectSorter:

This feature gets the custom attribute of the selected button called 'data-actsOn' which is the type of project that is meant to be shown when said button is pressed. If 'All' is selected all project cards fade in, otherwise all project cards fadeout, and then 500ms later, any project card with an id beginning with 'data-actsOn' fades in. 

***Code:***

    function projectSorter() {
        var toKeep = $(this).attr("data-actsOn");
        $("btn.blockOptionsbtn").css("background-color", "transparent");
        $(this).css("background-color", "lightblue")
        if (toKeep == "All") {
            $("div.postBox").fadeIn(500);
        } else {
            $("div.postBox").fadeOut(500);
            setTimeout(function () {
                $('div[id^="' + toKeep + '"]').fadeIn(500);
            }, 500);
        }
    }

***Trigger:*** ".blockOptionsbtn" click (Top of Projects section)

___

### Popup Handlers

***Purpose:***

These are two features that were created to handle the use of popup boxes containing information regarding projects. One to display the correct popup, and another to close the popup.

***Implmentation:***

overlayShow:

The first feature displays the correct popup information upon clicking the 'View Me!' button within each project card. This is done by getting the text from the custom attribute 'data-link' which is the path to the project file and saving it as a variable. The feature then fades in the project popup, and using .load() loads the title from the project files 'div.title' into the header of the popup, and the loads the content of the project into the content area of the popup (div.popContent), the information to be displayed as content must be within a element named div.projcontent in the projects HTML file.

overlayClose:

The second feature is simply to close the popup. This feature simply fades out the overlay upon pressing the red 'X' on the top right, and then using .empty() it clears out the HTML in the div.popContent element to save from having unnecessary loaded HTML in the background of the page.

***Code:***

    function overlayShow() {
        var file = $(this).attr("data-link");
        var title = $(this).parent().find("div.title").text()
        $("div.overlay").fadeIn();
        $("div.popHeader").text(title);
        $("div.popContent").load(file);
    }


    function overlayClose() {
        $("div.overlay").fadeOut();
        $("div.popContent").empty();
    }

***Trigger:*** overlayShow: ".btnView" click ("View Me!" button in project card) overlayClose: ".close" click (Red X top right of popup)

___

### Minimizer/Maximizer

***Purpose:***

The purpose of this feature was to give the option to minimize or maximize specific sections of the page aka 'pageBlocks' by clicking the respective arrow in each sections header.

***Implmentation:***

minimizer:

This feature is done using a simple if and else statement where the height of the block is checked to be 50px or not. If the height IS NOT 50px, a variable (origH) containing the original height of the element is created, then minimum height is set to 0, and the height is animated to shrint down to 50px. All content within the section (but of course the minimize/maximize button) is hidden, and a smaller version of the title within the section is faded in beside the min/max button. The button is rotated 180 deg to symbolize that the section is minimized, and lastly the "fakeBackground" that acts as a backsplash for the entire website, is resized by subtracting the height of the page section (origH), from the height of the background. If the height of the section IS 50px then all of the above is reversed, and the "fakeBackground" is shown if previously hidden, the [Background Resizer](#background-resizer) function is ran to make sure the "fakeBackground" is of proper size.

***Code:***

    function minimizer() {
        if ($(this).parent().height() == 50) {
            $(this).parent().css("min-height", "50%");
            $(this).parent().css("height", "auto");
            $(this).css("transform", "rotate(0deg)");
            $(this).parent().contents().not("div.minimizer").show();
            $(this).parent().find("div.miniTitle").hide();
            $("div.fakeBackground").show();
            backgroundResize();
        } else {
            var origH = $(this).parent().height();
            $(this).parent().css("min-height", "0");
            $(this).parent().animate({
                height: '50'
            }, 1000);
            $(this).parent().contents().not("div.minimizer, div.miniTitle").hide();
            $(this).parent().find("div.miniTitle").fadeIn(500);
            $(this).css("transform", "rotate(180deg)");
            $(".fakeBackground").css("height", $(".fakeBackground").height() - origH);
        }
    }
***Trigger:*** ".minimizer" click (Double red arrows at top right of each section header) "div.aboutBox h1" click (Any header with a red background makes use of a very similar function)

___

### Minimizer/Maximizer ALL


***Purpose:***

The purpose of this feature is to give the ability to maximize or minimize all sections (div.pageBlock) on the page, by clicking the respective buttons to the top right.

***Implmentation:***

minimizerALL:

The implementation of this feature is quite similar to - [Minimizer/Maximizer](#minimizer/maximizer) all that differs is that it checks the id attribute of which button was selected in an if and else if statment and based on the id (either #maximize or #minimize) iterates over ever elements of type div.pageBlock and proceeds to minimize or maximize it based on which button was selected. This feature also differs slightly in that when all sections are minimized the "fakeBackground" element is hidden.

***Code:***

    function minimizerALL() {
        if ($(this).is("#minimize")) {
            $("div.pageBlock").each(function () {
                if ($(this).height() != 50) {
                    $(this).css("min-height", "0");
                    $(this).animate({
                        height: '50'
                    }, 1000);
                    $(this).contents().not("div.minimizer, div.miniTitle").hide();
                    $(this).find("div.miniTitle").fadeIn(500);
                    $(this).find("div.minimizer").css("transform", "rotate(180deg)")
                    $("div.fakeBackground").hide()
                }
            })
        } else if ($(this).is("#maximize")) {
            $("div.pageBlock").each(function () {
                if ($(this).height() == 50) {
                    $(this).css("min-height", "50%");
                    $(this).css("height", "auto");
                    $(this).find("div.minimizer").css("transform", "rotate(0deg)");
                    $(this).contents().not("div.minimizer").show();
                    $(this).find("div.miniTitle").hide();
                    $("div.fakeBackground").show()
                }
            })
            backgroundResize()
        }
    }

***Trigger:*** ".exminbtn" click (Minimize/Maximize buttons sticky to top right of window when scrolling down)

___
### Random Gear Shifter

***Purpose:***

This is just a fun little feature that spawns new gears in the header and shifts/scales the gears in a direction based on a randomly generated number.

***Implmentation:***

This feature makes use of multiple else if statements that check the range of the randomly generated number which can be between 1 and 70. A different set of animations are set to each interval of 10. The function also clones the selected gear, and shifts it based on the width of the clonsed element, and shrinks the cloned element by a randomized amount between 1-100 pixels. Upon reaching a total of 25 gears on one side of the screen all clones fade out, and are subsequently removed. All of this is triggered upon pressing a gear in the header


***Code:***

    function randShift() {
        var rand = Math.random() * 70;
        var rand2 = Math.random() * 2
        var time = 250 + rand
        var shift = 25 * rand2
        var scaler = Math.random() * 100

        var newGear = $(this).clone()
        $(this).parent().append(newGear)
        $(this).parent().find("div.gear:last-of-type").on("click", randShift)
        var newEleWidth = $("div.gear:last-of-type").width()
        $(this).parent().find("div.gear:last-of-type").animate({
            right: "+=" + newEleWidth,
            left: "+=" + newEleWidth,
            top: "-=" + newEleWidth,
            bottom: "-=" + newEleWidth,
            width: "-=" + scaler,
            height: "-=" + scaler
        }, time)
        if (rand < 10) {
            $(this).animate({
                left: "+=" + shift + "%",
                width: "+=" + scaler,
                right: "+=" + shift + "%"
            }, time)
        } else if (rand < 20) {
            $(this).animate({
                left: "-=" + shift + "%",
                right: "-=" + shift + "%",
                height: "+=" + scaler
            }, time)
        } else if (rand < 30) {
            $(this).animate({
                top: "+=" + shift + "%",
                width: "-=" + scaler
            }, time)
        } else if (rand < 40) {
            $(this).animate({
                top: "-=" + shift + "%",
                height: "-=" + scaler
            }, time)
        } else if (rand < 50) {
            $(this).animate({
                top: "+=" + shift + "%",
                width: "+=" + scaler,
                right: "+=" + shift + "%",
                left: "+=" + shift + "%"
            }, time)
        } else if (rand < 60) {
            $(this).animate({
                top: "-=" + shift + "%",
                height: "+=" + scaler,
                right: "+=" + shift + "%",
                left: "+=" + shift + "%"
            }, time)
        } else if (rand < 70) {
            $(this).animate({
                top: "-=" + shift + "%",
                left: "-=" + shift + "%",
                right: "+=" + shift + "%",
                width: "-=" + scaler
            }, time)

        }

        if ($(this).parent().find("*").length > 25) {
            $("#gearL7").nextAll().fadeOut(500)
            $("#gearR7").nextAll().fadeOut(500)
            setTimeout(function() {
                $("#gearL7").nextAll().remove()
                $("#gearR7").nextAll().remove()
            }, 700)
        }

    }
    
***Trigger:*** ".gear" click (Any gear within the site header)

___

### Title Typewriter

***Purpose:***

This is just a cool animation that simulates someone typing out a title for the page multiple times until finally deciding on a single title.

***Implmentation:***

titleTyper:

This feature simply iterates over an array of arrays, where each subarray contains the characters making up each title. It compares the length of each subarray to a varriable and adds the array at said variable each iteration, then increments the variable by 1, upon filling in the complete array, it runs a helper function called titleRemover() which iterates over the current set title, slicing 1 off of the end each time, upon completion of removing the title the feature moves onto the next array until arriving at the last and stopping.

***Code:***

    var o = 0
    var y = 0

    function titleTyper() {
        var title = words[o]
        if (y < (title.length)) {
            var currentState = $("#title").text()
            $("#title").text(currentState + title[y])
            y++;
        } else {
            if (o == words.length - 1) {

            } else {
                titleRemover(title)
            }

        }
        setTimeout(function() {
            titleTyper()
        }, 100)
    }

    function titleRemover(title) {
        var z = $("#title").text().length
        if (z > 0) {
            var currentState = $("#title").text()
            var newString = currentState.slice(0, -1)
            $("#title").text(newString)
            z--;
        } else {
            z = 0
            y = 0
            if (o < words.length - 1) {
                o++;
            } else {
                o = 0;
            }
        }

    }


***Trigger:*** Page load

___

### General Animations and Features

***These are general Javascript implementations spanning across various unrelated elements using similar code***

---

#### Background Resizer

***Purpose:***

The purpose of this feature is simply to resize the "fakeBackground" (an element which acts as a barely visible background to the entire page) to fit the page accordingly

***Elements Effected***

div.fakeBackground

***Implmentation:***

The purpose of this feature is accomplished by first setting the height of the background to 0, then saving the height of the "main_container" element which is element that contains everything on the page but the header, and then sets the height of the background to be the height of the main_container.

***Example Code:***

    function backgroundResize() {
        $(".fakeBackground").css("height", "0");
        var mainH = $("div.main_container").height();
        $("div.fakeBackground").css("height", mainH);
    }

---

#### Page Scrollers

***Purpose:***

These animations are simply to scroll the user window to various sections on the page based on a button that was pressed ie. buttons in the navigation menu, or the scroll to top arrow in the bottom right hand corner.


***Elements Effected***

button.item: These are the buttons in the navigation menu, the About, Projects, and Contact, buttons scroll to their respective page locations

div.scrollTop: This is a button situated in the bottom right hand corner of the window and scrolls to the top of the page when clicked

***Implmentation:***

This feature simply works by animating the body of the page, scrolling to the result of "ELEMENT".offset() which returns the position of the element on the page, and then .top which selects only the position relative to the top. 

***Example Code:***

    function topScroll() {
        $('body').animate({
            scrollTop: ($("ELEMENT NAME HERE").offset().top)
        }, 500);
    }

---

#### Elements Hide/Fade

***Purpose:***

This is a simple feature that fades out or hides ceratin elements when the page is scrolled. This feature only runs once, however it is reactived by the [Top Checker](#top-checker) feature allowing it to run once more each time [Top Checker](#top-checker) is activated. 

***Elements Effected***

div.blackbox : This is simply a black rectangle that fades out dispalying the lightbulb background within the header of the page.

#left : this is the left panel of the pages header which is hidden by sliding to the left

#right : this is the right panel of the pages header which is hidden by sliding to the right

div.scrollTop : Unlike other elements this one fades in when the page is scrolled down, this is the button which allows a user to instantly scroll back to the top of the page

div.gearBox : This is the element containing the gear rotation animation in the header, upon scrolling down the animation is stopped to save resources

#quote : the header quote fades out upon scrolling down

***Implmentation:***

All of these effects use simple .fadeIn(), .fadeOut(), .hide() methods, additionally certain effects use .hide("slide") to achieve a slide left/right effect.

***Example Code:***

    function fader() {
        $("div.blackbox").fadeOut(2000);
        $("#left").hide("slide", {
            direction: "left"
        }, 1000);
        $("#right").hide("slide", {
            direction: "right"
        }, 1000);
        $("div.gearBox").contents().css("animation", "none");
        $("div.scrollTop").fadeIn(2000);
        $("#quote").fadeOut(500);
    }

---

#### Top Checker

***Purpose:***

The purpose of this feature is to simply check if the user is scrolled to the top of the page in order to activate various functions and features.


***Elements Effected***

div.blackbox : This is simply a black rectangle that fades in hiding the lightbulb background within the header of the page.

#left : this is the left panel of the pages header which is shown by sliding from the left

#right : this is the right panel of the pages header which is shown by sliding from the right

div.scrollTop : Unlike other elements this one fades out when the page is scrolled to the top.

div.gearBox : This is the element containing the gear rotation animation in the header, upon scrolling to the top the animation restarts.

#quote : the header quote fades in upon scrolling to the top


***Implmentation:***

This feature uses an if statement to check the scroll position of the window, and if it is 0 it proceeds with the effects. All of the effects use simple .fadeIn(), .fadeOut(), .show() methods, additionally certain effects use .show("slide") to achieve a slide left/right effect.

***Example Code:***

    function topCheck() {
        if ($(window).scrollTop() == 0) {
            $("div.blackbox").fadeIn(200);
            $("#left").show("slide", {
                direction: "left"
            }, 2000);
            $("#right").show("slide", {
                direction: "right"
            }, 2000);
            //setTimeout(function () {$("div.slideShow").css("opacity","100%")}, 2000);
            $("div.scrollTop").fadeOut(200);
            expander();
            $(window).one("scroll", menuToggle);
            $(window).one("scroll", fader);
            $("div.gearBox").contents().css("animation", "");
            $("#quote").fadeIn(2000);
        }
    }

---

#### Menu Toggler

***Purpose:***

This feature simply animates the navigation menu to slide it out of view when the user scrolls down. This only happens once, but is reactivated by [Top Checker](#top-checker) to allow to to run once more for each time [Top Checker](#top-checker) is activated.

***Elements Effected***

div.menu : This is the navigation menu element located at the bottom of the page ( and the sticking near the top of the page), it contains buttons which scroll to various sections of the site.

***Implmentation:***

This feature is a simple if/else statement which checks if the width of the menu element is currently 0, if it is then it runs a function called 'expander' which sets the width of the menu to 90% the width of the page, and then displays all of the buttons on the menu which were hidden. If the width is not 0, it runs a 'menuHider' function which sets the width to be 0, and hides all of the buttons contained within

***Example Code:***

    function menuToggle() {
        if ($("div.menu").width() == 0) {
            expander();
        } else {
            menuHider();
        }
    }

___

#### Scaler

***Purpose:***

This feature is for the purpose of scaling elements on the page to fit certain screen sizes, currently it only scales up in the event that the width of a page is greater than 3460px (400 pixels under that of 4k).

***Elements Effected***

The majority of elements that hold important information, as well as fonts, are scaled accordingly.

***Implmentation:***

winSizeCheck

This feature uses simple if and else/if statements to check the current width of the window and scales different elements on the page according to defined style changes using .css(). The function runs the background resize function in order to match the background to newly scaled elements. This function is triggered whenever the window is resized.

***Example Code:***

    function winSizeCheck() {
        if ($(window).width() >= 3460) {
            $("div.contentBox").css("max-width", "1500px")
            $("div.contentBox").css("font-size", "200%")
            $("div.popContent").css("font-size", "200%")
            $("div.aboutBox h1").css("font-size", "400%")
            ...etc
            ...
            ...
            backgroundResize()

___
___

## References

___


### Github Calendar

This feature simple embeds a github activity chart onto the webpage. Included in this references is "github-calendar-responsive.css" and github-calendar.min.js"

***Link:***

https://stackoverflow.com/questions/34516592/embed-github-contributions-graph-in-website

___
___
