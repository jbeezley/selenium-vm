@test "unzip should be installed" {
      test -x /usr/bin/unzip
}

@test "google chrome should exist" {
      test -x /usr/bin/google-chrome
}

@test "chromedriver should exist" {
      test -f /opt/local/selenium_grid/chromedriver
}

@test "should run chromedriver v2.9" {  
    timeout 1s /opt/local/selenium_grid/chromedriver | grep v2.9
}

@test "selenium-server should exist" {
      test -f /opt/local/selenium_grid/selenium-server-standalone-2.42.2.jar 
}

@test "config file should exist" {
      test -f /opt/local/selenium_grid/config.json
}

@test "should have browsers in config file" {
    browsers=(
        "chrome"
        "firefox"
    )
    for browser in "${browsers[@]}"
    do
        grep $browser "/opt/local/selenium_grid/config.json"
    done
}

@test "selenium-server hub should run" {
      supervisorctl status | grep hub | grep RUNNING
}
