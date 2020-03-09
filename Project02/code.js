$(document).ready(function() {
    //savedstuff: headerpic" src="https://avatars1.githubusercontent.com/u/47985359?s=460&v=4

    //----projects card generator
    var files = ['projects/twittersent.html', 'projects/bashproject1.html', 'projects/test2.html', 'projects/test3.html', 'projects/test4.html', 'projects/test5.html', 'projects/test6.html', 'projects/test2.html', 'projects/test3.html', 'projects/test4.html', 'projects/test5.html', 'projects/test6.html'];

    function cardMaker() {
        files.forEach(function(item) {
            $.get(item, null, function(data) {
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
    //----------------------

    //----auto slideshow
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

    //----This rescales a bunch of elements and font sizes if the screen width is greater than 2000px
    function winSizeCheck() {
        if ($(window).width() > 2000) {
            $("div.contentBox").css("max-width", "1500px")
            $("div.contentBox").css("font-size", "50px")
            $("div.popContent").css("font-size", "50px")
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
        } else {
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
        }
    }
    //----------------------

    function loadRemove() {
        $("div.loadingScreen").fadeOut(2000);
        setTimeout(function() {
            $("div.loadingScreen").remove();
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
        }
    }

    function wordFade() {
        if ($(window).scrollTop() == 0) {
            $("#quote").fadeIn(2000);
        } else {
            $("#quote").fadeOut(500);
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
        $("div.slideShow").css("opacity", "0");
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
        $("div.overlay").fadeIn();
        $("div.popHeader").load(file + " div.title");
        $("div.popContent").load(file + " div.starthere");
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
        $(this).css("background-color", "lightblue")
        if (toKeep == "All") {
            $("div.postBox").fadeIn(500);
        } else {
            $("div.postBox").fadeOut(500);
            setTimeout(function() {
                $('div[id^="' + toKeep + '"]').fadeIn(500);
            }, 500);
        }
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
        var rand = Math.random() * 100;
        var rand2 = (Math.random() * 10) * (Math.random() * 10);
        var time1 = 250 + rand
        var time2 = time1
        if (rand < 25) {
            $(this).animate({
                left: "+=" + (rand - rand2) + "%"
            }, time1)
            $(this).animate({
                width: "-=" + (rand - (rand2))
            }, time2)
        } else if (rand < 50) {
            $(this).animate({
                top: "+=" + (rand - rand2) + "%"
            }, time1)
            $(this).animate({
                height: "-=" + (rand - (rand2))
            }, time2)
        } else if (rand < 75) {
            $(this).animate({
                right: "+=" + (rand - rand2) + "%"
            }, time1)
            $(this).animate({
                width: "+=" + (rand - (rand2))
            }, time2)
        } else {
            $(this).animate({
                height: "+=" + (rand - (rand2))
            }, time2)
            $(this).animate({
                bottom: "+=" + (rand - rand2) + "%"
            }, time1)
        }

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
    }, 2000);
    //----------------------

    //---Actions
    $(window).one("scroll", menuToggle)
    $(window).scroll(topCheck)
    $(window).scroll(wordFade)
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

})