pragma solidity ^0.4.18;

contract MessageApp {
    
    struct Message {
        string inbox;
        address receiver;
    }
    
    Message[] messages;

    mapping (uint => address) public messageSender;
    mapping (address => uint) messageCount;
    mapping (uint => string) MessageContent;
    mapping (uint => address) messageReceiver;
    
    function write(string _string, address _to) public {
        uint id = messages.push(Message(_string, _to))- 1;
        messageSender[id] = msg.sender;
        messageCount[msg.sender]++;
        MessageContent[id] = _string;
        messageReceiver[id] = _to;
    }
    
    function checkSent(uint _messageId) view returns(string) {
        require(msg.sender == messageSender[_messageId]);
        return MessageContent[_messageId];
    }
    
    function checkInbox(uint _messageId) view returns(string) {
        require(msg.sender == messageReceiver[_messageId]);
        return MessageContent[_messageId];
    }
    

}
