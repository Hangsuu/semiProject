create table message(
  message_no number primary key,
  message_recipient references member(member_id),
  message_sender references member(member_id),
  message_title varchar2(300),
  message_content varchar2(3000),
  message_send_time date default sysdate not null,
  message_receive_time date,
  message_sender_store number(1) default 1 not null, -- 쪽지 보낸사람의 보낸쪽지함 저장 여부
  message_recipient_store number(1) default 1 not null -- 쪽지 받은 사람의 받은 쪽지함 저장 여부
);

create sequence message_seq;

update member set member_birth = sysdate where member_id = 'adminuser1';

insert into message (message_no, message_recipient, message_sender, message_title, message_content, message_send_time, message_sender_store, message_receiver_store)
values (1,'testuser1', 'testuser1', '테스트제목', '테스트내용', sysdate, 1, 1);

select * from message where message_no = 8 and (message_sender = 'testuser1' or message_recipient = 'testuser1');
select * from message where message_no = 8 and (message_sender = 'testuser1' or message_recipient = 'testuser1');

update message set message_receive_time = null where message_no = 8;
select * from message where  message_no = 8;