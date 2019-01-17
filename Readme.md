# Prerequisites

- Docker
- Bash

# Main idea

The constructed test suite verifies the happy path of the decision tree lifecycle:

- create one
- modify
- delete

It may be optimized in many ways, but the goal had been to demonstrate the feasibility of the concept, not to provide most optimal solution of all times.

# Running the tests

Please remember to set the credentials first. Those are not hardcoded, but should be provided on runtime from a secure secret management system.
Additionally set the browser to Chrome or Firefox

    > export BROWSER=Chrome
    > export SENS_LOGIN=...
    > export SENS_PASSWORD=...
    > ./run.sh

# Viewing results

After a run is complete, the results are available in the file `results/log.html`

# Technical improvement ideas

There are many. 

- First of all, the test suite provided should be only a fraction of a bigger test suite.
- Tests should be tagged to allow for more selective execution
- Documentation should be provided to all test cases and keywords, as well as test suites. Metadata probably too.
- Some, if not most keywords should be moved to resource files for reusability betwen test suites
- Setup and teardown with respect to data state before and after should be programmed using python library and should use app API to perform significant operations
- Selenium locators should be extracted from the test suite itself into a variable file, so that a centralized repository of locators is available
- Depending on use cases, probably some selectors that currently use official english labels (which is fine, because provided selenium grid uses english locale) should be converted to using pure xpath/css in order to limit test fragility. In addition to that, tests should be configured in CI to run with several different locales.
- and so on, and so on, one could iterate on the code until zen is achieved :)

# Test improvement ideas

I had actually used gut feeling and heuristics to come up with the idea behind implemented test suite, and would use it again for developing future ones, unless specifications were available. 

Without specification available to me, it's all exploratory testing, basically: trying to see what happens when I poke the app with a stick in various places. I wouldn't dare provide binding test scenarios, just rough ideas:

- are data entries correctly transported across screens? That means: if I name the decision tree on one screen, is it displayed on the next screen correctly? What about 3 operations later?
- are data entries correctly transported across multiple browser sessions? That means: if I make a change to the system in one browser session, is it immediately reflected in parallel browser session?
- does the UI behave correctly when the viewport size is changed? Here it would help to know what screen sizes are actually used. Would the app be used on mobile?
- does the search work? Does it reflect newly added and removed decision trees?
- can I successfully copy the decision trees? Are all properties copied correctly? What happens when I remove or change the original?

and that all is only the main screen of the application. 
