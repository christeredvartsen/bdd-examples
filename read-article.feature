Feature: Read article on vg.no
    In order to read an article on vg.no
    As a user
    I want to be able to fetch article pages

    Background:
        Given an article with ID 196000 exists and it has the title "Slik kan nettbankene bli sikrere"
        And an article with ID 23803772 exists and it has the title "UFC: Svenske Länsberg knust av «Knockout-Cyborg»"

    Scenario Outline: Fetch an article
        When I request vg.no/a/<id>
        Then I should get a response with status code 200
        And the article title is "<title>"

        Examples:
            | id       | title                                            |
            | 196000   | Slik kan nettbankene bli sikrere                 |
            | 23803772 | UFC: Svenske Länsberg knust av «Knockout-Cyborg» |

    Scenario: Fetch an article that does not exist
        When I request vg.no/a/123
        Then I should get a response with status code 404
