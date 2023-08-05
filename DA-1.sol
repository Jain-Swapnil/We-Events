pragma solidity >=0.5.0 <0.9.0;
 
 // SWAPNIL JAIN 20BCE2941

contract EventContract {
 struct Event{
   address organizer;
   string name;
   uint date; 
   uint price;
   uint ticketCount;  
   uint ticketRemain;
 }
 
 mapping(uint=>Event) public events;
 mapping(address=>mapping(uint=>uint)) public tickets;
 uint public nextId;
 
 
 function CreateEvent(string memory name,uint date,uint price,uint ticketCount) external{
   require(date>block.timestamp,"Events can be organized only for future dates");
   require(ticketCount>0,"Number of tickets must be greater than zero for event organizing");
 
   events[nextId] = Event(msg.sender,name,date,price,ticketCount,ticketCount);
   nextId++;
 }
 
 function buyTicket(uint id,uint quantity) external payable{
   require(events[id].date!=0,"Event does not exist");
   require(events[id].date>block.timestamp,"Event has already occured");
   Event storage _event = events[id];
   require(msg.value ==(_event.price*quantity),"Sufficient coins not available");
   require(_event.ticketRemain>=quantity,"Not enough tickets");
   _event.ticketRemain-=quantity;
   tickets[msg.sender][id]+=quantity;
 }
 
 function transferTicket(uint id,uint quantity,address to) external{
   require(events[id].date!=0,"Event does not exist");
   require(events[id].date>block.timestamp,"Event has already occured");
   require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
   tickets[msg.sender][id]-=quantity;
   tickets[to][id]+=quantity;
 }
}
 

