function newSnippit() {
  $('#new-snippit').on("click", function(event) {
    event.preventDefault();
    $.ajax({
      method: "GET",
      url: $(this).attr('href')
    }).then(function(result) {
      var newSnippitForm = $(result).find('#new-snippit').html();
      $('#snippits-container').html(newSnippitForm);
    });
  });
}

function editSnippit() {
  $('*#edit-snippit').each(function() {
    $(this).on("click", function(event) {
      event.preventDefault();
      $.ajax({
        method: "GET",
        url: $(this).attr('href')
      }).then(function(result) {
        var editSnippitForm = $(result).find('#edit-snippit').html();
        $('#snippits-container').html(editSnippitForm);
      });
    });
  });
}

function showSnippit() {
  $('#show-snippit').on("click", function(event) {
    event.preventDefault();
    $.ajax({
      method: "GET",
      url: $(this).attr('href')
    }).then(function(result) {
      var snippit = $(result).find('#snippit').html();
      $('#snippits-container').html(snippit);
    });
  });
}

// render single bookmark meta data
function bookmarkMouseover() {
  $(document).on('mouseenter', '.bookmark', function() {
    var bookmark = $(this).html();
    var aTag = $(bookmark).filter('#link').html();
    var url = $(aTag).attr('href');
    $.ajax({
      method: "GET",
      url: url
    }).then(function(result) {
      var userBookmark = $(result).find('#user-bookmark-show').html();
      $("#user-dash-bookmark-meta-display").html(userBookmark);
    }).then(function() {
      newSnippit();
      editSnippit();
      showSnippit();
    }).fail(function(){
      console.log(arguments);
    });
  });
}

// render new folder form on user dashboard
function renderFolderForm() {
  $.ajax({
    method: "GET",
    url: "/folders/new"
  }).then(function(result) {
    var newFolder = $(result).find('#new-folder').html();
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
        $('#user-dash-folder-display').find(folderContent);
      }).then(function() {
        bookmarkMouseover();
        editBookmark();
      });
    });
  });
}

// ajax the edit bookmark get request for the edit form
function editBookmark() {
  $('*#edit').each(function() {
    $(this).on('click', function(event) {
      event.preventDefault();
      var id = $(this).data().type;
      $.ajax({

        method: "GET",
        url: '/user_bookmarks/' + id + '/edit'
      }).then(function(response){
        var editBookmarkForm = $(response).find('#edit-bookmark').html();
        console.log(editBookmarkForm);
        // var id = $(response).find(".edit_user_bookmark input").last().val();
        // var editForm = $(response).find(".edit_user_bookmark");
         $("#user-dash-bookmark-meta-display").html(editBookmarkForm);
      }).fail(function(errors){
        console.log(errors);
      });
    });
  });
}

function editFolder(){
  $('*#folderEdit').each(function(){
    $(this).on('click', function(event){
      event.preventDefault();
      var id = $(this).data().type;
      $.ajax({
        method: "GET",
        url: '/folders/' + id + '/edit'
      }).then(function(response){
        var editForm = $(response).find(".edit_folder")
        $("#user-dash-bookmark-meta-display").html(editForm);
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
      var newBookmarkForm = $(result).find('#new-bookmark').html();
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
    var returned = $(result).find('#search-results').html();
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

function getRegistration () {
  $('#register').on('click', function(){
    event.preventDefault();
  $.ajax({
    method: "GET",
    url: "/users/new",
  }).done(function(response) {
    $('#ajax').html(response);
      }).fail(function(error) {
        console.log("Error: " + error);
        });
  });
}

$(document).ready(function() {
  if (window.location.pathname == '/user_bookmarks') {
          renderFolderForm();
        }
  getRegistration();
  bookmarkMouseover();
  displayFolderBookmarks();
  newBookmarkForm();
  editBookmark();
  editFolder();

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
