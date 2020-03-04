$(document).ready(function(){
    var p = $( "div.menu" ).last();
    var origOffset = p.offset().top;

    function expander() {
        $("div.menu").animate({width: '90%'}
        ,1000,
        buttonShower);
    }
    function menuHider() {
        $("div.menu").animate({width: '0'}
        ,1000,
        buttonHider);
        
    }
    function menuToggle(){
        if ($("div.menu").width() == 0) {
            expander();
        } else {
            menuHider();   
        }
    }
    function buttonHider(){
        $("button.item").hide()
    }
    function buttonShower(){
        $("button.item").show()
    }
    function topCheck(){
        if ( $(window).scrollTop() == 0 ) {
            expander();
            $(window).one("scroll", menuToggle);
        }
    }
    function wordFade(){
        if ( $(window).scrollTop() == 0 ) {
            $("#quote").fadeIn(2000)
        } else{
            $("#quote").fadeOut(500)
        }
    }
    function fader(){
        $("div.blackbox").fadeOut(2000)
    }
    $("div.menubtn").click(menuToggle)
    $(window).one("scroll", menuToggle)
    $(window).scroll(topCheck)
    $(window).scroll(wordFade)
    $(window).one("scroll",fader)
})