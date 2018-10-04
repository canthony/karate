Feature: ui automation core capabilities

Background:
  * def webUrlBase = karate.properties['web.url.base']

Scenario Outline: dom operations, validations and navigation
  * configure driver = <config>

  Given location webUrlBase + '/page-01'
  And input #eg01InputId = 'hello world'
  When click input[name=eg01SubmitName]
  Then match driver.text('#eg01DivId') == 'hello world'
  And match driver.value('#eg01InputId') == 'hello world'  
  
  When eval driver.refresh()
  Then match driver.location == webUrlBase + '/page-01'
  And match driver.text('#eg01DivId') == ''
  And match driver.value('#eg01InputId') == ''
  And match driver.title == 'Page One'

  When location webUrlBase + '/page-02'
  Then match driver.text('.eg01Cls') == 'Class Locator Test'
  And match driver.html('.eg01Cls') == '<span>Class Locator Test</span>'
  And match driver.title == 'Page Two'
  And match driver.location == webUrlBase + '/page-02'

  When eval driver.back()
  Then match driver.location == webUrlBase + '/page-01'
  And match driver.title == 'Page One'

  When eval driver.forward()
  Then match driver.location == webUrlBase + '/page-02'
  And match driver.title == 'Page Two'

Examples:
    | config |
    | { type: 'chrome', executable: 'chrome' } |
    | { type: 'chromedriver', port: 9515, executable: 'chromedriver' } |
    | { type: 'geckodriver', port: 4444, executable: 'geckodriver' } |
    | { type: 'safaridriver', port: 5555, executable: 'safaridriver' } |
    # | { type: 'mswebdriver', port: 17556, executable: 'MicrosoftWebDriver' } |
    # | { type: 'msedge', timeout: 5000, executable: 'MicrosoftEdge' } |
    