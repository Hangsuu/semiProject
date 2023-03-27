create table message(
  message_no number primary key,
  message_recipient references member(member_id),
  message_sender references member(member_id),
  message_title varchar2(300),
  message_content varchar2(3000),
  message_send_time date default sysdate not null,
  message_receive_time date,
  message_sender_store number(1) default 1 not null, -- 쪽지 보낸사람의 보낸쪽지함 저장 여부
  message_receiver_store number(1) default 1 not null -- 쪽지 받은 사람의 받은 쪽지함 저장 여부
);

create sequence message_seq;