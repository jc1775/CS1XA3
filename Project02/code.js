$(document).ready(function() {
    //savedstuff: headerpic" src="https://avatars1.githubusercontent.com/u/47985359?s=460&v=4 color: rgb(56, 50, 50)
    //something interesting for later $("div.popContent").load('https://cors-anywhere.herokuapp.com/https://github.com/jc1775/python-programming/blob/master/Twitter%20Sentiment%20Analysis.ipynb iframe.render-viewer')


    //----projects card generator
    var files = ['projects/twittersent.html', 'projects/bashproject1.html', 'projects/webcv.html', 'projects/learningsite.html', 'projects/projecttemplate.html', 'projects/projecttemplate.html', 'projects/projecttemplate.html', 'projects/projecttemplate.html', 'projects/projecttemplate.html', 'projects/projecttemplate.html'];

    function cardMaker() {
        files.forEach(function(item) {
            $.get(item, null, function(data) {
                var result = $(data);
                var type = ((result.filter("div.type"))[0].innerText)
                var title = ((result.filter("div.title"))[0].innerText)
                var pic = ((result.filter("div.pic"))[0].innerText)
                var datalink = ((result.filter("div.link"))[0].innerText)
                var card = $('<div id="' + type + item + '" class="postBox"> <div class="title">' + title + '</div><div class="content" style="background-image: url(' + pic + ')" ></div><div data-link="' + datalink + '" class="btnView">View me!</div></div>');
                $("#projectItems").append(card);
                $("div.btnView").on('click', overlayShow)
            });
        })
    }
    //----------------------

    //----auto slideshow--not currently in use
    var pics = []
    var x = -1;

    function slideShow() {
        if (x < (pics.length)) {
            $("div.imagCont").toggle("slide", {
                direction: "left"
            }, 1000)
            setTimeout(function() {
                x++;
                $("div.imagCont").css("background-image", 'url(' + pics[x] + ')');
                $("div.imagCont").toggle("slide", {
                    direction: "right"
                }, 1000)
            }, 2000)

        } else {
            x = -1;
        }
        setTimeout(function() {
            slideShow();
        }, 6000)
    }
    //----------------------

    //----This rescales a bunch of elements and font sizes if the screen width is greater than 3840px
    function winSizeCheck() {
        if ($(window).width() >= 3460) {
            $("div.contentBox").css("max-width", "1500px")
            $("div.contentBox").css("font-size", "200%")
            $("div.popContent").css("font-size", "200%")
            $("div.aboutBox h1").css("font-size", "400%")
            $("div.header").css("height", "90px")
            $("#inqName").css("width", "1000px")
            $("#inqMsg").css("width", "1000px")
            $("#inqName").css("height", "70px")
            $("#inqEmail").css("height", "70px")
            $("#inqEmail").css("width", "1000px")
            $("#inqName").css("font-size", "35px")
            $("#inqMsg").css("font-size", "35px")
            $("#inqEmail").css("font-size", "35px")
            $("div.postBox").css("width", "300px")
            $("div.postBox").css("max-width", "350px")
            $("div.postBox").css("height", "300px")
            $("div.postBox").css("max-width", "350px")
            $("#projectitems").css("max-width", "2500px")
            $("#projectitems").css("width", "2500px")
            backgroundResize()
        } else {
            $("div.aboutBox h1").css("font-size", "")
            $("div.contentBox").css("max-width", "")
            $("div.contentBox").css("font-size", "")
            $("div.popContent").css("font-size", "")
            $("div.header").css("height", "")
            $("#inqName").css("width", "")
            $("#inqMsg").css("width", "")
            $("#inqName").css("height", "")
            $("#inqEmail").css("height", "")
            $("#inqEmail").css("width", "")
            $("#inqName").css("font-size", "")
            $("#inqMsg").css("font-size", "")
            $("#inqEmail").css("font-size", "")
            $("div.postBox").css("width", "")
            $("div.postBox").css("max-width", "")
            $("div.postBox").css("height", "")
            $("div.postBox").css("max-width", "")
            $("#projectitems").css("max-width", "")
            $("#projectitems").css("width", "")
            backgroundResize()
        }
    }
    //----------------------

    function loadRemove() {
        $("div.loadingScreen").fadeOut(2000);
        setTimeout(function() {
            $("div.loadingScreen").remove();
            titleTyper()
        }, 2000);
    }

    function expander() {
        $("div.menu").animate({
            width: '90%'
        }, 1000, buttonShower);
    }

    function menuHider() {
        $("div.menu").animate({
            width: '0'
        }, 1000, buttonHider);
    }

    function menuToggle() {
        if ($("div.menu").width() == 0) {
            expander();
        } else {
            menuHider();
        }
    }

    function buttonHider() {
        $("button.item").hide();
    }

    function buttonShower() {
        $("button.item").show();
    }

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
            $("#title").fadeIn(2000);
        }
    }

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
        //$("div.slideShow").css("opacity", "0");
        $("#quote").fadeOut(500);
        $("#title").fadeOut(500);
    }

    function overlayClose() {
        $("div.overlay").fadeOut();
        $("div.popContent").empty();
    }

    function backgroundResize() {
        $(".fakeBackground").css("height", "0");
        var mainH = $("div.main_container").height();
        $("div.fakeBackground").css("height", mainH);
    }

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

    function overlayShow() {
        var file = $(this).attr("data-link");
        var title = $(this).parent().find("div.title").text()
        $("div.overlay").fadeIn();
        $("div.popHeader").text(title);
        $("div.popContent").load(file);
    }

    function topScroll() {
        $('body').animate({
            scrollTop: ($('body').offset().top)
        }, 500);
    }

    function msgSent() {
        var name = $("#inqName").val();
        alert(name + ", your message has been sent!");
        $("#inqMsg").val("");
        $("#inqEmail").val("");
        $("#inqName").val("");
    }

    function projectSorter() {
        var toKeep = $(this).attr("data-actsOn");
        $("btn.blockOptionsbtn").css("background-color", "transparent");
        $(this).css("background-color", "orange")
        if (toKeep == "All") {
            $("div.postBox").fadeIn(500);
        } else {
            $("div.postBox").fadeOut(500);
            setTimeout(function() {
                $('div[id^="' + toKeep + '"]').fadeIn(500);
            }, 500);
        }
        setTimeout(function() {
            backgroundResize()
        }, 1010)
    }

    function menuScroller() {
        var toScrollTo = $(this).attr("data-actsOn");
        $('body').animate({
            scrollTop: ($("#" + toScrollTo).offset().top)
        }, 500);
    }

    function minimizerALL() {
        if ($(this).is("#minimize")) {
            $("div.pageBlock").each(function() {
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
            $("div.contentBox").css("height", "auto")
            $("div.contentBox").contents().fadeIn(200)
            $("div.pageBlock").each(function() {
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
    var title1 = ["<", "h", "1", " ", "i", "d", "=", "\"", "g", "r", "e", "e", "t", "i", "n", "g", "\"", ">", " ", "H", "e", "y", "!", " "]
    var title2 = ["<", "h", "1", " ", "i", "d", "=", "\"", "g", "r", "e", "e", "t", "i", "n", "g", "\"", ">", " ", "W", "a", "a", "z", "z", "z", "z", " ", "U", "p", "p", "!", "!", "!", ".", ".", "."]
    var title3 = ["<", "h", "1", " ", "i", "d", "=", "\"", "g", "r", "e", "e", "t", "i", "n", "g", "\"", ">", " ", "W", "e", "l", "c", "o", "m", "e", " ", "t", "o", " ", "J", "o", "s", "e", "p", "h", "'", "s", " ", "W", "e", "b", " ", "C", "V", "!", " ", "<", "/", "h", "1", ">"]
    var words = [title1, title2, title3]
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

    function smallMinimizer() {
        if ($(this).parent().find("div.contentBox").height() == 0) {
            $(this).parent().find("div.contentBox").css("height", "auto")
            $(this).parent().find("div.contentBox").contents().fadeIn(200)
            backgroundResize()
        } else {
            var origH = $(this).parent().find("div.contentBox").height()
            $(this).parent().find("div.contentBox").animate({
                height: 0
            }, 300);
            $(this).parent().find("div.contentBox").contents().hide()
            $(".fakeBackground").css("height", $(".fakeBackground").height() - origH);

        }

    }

    function autoSplit() {
        var randInterval = Math.random() * 5000
        var gearNum = Math.floor(Math.random() * ("div.gear").length);
        var gearSelect = $("div.gear").eq(gearNum);
        randShift.call(gearSelect);
        setTimeout(function() { autoSplit() }, randInterval)
    }
    //---------------------------------------------------------------------End of function declarations

    cardMaker()
    $("div.overlay").hide();
    $("div.overlay").css("opacity", "100");
    $("div.scrollTop").hide();
    $("div.miniTitle").hide();

    //----This runs after 2s giving page elements time to load and set
    setTimeout(function() {
        window.scrollTo(0, 0);
        backgroundResize();
        winSizeCheck();
        loadRemove();
        autoSplit();
    }, 2000);
    //----------------------

    //---Actions
    $(window).one("scroll", menuToggle)
    $(window).scroll(topCheck)
    $(window).resize(backgroundResize, winSizeCheck)
    $(window).one("scroll", fader)
    $("btn.blockOptionsbtn").click(projectSorter)
    $("button.item").click(menuScroller)
    $("div.close").click(overlayClose)
    $("div.minimizer").click(minimizer)
    $("div.scrollTop").click(topScroll)
    $("#inq").click(msgSent)
    $("div.exminbtn").click(minimizerALL)
    $("div.gear").click(randShift)
    $("div.menubtn").click(menuToggle)
    $("div.aboutBox h1").click(smallMinimizer)

})