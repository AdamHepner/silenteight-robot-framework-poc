*** Settings ***
Library  SeleniumLibrary
Library  FakerLibrary
Variables  SE/urls.yaml
Test Setup  Open page https://sens.silenteight.com/decision-tree
Suite Setup  Navigate to decision tree selection
Suite Teardown  Close all browsers

***Test cases***
Create a new decision tree
  [Timeout]  15 seconds
  Invent new decision tree name
  Open decision tree creation dialogue
  Set new decision tree name to ${new tree name}
  Select an available AI model
  Confirm creation of the decision tree
  Assume the decision tree had been created successfully

Perform new assignment
  [Timeout]  30 seconds
  Assume the decision tree had been created successfully
  Open tree ${new tree name}
  Click "edit assignment"
  Assign a batch type
  Click save button
  Verify that the batch type had been assigned successfully

Delete the tree
  [Timeout]  20 seconds
  Assume the decision tree had been created successfully
  Trigger the decision tree removal
  Type "Delete" as safeword
  Verify that a warning is displayed
  Confirm the decision tree removal
  Verify that the decision tree had been removed

***Keywords***
Verify that a warning is displayed
  Wait until page contains  This process is irreversible, once deleted the Decision Tree cannot be restored.
  [Teardown]  Capture page screenshot

Type "${safeword}" as safeword
  Input text  xpath://input[@placeholder='Confirm your decision']  ${safeword}
  [Teardown]  Capture page screenshot

Confirm the decision tree removal
  Click button  Remove this Decision Tree  #Either sneaky, or this is out of convention for you. All other names are written in purely "Capitalized Format"
  Wait until page contains  The decision tree has been removed successfully
  [Teardown]  Capture page screenshot

Verify that the decision tree had been removed
  Run keyword and expect error  *  Assume the decision tree had been created successfully
  [Teardown]  Capture page screenshot


Trigger the decision tree removal
  Click button  xpath://a[text()='${new tree name}']/ancestor::tr//button[text()='Remove']
  Wait until page contains  Remove Decision Tree
  [Teardown]  Capture page screenshot
Confirm creation of the decision tree
  Click button  Create New Tree
  [Teardown]  Capture page screenshot
Set new decision tree name to ${tree name}
  Input text  xpath://app-create-new-decision-tree//input  ${tree name}
  [Teardown]  Capture page screenshot
Select an available AI model
  Select from list by index  xpath://app-create-new-decision-tree//select  1 
  [Teardown]  Capture page screenshot
Open decision tree creation dialogue
  Click button  Create Blank Tree
  [Teardown]  Capture page screenshot
Invent new decision tree name
  ${new tree number}=  Random number  10
  Set suite variable  ${new tree name}  test-tree-${new tree number}

Assume the decision tree had been created successfully
    Wait until element is visible  link:${new tree name}
    [Teardown]  Capture page screenshot

Navigate to decision tree selection
  #//app-create-new-decision-tree/div/section[2]/perfect-scrollbar/div/div[1]/section[1]/div/input
  Wait until keyword succeeds  1 minute  5 seconds  Open browser  ${sut_url}  %{BROWSER}  remote_url=http://localhost:4444/wd/hub
  Capture page screenshot
  Log in as %{SENS_LOGIN} with password %{SENS_PASSWORD}

Log in as ${username} with password ${password}
  [Timeout]  10 seconds
  Input text  username  ${username}
  Input password  password  ${password}
  Click button  submit-button
  Wait until element contains  class:user-info-label  Logged in as
  Wait until element contains  class:username  ${username}
  [Teardown]  Capture page screenshot
  
Open tree ${tree name}
  Click element  link:${tree name}
  Wait until decision tree page is opened
  [Teardown]  Capture page screenshot

Click "edit assignment"
  Click button  Edit Assignments
  [Teardown]  Capture page screenshot


Assign a batch type
  ${assignment added}=  Get text  xpath://h3[text()='Available']/following::ul/li[1]/div[@class='name']
  Set test variable  ${assignment}  ${assignment added}
  Click button  xpath://h3[text()='Available']/following::ul/li[1]/div[@class='name']/following::div/button
  [Teardown]  Capture page screenshot

Click save button
  Click button  Save Changes
  Wait until page contains  The decision tree has been changed successfully
  [Teardown]  Capture page screenshot

Verify that the batch type had been assigned successfully
  Element should contain  xpath://h3[text()='Agents']/parent::section/following-sibling::section/ul/li  ${assignment}

Wait until decision tree page is opened
  [Documentation]  Ensure that the page displayed is actually the decision tree edition page
  Wait until page contains  Basic Information
  Wait until page contains  Agents
  Wait until page contains  Details
  Wait until page contains  Reasoning Branches

Open page ${url}
  Go to  ${url}