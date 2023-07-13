insert into user_table values(
"admin", 
"admin", 
"admin", 
"서울대입구 서울특별시 청룡동", 
"010-1234-5678", 
"admin@naver.com", 
"https://images.unsplash.com/photo-1531723492606-bb53948b6c09?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80");

insert into user_table values(
"admin2", 
"admin2", 
"admin2", 
"서울특별시 서대문구 연세로 50 연세대학교 신촌캠퍼스", 
"010-2222-2222", 
"admin2@gmail.com", 
"https://images.unsplash.com/photo-1607457561901-e6ec3a6d16cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80");

insert into user_table values(
"admin3", 
"admin3", 
"admin3", 
"서울특별시 성북구 안암로 145 고려대학교", 
"010-3333-3333", 
"admin3@gmail.com", 
"https://img.extmovie.com/files/attach/images/135/376/540/090/451856d47bd2091e3c346812843ea12d.jpg");

insert into user_table values(
"admin4", 
"admin4", 
"admin4", 
"집", 
"010-3443-4334", 
"admin4@gmail.com", 
"https://images.unsplash.com/photo-1566041510394-cf7c8fe21800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80");

insert into user_table values(
"admin5", 
"admin5", 
"admin5", 
"학교", 
"010-5555-5555", 
"admin5@gmail.com", 
"https://images.unsplash.com/photo-1564564699685-b1c926c82d16?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80");

insert into group_table values(
	"potatogroup",
    "감자 프로젝트",
    default,
    "감자의 프로젝트입니다.",
    null,
    null,
    20230914
);

insert into group_user_table values(
	"potatogroup",
    "admin",
    "1",
    default,
    default
);

insert into group_user_table values(
	"potatogroup",
    "admin2",
    default,
    default,
    default
);

insert into group_user_table values(
	"potatogroup",
    "admin3",
    default,
    1,
    default
);

insert into group_user_table values(
	"potatogroup",
    "admin4",
    default,
    default,
    default
);

insert into group_user_table values(
	"potatogroup",
    "admin5",
    default,
    1,
    default
);