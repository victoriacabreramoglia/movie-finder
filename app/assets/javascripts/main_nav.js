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
            <a href="/critics/index">
              <div class='page__nav-menu-accordion-item'>
                Critics
              </div>
            </a>
          <a href="/movie/index">
            <div class='page__nav-menu-accordion-item'>
              Movies
            </div>
          </a>
        </div>
        `);
    } else {
      nav = false;
      $(".page__nav-menu-accordion").empty();
    }
  });
});
