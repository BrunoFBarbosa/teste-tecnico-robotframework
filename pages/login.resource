*** Settings ***
Library    Browser
Library    FakerLibrary
Library    DateTime

*** Variables ***

${BROWSER}             chromium
${HEADLESS}            ${true}
${USER}                Admin
${PASSWORD}            admin123
${LOGIN_URL}           https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

${USER_INPUT}          css=[name='username']
${PASSWORD_INPUT}      css=[name='password']
${LOGIN_BTN}           css=[type='submit']

*** Keywords ***
O Usuario Esteja No Site
    New Browser        browser=${BROWSER}
    ...                headless=${HEADLESS}
    New Context        viewport={'width': 1200, 'height': 800}

    New Page          url=${LOGIN_URL}
    
    Fill Text         ${USER_INPUT}         ${USER}
    Fill Text         ${PASSWORD_INPUT}     ${PASSWORD}
    Click             ${LOGIN_BTN}