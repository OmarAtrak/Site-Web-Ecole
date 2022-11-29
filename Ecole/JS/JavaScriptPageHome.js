let etat = true;
let eye = document.getElementById("show");
let txtpassword = document.getElementById("password");

eye.addEventListener("click", function () {
    if (etat == true) {
        eye.setAttribute("src", "icons/hidden.png");
        txtpassword.setAttribute("type", "text");
        etat = false;
    }
    else {
        eye.setAttribute("src", "icons/view.png");
        txtpassword.setAttribute("type", "password");
        etat = true;
    }
});