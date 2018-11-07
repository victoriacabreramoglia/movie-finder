$(document).ready(function() {
  var nav = false;
  console.log("ready!");
  $(".page__nav-menu").click(function() {
    if (nav === false) {
      nav = true;
      $(this).after(`
        <div class="page__nav-menu-accordion">
          <div class='page__nav-menu-accordion-item'>
            About
          </div>
          <div class='page__nav-menu-accordion-item'>
            Critics
          </div>
          <div class='page__nav-menu-accordion-item'>
            Movies
          </div>
        </div>
        `);
    } else {
      nav = false;
      $(".page__nav-menu-accordion").empty();
    }
  });
});
