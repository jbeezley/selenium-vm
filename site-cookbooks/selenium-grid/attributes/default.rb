override['supervisor']['inet_port'] = '9001'
override['supervisor']['version'] = '3.0a12'

default['selenium']['dir'] = '/opt/local/selenium_grid'
default['selenium']['url'] = 'http://selenium-release.storage.googleapis.com/2.42'
default['selenium']['jar'] =  'selenium-server-standalone-2.42.2.jar'
default['selenium']['config'] = 'config'

default['chromedriver']['url'] = 'http://chromedriver.storage.googleapis.com'
default['chromedriver']['version'] = '2.9'
default['chromedriver']['zip'] = 'chromedriver_linux64.zip'
default['chromedriver']['exe'] = 'chromedriver'

default['grid']['hub']['url'] = 'localhost'
default['grid']['node']['url'] = 'localhost'
