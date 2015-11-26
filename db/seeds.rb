Category.create!([
  {name: "Business and Marketing"},
  {name: "Real Estate"},
  {name: "Software"},
  {name: "Public Services"},
  {name: "Natural Resources"},
  {name: "Manufacturing"}
])
Page.create!([
  {html: "<p>ok</p>", slug: "about"}
])
PostCategory.create!([
  {name: "review"},
  {name: "job"},
  {name: "status"},
  {name: "portfolio"},
  {name: "promotion"}
])
