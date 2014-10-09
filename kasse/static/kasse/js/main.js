(function () {
    /*function loadContent(url) {
        $("#content").html(url);
    }*/

    $( document ).ready(function() {
        $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    });
    
})();
