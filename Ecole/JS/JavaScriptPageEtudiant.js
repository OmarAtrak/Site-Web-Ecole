﻿let sidebar = document.getElementById("content-menu");
let profil = document.getElementById("info");
let mot_passe = document.getElementById("mot_passe");
let bg_sidebar = document.getElementById("bg_sidebar");
let content_profil = document.getElementById("content_profil");
let content_mot_passe = document.getElementById("content_mot_passe");
let tbl_info = document.getElementById("tbl_info");


function OpenSidebar() {
    sidebar.style.left = "0px";
}
function CloseSidebar() {
    sidebar.style.left = "-350px";
}
function ActiverOpacity_0() {
    bg_sidebar.style.top = "-100%";
    bg_sidebar.style.opacity = "0";
    bg_sidebar.style.position = "absolute";
}
function ActiverOpacity_1() {
    bg_sidebar.style.top = "0%";
    bg_sidebar.style.opacity = "1";
    bg_sidebar.style.position = "fixed";
}
function OpenContentProfile() {
    content_profil.style.top = "10%";
    content_profil.style.opacity = "1";
    content_profil.style.position = "fixed";
}
function CloseContentProfile() {
    content_profil.style.top = "-100%";
    content_profil.style.opacity = "0";
    content_profil.style.position = "absolute";
}

/**************************************for open sidebar**************************************/
document.getElementById("menu-btn").addEventListener("click", function () {
    OpenSidebar();
    ActiverOpacity_1();
    CloseContentProfile();
});

/**************************************for close sidebar**************************************/
document.getElementById("exit").addEventListener("click", function () {
    CloseSidebar();
    ActiverOpacity_0();
});

/********************************************* for close content by profil and sidebar *********************************************/
document.getElementById("bg_sidebar").addEventListener("click", function () {
    CloseSidebar();
    ActiverOpacity_0();
    CloseContentProfile();
});
/************************************* onclick btn profile for see the information *************************************/
profil.addEventListener("click", function () {
    ActiverOpacity_1();
    OpenContentProfile();
    CloseSidebar();
});


document.getElementById("circle").addEventListener("click", function () {
    let s = document.getElementById("s").style.display = "none";
});





/*let a = 0;
let sidebar = document.getElementById("content-menu");
let profil = document.getElementById("info");
let bg_sidebar = document.getElementById("bg_sidebar");
let content_profil = document.getElementById("content_profil");
let tbl_info = document.getElementById("tbl_info");
let btnUpdateMotPasse = document.getElementById("btnUpdateMotPasse");


function OpenSidebar() {
    sidebar.style.left = "0px";
}
function CloseSidebar() {
    sidebar.style.left = "-350px";
}
function ActiverOpacity_0() {
    bg_sidebar.style.top = "-100%";
    bg_sidebar.style.opacity = "0";
    bg_sidebar.style.position = "absolute";
}
function ActiverOpacity_1() {
    bg_sidebar.style.top = "0%";
    bg_sidebar.style.opacity = "1";
    bg_sidebar.style.position = "fixed";
}
function OpenContentProfile() {
    content_profil.style.top = "10%";
    content_profil.style.opacity = "1";
    content_profil.style.position = "fixed";
}
function CloseContentProfile() {
    content_profil.style.top = "-100%";
    content_profil.style.opacity = "0";
    content_profil.style.position = "absolute";
}

//**************************************for open sidebar**************************************
document.getElementById("menu-btn").addEventListener("click", function () {
    OpenSidebar();
    ActiverOpacity_1();
    CloseContentProfile();
    CloseContentMotPasse();
});

//**************************************for close sidebar**************************************
document.getElementById("exit").addEventListener("click", function () {
    CloseSidebar();
    ActiverOpacity_0();
});

//********************************************* for close content by profil and sidebar *********************************************
bg_sidebar.addEventListener("click", function () {
    ActiverOpacity_0();
    CloseContentProfile();
    CloseContentMotPasse();
    CloseSidebar();
});
//************************************* onclick btn profile for see the information *************************************
profil.addEventListener("click", function () {
    ActiverOpacity_1();
    OpenContentProfile();
    CloseSidebar();
});*/