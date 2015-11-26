# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|

  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    new_movie = Movie.create(movie)
    # puts "#{new_movie.title}, #{new_movie.rating}, #{new_movie.release_date}"
  end
  
  # Movie.all.each{|m| puts "#{m.title}, #{m.rating}, #{m.release_date}"}
  # fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  expect(page).to have_content(e1)
  expect(page).to have_content(e2)
  expect(page.body.index(e1)).to be < page.body.index(e2)
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  boxes = rating_list.split
  #puts "CheckBoxes=#{boxes}"
  boxes.each do |rating|
    #puts"Rating=#{rating}"
    if uncheck then
      #puts"Uncheck=#{rating}"
      uncheck(rating)
    else
      #puts"Check=#{rating}"
      check(rating)
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie| 
    #puts "Searching Page for Movie Title= #{movie.title}"
    expect(page).to have_content(movie.title)
  end
end


Then /the (.*) of "(.*)" should be "(.*)"/ do |field, title, expected_value|
  # Make sure that all the movies in the app are visible in the table

  movie = Movie.where(:title=>title).first 
  #puts movie.inspect
  instance_value = eval("movie.#{field}") 
  #puts "#{title}, #{field} should be #{expected_value}, current value=#{instance_value}"
  expect(instance_value).to eq expected_value
end