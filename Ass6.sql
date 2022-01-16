create database BookStore
go
use BookStore

create table Books (
BookCode int primary key,
Category varchar(50),
Author varchar(50),
Title varchar(50),
Price int,
InStore int,
Content varchar(150)
)

create table Customers(
CustomerName varchar(50),
BookCode int,
Address varchar(50),
Quantily int,
PublishingYear int 
constraint fk_customer foreign key (BookCode) references Books(BookCode)
)

insert into Books values 
(001,'Khoa hoc xa hoi','Eran Katz','Tri tue Do Thai',79000,100,'Nguoi Do Thai sang tao'),
(002,'Van hoc','Ngo Tat To','Tat Den',120000,50,'mieu ta cuoc song nguoi nong dan trong nhung ngay suu thue nang ne'),
(003,'Tieu thuyet','Hector Malot','Khong Gia Dinh',150000,20,'Ke ve 1 cau be khong cha me b? bo roi'),
(004,'Kinh te','Bill Aulet','Kinh Dien Ve Khoi Nghiep',100000,90,'24 buoc khoi su kinh doanh thanh cong')


insert into Customers values
('Tri Thuc',001,'Hai Ba Trung , Ha Noi',2,2010),
('Tri Thuc',002,'Hai Ba Trung , Ha Noi',1,2010),
('Kim Dong',003,'Dong Da , Ha Noi',1,2012),
('Kim Dong',002,'Dong Da , Ha Noi',2,2012),
('Tai Chinh',004,'Ha Dong , Ha Noi',1,2009)

--3
select Title,CustomerName from Books
join Customers on Customers.BookCode=Books.BookCode where PublishingYear > 2008

--4
select Title,Price from Books where Price > 80000

--5
select Title,Category from Books
where Category like 'Van Hoc'

--6
select Title from Books where Title like 'T%'

--7
select Title,CustomerName from Books
join Customers on Customers.BookCode=Books.BookCode where CustomerName = 'Tri thuc'

--8
select Title,CustomerName,Address,Quantily,PublishingYear from Books
join Customers on Customers.BookCode=Books.BookCode where Title = 'Tri tue Do Thai'

--9
select Books.BookCode,Title,CustomerName,PublishingYear,Category from Books
join Customers on Customers.BookCode=Books.BookCode

--10
select max(Price)as maxTitle from Books 
--11
select max(InStore)as Max_InStore from Books
--12
select Title,Author from Books where Author ='Eran Katz'
--13
select Title,(Price-Price*0.1) as PriceNew from Books 
join Customers on Customers.BookCode=Books.BookCode where PublishingYear >2008
--17
create view View_Book as
select Books.BookCode,Title,Author ,CustomerName,Price from Books
join Customers on Customers.BookCode=Books.BookCode 
--18
create proc SP_Them_Sach
as
  insert into Books values (005,'Van hoc','Vu Trong Phung','Vo de',100000,20,'noi ve chuyen 1 ong quan huyen co gang thanh liem')

EXEC SP_Them_Sach
select *from Books
--18
create proc SP_Tim_Sach(@name varchar(50))
as
   begin 
      if(exists(select Title from Books where Title=@name))
	   print N'Có cuốn sách bạn cần tìm'
	  else
	    print N'Không tìm thấy sach này' + @name
   end;
EXEC SP_Tim_Sach  'Vo de'

--19

create trigger drop_book on Books instead of delete 
as
 if(select InStore from deleted) >0
 begin 
 print N'Khong duoc xoa cuon sach van trong kho'
 rollback transaction 
 end

 delete from Books where Title= 'Tat Den'

 --20 
