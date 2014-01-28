# == Define: n::app
#
# == Parameters:
#
# [*interface*]
# Which interface the app will listen on.
# - required
#
# [*console_log*]
# Path to app's console log.
# - default: "${instance_dir}/log/console.log"
#
# [*instance*]
# Number corresponding to instance. Starts at 1 and increments.
#
# [*vhost_template*]
# Path to apache vhost template in either autoloader format such as
# 'myapp-vhost.conf.erb' or a fully qualified path such as
# '/srv/app_templates/myapp-vhost.conf.erb'.
# - default: 'default-vhost.conf.erb'
#

define code_only::instance (
  $deploy_dir='',
){

  $app_name = template('coldfusion/app_name.erb')


  # Tags everything with the appname for more specific puppet runs
  tag $app_name

  # Set the instance name for readability
  $instancename = $name

  $instancenum = template('code_only/instance.erb')

  # validate $instance
  if is_integer($instancenum) == false {
    fail("Name is ${instancename} and instancenum is <${instancenum}> which is not an integer.")
  }

  # validate $app_name
  validate_re($app_name, '[A-Za-z_-]', "${instancename} -- app_name <${app_name}> does not match regex")

  # Hash of config entries for app
  $config = hiera_hash("${app_name}::config")


  if $deploy_dir =~ /^\// {
    $real_deploy_dir = $deploy_dir
  } else {
    $real_deploy_dir = "/x01/www/html/${instancename}"
  }


  file { $real_deploy_dir:
    ensure => directory,
    mode   => '0775',
  }

}
