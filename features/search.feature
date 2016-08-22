Feature: Search

	As a web user
	I want to search with keywords in Wikipedia 
	So that I can find the meaning of words

	Scenario: Search the Wikipedia with a keyword
		Given I visit the Wikipedia web site
		When I search with keyword "cloud"
		Then I should see a page with keyword "cloud"
