-- 멤버 테이블 생성 및 더미 데이터 넣기
create table member(
  member_id varchar2(20) primary key,
  member_pw varchar2(20) not null,
  member_nick varchar2(21) not null,
  member_code varchar2(20), -- 친구 추가 코드
  member_email varchar2(40),
  member_level varchar2(18) default '일반회원' not null,
  member_point number default 0 not null,
  member_join date default sysdate not null,
  member_login date,
  member_login_cnt number default 0 not null,
  member_deadline date default sysdate not null -- 제재 날짜
);
insert into member (
member_id, member_pw, member_nick, member_code, member_email, 
member_level, member_point, member_join, member_login_cnt, member_deadline )
values (
'testuser1', 'Testuser1!', '테스트유저1', '#123456789', 'testuser1@gmail.com', 
'일반회원', 0, sysdate, 0, sysdate
);
insert into member (
member_id, member_pw, member_nick, member_code, member_email, 
member_level, member_point, member_join, member_login_cnt, member_deadline )
values (
'testuser2', 'Testuser2!', '테스트유저2', '#234567890', 'testuser2@gmail.com', 
'일반회원', 0, sysdate, 0, sysdate
);
insert into member (
member_id, member_pw, member_nick, member_code, member_email, 
member_level, member_point, member_join, member_login_cnt, member_deadline )
values (
'adminuser1', 'Adminuser1!', '관리자유저1', '#345678901', 'adminuser1@gmail.com', 
'마스터', 0, sysdate, 0, sysdate
);
commit;

-- 올보드 테이블
create table allboard (
  allboard_no number primary key,
  allboard_board_type varchar2(30),
  allboard_board_type_no number
);
create sequence allboard_seq;

-- 댓글 테이블 생성
create table reply(
  reply_no number primary key,
  reply_origin references allboard(allboard_no),
  reply_writer references member(member_id),
  reply_content varchar2(3000),
  reply_time date,
  reply_group references reply(reply_no)
);
create sequence reply_seq;
create table reply_attach(
  reply_no references reply(reply_no),
  attachment_no references attachment(attachment_no)
);

-- 좋아요 테이블
create table nice(
  allboard_no references allboard(allboard_no),
  member_id references member(member_id)
);

-- 첨부파일 테이블
create table attachment (
  attachment_no number primary key,
  attachment_name varchar2(256),
  attachment_type varchar2(60),
  attachment_size number
);
create sequence attachment_seq;



-- 포켓몬 교환 테이블
create table pocketmon_trade (
  pocketmon_trade_no number PRIMARY KEY,
  pocketmon_allboard_no references allboard(allboard_no),
  pocketmon_trade_title varchar2(100),
  pocketmon_trade_writer references member(member_id),
  pocketmon_trade_written_time date,
  pocketmon_trade_content varchar2(4000),
  pocketmon_trade_trade_time date,
  pocketmon_trade_complete number(1),
  pocketmon_trade_read number,
  pocketmon_trade_reply number,
  pocketmon_trade_like number
);
create sequence pocketmon_trade_seq;