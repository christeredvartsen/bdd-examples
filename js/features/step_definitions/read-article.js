const assert = require('assert');

module.exports = function() {
    var articles = [],
        currentArticle;

    this.Given(/^an article with ID (\d+) exists and it has the title "([^"]*)"$/, (id, title) => {
        articles[id] = { title };
    });

    this.When(/^I request vg\.no\/a\/(\d+)$/, (id) => {
        currentArticle = null;

        if (typeof articles[id] !== 'undefined') {
            currentArticle = articles[id];
        }
    });

    this.Then(/^I should get a response with status code (\d+)$/, (code) => {
        if (code == 200 && !currentArticle) {
            assert.fail('Article should exist, but does not');
        } else if (code == 404 && currentArticle) {
            assert.fail('Article exists, but should not');
        }
    });

    this.Then(/^the article title is "([^"]*)"$/, (title) => {
        assert.equal(
            title,
            currentArticle.title,
            'Incorrect title, expected ' + title + ', got ' + currentArticle.title
        );
    });
};
