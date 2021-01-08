Feature: Projects redmine test script

  Background:
    * url urlApp

  Scenario: Create a new project redmine
    Given path 'projects.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request read('project.json')
    When method POST
    Then status 201

  Scenario Outline: Create a new project with parameterized values
    * def numberRandom = function() {return (Math.floor(Math.random() * (900000)) + 100000).toString()}
    * def numberRandom = 'redmineproject' + numberRandom()
    Given path 'projects.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request read('project.json')
    When method POST
    Then status 201
    And match response.project.name == '<name>'

    Examples:
      |read('projects.csv')|

  Scenario Outline: Create a new project with parametrized values
    * def numberRandom = function() {return (Math.floor(Math.random() * (900000) )  + 100000).toString()}
    * def numberRandom = 'redmineproject' + numberRandom()
    Given path 'projects.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request read('project.json')
    When method post
    Then status 201
    And match response.project.name == '<name>'

    Examples:
      |read('projects.csv')|