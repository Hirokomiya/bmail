pragma solidity ^0.4.18;

contract MessageApp {
    
    struct Message {
        string inbox;
        address receiver;
        address sender;
    }
    
    Message[] messages;

    mapping (uint => address) messageSender;
    mapping (address => uint) messageCount;
    mapping (uint => string) messageContent;
    mapping (uint => address) messageReceiver;
    mapping (address => uint) receiveCount;
    
    function ethmail(string message, address to) public {
        uint id = messages.push(Message(message, to, msg.sender))- 1;
        messageSender[id] = msg.sender;
        messageCount[msg.sender]++;
        messageContent[id] = message;
        messageReceiver[id] = to;
        receiveCount[to]++;
    }
    
    function Sent(uint _messageId) view returns(string) {
        require(msg.sender == messageSender[_messageId]);
        return messageContent[_messageId];
    }
    
    function Inbox(uint _messageId) view returns(string) {
        require(msg.sender == messageReceiver[_messageId]);
        return messageContent[_messageId];
    }
    
    function Index_sent() external view returns(uint[]) {
    uint[] memory result = new uint[](messageCount[msg.sender]);
    uint counter = 0;
    for (uint i = 0; i < messages.length; i++) {
      if (messageSender[i] == msg.sender) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
  
    function Index_inbox() external view returns(uint[]) {
    uint[] memory result = new uint[](receiveCount[msg.sender]);
    uint counter = 0;
    for (uint i = 0; i < messages.length; i++) {
      if (messageReceiver[i] == msg.sender) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
