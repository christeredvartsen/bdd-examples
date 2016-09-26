<?php
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context {
    private $articles = [];
    private $currentArticle;

    /**
     * @Given an article with ID :id exists and it has the title :title
     */
    public function givenAnArticleExists($id, $title) {
        $this->articles[(int) $id] = [
            'title' => $title,
        ];
    }

    /**
     * @When I request vg.no\/a\/:id
     */
    public function whenIRequestArticle($id) {
        $id = (int) $id;
        $this->currentArticle = null;

        if (isset($this->articles[$id])) {
            $this->currentArticle = $this->articles[$id];
        }
    }

    /**
     * @Then I should get a response with status code :code
     */
    public function thenResponseStatusCodeIs($code) {
        $code = (int) $code;

        if ($code === 200 && !$this->currentArticle) {
            throw new Exception('Article should exist, but does not');
        } else if ($code === 404 && $this->currentArticle) {
            throw new Exception('Article exists, but should not');
        }
    }

    /**
     * @Then the article title is :title
     */
    public function thenTheTitleIs($title) {
        if ($this->currentArticle['title'] !== $title) {
            throw new Exception(sprintf(
                'Incorrect title, expected %s, got %s',
                $title,
                $this->currentArticle['title']
            ));
        }
    }
}
