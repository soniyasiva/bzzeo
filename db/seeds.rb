# http://hbswk.hbs.edu/industries/
[
  "Accommodations",
  "Accounting",
  "Advertising",
  "Aerospace",
  "Agriculture & Agribusiness",
  "Air Transportation",
  "Apparel & Accessories",
  "Auto",
  "Banking",
  "Beauty & Cosmetics",
  "Biotechnology",
  "Chemical",
  "Communications",
  "Computer",
  "Construction",
  "Consulting",
  "Consumer Products",
  "Education",
  "Electronics",
  "Employment",
  "Energy",
  "Entertainment & Recreation",
  "Fashion",
  "Financial Services",
  "Food & Beverage",
  "Health",
  "Information",
  "Information Technology",
  "Insurance",
  "Journalism & News",
  "Legal Services",
  "Manufacturing",
  "Media & Broadcasting",
  "Medical Devices & Supplies",
  "Motion Pictures & Video",
  "Music",
  "Pharmaceutical",
  "Public Administration",
  "Public Relations",
  "Publishing",
  "Real Estate",
  "Retail",
  "Service",
  "Sports",
  "Technology",
  "Telecommunications",
  "Tourism",
  "Transportation",
  "Travel",
  "Utilities",
  "Video Game",
  "Web Services"
].each do |category|
  Category.create!(name: category)
end

Page.create!([
  {title: "About", slug: "about", html: "<p>ok</p>"},
  {title: "Home", slug: 'home', html: "<div class=\"row\">\r\n  <div class=\"col-xs-12 col-sm-6\">\r\n    <div class=\"embed-responsive embed-responsive-16by9\">\r\n      <iframe allowfullscreen=\"\" class=\"embed-responsive-item\" frameborder=\"0\" src=\"https://www.youtube.com/embed/pt8VYOfr8To\"></iframe>\r\n    </div>\r\n    <h3 class=\"text-center\">\r\n      Explore businesses, deals, jobs + more - locally &amp; globally!\r\n    </h3>\r\n  </div>\r\n  <div class=\"col-xs-12 col-sm-6\">\r\n    <form action=\"/users/sign_in\" accept-charset=\"UTF-8\" method=\"post\"><input name=\"utf8\" type=\"hidden\" value=\"✓\"><input type=\"hidden\" name=\"authenticity_token\" value=\"3Zyj5wfCiKvIqP5u1FHhhEuKjmUyW6P6ZLTyvx4LnLFA8mvY5qy9H6Fd7945BO94abeJBwpM5UKUS0oI7XBxaA==\">\r\n      <div class=\"row\">\r\n        <div class=\"col-xs-12\">\r\n          <h2 class=\"text-center\">(Get ahead, Get bzzeo.)</h2>\r\n            <div class=\"form-group\">\r\n              <label for=\"user_email\">Email</label>\r\n              <input type=\"text\" name=\"user[email]\" id=\"user_email\" class=\"form-control\">\r\n            </div>\r\n            <div class=\"form-group\">\r\n              <label for=\"user_password\">Password</label>\r\n              <input type=\"password\" name=\"user[password]\" id=\"user_password\" class=\"form-control\">\r\n            </div>\r\n            <div class=\"form-group\">\r\n              <input type=\"checkbox\" name=\"user[remember_me]\" id=\"user_remember_me\" checked=\"checked\">\r\n              <label for=\"user_remember_me\">Remember me</label>\r\n            </div>\r\n        </div>\r\n      </div>\r\n      <div class=\"row\">\r\n        <div class=\"col-xs-12 col-sm-6\">\r\n          <button class=\"btn btn-block btn-primary\">Login</button>\r\n          <a href=\"/users/password/new\">Forgot your password?</a>\r\n        </div>\r\n        <div class=\"col-xs-12 col-sm-6\">\r\n          <a class=\"btn btn-block btn-default\" href=\"/users/sign_up\">Join</a>\r\n        </div>\r\n      </div>\r\n    </form>\r\n  </div>\r\n</div>"}
])
PostCategory.create!([
  {name: "review"},
  {name: "job"},
  {name: "status"},
  {name: "portfolio"},
  {name: "promotion"}
])
