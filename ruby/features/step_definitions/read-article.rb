articles = []
currentArticle = nil

Given(/^an article with ID (\d+) exists and it has the title "([^"]*)"$/) do |id, title|
    articles[id.to_i] = { title: title }
end

When(/^I request vg\.no\/a\/(\d+)$/) do |id|
    id = id.to_i
    currentArticle = nil
    currentArticle = articles[id] unless articles[id].nil?
end

Then(/^I should get a response with status code (\d+)$/) do |code|
    code = code.to_i
    raise 'Article should exist, but does not' if code == 200 && currentArticle.nil?
    raise 'Article exists, but should not' if code == 404 && currentArticle
end

Then(/^the article title is "([^"]*)"$/) do |title|
    raise 'foo' unless currentArticle[:title] == title
end
