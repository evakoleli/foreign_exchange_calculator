Feature: Foreign Exchange Calculator
  In order to calculate foreign exchange rates
  As a user
  I want to be able to give date, amount of money from one given currency and to get the amount converted in another currency

  Background:
    Given I am on the home page

  Scenario: Calculate currency
    When I want to calculate:
      | Date   | 10/13/2015 |
      | Amount | 10         |
      | From   | EUR        |
      | To     | GBP        |
    Then I should see the result "7.48"

  Scenario: Calculate currency out of date range
    When I want to calculate:
      | Date   | 10/13/1999 |
      | Amount | 10         |
      | From   | EUR        |
      | To     | GBP        |
    Then I should be on the result page
    Then I should not see a result

  Scenario: Calculate currency on invalid date
    When I want to calculate:
      | Amount | 10         |
      | From   | EUR        |
      | To     | GBP        |
    Then I should be on the home page
    And I should see the message "Invalid date"
