Feature: Signup
  In order to use Shogun
  As a User
  I want to sign up

  Scenario: Sign up
    Given I am on the homepage
    And I should see the home page
    When I fill in "username" with "paulbjensen"
    And I fill in "email" with "paulbjensen@gmail.com"
    And I fill in "password" with "123456"
    And I press "Signup"
    And I should see the projects page
    Then I should see "paulbjensen"
    And I should see "Your project"