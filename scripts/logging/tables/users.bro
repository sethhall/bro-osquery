#! Logs user login/logout activity.

module osquery::users;

export {
	redef enum Log::ID += { LOG };

	type Info: record {
		t:            time &log;
		host:         string &log;
		device:       string &log;
		device_alias: string &log;
		action:       string &log;
		user_name:    string &log;
	};
}

event logged_in_user(resultInfo: osquery::ResultInfo, user_name: string)
	{
	local action = "";
	if ( resultInfo$utype == osquery::ADD )
		action = "login";
	else if ( resultInfo$utype == osquery::REMOVE )
		action = "logout";
	
	local info = Info($t=network_time(),
	                  $host=resultInfo$host,
	                  $device = device,
	                  $device_alias = device_alias,
	                  $user_name = user_name,
	                  $action=action);
	
	Log::write(LOG, info);
	}

event bro_init()
	{
	Log::create_stream(LOG, [$columns=Info, $path="osq-users"]);

	local ev = [$ev=logged_in_user,$query="select user from logged_in_users where type='user'"];
	osquery::subscribe(ev);
	}
