--初始化日志模块
Debug.LogInit("logger/ChatRoom","ChatRoom",true);
--初始化协议模块
local ProtoType={
    Json=0,
    Protobuf=1,
};
ProtoManager.Init(ProtoType.Protobuf);
--如果是Protobuf协议，还需要注册映射表
if ProtoManager.ProtoType()==ProtoType.Protobuf then
    local cmdNameMap=require("CmdNameMap");
    if cmdNameMap then
        ProtoManager.RegisterCmdMap(cmdNameMap);
    end
end

--开启网络服务
Netbus.TcpListen(6080);
Netbus.WebsocketListen(8001);
Netbus.UdpListen(8002);

print("start all service success");

--注册服务
----第一个参数：sType
----第二个参数：表：{OnSessionRecvCmd，OnSessionDisconnected}
local s1=require("ChatRoom/ChatServer");
local ret =  Service.Register(s1.serviceType,s1.service);
if ret then
    print("register chat_server success");
end