Feature: Issues redmine test script 
  
  Background: 
    * url urlApp
    
    Scenario: Get issues list by JSON
      Given path 'issues.json'
      When method GET
      Then status 200


    Scenario: Get issue by id - JSON
      * def idIssue = 2

      Given path 'issues/'+idIssue+'.json'
      When method GET
      Then status 200
      And match response.issue.id == 2
      And match response.issue.status.name == 'New'
      And match response.issue.priority.name == 'Low'
      And match response.issue.author.name == 'Redmine Admin'
      And match response.issue.subject == 'I cannot create a user xml.'
      And match response.issue.description == 'As an admin user, I cannot create an user when xml...'
      And match response.issue.is_private == true
      And match response.issue.create_on == '2020-01-16T11:17:25Z'


    #https://github.com/intuit/karate#schema-validation
    Scenario: Get issue by id - Validate JSON Schema
      * def idIssue = 2
      Given path 'issues/'+idIssue+'.json'
      When method GET
      Then status 200
      And match response.issue.id == 2
      And match response.issue.subject == '#string'
      And match response.issue ==
          """
              {
                  id: '#number',
                  project: '#ignore',
                  tracker: '#ignore',
                  status: {
                    id: '#number? _ >= 0',
                    name: '#string',
                  },
                  priority: '#ignore',
                  author: '#ignore',
                  assigned_to: {
                    id: '#number',
                    name: '#string'
                  },
                  subject: '#string',
                  description: '#string',
                  start_date: '#string',
                  due_date: '## #string',
                  done_ratio: '#notnull',
                  is_private: '#boolean',
                  estimated_hours: '#ignore',
                  total_estimated_hours: '#ignore',
                  spent_hours: '#ignore',
                  total_spent_hours: '#number? _ == 0',
                  created_on: '#ignore',
                  updated_on: '#ignore',
                  closed_on: '##'
              }
          """

      @debug
      Scenario: Create a new issue JSON and update issue
        * def bodyIssue =
        """
        {
          "issue":{
          "project_id": 1,
          "subject": "Mi issue creado desde Karate DSL",
          "priority_id": 1
          }
        }
        """
        Given path 'issue.json'
        And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
        And request bodyIssue
        When method POST
        Then status 201
        
        * def idIssue = response.issue.id
        * print 'Issue created id is: ', idIssue
        
        Given path 'issues/' + idIssue + '.json'
        And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
        And request
        """
        {
          "issue":{
          "subject": "Mi issue creado desde Karate DSL",
          "priority_id": 5,
          "notes": "The subject was changed"
          }
        }
        """
        When method PUT
        Then status 204

  Scenario: Create a new issue JSON and update issue xdxd

    * def  bodyIssue =
        """
        {
          "issue": {
          "project_id": 1,
          "subject": "Mi issue creado desde Karate DSL",
          "priority_id": 1
          }
        }
        """
    Given path 'issues.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request bodyIssue
    When method post
    Then status 201

    * def idIssue = response.issue.id
    * print 'Issue created id is: ', idIssue

    Given path 'issues/' +idIssue+ '.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request
        """
        {
          "issue": {
            "subject": "Issue Modificado desde Karate DSL",
            "priority_id" : 5,
            "notes": "The subject was changed"
          }
        }
        """
    When method put
    Then status 204


  Scenario: Create a new issue JSON and delete issue xdxd

    * def  bodyIssue =
        """
        {
          "issue": {
          "project_id": 1,
          "subject": "Mi issue creado desde Karate DSL",
          "priority_id": 1
          }
        }
        """
    Given path 'issues.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    And request bodyIssue
    When method post
    Then status 201

    * def idIssue = response.issue.id
    * print 'Issue created id is: ', idIssue

    Given path 'issues/' +idIssue+ '.json'
    And header X-Redmine-API-Key = '54d992219a4d120df54d5a72cb152e8b89d20d65'
    When method delete
    Then status 204