-- Copyright (C) 2017
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.sysmonitor", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/sysmonitor") then
		return
	end
	entry({"admin", "services", "sysmonitor"}, 10).dependent = true
	entry({"admin", "services", "sysmonitor"}, cbi("sysmonitor/setup"), _("SYS Monitor"), 80).dependent=false
	
	entry({"admin", "services", "sysmonitor", "ipsecfw_status"}, call("action_ipsecfw_status")).leaf = true
	entry({"admin", "services", "sysmonitor", "gateway_status"}, call("action_gateway_status")).leaf = true
	entry({"admin", "services", "sysmonitor", "vpn_status"}, call("action_vpn_status")).leaf = true
	entry({"admin", "services", "sysmonitor", "ipsec_status"}, call("action_ipsec_status")).leaf = true
	entry({"admin", "services", "sysmonitor", "pptp_status"}, call("action_pptp_status")).leaf = true
	entry({"admin", "services", "sysmonitor", "switch_vpn"}, call("switch_vpn")).leaf = true
	entry({"admin", "services", "sysmonitor", "switch_ipsecfw"}, call("switch_ipsecfw")).leaf = true

end

function get_users()
    luci.http.write(luci.sys.exec(
                        "[ -f '/var/log/ipsec_users' ] && cat /var/log/ipsec_users"))
end

function action_ipsecfw_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		ipsecfw_state = luci.sys.exec("uci get firewall.@zone[0].masq")
	})
end

function action_gateway_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		gateway_state = luci.sys.exec("uci get network.wan.gateway")
	})
end

function action_vpn_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		vpn_state = luci.sys.exec("/usr/share/sysmonitor/sysapp.sh ssr")
	})
end

function action_ipsec_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		ipsec_state = luci.sys.exec("/usr/share/sysmonitor/sysapp.sh ipsec")
	})
end

function action_pptp_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		pptp_state = luci.sys.exec("/usr/share/sysmonitor/sysapp.sh pptp")
	})
end

function switch_vpn()
	luci.http.redirect(luci.dispatcher.build_url("admin", "services", "sysmonitor"))
	luci.sys.exec("/usr/share/sysmonitor/sysapp.sh switch_vpn")	
end

function switch_ipsecfw()
	luci.http.redirect(luci.dispatcher.build_url("admin", "services", "sysmonitor"))
	luci.sys.exec("/usr/share/sysmonitor/sysapp.sh switch_ipsecfw")	
end

