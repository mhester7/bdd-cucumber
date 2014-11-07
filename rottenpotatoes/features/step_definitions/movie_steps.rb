Given /the following movies exist/ do |movies_table|
    Movie.create!(movies_table.hashes)
    step("there should be #{movies_table.hashes.length} movies")
end

Then /^there should be (.*) movies$/ do |num|
	assert_equal num.to_i, Movie.count
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #debugger
  if page.respond_to? :should
    page.should have_content(e1)
    page.should have_content(e2)
  else
    assert page.has_content?(e1)
    assert page.has_content?(e2)    
  end
  debugger
  first = page.body.index(e1)
  second = page.body.index(e2)
  first.should < second
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(%r{,\s*}).each do |rating|
		if uncheck
			step(%Q{uncheck "ratings[#{rating}]"}) #.chomp("'").reverse.chomp("'").reverse}]"})
		else
			step(%Q{check "ratings[#{rating}]"}) #.chomp("'").reverse.chomp("'").reverse}]"})
		end
	end
end


Then /I should see all the movies/ do
	rows = Movie.count
	if rows != nil
		rows.should == 10
	end  
end
