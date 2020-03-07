$(document).ready(function () {
    //savedstuff: headerpic" src="https://avatars1.githubusercontent.com/u/47985359?s=460&v=4
    //----projects
    $("div.scrollTop").hide();
    $("#projects").css("height", "0");
    var files = ['projects/twittersent.html', 'projects/test2.html', 'projects/test3.html','projects/test4.html','projects/bashproject1.html', 'projects/test3.html', 'projects/test3.html', 'projects/test3.html', 'projects/test3.html'];
    function cardMaker(){
    files.forEach(function (item) {
        $.get(item, null, function (data) {
            var result = $(data);
            var type = ((result.filter("div.type"))[0].innerText)
            var title = ((result.filter("div.title"))[0].innerText)
            var pic = ((result.filter("div.pic"))[0].innerText)
            var card = $('<div id="' + type + item + '" class="postBox"> <div class="title">' + title + '</div><div class="content" style="background-image: url(' + pic + ')" ></div><div data-link="' + item + '" class="btnView">View me!</div></div>');
            var overlay = $('<div id="' + item + '" class="overlay" style="opacity: 0"><div class="window"><div class="close">X</div><div class="popHeader"><h1>' + title +'</h1></div><div class="popContent"></div></div></div>')
            $("body").prepend(overlay);
            $("div.overlay").hide();
            $("#projects").append(card);
            $("div.btnView").on('click', overlayShow)
            $("#projects").css("height", $("div.postBox").height() * (($("div.postBox").length / 4) + 2));
        });
    })
    }
    cardMaker()
    setTimeout(function(){
        window.scrollTo(0, 0);
        loadRemove()
    }, 2000);
    //$("#python1 div.title").load("projects/twittersent.html div.title");
    //$("body").load()
    //----
    
    var totalH = $(document).height();
    var topH = $("div.header_container").height();
    var menH = $("div.menu_container").height();
    $(".fakeBackground").css("height", totalH - topH - menH);
    $("div.overlay").css("opacity", "100");
    var p = $("div.menu").last();
    var origOffset = p.offset().top;
    
    function loadRemove() {
        
        $("div.loadingScreen").fadeOut(2000);
        setTimeout(function(){
        $("div.loadingScreen").remove();
    }, 2000);
    }

    function expander() {
        $("div.menu").animate({
                width: '90%'
            }, 1000,
            buttonShower);
    }

    function menuHider() {
        $("div.menu").animate({
                width: '0'
            }, 1000,
            buttonHider);

    }

    function menuToggle() {
        if ($("div.menu").width() == 0) {
            expander();
        } else {
            menuHider();
        }
    }

    function buttonHider() {
        $("button.item").hide()
    }

    function buttonShower() {
        $("button.item").show()
    }

    function topCheck() {
        if ($(window).scrollTop() == 0) {
            $("div.blackbox").fadeIn(200);
            $("div.scrollTop").fadeOut(200);
            expander();
            $(window).one("scroll", menuToggle);
            $(window).one("scroll", fader);
        }
    }

    function wordFade() {
        if ($(window).scrollTop() == 0) {
            $("#quote").fadeIn(2000)
        } else {
            $("#quote").fadeOut(500)
        }
    }

    function fader() {
        $("div.blackbox").fadeOut(2000)
        $("div.scrollTop").fadeIn(2000);
    }

    function pythonHider() {
        $("#btnAll").css("background-color", "transparent")
        $("#btnPython").css("background-color", "lightblue")
        $("#btnJava").css("background-color", "transparent")
        $("#btnBash").css("background-color", "transparent")
        $("#btnHaskell").css("background-color", "transparent")
        $("#btnHTML").css("background-color", "transparent")
        $('div[id^="java"]').fadeOut(500);
        $('div[id^="python"]').fadeIn(500);
        $('div[id^="html"]').fadeOut(500);
        $('div[id^="bash"]').fadeOut(500);
        $('div[id^="haskell"]').fadeOut(500);
    }

    function javaHider() {
        $("#btnAll").css("background-color", "transparent")
        $("#btnPython").css("background-color", "transparent")
        $("#btnJava").css("background-color", "lightblue")
        $("#btnBash").css("background-color", "transparent")
        $("#btnHaskell").css("background-color", "transparent")
        $("#btnHTML").css("background-color", "transparent")
        $('div[id^="java"]').fadeIn(500);
        $('div[id^="python"]').fadeOut(500);
        $('div[id^="html"]').fadeOut(500);
        $('div[id^="bash"]').fadeOut(500);
        $('div[id^="haskell"]').fadeOut(500);
    }

    function htmlHider() {
        $("#btnAll").css("background-color", "transparent")
        $("#btnPython").css("background-color", "transparent")
        $("#btnJava").css("background-color", "transparent")
        $("#btnBash").css("background-color", "transparent")
        $("#btnHaskell").css("background-color", "transparent")
        $("#btnHTML").css("background-color", "lightblue")
        $('div[id^="java"]').fadeOut(500);
        $('div[id^="python"]').fadeOut(500);
        $('div[id^="html"]').fadeIn(500);
        $('div[id^="bash"]').fadeOut(500);
        $('div[id^="haskell"]').fadeOut(500);
    }

    function bashHider() {
        $("#btnAll").css("background-color", "transparent")
        $("#btnPython").css("background-color", "transparent")
        $("#btnJava").css("background-color", "transparent")
        $("#btnBash").css("background-color", "lightblue")
        $("#btnHaskell").css("background-color", "transparent")
        $("#btnHTML").css("background-color", "transparent")
        $('div[id^="java"]').fadeOut(500);
        $('div[id^="python"]').fadeOut(500);
        $('div[id^="html"]').fadeOut(500);
        $('div[id^="bash"]').fadeIn(500);
        $('div[id^="haskell"]').fadeOut(500);
    }

    function haskellHider() {
        $("#btnAll").css("background-color", "transparent")
        $("#btnPython").css("background-color", "transparent")
        $("#btnJava").css("background-color", "transparent")
        $("#btnBash").css("background-color", "transparent")
        $("#btnHaskell").css("background-color", "lightblue")
        $("#btnHTML").css("background-color", "transparent")
        $('div[id^="java"]').fadeOut(500);
        $('div[id^="python"]').fadeOut(500);
        $('div[id^="html"]').fadeOut(500);
        $('div[id^="bash"]').fadeOut(500);
        $('div[id^="haskell"]').fadeIn(500);
    }

    function allShower() {
        $("#btnAll").css("background-color", "lightblue")
        $("#btnPython").css("background-color", "transparent")
        $("#btnJava").css("background-color", "transparent")
        $("#btnBash").css("background-color", "transparent")
        $("#btnHaskell").css("background-color", "transparent")
        $("#btnHTML").css("background-color", "transparent")
        $('div[id^="java"]').fadeIn(500);
        $('div[id^="python"]').fadeIn(500);
        $('div[id^="html"]').fadeIn(500);
        $('div[id^="bash"]').fadeIn(500);
        $('div[id^="haskell"]').fadeIn(500);
    }

    function projectsScroller() {
        $('html, body').animate({
            scrollTop: ($('#projectsHeader').offset().top)
        }, 500);
    }

    function aboutScroller() {
        $('html, body').animate({
            scrollTop: ($('#aboutme').offset().top)
        }, 500);
    }

    function contactScroller() {
        $('html, body').animate({
            scrollTop: ($('#contactHeader').offset().top)
        }, 500);
    }

    function overlayClose() {
        $("div.overlay").fadeOut();
        $("div.popContent").empty();
    }

    function backgroundResize() {
        $(".fakeBackground").css("height", "0");
        var totalH = $(document).height();
        var topH = $("div.header_container").height();
        var menH = $("div.menu_container").height();
        $(".fakeBackground").css("height", totalH - topH - menH);
    }

    function minimizer() {
        if ($(this).parent().height() == 50) {
            $(this).parent().css("min-height", "50%");
            $(this).parent().css("height", "auto");
            $(this).css("transform", "rotate(0deg)")
            if ($(this).parent().is("#projects")) {
                $(this).parent().css("height", $("div.postBox").height() * (($("div.postBox").length / 4) + 2));
            }
            $(this).parent().contents().not("div.minimizer").show()
            backgroundResize();
        } else {
            var origH = $(this).parent().height();
            $(this).parent().css("min-height", "0");
            $(this).parent().animate({
                height: '50'
            }, 1000);
            $(this).parent().contents().not("div.minimizer").hide();
            $(this).css("transform", "rotate(180deg)")
            $(".fakeBackground").css("height", $(".fakeBackground").height() - origH);
        }

    }
    
    function overlayShow() {
        var file = $(this).attr("data-link");
        $("div.overlay").fadeIn();
        $("div.popHeader").load(file + " div.title");
        $("div.popContent").load(file + " div.starthere");
    }
    function topScroll(){
        $('html, body').animate({
            scrollTop: ($('body').offset().top)
        }, 500);
    }
    
    function msgSent(){
        var name = $("#inqName").val();
        alert(name + ", your message has been sent!");
        $("#inqMsg").val("");
        $("#inqEmail").val("");
        $("#inqName").val("");
        
    }
    
    $("div.menubtn").click(menuToggle)
    $(window).one("scroll", menuToggle)
    $(window).scroll(topCheck)
    $(window).scroll(wordFade)
    $(window).one("scroll", fader)
    $("#btnAll").click(allShower)
    $("#btnPython").click(pythonHider)
    $("#btnJava").click(javaHider)
    $("#btnBash").click(bashHider)
    $("#btnHaskell").click(haskellHider)
    $("#btnHTML").click(htmlHider)
    $("#btnProjects").click(projectsScroller)
    $("#btnAbout").click(aboutScroller)
    $("#btnContact").click(contactScroller)
    $("div.close").click(overlayClose)
    $(window).resize(backgroundResize)
    $("div.minimizer").click(minimizer)
    $("div.scrollTop").click(topScroll)
    $("#inq").click(msgSent)
})
