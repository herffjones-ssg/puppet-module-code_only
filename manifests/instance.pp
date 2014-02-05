# == Define: n::app
#
# == Parameters:
#
#

define code_only::instance (
  $deploy_dir='',
){

  $app_name = template('code_only/app_name.erb')


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
