***Settings***
Documentation  This is an empty test suite just to prove that the docker runner executes correctly
Library  SeleniumLibrary

***Test Cases***
Do nothing
  No operation

Take google screenshot
  [Setup]  Wait until keyword succeeds  1 minute  5 seconds  Open browser  https://google.com  Chrome  remote_url=http://localhost:4444/wd/hub
  Capture page screenshot
  [Teardown]  Close all browsers