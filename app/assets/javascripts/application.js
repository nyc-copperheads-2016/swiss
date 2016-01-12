// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require_tree .

// render single bookmark meta data
function bookmarkMouseover() {
  $('*#bookmark').each(function() {
    $(this).mouseover(function() {
      var bookmark = $(this).html();
      var aTag = $(bookmark).filter('#link').html();
      var url = $(aTag).attr('href');
      $.ajax({
        method: "GET",
        url: url
      }).then(function(result) {
        var userBookmark = $(result).filter('#user-bookmark-show').html();
        $("#user-dash-bookmark-meta-display").html(userBookmark);
      });
    });
  });
}

// render new folder form on user dashboard
function renderFolderForm() {
  $.ajax({
    method: "GET",
    url: "/folders/new"
  }).then(function(result) {
    var newFolder = $(result).filter('#new-folder').html();
    $('#user-profile-new-folder').html(newFolder);
  });
}

// user dashboard display bookmarks by folder logic
function displayFolderBookmarks() {
  $('*#folder-name').each(function() {
    $(this).on("click", function(event) {
      event.preventDefault();

      $.ajax({
        method: "GET",
        url: $(this).attr('href')
      }).then(function(result) {
        var folderContent = $(result).filter('#folder-bookmarks-show').html();
        $('#user-dash-folder-display').html(folderContent);
      }).then(function() {
        bookmarkMouseover();
      });
    });
  });
}


// user dashboard new bokmark logic
function newBookmarkForm() {
  $('#user-dash-new-bookmark').on("click", function(event) {
    event.preventDefault();

    $.ajax({
      method: "GET",
      url: "/user_bookmarks/new"
    }).then(function(result) {
      var newBookmarkForm = $(result).filter('#new-bookmark').html();
      $('#modular-user-nav-tab').html(newBookmarkForm);
    });
  });
}

// search bar logic
function doneTyping () {
  $.ajax({
    method: "GET",
    url: "/",
    data: {q: $('#search-field').val()}
  }).then(function(result) {
    var returned = $(result).filter('#search-results').html();
    $('#search-results').html(returned);

    $("*#search-result-link").each(function() {
      $(this).on("click", function(event) {
        event.preventDefault();
        var $link = $(event.target).attr('href');
        $('#preview-frame').html('<iframe id="frame" width="100%" height="500" src="' + $link + '"></iframe>');
      });
    });
  });
}


$(document).ready(function() {

  renderFolderForm();
  bookmarkMouseover();
  displayFolderBookmarks();
  newBookmarkForm();

// search bar logic

  var typingTimer;
  var doneTypingInterval = 0;

  $('#search-field').on('keyup', function () {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(doneTyping, doneTypingInterval);
  });

  $('#search-field').on('keydown', function () {
    clearTimeout(typingTimer);
  });

  doneTyping();

});
