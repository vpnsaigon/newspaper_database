use BAO_DIEN_TU;

-- Truy vấn tất cả bảng POST và MANAGERS
select * from POST;
select * from MANAGERS;

-- Trong bảng POST, truy vấn những bài viết có LUOT_XEM lớn hơn 20.
select * from POST where LUOT_XEM > 20;


-- Trong bảng POST, viết truy vấn những bài viết đã được xét duyệt và 
-- sắp xếp kết quả theo thứ tự bảng chữ cái của cột tiêu đề.
select * from POST where XET_DUYET = 1 order by TIEU_DE asc;


-- Viết truy vấn để lấy tên các acount_name của user comment vào POST: 
select cm.NGUOI_COMMENT,
    us.ACCOUNT_NAME,
    cm.NOI_DUNG
from USERS as us
inner join COMMENT as cm
on us.ID_USER = cm.NGUOI_COMMENT
order by cm.NGUOI_COMMENT;


-- Viết truy vấn để tìm nội dung bài viết bắt đầu bằng chữ ‘n’
select * from POST where NOI_DUNG like 'n%';


-- Tạo VIEW để lấy ra những bài viết đã được duyệt bởi những người quản lý.
create view POST_DUOC_DUYET as 
select * from POST where XET_DUYET = 1;

select * from POST_DUOC_DUYET;


-- Tạo VIEW để lấy ra các comment của user.

create view COMMENT_USER as
select NOI_DUNG from COMMENT;

select * from COMMENT_USER;

-- Tạo thủ tục để lấy được những bài viết đã được duyệt
delimiter $$
create procedure POST_DUOC_DUYET()
begin
    select * from POST where XET_DUYET = 1;
end $$
delimiter ;

call POST_DUOC_DUYET();


-- Tạo thủ tục để lấy những bài viết chưa được duyệt trước ngày 01-02-2018.
delimiter $$
create procedure POST_DUOC_DUYET_02_2018()
begin
    select * from POST 
    where XET_DUYET = 0 and THOI_GIAN_DANG < '2018-02-01';
end $$
delimiter ;

call POST_DUOC_DUYET_02_2018();


-- Tạo function để lấy được số tháng lớn nhất mà các bài viết 
-- đã đăng kể từ thời điểm được đăng đến thời điểm 01-01-2019 trong bảng POST.
delimiter $$
create function DEM_THANG()
returns int 
deterministic
begin
    declare max_month int default 0;
    select max(timestampdiff(MONTH, THOI_GIAN_DANG, '2019-01-01')) into max_month from POST;
    return max_month;
end $$
delimiter ;

select DEM_THANG();


-- Bạn hãy tạo một trigger để lưu lại mỗi user đã thực hiện comment bao nhiêu lần theo từng ngày.

create table TOTAL_COMMENT (
    ID int auto_increment primary key,
    ID_USER int,
    DAY_CMT date,
    TOTAL_CMT int    
);


delimiter $$
create trigger COMMENT_TIMES
after insert
on COMMENT for each row
begin
    declare total_cmt int;
    
    select count(*) into total_cmt
    from TOTAL_COMMENT 
    where DAY_CMT = date(new.TIME_COMMENT) and ID_USER = new.NGUOI_COMMENT;
    
    if total_cmt = 0 then
        insert into TOTAL_COMMENT (ID_USER, DAY_CMT, TOTAL_CMT)
        values (new.NGUOI_COMMENT, date(new.TIME_COMMENT), 1);
    else 
        update TOTAL_COMMENT set total_cmt = total_cmt + 1
        where ID_USER = new.NGUOI_COMMENT and DAY_CMT = date(new.TIME_COMMENT);
    end if;
end $$
delimiter ;

INSERT INTO COMMENT (TIME_COMMENT, NOI_DUNG , NGUOI_COMMENT)
VALUES ('2023-10-03', 'TOI CUNG NGHI NHU VAY', 1);

select * from TOTAL_COMMENT;
select * from COMMENT;


-- Lựa chọn một hoặc nhiều cột trong số các bảng đã tạo để tiến hành tạo INDEX. 
-- Sau khi tạo INDEX, các bạn hãy chỉ ra lý do chọn một hoặc nhiều cột đó để đánh INDEX.

create index search_post 
on POST (TIEU_DE, THOI_GIAN_DANG) using btree;

show index from POST;




