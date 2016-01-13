var getSessionPath = "http://localhost:3000/loggedin";
var postLoginPath = 'http://localhost:3000/login';
var getLoginFormPath = 'http://localhost:3000/chrome_new';
var getOpenTabPath = "http://localhost:3000/user_bookmarks";
var getUrlNamePath =  "http://localhost:3000/chrome";
var postBookmarkPath = 'http://localhost:3000/chrome_create';
var getLoginLinkPath = "http://localhost:3000/mlogin";

function loggedIn() {
$.get(getSessionPath, function(data) {
   if (data) {
     sessionStorage.loggedIn = true ;
     console.log("User is logged in");
     setFormVals().then(function(){postLink(data)});
    } else {
      console.log("hi");
      sessionStorage.clear();
      getLogin().then(function(){
        getHeader();
        logIn();
      });
    }
  });
}

$(document).ready(function(){
loggedIn();
})

function getHeader(){
  return $("#chrome_login a").on('click', function() {
    event.preventDefault();
    $.ajax({
      url: getLoginFormPath,
      method: 'GET'
    }).done(function(response){
      $('body').html(response);
    }).fail(function(error) {
      console.log("Error: " + error);
      });
  });
}

function getLogin(){
return $.get(getLoginLinkPath, function(form) {
        $("body").html(form);
      });
}

  function linkHome(){
  $("#chrome_app").on('click', 'a', function(event) {
    event.preventDefault();
    var newURL = getOpenTabPath;
    chrome.tabs.create({ url: newURL });
  });  
}

function logIn () {
  $('html').on('submit','#user_form', function(){
    event.preventDefault();
    $.ajax({
      url: postLoginPath,
      method: "POST",
      data: $(event.target).serialize()
    }).then(function() {
      loggedIn();
      }).fail(function(error) {
        console.log("Error: " + error);
        });
  });
}

function setFormVals () {
  return $.get(getUrlNamePath, function(form){
    chrome.tabs.query({'active': true, 'windowId': chrome.windows.WINDOW_ID_CURRENT},
      function(tabs){
        url = tabs[0].url;
        $('#url').val(url);
      });
      chrome.tabs.getSelected(null,function(tab) { // null defaults to current window
        title = tab.title;
        $('#name').val(title);
      });
    $("body").html(form);
    linkHome();
  });
}

function postLink (){$("#bookmark_form").on('submit', function() {
  event.preventDefault();
  $.ajax({
    url: postBookmarkPath,
    method: "POST",
    data: $(event.target).serialize()
  }).then(function(response) {
    console.log(response)
   $("body").html(response);
   linkHome();
    }).fail(function(error) {
      console.log("Error: " + error);
      });
  });
}

